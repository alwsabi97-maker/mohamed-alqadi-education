import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String studentNameKey = 'student_name';
  static const String studentCodeKey = 'student_code';
  static const String resultsKey = 'results';

  static Future<void> saveStudent(String name, String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(studentNameKey, name);
    await prefs.setString(studentCodeKey, code);
  }

  static Future<Map<String, String>> loadStudent() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString(studentNameKey) ?? '',
      'code': prefs.getString(studentCodeKey) ?? '',
    };
  }

  static Future<void> clearStudent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(studentNameKey);
    await prefs.remove(studentCodeKey);
  }

  static Future<List<String>> loadResults() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(resultsKey) ?? <String>[];
  }

  static Future<void> saveResults(List<String> entries) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(resultsKey, entries);
  }
}
