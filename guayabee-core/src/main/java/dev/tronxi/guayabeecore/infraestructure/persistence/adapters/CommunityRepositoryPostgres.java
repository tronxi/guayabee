package dev.tronxi.guayabeecore.infraestructure.persistence.adapters;

import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.models.CreateCommunityOrder;
import dev.tronxi.guayabeecore.domain.persistence.CommunityRepository;
import dev.tronxi.guayabeecore.infraestructure.persistence.entities.CommunityEntity;
import dev.tronxi.guayabeecore.infraestructure.persistence.entities.UserCommunityEntity;
import dev.tronxi.guayabeecore.infraestructure.persistence.jpa.CommunityRepositoryJPA;
import dev.tronxi.guayabeecore.infraestructure.persistence.jpa.UserCommunityRepositoryJPA;
import dev.tronxi.guayabeecore.infraestructure.persistence.mappers.CommunityEntityMapper;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class CommunityRepositoryPostgres implements CommunityRepository {

    private final CommunityEntityMapper communityEntityMapper;
    private final CommunityRepositoryJPA communityRepository;
    private final CommunityRepositoryJPA communityRepositoryJPA;
    private final UserCommunityRepositoryJPA userCommunityRepositoryJPA;

    public CommunityRepositoryPostgres(CommunityEntityMapper communityEntityMapper, CommunityRepositoryJPA communityRepository, CommunityRepositoryJPA communityRepositoryJPA, UserCommunityRepositoryJPA userCommunityRepositoryJPA) {
        this.communityEntityMapper = communityEntityMapper;
        this.communityRepository = communityRepository;
        this.communityRepositoryJPA = communityRepositoryJPA;
        this.userCommunityRepositoryJPA = userCommunityRepositoryJPA;
    }

    @Override
    public List<Community> findAll() {
        return communityRepositoryJPA.findAllByOrderByMembersDesc().stream()
                .map(communityEntityMapper::toDomain)
                .toList();
    }

    @Override
    public List<Community> findAllByUserId(String userId) {
        return userCommunityRepositoryJPA.findByUserIdOrderByCommunityEntityMembersDesc(userId).stream()
                .map(UserCommunityEntity::getCommunityEntity)
                .map(communityEntityMapper::toDomain)
                .toList();
    }

    @Override
    public Community create(CreateCommunityOrder createCommunityOrder) {
        CommunityEntity communityEntityToSave = communityEntityMapper.toEntity(createCommunityOrder);
        CommunityEntity savedCommunityEntity = communityRepository.save(communityEntityToSave);
        return communityEntityMapper.toDomain(savedCommunityEntity);
    }

    @Override
    public Community update(Community community) {
        CommunityEntity communityEntityToUpdate = communityEntityMapper.toEntity(community);
        CommunityEntity updated = communityRepositoryJPA.save(communityEntityToUpdate);
        return communityEntityMapper.toDomain(updated);
    }

    @Override
    public Optional<Community> findByName(String name) {
        return communityRepositoryJPA.findByName(name)
                .map(communityEntityMapper::toDomain);
    }

    @Override
    public Optional<Community> findById(Long id) {
        return communityRepositoryJPA.findById(id)
                .map(communityEntityMapper::toDomain);
    }

    @Override
    public Optional<Community> findByCommunityAndUserId(Community community, String userId) {
        CommunityEntity communityEntity = communityEntityMapper.toEntity(community);
        return userCommunityRepositoryJPA.findByCommunityEntityAndUserId(communityEntity, userId)
                .map(UserCommunityEntity::getCommunityEntity)
                .map(communityEntityMapper::toDomain);
    }

    @Override
    public void joinCommunity(Community community, String userId) {
        CommunityEntity communityEntity = communityEntityMapper.toEntity(community);
        UserCommunityEntity userCommunity = new UserCommunityEntity();
        userCommunity.setCommunityEntity(communityEntity);
        userCommunity.setUserId(userId);
        userCommunityRepositoryJPA.save(userCommunity);
    }

    @Override
    public void leaveCommunity(Community community, String userId) {
        CommunityEntity communityEntity = communityEntityMapper.toEntity(community);
        Optional<UserCommunityEntity> maybeUserCommunityEntity = userCommunityRepositoryJPA.findByCommunityEntityAndUserId(communityEntity, userId);
        maybeUserCommunityEntity.ifPresent(userCommunityRepositoryJPA::delete);
    }
}
