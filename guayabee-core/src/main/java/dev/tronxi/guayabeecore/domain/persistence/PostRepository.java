package dev.tronxi.guayabeecore.domain.persistence;

import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.models.CreatePostOrder;
import dev.tronxi.guayabeecore.domain.models.Post;

import java.util.List;

public interface PostRepository {
    Post create(Community community, CreatePostOrder createPostOrder);

    List<Post> retrievePostsByCommunity(Community community);
}
