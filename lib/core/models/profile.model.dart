import 'package:pomodoro_timer/core/models/social-media.model.dart';

class ProfileModel {
  String name, email, imagePath, profileUrl;
  List<SocialMedia> socialMediaList;

  ProfileModel({
    this.name,
    this.email,
    this.imagePath,
    this.profileUrl,
    this.socialMediaList,
  });

  Map toJson() => {
        'name': this.name,
        'email': this.email,
        'imagePath': this.imagePath,
        'githubProfile': this.profileUrl,
        'socialMediaList': this.socialMediaList,
      };

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      email: json['email'],
      imagePath: json['imagePath'],
      profileUrl: json['profileUrl'],
      socialMediaList: json['socialMediaList'],
    );
  }

  String toString() {
    return '{name: ${this.name}, email: ${this.email}, imagePath: ${this.imagePath}, profileUrl: ${this.profileUrl}, socialMediaList: [${this.socialMediaList.join(",")}]}';
  }
}
