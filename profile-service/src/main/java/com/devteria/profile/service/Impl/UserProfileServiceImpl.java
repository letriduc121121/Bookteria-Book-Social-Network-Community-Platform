package com.devteria.profile.service.Impl;

import org.springframework.stereotype.Service;

import com.devteria.profile.dto.request.ProfileCreateRequest;
import com.devteria.profile.dto.response.UserProfileResponse;
import com.devteria.profile.entity.UserProfile;
import com.devteria.profile.mapper.UserProfileMapper;
import com.devteria.profile.repository.UserProfileRepository;
import com.devteria.profile.service.UserProfileService;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class UserProfileServiceImpl implements UserProfileService {

    UserProfileRepository userProfileRepository;

    UserProfileMapper userProfileMapper;

    @Override
    public UserProfileResponse createProfile(ProfileCreateRequest profileCreateRequest) {
        UserProfile userProfile = userProfileMapper.toUserProfile(profileCreateRequest);

        userProfile = userProfileRepository.save(userProfile);

        log.info(userProfile.toString());

        // chuyen ve response tra ve client
        return userProfileMapper.toUserProfileResponse(userProfile);
    }

    @Override
    public UserProfileResponse getProfile(String profileId) {

        UserProfile userProfile = userProfileRepository
                .findById(profileId)
                .orElseThrow(() -> new RuntimeException("Khong tim kiem user Id"));
        log.info(userProfile.toString());
        return userProfileMapper.toUserProfileResponse(userProfile);
    }
}
