package dev.tronxi.gauyabeecore.infraestructure.api.controllers;

import dev.tronxi.gauyabeecore.domain.models.Community;
import dev.tronxi.gauyabeecore.domain.usecases.JoinToCommunityUseCase;
import dev.tronxi.gauyabeecore.domain.usecases.RetrieveCommunityUseCase;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("users")
public class UsersController {

    private final JoinToCommunityUseCase joinToCommunityUseCase;

    private final RetrieveCommunityUseCase retrieveCommunityUseCase;


    public UsersController(JoinToCommunityUseCase joinToCommunityUseCase, RetrieveCommunityUseCase retrieveCommunityUseCase) {
        this.joinToCommunityUseCase = joinToCommunityUseCase;
        this.retrieveCommunityUseCase = retrieveCommunityUseCase;
    }


    @PutMapping("/communities/{communityId}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Void> join(Principal principal, @PathVariable Long communityId) {
        JwtAuthenticationToken token = (JwtAuthenticationToken) principal;
        String userId = token.getTokenAttributes().get("sub").toString();
        joinToCommunityUseCase.joinToCommunity(communityId, userId);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/communities")
    public ResponseEntity<List<Community>> retrieveByUserId(Principal principal) {
        JwtAuthenticationToken token = (JwtAuthenticationToken) principal;
        String userId = token.getTokenAttributes().get("sub").toString();
        return ResponseEntity.ok(retrieveCommunityUseCase.retrieveByUserId(userId));
    }

}
