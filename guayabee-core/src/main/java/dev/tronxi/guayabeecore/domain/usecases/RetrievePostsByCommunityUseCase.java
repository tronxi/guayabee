package dev.tronxi.guayabeecore.domain.usecases;

import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.models.Post;
import dev.tronxi.guayabeecore.domain.persistence.PostRepository;
import dev.tronxi.guayabeecore.domain.services.CommunityRetriever;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RetrievePostsByCommunityUseCase {

    private final CommunityRetriever communityRetriever;
    private final PostRepository postRepository;

    public RetrievePostsByCommunityUseCase(CommunityRetriever communityRetriever, PostRepository postRepository) {
        this.communityRetriever = communityRetriever;
        this.postRepository = postRepository;
    }

    public List<Post> retrievePostsByCommunity(Long communityId) {
        Community community = communityRetriever.retrieveCommunityByIdOrThrow(communityId);
        return postRepository.retrievePostsByCommunity(community);
    }
}
