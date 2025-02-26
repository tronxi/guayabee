package dev.tronxi.guayabeecore.domain.usecases;

import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.persistence.CommunityRepository;
import dev.tronxi.guayabeecore.domain.services.CommunityRetriever;
import dev.tronxi.guayabeecore.domain.services.UserInCommunityChecker;
import org.springframework.stereotype.Service;

@Service
public class JoinCommunityUseCase {
    private final CommunityRepository communityRepository;
    private final CommunityRetriever communityRetriever;
    private final UserInCommunityChecker userInCommunityChecker;

    public JoinCommunityUseCase(CommunityRepository communityRepository, CommunityRetriever communityRetriever, UserInCommunityChecker userInCommunityChecker) {
        this.communityRepository = communityRepository;
        this.communityRetriever = communityRetriever;
        this.userInCommunityChecker = userInCommunityChecker;
    }

    public void joinCommunity(Long communityId, String userId) {
        Community community = communityRetriever.retrieveCommunityByIdOrThrow(communityId);
        userInCommunityChecker.validateMembershipOrThrow(community, userId);
        Community communityWithNewMember = community.incrementMembers();
        Community updatedCommunity = communityRepository.update(communityWithNewMember);
        communityRepository.joinCommunity(updatedCommunity, userId);
    }
}
