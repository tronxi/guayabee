package dev.tronxi.gauyabeecore.domain.usecases;

import dev.tronxi.gauyabeecore.domain.models.Community;
import dev.tronxi.gauyabeecore.domain.persistence.CommunityRepository;
import dev.tronxi.gauyabeecore.domain.services.CommunityRetriever;
import dev.tronxi.gauyabeecore.domain.services.UserInCommunityChecker;
import org.springframework.stereotype.Service;

@Service
public class JoinToCommunityUseCase {
    private final CommunityRepository communityRepository;
    private final CommunityRetriever communityRetriever;
    private final UserInCommunityChecker userInCommunityChecker;

    public JoinToCommunityUseCase(CommunityRepository communityRepository, CommunityRetriever communityRetriever, UserInCommunityChecker userInCommunityChecker) {
        this.communityRepository = communityRepository;
        this.communityRetriever = communityRetriever;
        this.userInCommunityChecker = userInCommunityChecker;
    }

    public void joinToCommunity(Long communityId, String userId) {
        Community community = communityRetriever.retrieveCommunityByIdOrThrow(communityId);
        //todo review checkOrThrow
        userInCommunityChecker.checkOrThrow(community, userId);
        Community communityWithNewMember = community.incrementMembers();
        Community updatedCommunity = communityRepository.update(communityWithNewMember);
        communityRepository.joinCommunity(updatedCommunity, userId);
    }
}
