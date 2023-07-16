class AppUser {
  final String? id;
  final String userName;
  final String email;
  final String avatarUrl;
  final List<dynamic> myposts;
  final List<ConfessorsModel> pastConfessor;

  AppUser({
    this.id,
    required this.userName,
    required this.email,
    required this.avatarUrl,
    required this.myposts,
    required this.pastConfessor,
  });

  static AppUser fromJson(json) => AppUser(
      id: json['id'],
      email: json['email'],
      userName: json['userName'],
      myposts: json['myposts'],
      avatarUrl: json['avatarUrl'],
      pastConfessor: (json['pastConfessors'] as List<dynamic>).map((e) {
        return ConfessorsModel.fromJson(e);
      }).toList());

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "email": email,
        "avatarUrl": avatarUrl,
        "myposts": myposts,
        "pastConfessors":
            pastConfessor.map((confessor) => confessor.toJson()).toList(),
      };
}

class ConfessorsModel {
  final String id;
  final String name;

  ConfessorsModel({
    required this.id,
    required this.name,
  });

  static ConfessorsModel fromJson(json) => ConfessorsModel(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
