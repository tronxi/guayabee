package dev.tronxi.gauyabeecore.infraestructure.persistence.jpa;

import dev.tronxi.gauyabeecore.infraestructure.persistence.entities.CommunityEntity;
import dev.tronxi.gauyabeecore.infraestructure.persistence.entities.UserCommunityEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserCommunityRepositoryJPA extends JpaRepository<UserCommunityEntity, Long> {
    List<UserCommunityEntity> findByUserId(String userId);

    Optional<UserCommunityEntity> findByCommunityEntityAndUserId(CommunityEntity communityEntity, String userId);
}
