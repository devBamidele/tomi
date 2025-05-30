import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/constants/hive_constants.dart';

part 'match_result.g.dart';

@HiveType(typeId: HiveConstants.matchResultHiveId)
@JsonSerializable()
class MatchResult {
  @HiveField(0)
  final String role;

  @HiveField(1)
  final double match;

  MatchResult({required this.role, required this.match});

  factory MatchResult.fromJson(Map<String, dynamic> json) =>
      _$MatchResultFromJson(json);

  Map<String, dynamic> toJson() => _$MatchResultToJson(this);

  @override
  String toString() => 'MatchResult(role: $role, match: $match)';
}
