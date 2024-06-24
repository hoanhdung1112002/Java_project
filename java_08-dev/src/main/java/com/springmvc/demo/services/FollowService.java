package com.springmvc.demo.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.demo.models.Follow;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.FollowRepository;

@Service
public class FollowService {
    @Autowired
    private FollowRepository followRepository;

    public Boolean isLiked(User follower, User following) {
        Follow check = followRepository.isFollow(follower, following);
        return check != null;
    }
}
