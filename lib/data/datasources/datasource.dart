
import 'package:testing/data/models/index.dart';

abstract class DataSource {
  Future<UserModel> getUsers({int? page});
  Future<dynamic> create({Map? data});
  Future<dynamic> update({int? id, Map? data});
  Future<dynamic> delete({int? id});
}