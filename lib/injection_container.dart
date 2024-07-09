import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/data/datasources/datasource.dart';
import 'package:testing/data/datasources/datasource_impl.dart';
import 'package:testing/data/repositories/repository_impl.dart';
import 'package:testing/data/services/api_services.dart';
import 'package:testing/domain/repositories/repository.dart';
import 'package:testing/domain/usecase/users/create_user_usecase.dart';
import 'package:testing/domain/usecase/users/delete_user_usecase.dart';
import 'package:testing/domain/usecase/users/get_user_usecase.dart';
import 'package:testing/domain/usecase/users/update_user_usecase.dart';
import 'package:testing/presentation/privider/onboard/notifier.dart';
import 'package:testing/presentation/privider/users/notifier.dart';

final getIt = GetIt.instance;
Future<void> init() async {
  getIt.registerFactory<OnBoardNotifier>(() => OnBoardNotifier());
  getIt.registerFactory<UsersNotifier>(() => UsersNotifier(
    getUseresUseCase: getIt.call(), 
    createUserUseCase: getIt.call(),
    updateUserUseCase: getIt.call(),
    deleteUserUseCase: getIt.call()));

  getIt.registerLazySingleton<GetUseresUseCase>(() => GetUseresUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<CreateUserUseCase>(() => CreateUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<UpdateUserUseCase>(() => UpdateUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<DeleteUserUseCase>(() => DeleteUserUseCase(repository: getIt.call()));

  getIt.registerLazySingleton<Repository>(
      () => RepositoryImpl(dataSource: getIt.call()));

  //remote data
  getIt.registerLazySingleton<DataSource>(
      () => DataSourceImpl(api: getIt.call()));

  //External
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => prefs);
}