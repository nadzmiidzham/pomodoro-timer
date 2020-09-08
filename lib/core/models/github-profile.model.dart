class GithubProfileModel {
  String profileLink;
  String name;
  String email;
  String profilePictureLink;

  GithubProfileModel({
    this.profileLink,
    this.name,
    this.profilePictureLink,
    this.email,
  });

  Map toJson() => {
        'profileLink': this.profileLink,
        'name': this.name,
        'profilePictureLink': this.profilePictureLink,
        'email': this.email,
      };

  factory GithubProfileModel.fromJson(Map<String, dynamic> json) {
    return GithubProfileModel(
      profileLink: json['html_url'],
      name: json['name'],
      profilePictureLink: json['avatar_url'],
      email: json['email'],
    );
  }

  String toString() {
    return '{profileLink: ${this.profileLink}, name: ${this.name}, profilePictureLink: ${this.profilePictureLink}, email: ${this.email}}';
  }
}
