import 'package:pomodoro_timer/core/constants/profile.constant.dart';
import 'package:pomodoro_timer/core/models/social-media.model.dart';

class SocialMediaService {
  List<SocialMedia> getSocialMediaList() {
    List<SocialMedia> socialMediaList = [];

    ProfileConstant.SOCIAL_MEDIA_LINK_LIST.forEach((element) {
      socialMediaList.add(SocialMedia.fromJson(element));
    });

    return socialMediaList;
  }
}
