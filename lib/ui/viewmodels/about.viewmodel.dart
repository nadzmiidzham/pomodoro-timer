import 'package:pomodoro_timer/core/models/github-profile.model.dart';
import 'package:pomodoro_timer/core/services/cache.service.dart';
import 'package:pomodoro_timer/core/services/github-api.service.dart';
import 'package:pomodoro_timer/locator.dart';
import 'package:pomodoro_timer/ui/viewmodels/base.viewmodel.dart';

class AboutViewModel extends BaseViewModel {
  CacheService _cacheService = locator<CacheService>();
  GithubApiService _githubApiService = locator<GithubApiService>();
  GithubProfileModel _profile =
      GithubProfileModel(name: '', profileLink: null, profilePictureLink: null);

  // getter
  String get profileLink {
    return _profile.profileLink;
  }

  String get name {
    return _profile.name;
  }

  String get profilePictureLink {
    return _profile.profilePictureLink;
  }

  // init methods
  initProfile() async {
    setState(ViewState.BUSY);
    _profile = await _githubApiService.getGithubProfile();
    setState(ViewState.IDLE);
  }

  // action methods
  openWebBrowser(String url) {}

  openEmail(String email) {}
}