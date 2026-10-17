package com.devteria.profile.service;

import com.devteria.profile.dto.request.ProfileCreateRequest;
import com.devteria.profile.dto.response.UserProfileResponse;

public interface UserProfileService {
    UserProfileResponse createProfile(ProfileCreateRequest profileCreateRequest);

    UserProfileResponse getProfile(String profileId);
}
