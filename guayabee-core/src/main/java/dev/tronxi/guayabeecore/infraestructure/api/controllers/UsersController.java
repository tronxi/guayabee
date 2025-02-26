package dev.tronxi.guayabeecore.infraestructure.api.controllers;

import dev.tronxi.guayabeecore.domain.models.Community;
import dev.tronxi.guayabeecore.domain.usecases.JoinCommunityUseCase;
import dev.tronxi.guayabeecore.domain.usecases.LeaveCommunityUseCase;
import dev.tronxi.guayabeecore.domain.usecases.RetrieveCommunityUseCase;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("users")
public class UsersController {

    private final JoinCommunityUseCase joinCommunityUseCase;
    private final RetrieveCommunityUseCase retrieveCommunityUseCase;
    private final LeaveCommunityUseCase leaveCommunityUseCase;


    public UsersController(JoinCommunityUseCase joinCommunityUseCase, RetrieveCommunityUseCase retrieveCommunityUseCase, LeaveCommunityUseCase leaveCommunityUseCase) {
        this.joinCommunityUseCase = joinCommunityUseCase;
        this.retrieveCommunityUseCase = retrieveCommunityUseCase;
        this.leaveCommunityUseCase = leaveCommunityUseCase;
    }


    @PutMapping("/communities/{communityId}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Void> join(Principal principal, @PathVariable Long communityId) {
        JwtAuthenticationToken token = (JwtAuthenticationToken) principal;
        String userId = token.getTokenAttributes().get("sub").toString();
        joinCommunityUseCase.joinCommunity(communityId, userId);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/communities/{communityId}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Void> leave(Principal principal, @PathVariable Long communityId) {
        JwtAuthenticationToken token = (JwtAuthenticationToken) principal;
        String userId = token.getTokenAttributes().get("sub").toString();
        leaveCommunityUseCase.leaveCommunity(communityId, userId);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/communities")
    public ResponseEntity<List<Community>> retrieveByUserId(Principal principal) {
        JwtAuthenticationToken token = (JwtAuthenticationToken) principal;
        if (principal == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        String userId = token.getTokenAttributes().get("sub").toString();
        return ResponseEntity.ok(retrieveCommunityUseCase.retrieveByUserId(userId));
    }

}
