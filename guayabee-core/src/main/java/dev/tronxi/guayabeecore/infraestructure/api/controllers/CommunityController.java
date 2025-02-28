package dev.tronxi.guayabeecore.infraestructure.api.controllers;

import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.models.CreateCommunityOrder;
import dev.tronxi.guayabeecore.domain.models.Post;
import dev.tronxi.guayabeecore.domain.usecases.CreateCommunityUseCase;
import dev.tronxi.guayabeecore.domain.usecases.RetrieveCommunityUseCase;
import dev.tronxi.guayabeecore.domain.usecases.RetrievePostsByCommunityUseCase;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;

@RestController
@RequestMapping("communities")
public class CommunityController {

    private final CreateCommunityUseCase createCommunityUseCase;
    private final RetrieveCommunityUseCase retrieveCommunityUseCase;
    private final RetrievePostsByCommunityUseCase retrievePostsByCommunityUseCase;

    public CommunityController(CreateCommunityUseCase createCommunityUseCase, RetrieveCommunityUseCase retrieveCommunityUseCase, RetrievePostsByCommunityUseCase retrievePostsByCommunityUseCase) {
        this.createCommunityUseCase = createCommunityUseCase;
        this.retrieveCommunityUseCase = retrieveCommunityUseCase;
        this.retrievePostsByCommunityUseCase = retrievePostsByCommunityUseCase;
    }

    @PostMapping
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Community> createCommunity(@RequestBody CreateCommunityOrder createCommunityOrder) {
        Community community = createCommunityUseCase.create(createCommunityOrder);
        return ResponseEntity.ok(community);
    }

    @GetMapping
    public ResponseEntity<List<Community>> retrieveAll() {
        return ResponseEntity.ok(retrieveCommunityUseCase.retrieveAll());
    }

    @GetMapping("{communityId}/posts")
    public ResponseEntity<List<Post>> retrieveAllPosts(@PathVariable Long communityId) {
        List<Post> posts = retrievePostsByCommunityUseCase.retrievePostsByCommunity(communityId);
        return ResponseEntity.ok(posts);
    }

}
