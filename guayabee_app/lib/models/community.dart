class Community {
  final int id;
  final String name;
  final String? description;
  String? imageUrl;
  final int members;

  Community({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.members,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      members: json['members'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'members': members,
  };

  @override
  String toString() {
    return 'Community{id: $id, name: $name, description: $description, imageUrl: $imageUrl, members: $members}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Community &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
