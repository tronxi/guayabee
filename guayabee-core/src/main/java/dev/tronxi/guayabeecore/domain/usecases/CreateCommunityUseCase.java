package dev.tronxi.guayabeecore.domain.usecases;

import dev.tronxi.guayabeecore.domain.exceptions.DomainException;
import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.models.CreateCommunityOrder;
import dev.tronxi.guayabeecore.domain.persistence.CommunityRepository;
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
