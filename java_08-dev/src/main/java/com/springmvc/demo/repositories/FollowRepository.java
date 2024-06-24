package com.springmvc.demo.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.springmvc.demo.models.Follow;
import com.springmvc.demo.models.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface FollowRepository  extends CrudRepository<Follow, Long> {

    /**
     * Check is follow ?
     * @param followerID
     * @param followingID
     * @return
     */
    @Query("SELECT c FROM Follow c WHERE c.followerID = :followerID AND c.followingID = :followingID")
    Follow isFollow(@Param("followerID") User followerID, @Param("followingID") User followingID);

    /**
     * Get list following
     * @param followerID
     * @return
     */
    @Query("SELECT fl FROM Follow fl JOIN User u ON u.ID = fl.followingID WHERE fl.followerID = :followerID")
    Page<Follow> getFollowing(@Param("followerID") User followerID, Pageable pageable);

    /**
     * Get list follower
     * @param followingID
     * @return
     */
    @Query("SELECT fl FROM Follow fl JOIN User u ON u.ID = fl.followerID WHERE fl.followingID = :followerID")
    Page<Follow> getFollower(@Param("followerID") User followerID, Pageable pageable);
}
