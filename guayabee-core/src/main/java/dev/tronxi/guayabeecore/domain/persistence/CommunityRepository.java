package dev.tronxi.guayabeecore.domain.persistence;


import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.models.CreateCommunityOrder;

import java.util.List;
import java.util.Optional;

public interface CommunityRepository {
    Community create(CreateCommunityOrder createCommunityOrder);

    Community update(Community community);

    List<Community> findAll();

    List<Community> findAllByUserId(String userId);

    Optional<Community> findByName(String name);

    Optional<Community> findById(Long id);

    Optional<Community> findByCommunityAndUserId(Community community, String userId);

    void joinCommunity(Community community, String userId);
    void leaveCommunity(Community community, String userId);
}
