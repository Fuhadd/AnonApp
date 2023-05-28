class AppUser {
  final String? id;
  final String userName;
  final String email;
  final String avatarUrl;
  final List<dynamic> myposts;

  AppUser({
    this.id,
    required this.userName,
    required this.email,
    required this.avatarUrl,
    required this.myposts,
  });

  static AppUser fromJson(json) => AppUser(
      id: json['id'],
      email: json['email'],
      userName: json['userName'],
      myposts: json['myposts'],
      avatarUrl: json['avatarUrl']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "email": email,
        "avatarUrl": avatarUrl,
        "myposts": myposts,
      };
}
