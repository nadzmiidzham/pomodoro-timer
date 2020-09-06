import 'package:pomodoro_timer/core/models/github-profile.model.dart';
import 'package:pomodoro_timer/core/models/profile.model.dart';
import 'package:pomodoro_timer/core/models/social-media.model.dart';
import 'package:pomodoro_timer/core/services/github-api.service.dart';
import 'package:pomodoro_timer/core/services/social-media.service.dart';
import 'package:pomodoro_timer/locator.dart';

class ProfileService {
  GithubApiService _githubApiService = locator<GithubApiService>();
  SocialMediaService _socialMediaService = locator<SocialMediaService>();

  Future<ProfileModel> getProfile() async {
    GithubProfileModel githubProfile =
        await _githubApiService.getGithubProfile();
    List<SocialMedia> socialMediaList =
        _socialMediaService.getSocialMediaList();

    return ProfileModel.fromJson({
      'name': githubProfile?.name,
      'email': githubProfile?.email,
      'imagePath': githubProfile?.profilePictureLink,
      'profileUrl': githubProfile?.profileLink,
      'socialMediaList': socialMediaList,
    });
  }
}
