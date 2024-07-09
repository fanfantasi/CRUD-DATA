
import 'package:flutter/material.dart';
import 'package:testing/data/models/onboard.dart';

class OnBoardNotifier extends ChangeNotifier {
  PageController? pageController;

  // Initial Index
  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  set pageIndex(int val){
    _pageIndex = val;
    notifyListeners();
  }

  // List Onboard
  List<Onbord> _onbordData = [];
  List<Onbord> get onboardData => _onbordData;
  set onboardData(List<Onbord> val){
    _onbordData = val;
    notifyListeners();
  }

  OnBoardNotifier() {
    pageController = PageController(initialPage: 0);
    createOnboard();
  }

  Future<void> createOnboard() async {
    onboardData.add(Onbord(image: 'assets/images/onboard.svg', title: 'Loren Ipsum Sit Amet', description: 'Lorem ipsum dolor sit amet, consectetur elit sit amet'));
    onboardData.add(Onbord(image: 'assets/images/onboard.svg', title: 'Loren Ipsum Sit Amet', description: 'Lorem ipsum dolor sit amet, consectetur elit sit amet'));
    onboardData.add(Onbord(image: 'assets/images/onboard.svg', title: 'Loren Ipsum Sit Amet', description: 'Lorem ipsum dolor sit amet, consectetur elit sit amet'));
    onboardData.add(Onbord(image: 'assets/images/onboard.svg', title: 'Loren Ipsum Sit Amet', description: 'Lorem ipsum dolor sit amet, consectetur elit sit amet'));
  }

  @override
  void dispose() {
    if (pageController != null){
      pageController!.dispose();
    }
    super.dispose();
  }
}