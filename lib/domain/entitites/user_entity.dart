class UserEntity {
  final int? page;
  final int? perpage;
  final int? total;
  final int? totalpage;
  final List<ResultUserEntity>? data;
  const UserEntity({this.page, this.perpage, this.total, this.totalpage, this.data});
}

class ResultUserEntity {
  final int? id;
  final String? email;
  final String? firstname;
  final String? lastname;
  final String? avatar;
  const ResultUserEntity({this.id, this.email, this.firstname, this.lastname, this.avatar});
}
