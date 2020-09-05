import 'dart:convert';

import 'package:pomodoro_timer/core/constants/github-api.constant.dart';
import 'package:http/http.dart' as http;
import 'package:pomodoro_timer/core/models/github-profile.model.dart';

class GithubApiService {
  Future<GithubProfileModel> getGithubProfile() async {
    http.Response response = await http.get(
        '${GithubApiConstant.API_URL}${GithubApiConstant.USER_ENDPOINT}/${GithubApiConstant.USERNAME}');

    return GithubProfileModel.fromJson(jsonDecode(response.body));
  }
}
