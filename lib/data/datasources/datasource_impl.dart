import 'package:testing/data/datasources/datasource.dart';
import 'package:testing/data/models/index.dart';
import 'package:testing/data/services/api_services.dart';

class DataSourceImpl implements DataSource {
  final ApiService api;
  DataSourceImpl({required this.api});

  @override
  Future<UserModel> getUsers({int? page}) async => await api.getUser(page: page);
  
  @override
  Future create({Map? data}) async {
    await api.create(data: data);
  }
  
  @override
  Future delete({int? id}) async {
    await api.delete(id: id);
  }
  
  @override
  Future update({int? id, Map? data}) async {
    await api.update(id: id, data: data);
  }
}