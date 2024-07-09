import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:testing/data/datasources/local.dart';
import 'package:testing/data/models/index.dart';
import 'package:testing/data/models/jobs.dart';
import 'package:testing/domain/entitites/user_entity.dart';
import 'package:testing/domain/usecase/users/create_user_usecase.dart';
import 'package:testing/domain/usecase/users/delete_user_usecase.dart';
import 'package:testing/domain/usecase/users/get_user_usecase.dart';
import 'package:testing/domain/usecase/users/update_user_usecase.dart';
import 'package:testing/presentation/pages/users/widgets/confirm.dart';
import 'package:testing/presentation/pages/users/widgets/jobs.dart';

class UsersNotifier extends ChangeNotifier {
  final GetUseresUseCase getUseresUseCase;
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  UsersNotifier({required this.getUseresUseCase, required this.createUserUseCase, required this.updateUserUseCase, required this.deleteUserUseCase});


  TabController? tabController;
  

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  final TextEditingController textNameController = TextEditingController();
  final TextEditingController textLastnameController = TextEditingController();
  final TextEditingController textJobController = TextEditingController();


  final List<Tab> tabs = const [
    Tab(text: 'Non Selected'),
    Tab(text: 'Selected'),
  ];

  List<Jobs> jobs =[
    Jobs(name: 'front end', label: 'Front End', selected: false),
    Jobs(name: 'back end', label: 'Back End', selected: false),
    Jobs(name: 'data analyst', label: 'Data Analyst', selected: false),
  ];

  //Loading Page
  bool _isInitialPage = true;
  bool get isInitialPage => _isInitialPage;
  set isInitialPage(bool val){
    _isInitialPage = val;
    notifyListeners();
  }

  //Loading Page
  bool _isloading = false;
  bool get isloading => _isloading;
  set isloading(bool val){
    _isloading = val;
    notifyListeners();
  }

  //Page
  int _page = 1;
  int get page => _page;
  set page(int val){
    _page = val;
    notifyListeners();
  }

  //Page
  int _totalpage = 0;
  int get totalpage => _totalpage;
  set totalpage(int val){
    _totalpage = val;
    notifyListeners();
  }

  //Popup Index
  int _popupMenuItemIndex = 0;
  int get popupMenuItemIndex => _popupMenuItemIndex;
  set popupMenuItemIndex(int val){
    _popupMenuItemIndex = val;
    notifyListeners();
  }

  //Refresh Page
  bool _isRefresh = false;
  bool get isRefreh => _isRefresh;
  set isRefreh(bool val){
    _isRefresh = val;
    notifyListeners();
  }

  //Last Page
  bool _isLastpage = false;
  bool get isLastpage => _isLastpage;
  set isLastpage(bool val){
    _isLastpage = val;
    notifyListeners();
  }

  //Load Next Page
  bool _isLoadmore = false;
  bool get isLoadmore => _isLoadmore;
  set isLoadmore(bool val){
    _isLoadmore = val;
    notifyListeners();
  }

  UserModel? user;
  List<ResultUserEntity> _users = [];
  List<ResultUserEntity> get users => _users;
  set users(List<ResultUserEntity> val) {
    _users = val;
    notifyListeners();
  }

  Future<void> getUser() async {
    users.clear();
    isInitialPage = true;
    try{
      if (isloading) return;

      isloading = true;

      var result = await getUseresUseCase.call(page: page);
      if (result.data?.isNotEmpty??false){
        user = result;
        totalpage = result.perpage??0;
        users.addAll(user?.data??[]);
        isloading = false;
      }else{
        isLastpage = true;
        isLoadmore = false;
        isloading = false;
      }
    }catch(_){
      isloading = false;
      Fluttertoast.showToast(msg: 'Something worng!');
    }
  }

  Future<void> getLoadMore() async {
    isInitialPage = false;
    if (isLastpage) return;
    isloading = true;
    var result = await getUseresUseCase.call(page: page);
    if (result.data?.isNotEmpty??false){
        user = result;
        totalpage += result.perpage??0;
        users.addAll(result.data??[]);
        isloading = false;
        isLastpage = false;
      }else{
        isLastpage = true;
        isloading = false;
        Fluttertoast.showToast(msg: 'This Last Page');
      }
  }

  // Popup Jobs
  void showButtomSheetInfoJobs(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return const JobsPopUp();
        }
    );
  }

  // Confirm
  void showButtomSheetConfirm(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return const ConfirmPopUp();
        }
    );
  }

  //Create User
  Future<void> create(BuildContext context) async {
    try{
      await createUserUseCase.call(map: {
        'first_name': textNameController.text,
        'last_name': textLastnameController.text,
        'job': jobs.firstWhere((element) => element.selected == true).name
      });
      Fluttertoast.showToast(msg: 'Create user successfully');
      Navigator.pop(context);
    }catch(_){
      Fluttertoast.showToast(msg: 'Something worng');
    }
  }

  int _id = 0;
  int get id => _id;
  set id (int val){
    _id = val;
    notifyListeners();
  }

  ResultUserEntity? _selectedData;
  ResultUserEntity? get selectedData => _selectedData;
  set selectedData(ResultUserEntity? val){
    _selectedData = val;
    notifyListeners();
  }
  Future<void> autoFillData() async {
    id = selectedData?.id??0;
    textNameController.text = selectedData?.firstname??'';
    textLastnameController.text = selectedData?.lastname??'';
  }
  //Update Data
  Future<void> update(BuildContext context) async {
    try{
      await updateUserUseCase.call(
      id: id,
      map: {
        'first_name': textNameController.text,
        'last_name': textLastnameController.text,
        'job': jobs.firstWhere((element) => element.selected == true).name
      });
      Fluttertoast.showToast(msg: 'Update user successfully');
      Navigator.pop(context);
    }catch(_){
      Fluttertoast.showToast(msg: 'Something worng');
    }
  }

  //Update Data
  Future<bool> delete(BuildContext context) async {
    
    await deleteUserUseCase.call(id: _id);
    totalpage -=1;
    deleteList();
    return true;
  }

  Future<void> deleteList() async {
    users.removeWhere((element) => element.id == id);
  }

  UserDatabase userDatabase = UserDatabase.instance;
  List<ResultUserModel> _userLocal = [];
  List<ResultUserModel> get userLocal => _userLocal;
  set userLocal(List<ResultUserModel> val){
    _userLocal = val;
    notifyListeners();
  }

  Future<void> refreshLocalData() async {
    userDatabase.readAll().then((value) {
      userLocal = value;
    });
  }

  Future<void> selectUser(ResultUserModel user) async {
    if (userLocal.isEmpty){
      refreshLocalData();
    }

    if(userLocal.where((element) => element.id == user.id).isEmpty){
      userDatabase.create(user);
      Fluttertoast.showToast(msg: 'Create Local Data Successfully');
    }else{
      userDatabase.update(user);
      Fluttertoast.showToast(msg: 'Update Local Data Successfully');
    }
  }

  Future<void> deleteLocal(ResultUserModel user) async {
    userDatabase.delete(user.id??0);
    refreshLocalData();
    Fluttertoast.showToast(msg: 'Delete Local Data Successfully');
  }
}