package dev.tronxi.guayabeecore.infraestructure.persistence.mappers;

import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.models.CreatePostOrder;
import dev.tronxi.guayabeecore.domain.models.Post;
import dev.tronxi.guayabeecore.infraestructure.persistence.entities.CommunityEntity;
import dev.tronxi.guayabeecore.infraestructure.persistence.entities.PostEntity;
import org.springframework.stereotype.Component;

@Component
public class PostEntityMapper {
    private final CommunityEntityMapper communityEntityMapper;

    public PostEntityMapper(CommunityEntityMapper communityEntityMapper) {
        this.communityEntityMapper = communityEntityMapper;
    }

    public PostEntity toEntity(Community community, CreatePostOrder createPostOrder) {
        CommunityEntity communityEntity = communityEntityMapper.toEntity(community);
        PostEntity postEntity = new PostEntity();
        postEntity.setCommunity(communityEntity);
        postEntity.setName(createPostOrder.name());
        postEntity.setDescription(createPostOrder.description());
        postEntity.setImageUrl(createPostOrder.imageUrl());
        postEntity.setUpVotes(0);
        postEntity.setDownVotes(0);
        return postEntity;
    }

    public Post toDomain(PostEntity postEntity) {
        Community community = communityEntityMapper.toDomain(postEntity.getCommunity());
        return new Post(community, postEntity.getId(), postEntity.getName(), postEntity.getDescription(), postEntity.getImageUrl(), postEntity.getUpVotes(), postEntity.getDownVotes());
    }
}
