import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  Future<bool> saveCache(String cacheKey, String data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(cacheKey, data);
  }

  Future<String> getCache(String cacheKey) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(cacheKey) ?? null;
  }
}
