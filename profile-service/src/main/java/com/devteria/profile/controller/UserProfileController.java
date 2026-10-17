package com.devteria.profile.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.devteria.profile.dto.request.ProfileCreateRequest;
import com.devteria.profile.dto.response.UserProfileResponse;
import com.devteria.profile.service.UserProfileService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@RestController
@Controller
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserProfileController {
    UserProfileService userProfileService;

    @PostMapping("/users")
    public UserProfileResponse createProfile(@RequestBody ProfileCreateRequest profileCreateRequest) {
        return userProfileService.createProfile(profileCreateRequest);
    }

    @GetMapping("/users/{profileId}")
    public UserProfileResponse getProfile(@PathVariable String profileId) {
        return userProfileService.getProfile(profileId);
    }
}
