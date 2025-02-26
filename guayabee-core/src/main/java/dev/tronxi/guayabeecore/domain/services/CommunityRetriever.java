package dev.tronxi.guayabeecore.domain.services;

import dev.tronxi.guayabeecore.domain.DomainException;
import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.persistence.CommunityRepository;
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
