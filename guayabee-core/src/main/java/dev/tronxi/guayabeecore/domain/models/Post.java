package dev.tronxi.guayabeecore.domain.models;

public record Post(Community community, Long id, String name, String description, String imageUrl, int upVotes,
                   int downVotes) {
}
