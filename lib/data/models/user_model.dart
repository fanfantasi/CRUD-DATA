
import 'package:testing/domain/entitites/user_entity.dart';

class UserModel extends UserEntity {
  UserModel.fromJSON(Map<String, dynamic> json)
      : super(
          page: json['page'],
          perpage: json['per_page'],
          total: json['total'],
          totalpage: json['total_pages'],
          data: json['data'] != null
              ? List.from(json['data'])
                  .map((e) => ResultUserModel.fromJSON(e))
                  .toList()
              : null,
        );

  Map<String, dynamic> toJson() => {
        'page':page,
        'per_page':page,
        'total':total,
        'total_pages':page,
        'data': data,
      };
}

class ResultUserModel extends ResultUserEntity {
  ResultUserModel.fromJSON(Map<String, dynamic> json)
  :super (
    id: json['id'],
    email: json['email'],
    firstname: json['first_name'],
    lastname: json['last_name'],
    avatar: json['avatar'],
  );

  Map<String, dynamic> toJson() => {
      'id':id,
      'email':email,
      'first_name':firstname,
      'last_name':lastname,
      'avatar': avatar,
    };

}

