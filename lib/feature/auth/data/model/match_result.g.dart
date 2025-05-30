// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchResultAdapter extends TypeAdapter<MatchResult> {
  @override
  final int typeId = 2;

  @override
  MatchResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatchResult(role: fields[0] as String, match: fields[1] as double);
  }

  @override
  void write(BinaryWriter writer, MatchResult obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.role)
      ..writeByte(1)
      ..write(obj.match);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchResult _$MatchResultFromJson(Map<String, dynamic> json) => MatchResult(
  role: json['role'] as String,
  match: (json['match'] as num).toDouble(),
);

Map<String, dynamic> _$MatchResultToJson(MatchResult instance) =>
    <String, dynamic>{'role': instance.role, 'match': instance.match};
