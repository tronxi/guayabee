package dev.tronxi.guayabeecore.infraestructure.persistence.adapters;

import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.models.CreatePostOrder;
import dev.tronxi.guayabeecore.domain.models.Post;
import dev.tronxi.guayabeecore.domain.persistence.PostRepository;
import dev.tronxi.guayabeecore.infraestructure.persistence.entities.PostEntity;
import dev.tronxi.guayabeecore.infraestructure.persistence.jpa.PostRepositoryJPA;
import dev.tronxi.guayabeecore.infraestructure.persistence.mappers.PostEntityMapper;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class PostRepositoryPostgres implements PostRepository {

    private final PostRepositoryJPA postRepositoryJPA;
    private final PostEntityMapper postEntityMapper;

    public PostRepositoryPostgres(PostRepositoryJPA postRepositoryJPA, PostEntityMapper postEntityMapper) {
        this.postRepositoryJPA = postRepositoryJPA;
        this.postEntityMapper = postEntityMapper;
    }

    @Override
    public Post create(Community community, CreatePostOrder createPostOrder) {
        PostEntity toSave = postEntityMapper.toEntity(community, createPostOrder);
        PostEntity saved = postRepositoryJPA.save(toSave);
        return postEntityMapper.toDomain(saved);
    }

    @Override
    public List<Post> retrievePostsByCommunity(Community community) {
        return postRepositoryJPA.findByCommunity_Id(community.id()).stream()
                .map(postEntityMapper::toDomain)
                .toList();
    }
}
