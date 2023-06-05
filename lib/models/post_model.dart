class Post {
  final String id;
  //This categoryName will be an enum, e.g marriage=1 and so on
  final String categoryName;
  final String communityId;
  final String createdBy;
  final String userName;

  // final String title;
  final String post;
  final DateTime createdAt;
  //Comments will be a collection

  Post({
    required this.id,
    required this.categoryName,
    required this.createdBy,
    required this.userName,
    // required this.title,
    required this.post,
    required this.communityId,
    required this.createdAt,
  });

  static Post fromJson(json) => Post(
        id: json['id'],
        createdBy: json['createdBy'],
        categoryName: json['categoryName'],
        userName: json['userName'],
        // // title: json['title'],
        post: json['post'],
        communityId: json['communityId'],
        createdAt: json['createdAt'].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryName": categoryName,
        "createdBy": createdBy,
        "userName": userName,
        // // "title": title,
        "post": post,
        "communityId": communityId,
        "createdAt": createdAt,
      };
}
