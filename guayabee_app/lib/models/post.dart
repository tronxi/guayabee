import 'package:guayabee_app/models/community.dart';

class Post {
  final Community community;
  final int id;
  final String name;
  final String? description;
  String? imageUrl;
  final int upVotes;
  final int downVotes;

  Post({
    required this.community,
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.upVotes,
    required this.downVotes,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      community: Community.fromJson(json['community']),
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      upVotes: json['upVotes'],
      downVotes: json['downVotes'],
    );
  }

  Map<String, dynamic> toJson() => {
    'community': community.toJson(),
    'id': id,
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'upVotes': upVotes,
    'downVotes': downVotes,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Post{id: $id, name: $name, description: $description, imageUrl: $imageUrl, upVotes: $upVotes, downVotes: $downVotes}';
  }
}
