package dev.tronxi.gauyabeecore.infraestructure.persistence.jpa;

import dev.tronxi.gauyabeecore.infraestructure.persistence.entities.CommunityEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CommunityRepositoryJPA extends JpaRepository<CommunityEntity, Long> {
    Optional<CommunityEntity> findByName(String name);
}
