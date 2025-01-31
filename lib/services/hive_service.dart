import 'package:hive/hive.dart';

class HiveService {
  late Box _settingsBox;

  Future<void> initHive() async {
    _settingsBox = await Hive.openBox('settings');
  }

  void setThemeMode(bool isDark) => _settingsBox.put('isDark', isDark);
  bool getThemeMode() => _settingsBox.get('isDark', defaultValue: false);

  void setSortOrder(String order) => _settingsBox.put('sortOrder', order);
  String getSortOrder() => _settingsBox.get('sortOrder', defaultValue: 'date');
}
   