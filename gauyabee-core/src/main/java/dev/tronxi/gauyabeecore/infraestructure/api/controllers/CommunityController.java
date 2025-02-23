package dev.tronxi.gauyabeecore.infraestructure.api.controllers;

import dev.tronxi.gauyabeecore.domain.models.Community;
import dev.tronxi.gauyabeecore.domain.models.CreateCommunityOrder;
import dev.tronxi.gauyabeecore.domain.usecases.CreateCommunityUseCase;
import dev.tronxi.gauyabeecore.domain.usecases.RetrieveCommunityUseCase;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;

@RestController
@RequestMapping("communities")
public class CommunityController {

    private final CreateCommunityUseCase createCommunityUseCase;
    private final RetrieveCommunityUseCase retrieveCommunityUseCase;

    public CommunityController(CreateCommunityUseCase createCommunityUseCase, RetrieveCommunityUseCase retrieveCommunityUseCase) {
        this.createCommunityUseCase = createCommunityUseCase;
        this.retrieveCommunityUseCase = retrieveCommunityUseCase;
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Community> createCommunity(@RequestBody CreateCommunityOrder createCommunityOrder) {
        Community community = createCommunityUseCase.create(createCommunityOrder);
        return ResponseEntity.ok(community);
    }

    @GetMapping
    public ResponseEntity<List<Community>> retrieveAll() {
        return ResponseEntity.ok(retrieveCommunityUseCase.retrieveAll());
    }

}
