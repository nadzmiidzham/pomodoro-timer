import 'package:pomodoro_timer/core/constants/github-api.constant.dart';
import 'package:pomodoro_timer/core/models/github-profile.model.dart';
import 'package:pomodoro_timer/core/models/social-media.model.dart';
import 'package:pomodoro_timer/core/services/github-api.service.dart';
import 'package:pomodoro_timer/core/services/social-media.service.dart';
import 'package:pomodoro_timer/locator.dart';
import 'package:pomodoro_timer/ui/viewmodels/base.viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutViewModel extends BaseViewModel {
  GithubApiService _githubApiService = locator<GithubApiService>();
  SocialMediaService _socialMediaService = locator<SocialMediaService>();
  GithubProfileModel _profile;
  List<SocialMedia> _socialMediaList;

  // getter
  String get profileLink {
    return _profile.profileLink ?? GithubApiConstant.GITHUB_PROFILE_URL;
  }

  String get name {
    return _profile.name ?? GithubApiConstant.GITHUB_PROFILE_NAME;
  }

  String get profilePictureLink {
    return _profile.profilePictureLink;
  }

  String get email {
    return _profile.email ?? GithubApiConstant.GITHUB_PROFILE_EMAIL;
  }

  List<Map<String, dynamic>> get socialMediaList {
    List<Map<String, dynamic>> list = [];

    _socialMediaList.forEach((element) {
      list.add(
          {'iconPath': element.iconPath, 'profileLink': element.profileLink});
    });

    return list;
  }

  // init methods
  initProfile() async {
    setState(ViewState.BUSY);
    _profile =
        await _githubApiService.getGithubProfile() ?? GithubProfileModel();
    _socialMediaList = _socialMediaService.getSocialMediaList();
    setState(ViewState.IDLE);
  }

  // action methods
  openWebBrowser(String url) async {
    setState(ViewState.BUSY);

    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Cannot launch web browser.';
    }

    setState(ViewState.IDLE);
  }

  openEmailApp(String email) async {
    setState(ViewState.BUSY);

    String emailUrl = 'mailto:$email';

    if (await canLaunch(emailUrl)) {
      launch(emailUrl);
    } else {
      throw 'Cannot launch email app.';
    }

    setState(ViewState.IDLE);
  }
}
