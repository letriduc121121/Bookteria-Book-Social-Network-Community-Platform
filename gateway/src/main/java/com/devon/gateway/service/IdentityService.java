package com.devon.gateway.service;

import com.devon.gateway.client.IdentityClient;
import com.devon.gateway.dto.request.IntrospectRequest;
import com.devon.gateway.dto.response.ApiResponse;
import com.devon.gateway.dto.response.IntrospectResponse;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class IdentityService {
    IdentityClient identityClient;
    public  Mono<ApiResponse<IntrospectResponse>> introspect(String token){
         return identityClient.introspect(IntrospectRequest.builder().token(token).build());
    }
}
