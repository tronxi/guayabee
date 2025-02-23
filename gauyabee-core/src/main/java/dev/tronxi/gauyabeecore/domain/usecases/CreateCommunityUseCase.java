package dev.tronxi.gauyabeecore.domain.usecases;

import dev.tronxi.gauyabeecore.domain.DomainException;
import dev.tronxi.gauyabeecore.domain.models.Community;
import dev.tronxi.gauyabeecore.domain.models.CreateCommunityOrder;
import dev.tronxi.gauyabeecore.domain.persistence.CommunityRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CreateCommunityUseCase {

    private final CommunityRepository communityRepository;

    public CreateCommunityUseCase(CommunityRepository communityRepository) {
        this.communityRepository = communityRepository;
    }

    public Community create(CreateCommunityOrder createCommunityOrder) {
        Optional<Community> maybeCommunity = communityRepository.findByName(createCommunityOrder.name());
        if (maybeCommunity.isPresent()) {
            throw new DomainException("Community with name " + createCommunityOrder.name() + " already exists");
        }
        return communityRepository.create(createCommunityOrder);
    }
}
