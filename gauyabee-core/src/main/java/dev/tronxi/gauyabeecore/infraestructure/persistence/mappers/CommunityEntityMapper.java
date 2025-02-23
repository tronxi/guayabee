package dev.tronxi.gauyabeecore.infraestructure.persistence.mappers;

import dev.tronxi.gauyabeecore.domain.models.Community;
import dev.tronxi.gauyabeecore.domain.models.CreateCommunityOrder;
import dev.tronxi.gauyabeecore.infraestructure.persistence.entities.CommunityEntity;
import org.springframework.stereotype.Component;

@Component
public class CommunityEntityMapper {

    public CommunityEntity toEntity(CreateCommunityOrder createCommunityOrder) {
        CommunityEntity communityEntity = new CommunityEntity();
        communityEntity.setName(createCommunityOrder.name());
        communityEntity.setDescription(createCommunityOrder.description());
        communityEntity.setImageUrl(createCommunityOrder.imageUrl());
        communityEntity.setMembers(0L);
        return communityEntity;
    }

    public CommunityEntity toEntity(Community community) {
        CommunityEntity communityEntity = new CommunityEntity();
        communityEntity.setId( community.id());
        communityEntity.setName(community.name());
        communityEntity.setDescription(community.description());
        communityEntity.setImageUrl(community.imageUrl());
        communityEntity.setMembers(community.members());
        return communityEntity;
    }

    public Community toDomain(CommunityEntity communityEntity) {
        return new Community(communityEntity.getId(),
                communityEntity.getName(),
                communityEntity.getDescription(),
                communityEntity.getImageUrl(),
                communityEntity.getMembers());
    }
}
