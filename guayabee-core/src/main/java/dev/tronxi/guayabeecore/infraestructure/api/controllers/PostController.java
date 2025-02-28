package dev.tronxi.guayabeecore.infraestructure.api.controllers;

import dev.tronxi.guayabeecore.domain.models.CreatePostOrder;
import dev.tronxi.guayabeecore.domain.models.Post;
import dev.tronxi.guayabeecore.domain.usecases.CreatePostUseCase;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("posts")
public class PostController {

    private final CreatePostUseCase createPostUseCase;

    public PostController(CreatePostUseCase createPostUseCase) {
        this.createPostUseCase = createPostUseCase;
    }

    @PostMapping
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Post> create(@RequestBody CreatePostOrder createPostOrder) {
        Post post = createPostUseCase.create(createPostOrder);
        return ResponseEntity.ok(post);
    }
}
