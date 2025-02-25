class CreateCommunityOrder {
  final String name;
  final String? description;
  String? imageUrl;

  CreateCommunityOrder({required this.name, this.description, this.imageUrl});

  factory CreateCommunityOrder.fromJson(Map<String, dynamic> json) {
    return CreateCommunityOrder(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
  };

  @override
  String toString() {
    return 'CreateCommunityOrder{name: $name, description: $description, imageUrl: $imageUrl}';
  }
}
