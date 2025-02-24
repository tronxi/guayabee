class Community {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  int? members;

  Community({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.members,
  });

  Community.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    members = json['members'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['members'] = members;
    return data;
  }

  @override
  String toString() {
    return 'Community{id: $id, name: $name, description: $description, imageUrl: $imageUrl, members: $members}';
  }
}
