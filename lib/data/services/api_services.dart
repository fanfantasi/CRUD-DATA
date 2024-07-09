import 'package:dio/dio.dart';
import 'package:testing/data/models/index.dart';
import 'logging_interceptors.dart';

class ApiService {
  Dio get dio => _dio();
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: 'https://reqres.in',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 10000),
      contentType: "application/json;charset=utf-8",
      validateStatus: (_) => true,
    );

    var dio = Dio(options);

    dio.interceptors.add(LoggingInterceptors());
    return dio;
  }
  
  //User
  Future<UserModel> getUser({int? page}) async {
    try{
      Response response = await dio.get('/api/users?page=$page');
      return UserModel.fromJSON(response.data);
    }catch(error, stacktrace){
      throw Exception("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  //Create
  Future<dynamic> create({Map? data}) async {
    try{
      Response response = await dio.post('/api/users', data: data);
      return response.data;
    }catch(error, stacktrace){
      throw Exception("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  //Update
  Future<dynamic> update({int? id, Map? data}) async {
    try{
      Response response = await dio.put('/api/users/$id', data: data);
      return response.data;
    }catch(error, stacktrace){
      throw Exception("Exception occurred: $error stackTrace: $stacktrace");
    }
  }

  //Update
  Future<dynamic> delete({int? id}) async {
    try{
      Response response = await dio.delete('/api/users/$id');
      return response.data;
    }catch(error, stacktrace){
      throw Exception("Exception occurred: $error stackTrace: $stacktrace");
    }
  }
}
