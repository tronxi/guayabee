package dev.tronxi.guayabeecore.domain.services;

import dev.tronxi.guayabeecore.domain.exceptions.DomainException;
import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.persistence.CommunityRepository;
import org.springframework.stereotype.Component;

@Component
public class UserInCommunityChecker {

    private final CommunityRepository communityRepository;

    public UserInCommunityChecker(CommunityRepository communityRepository) {
        this.communityRepository = communityRepository;
    }

    public void validateMembershipOrThrow(Community community, String userId) {
        if (communityRepository.findByCommunityAndUserId(community, userId).isPresent()) {
            throw new DomainException("User: " + userId + " already belongs to the community: " + community.id());
        }
    }

    public void validateNotMemberOrThrow(Community community, String userId) {
        if (communityRepository.findByCommunityAndUserId(community, userId).isEmpty()) {
            throw new DomainException("User: " + userId + " does not belong to the community: " + community.id());
        }
    }
}
