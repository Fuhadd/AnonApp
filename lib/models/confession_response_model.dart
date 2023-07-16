class ConfessionResponse {
  final String id;
  final String imageUrl;
  final String userName;
  final String title;
  final String content;

  ConfessionResponse({
    required this.id,
    required this.imageUrl,
    required this.userName,
    required this.title,
    required this.content,
  });

  static ConfessionResponse fromJson(json) => ConfessionResponse(
        id: json['id'],
        imageUrl: json['imageUrl'],
        userName: json['userName'],
        title: json['title'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "userName": userName,
        "title": title,
        "content": content,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfessionResponse &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          userName == other.userName &&
          title == other.title &&
          content == other.content;

  @override
  int get hashCode =>
      id.hashCode ^
      imageUrl.hashCode ^
      userName.hashCode ^
      title.hashCode ^
      content.hashCode;
}
