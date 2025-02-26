package dev.tronxi.guayabeecore.infraestructure.persistence.entities;

import jakarta.persistence.*;

@Entity
public class UserCommunityEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    @ManyToOne(fetch = FetchType.EAGER)
    private CommunityEntity communityEntity;

    private String userId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public CommunityEntity getCommunityEntity() {
        return communityEntity;
    }

    public void setCommunityEntity(CommunityEntity communityEntity) {
        this.communityEntity = communityEntity;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
