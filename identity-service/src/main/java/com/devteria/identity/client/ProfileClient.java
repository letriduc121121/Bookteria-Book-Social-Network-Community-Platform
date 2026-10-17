package com.devteria.identity.client;

import java.awt.*;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.devteria.identity.dto.request.ProfileCreateRequest;
import com.devteria.identity.dto.response.UserProfileResponse;

// day la tang su dung feign client
@FeignClient(name = "profile-service", url = "http://localhost:8081/profile")
public interface ProfileClient {

    @PostMapping(value = "/users", produces = MediaType.APPLICATION_JSON_VALUE)
    UserProfileResponse createProfile(@RequestBody ProfileCreateRequest profileCreateRequest);
}
