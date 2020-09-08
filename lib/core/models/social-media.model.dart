class SocialMedia {
  String iconPath;
  String profileLink;

  SocialMedia({this.iconPath, this.profileLink});

  Map toJson() => {
        'iconPath': this.iconPath,
        'profileLink': this.profileLink,
      };

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      iconPath: json['iconPath'],
      profileLink: json['profileLink'],
    );
  }

  String toString() {
    return '{iconPath: ${this.iconPath}, profileLink: ${this.profileLink}}';
  }
}
