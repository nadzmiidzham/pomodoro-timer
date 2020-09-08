import 'package:pomodoro_timer/core/constants/profile.constant.dart';
import 'package:pomodoro_timer/core/models/profile.model.dart';
import 'package:pomodoro_timer/core/services/profile.service.dart';
import 'package:pomodoro_timer/locator.dart';
import 'package:pomodoro_timer/ui/viewmodels/base.viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutViewModel extends BaseViewModel {
  ProfileService _profileService = locator<ProfileService>();
  ProfileModel _profile;

  // getter
  String get profileUrl {
    return _profile.profileUrl ?? ProfileConstant.GITHUB_PROFILE_URL;
  }

  String get name {
    return _profile.name ?? ProfileConstant.GITHUB_PROFILE_NAME;
  }

  String get profilePicturePath {
    return _profile.imagePath;
  }

  String get email {
    return _profile.email ?? ProfileConstant.GITHUB_PROFILE_EMAIL;
  }

  List<Map<String, dynamic>> get socialMediaList {
    List<Map<String, dynamic>> list = [];

    _profile.socialMediaList.forEach((element) {
      list.add(
          {'iconPath': element.iconPath, 'profileLink': element.profileLink});
    });

    return list;
  }

  // init methods
  initProfile() async {
    setState(ViewState.BUSY);
    _profile = await _profileService.getProfile();
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
