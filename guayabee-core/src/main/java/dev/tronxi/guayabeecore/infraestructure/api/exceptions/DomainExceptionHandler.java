package dev.tronxi.guayabeecore.infraestructure.api.exceptions;

import dev.tronxi.guayabeecore.domain.exceptions.DomainException;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice

public class DomainExceptionHandler {

    @ExceptionHandler(value = DomainException.class)
    public ResponseEntity<Error> domainExceptionHandler(DomainException exception) {
        return ResponseEntity
                .badRequest()
                .contentType(MediaType.APPLICATION_JSON)
                .body(new Error(exception.getMessage()));
    }
}
