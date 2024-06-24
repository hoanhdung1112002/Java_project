package com.springmvc.demo.repositories;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.springmvc.demo.models.Notification;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.User;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface NotifyRepository  extends CrudRepository<Notification, Long> {

    /**
     * Get notify by userSend, type and postID
     * @param userSend
     * @param postID
     * @return
     */
    @Query("SELECT c FROM Notification c WHERE c.userSend = :userSend AND c.postID = :postID AND c.type = :type")
    Optional<Notification> findByUserSendAndPostID(@Param("userSend") User userSend, @Param("postID") Post postID, @Param("type") Integer type);

    /**
     * findTypeFollow
     * @param userSend
     * @param userInbox
     * @param type
     * @return
     */
    @Query("SELECT c FROM Notification c WHERE c.userSend = :userSend AND c.userInbox = :userInbox AND c.type = :type")
    Optional<Notification> findTypeFollow(@Param("userSend") User userSend, @Param("userInbox") User userInbox, @Param("type") Integer type);
    
    /**
     * Get notify of user (by userID)
     * @param userID
     * @param pageable
     * @return
     */
    @Query("SELECT c FROM Notification c WHERE c.userInbox = :userID OR c.userInbox IS NULL ORDER BY c.createdAt DESC")
    Page<Notification> getNotifyByUserID(@Param("userID") User userID, Pageable pageable);

    /**
     * Get notify create by admin
     * @return
     */
    @Query("SELECT c FROM Notification c WHERE c.userInbox IS NULL ORDER BY c.createdAt DESC")
    List<Notification> getNotifyOfAdmin(Pageable pageable);
}

