import 'dart:convert';

import 'package:pomodoro_timer/core/constants/github-api.constant.dart';
import 'package:http/http.dart' as http;
import 'package:pomodoro_timer/core/models/github-profile.model.dart';
import 'package:pomodoro_timer/core/services/cache.service.dart';
import 'package:pomodoro_timer/locator.dart';

class GithubApiService {
  CacheService _cacheService = locator<CacheService>();

  Future<GithubProfileModel> getGithubProfile() async {
    http.Response response = await http.get(
        '${GithubApiConstant.API_URL}${GithubApiConstant.USER_ENDPOINT}/${GithubApiConstant.USERNAME}');

    // get data from cache if possible
    String cachedGithubProfile =
        await _cacheService.getCache(GithubApiConstant.API_CACHE_KEY);
    if (cachedGithubProfile != null) {
      return GithubProfileModel.fromJson(jsonDecode(cachedGithubProfile));
    }

    // if failed response, show default data
    if (response.statusCode != 200) {
      return GithubProfileModel(
        name: GithubApiConstant.GITHUB_PROFILE_NAME,
        profileLink: GithubApiConstant.GITHUB_PROFILE_URL,
        profilePictureLink: GithubApiConstant.GITHUB_PROFILE_IMAGE_URL,
      );
    }

    // if request is first time, cache response body
    _cacheService.saveCache(GithubApiConstant.API_CACHE_KEY, response.body);

    return GithubProfileModel.fromJson(jsonDecode(response.body));
  }
}
