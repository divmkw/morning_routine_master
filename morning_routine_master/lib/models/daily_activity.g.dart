// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_activity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyActivityAdapter extends TypeAdapter<DailyActivity> {
  @override
  final int typeId = 1;

  @override
  DailyActivity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyActivity(
      date: fields[0] as DateTime,
      taskName: fields[1] as String,
      isCompleted: fields[2] as bool,
      timeSpent: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DailyActivity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.taskName)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.timeSpent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
