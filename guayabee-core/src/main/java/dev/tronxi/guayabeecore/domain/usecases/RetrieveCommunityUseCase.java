package dev.tronxi.guayabeecore.domain.usecases;

import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.persistence.CommunityRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RetrieveCommunityUseCase {

    private final CommunityRepository communityRepository;

    public RetrieveCommunityUseCase(CommunityRepository communityRepository) {
        this.communityRepository = communityRepository;
    }

    public List<Community> retrieveAll() {
        return communityRepository.findAll();
    }

    public List<Community> retrieveByUserId(String userId) {
        return communityRepository.findAllByUserId(userId);
    }
}
