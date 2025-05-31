import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/constants/hive_constants.dart';

part 'user.g.dart';

@HiveType(typeId: HiveConstants.userHiveId)
@JsonSerializable()
class User {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int? id;

  @HiveField(1)
  @JsonKey(name: 'email')
  final String? email;

  @HiveField(2)
  @JsonKey(name: 'name')
  final String? name;

  const User({this.id, this.email, this.name});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({int? id, String? email, String? name}) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return '''User(
  id: $id, 
  email: $email, 
  name: $name,
)''';
  }
}
