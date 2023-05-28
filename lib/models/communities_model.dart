class Community {
  final String id;
  final String createdBy;
  final String name;
  final String description;
  final int visibility;
  final int icon;
  final int color;
  final List<dynamic> members;
  final List<dynamic> postIds;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.members,
    required this.postIds,
    required this.color,
    required this.visibility,
    required this.createdBy,
  });

  static Community fromJson(json) => Community(
        id: json['id'],
        description: json['description'],
        name: json['name'],
        icon: json['icon'],
        members: json['members'],
        postIds: json['postIds'],
        color: json['color'],
        visibility: json['visibility'],
        createdBy: json['createdBy'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "icon": icon,
        "members": members,
        "postIds": postIds,
        'color': color,
        'visibility': visibility,
        'createdBy': createdBy,
      };
}
