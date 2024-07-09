import '../../repositories/repository.dart';

class UpdateUserUseCase {
  final Repository repository;
  UpdateUserUseCase({required this.repository});

  Future<dynamic> call({int? id, Map? map}) async {
    return await repository.update(id: id, data: map);
  }
}
