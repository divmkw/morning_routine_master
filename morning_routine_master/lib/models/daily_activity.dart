import 'package:hive/hive.dart';

part 'daily_activity.g.dart';

@HiveType(typeId: 1)
class DailyActivity extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final String taskName;

  @HiveField(2)
  final bool isCompleted;

  @HiveField(3)
  final String timeSpent;

  DailyActivity({
    required this.date,
    required this.taskName,
    required this.isCompleted,
    required this.timeSpent,
  });
}