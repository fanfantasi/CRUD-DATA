import 'package:testing/data/models/index.dart';
import '../../repositories/repository.dart';

class GetUseresUseCase {
  final Repository repository;
  GetUseresUseCase({required this.repository});

  Future<UserModel> call({int? page}) async {
    return await repository.getUsers(page: page);
  }
}
