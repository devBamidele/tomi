// data/model/evaluation_result.dart

import 'package:json_annotation/json_annotation.dart';

part 'evaluation_result.g.dart';

@JsonSerializable()
class EvaluationResult {
  final String domain;

  @JsonKey(name: 'syllabus_keywords')
  final List<String> syllabusKeywords;

  @JsonKey(name: 'content_keywords')
  final List<String> contentKeywords;

  @JsonKey(name: 'relevance_score')
  final double relevanceScore;

  @JsonKey(name: 'readability_score')
  final double readabilityScore;

  @JsonKey(name: 'lexical_diversity_score')
  final double lexicalDiversityScore;

  @JsonKey(name: 'overall_quality_score')
  final double overallQualityScore;

  EvaluationResult({
    required this.domain,
    required this.syllabusKeywords,
    required this.contentKeywords,
    required this.relevanceScore,
    required this.readabilityScore,
    required this.lexicalDiversityScore,
    required this.overallQualityScore,
  });

  factory EvaluationResult.fromJson(Map<String, dynamic> json) =>
      _$EvaluationResultFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationResultToJson(this);
}
