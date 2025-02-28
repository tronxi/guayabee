package dev.tronxi.guayabeecore.infraestructure.persistence.jpa;

import dev.tronxi.guayabeecore.infraestructure.persistence.entities.PostEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PostRepositoryJPA extends JpaRepository<PostEntity, Long> {

    List<PostEntity> findByCommunity_Id(Long communityId);
}
