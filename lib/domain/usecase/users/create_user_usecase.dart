import '../../repositories/repository.dart';

class CreateUserUseCase {
  final Repository repository;
  CreateUserUseCase({required this.repository});

  Future<dynamic> call({Map? map}) async {
    return await repository.create(data: map);
  }
}
