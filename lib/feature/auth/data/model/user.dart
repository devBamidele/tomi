import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/constants/hive_constants.dart';
import 'match_result.dart';

part 'user.g.dart';

@HiveType(typeId: HiveConstants.userHiveId)
@JsonSerializable()
class User {
  @HiveField(0)
  @JsonKey(name: 'id')
  final String? id;

  @HiveField(1)
  @JsonKey(name: 'email')
  final String? email;

  @HiveField(2)
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @HiveField(3)
  @JsonKey(name: 'hasTakenQuestionnaire')
  final bool? hasTakenQuestionnaire;

  @HiveField(4)
  @JsonKey(name: 'questionnaireAnswers')
  final List<String>? questionnaireAnswers;

  @HiveField(5)
  @JsonKey(name: 'topMatches')
  final List<MatchResult>? topMatches;

  const User({
    this.id,
    this.email,
    this.createdAt,
    this.hasTakenQuestionnaire,
    this.questionnaireAnswers,
    this.topMatches,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? email,
    DateTime? createdAt,
    bool? hasTakenQuestionnaire,
    List<String>? questionnaireAnswers,
    List<MatchResult>? topMatches,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      hasTakenQuestionnaire:
          hasTakenQuestionnaire ?? this.hasTakenQuestionnaire,
      questionnaireAnswers: questionnaireAnswers ?? this.questionnaireAnswers,
      topMatches: topMatches ?? this.topMatches,
    );
  }

  @override
  String toString() {
    return '''User(
  id: $id, 
  email: $email, 
  createdAt: $createdAt, 
  hasTakenQuestionnaire: $hasTakenQuestionnaire, 
  questionnaireAnswers: $questionnaireAnswers, 
  topMatches: $topMatches
)''';
  }
}
