import 'package:testing/data/datasources/datasource.dart';
import 'package:testing/data/models/index.dart';
import 'package:testing/domain/repositories/repository.dart';

class RepositoryImpl implements Repository {
  final DataSource dataSource;

  RepositoryImpl({required this.dataSource});

  @override
  Future<UserModel> getUsers({int? page}) async => await dataSource.getUsers(page: page);

  @override
  Future create({Map? data}) async {
    await dataSource.create(data: data);
  }
  
  @override
  Future delete({int? id}) async {
    await dataSource.delete(id: id);
  }
  
  @override
  Future update({int? id, Map? data}) async {
    await dataSource.update(id: id, data: data);
  }
  
}
