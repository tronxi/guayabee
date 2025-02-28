package dev.tronxi.guayabeecore.domain.usecases;

import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.models.CreatePostOrder;
import dev.tronxi.guayabeecore.domain.models.Post;
import dev.tronxi.guayabeecore.domain.persistence.PostRepository;
import dev.tronxi.guayabeecore.domain.services.CommunityRetriever;
import org.springframework.stereotype.Service;

@Service
public class CreatePostUseCase {

    private final CommunityRetriever communityRetriever;
    private final PostRepository postRepository;

    public CreatePostUseCase(CommunityRetriever communityRetriever, PostRepository postRepository) {
        this.communityRetriever = communityRetriever;
        this.postRepository = postRepository;
    }

    public Post create(CreatePostOrder createPostOrder) {
        Community community = communityRetriever.retrieveCommunityByIdOrThrow(createPostOrder.communityId());
        return postRepository.create(community, createPostOrder);
    }
}
