package dev.tronxi.guayabeecore.domain.models;

public record Community(Long id, String name, String description, String imageUrl, Long members) {
    public Community incrementMembers() {
        return new Community(id, name, description, imageUrl, members + 1);
    }

    public Community decrementMembers() {
        return new Community(id, name, description, imageUrl, members - 1);
    }
}
