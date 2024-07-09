import '../../repositories/repository.dart';

class DeleteUserUseCase {
  final Repository repository;
  DeleteUserUseCase({required this.repository});

  Future<dynamic> call({int? id}) async {
    return await repository.delete(id: id);
  }
}
