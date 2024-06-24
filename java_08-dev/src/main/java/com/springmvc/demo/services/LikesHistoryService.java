package com.springmvc.demo.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.demo.models.LikesHistory;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.LikesHistoryRepository;

@Service
public class LikesHistoryService {
    
    @Autowired
    private LikesHistoryRepository likesHistoryRepository;

    public Boolean isLiked(Post post, User user) {
        LikesHistory check = likesHistoryRepository.isLiked(post, user);
        return check != null;
    }
}
