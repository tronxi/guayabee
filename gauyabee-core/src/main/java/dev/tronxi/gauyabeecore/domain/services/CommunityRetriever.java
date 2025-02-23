package dev.tronxi.gauyabeecore.domain.services;

import dev.tronxi.gauyabeecore.domain.DomainException;
import dev.tronxi.gauyabeecore.domain.models.Community;
import dev.tronxi.gauyabeecore.domain.persistence.CommunityRepository;
import org.springframework.stereotype.Component;

@Component
public class CommunityRetriever {

    private final CommunityRepository communityRepository;

    public CommunityRetriever(CommunityRepository communityRepository) {
        this.communityRepository = communityRepository;
    }

    public Community retrieveCommunityByIdOrThrow(Long communityId) {
        return communityRepository.findById(communityId)
                .orElseThrow(() -> new DomainException("Community " + communityId + " not found"));
    }
}
