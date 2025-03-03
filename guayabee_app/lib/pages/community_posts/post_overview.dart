import 'package:flutter/material.dart';
import 'package:guayabee_app/models/post.dart';
import 'package:guayabee_app/routes.dart';

class PostOverview extends StatelessWidget {
  final Post post;

  const PostOverview({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 600, minWidth: 600),
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Routes.change(Routes.homeRoute);
            },
            highlightColor: Colors.transparent,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child:
                      post.imageUrl != null && post.imageUrl!.isNotEmpty
                          ? Image.network(
                            post.imageUrl!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.broken_image,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                          )
                          : const Icon(
                            Icons.article,
                            size: 80,
                            color: Colors.blue,
                          ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        post.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        post.description ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        post.community.name,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_upward, color: Colors.green),
                      onPressed: () {},
                    ),
                    Text("${post.upVotes - post.downVotes}"),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward, color: Colors.red),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
