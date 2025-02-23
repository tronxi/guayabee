package dev.tronxi.gauyabeecore.domain.usecases;

import dev.tronxi.gauyabeecore.domain.models.Community;
import dev.tronxi.gauyabeecore.domain.persistence.CommunityRepository;
import dev.tronxi.gauyabeecore.domain.services.CommunityRetriever;
import dev.tronxi.gauyabeecore.domain.services.UserInCommunityChecker;
import org.springframework.stereotype.Service;

@Service
public class LeaveCommunityUseCase {
    private final CommunityRepository communityRepository;
    private final CommunityRetriever communityRetriever;
    private final UserInCommunityChecker userInCommunityChecker;

    public LeaveCommunityUseCase(CommunityRepository communityRepository, CommunityRetriever communityRetriever, UserInCommunityChecker userInCommunityChecker) {
        this.communityRepository = communityRepository;
        this.communityRetriever = communityRetriever;
        this.userInCommunityChecker = userInCommunityChecker;
    }

    public void leaveCommunity(Long communityId, String userId) {
        Community community = communityRetriever.retrieveCommunityByIdOrThrow(communityId);
        userInCommunityChecker.validateNotMemberOrThrow(community, userId);
        Community communityWithoutNewMember = community.decrementMembers();
        Community updatedCommunity = communityRepository.update(communityWithoutNewMember);
        communityRepository.leaveCommunity(updatedCommunity, userId);
    }
}
