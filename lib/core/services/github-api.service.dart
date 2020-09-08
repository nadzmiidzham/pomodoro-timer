import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:pomodoro_timer/core/constants/github-api.constant.dart';
import 'package:pomodoro_timer/core/models/github-profile.model.dart';
import 'package:pomodoro_timer/core/services/cache.service.dart';
import 'package:pomodoro_timer/locator.dart';

class GithubApiService {
  CacheService _cacheService = locator<CacheService>();

  Future<GithubProfileModel> getGithubProfile() async {
    // get data from cache if possible
    String cachedGithubProfile =
        await _cacheService.getCache(GithubApiConstant.API_CACHE_KEY);
    if (cachedGithubProfile != null) {
      return GithubProfileModel.fromJson(jsonDecode(cachedGithubProfile));
    }

    // check internet connection
    var connection = await (Connectivity().checkConnectivity());
    if (connection == ConnectivityResult.none) {
      return null;
    }

    // get github profile data using Github API
    Response response = await get(
        '${GithubApiConstant.API_URL}${GithubApiConstant.USER_ENDPOINT}/${GithubApiConstant.USERNAME}');
    if (response.statusCode != 200) {
      return null;
    }

    // if request is first time, cache response body
    _cacheService.saveCache(GithubApiConstant.API_CACHE_KEY, response.body);
    return GithubProfileModel.fromJson(jsonDecode(response.body));
  }
}
