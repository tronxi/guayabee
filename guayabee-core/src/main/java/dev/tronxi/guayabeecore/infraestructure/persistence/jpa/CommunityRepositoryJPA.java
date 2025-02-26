package dev.tronxi.guayabeecore.infraestructure.persistence.jpa;

import dev.tronxi.guayabeecore.infraestructure.persistence.entities.CommunityEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CommunityRepositoryJPA extends JpaRepository<CommunityEntity, Long> {
    List<CommunityEntity> findAllByOrderByMembersDesc();
    Optional<CommunityEntity> findByName(String name);
}
