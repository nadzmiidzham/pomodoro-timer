class GithubProfileModel {
  String profileLink;
  String name;
  String profilePictureLink;

  GithubProfileModel({
    this.profileLink,
    this.name,
    this.profilePictureLink,
  });

  Map toJson() => {
        'profileLink': this.profileLink,
        'name': this.name,
        'profilePictureLink': this.profilePictureLink,
      };

  factory GithubProfileModel.fromJson(Map<String, dynamic> json) {
    return GithubProfileModel(
      profileLink: json['html_url'],
      name: json['name'],
      profilePictureLink: json['avatar_url'],
    );
  }

  String toString() {
    return '{profileLink: ${this.profileLink}, name: ${this.name}, profilePictureLink: ${this.profilePictureLink}}';
  }
}
