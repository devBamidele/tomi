// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String?,
      email: fields[1] as String?,
      createdAt: fields[2] as DateTime?,
      hasTakenQuestionnaire: fields[3] as bool?,
      questionnaireAnswers: (fields[4] as List?)?.cast<String>(),
      topMatches: (fields[5] as List?)?.cast<MatchResult>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.hasTakenQuestionnaire)
      ..writeByte(4)
      ..write(obj.questionnaireAnswers)
      ..writeByte(5)
      ..write(obj.topMatches);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String?,
  email: json['email'] as String?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  hasTakenQuestionnaire: json['hasTakenQuestionnaire'] as bool?,
  questionnaireAnswers:
      (json['questionnaireAnswers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
  topMatches:
      (json['topMatches'] as List<dynamic>?)
          ?.map((e) => MatchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'createdAt': instance.createdAt?.toIso8601String(),
  'hasTakenQuestionnaire': instance.hasTakenQuestionnaire,
  'questionnaireAnswers': instance.questionnaireAnswers,
  'topMatches': instance.topMatches,
};
