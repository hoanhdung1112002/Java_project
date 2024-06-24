package com.springmvc.demo.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.springmvc.demo.models.LikesHistory;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.User;

public interface LikesHistoryRepository  extends CrudRepository<LikesHistory, Long> {

    /**
     * Check liked post ?
     * @param post
     * @param user
     * @return
     */
    @Query("SELECT c FROM LikesHistory c WHERE c.postID = :post AND c.userID = :user")
    LikesHistory isLiked(@Param("post") Post post, @Param("user") User user);
}
