import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user_model.dart';
import '../models/daily_activity.dart';

class HiveService {
  static const String userBox = 'userBox';
  static const String activityBox = 'activityBox';

  static Future<void> initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
    
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(DailyActivityAdapter());
    
    await Hive.openBox<User>(userBox);
    await Hive.openBox<DailyActivity>(activityBox);
  }

  // User methods
  static Future<void> saveUser(User user) async {
    final box = Hive.box<User>(userBox);
    await box.put('currentUser', user);
  }

  static User? getUser() {
    final box = Hive.box<User>(userBox);
    return box.get('currentUser');
  }

  // Daily Activity methods
  static Future<void> saveDailyActivity(DailyActivity activity) async {
    final box = Hive.box<DailyActivity>(activityBox);
    final key = '${activity.date.toIso8601String()}_${activity.taskName}';
    await box.put(key, activity);
  }

  static List<DailyActivity> getActivitiesForDate(DateTime date) {
    final box = Hive.box<DailyActivity>(activityBox);
    final dateString = date.toIso8601String().split('T')[0];
    
    return box.values.where((activity) {
      final activityDate = activity.date.toIso8601String().split('T')[0];
      return activityDate == dateString;
    }).toList();
  }

  static Future<void> clearAllData() async {
    await Hive.box<User>(userBox).clear();
    await Hive.box<DailyActivity>(activityBox).clear();
  }
}