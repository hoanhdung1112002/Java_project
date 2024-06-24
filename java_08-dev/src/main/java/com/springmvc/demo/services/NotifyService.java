package com.springmvc.demo.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.demo.models.Notification;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.NotifyRepository;

@Service
public class NotifyService {
    @Autowired
    private NotifyRepository notifyRepository;

    /**
     * Create notify
     * @param userSend
     * @param userInbox
     * @param content
     * @param type
     * @return
     */
    public Notification store(User userSend, User userInbox, Post postID, String content, Integer type) {
        Notification notification = new Notification();

        notification.setUserSend(userSend);
        notification.setUserInbox(userInbox);
        notification.setPostID(postID);
        notification.setStatus(1); // Chưa đọc
        notification.setType(type);
        notification.setContent(content);

        Notification notifyCrete = notifyRepository.save(notification);
        return notifyCrete;
    }

    /**
     * Delete notify by (userSend, postID, type)
     * @param userSend
     * @param postID
     * @param type
     * @return
     */
    public Boolean destroy(User userSend, Post postID, Integer type) {
        Optional<Notification> findNotify = notifyRepository.findByUserSendAndPostID(userSend, postID, type);
        if (findNotify.isPresent()) {
            notifyRepository.deleteById(findNotify.get().getID());
            return true;
        }
        return false;
    }

    /**
     * Delete notify by (userSend, userInbox, type)
     * @param userSend
     * @param userInbox
     * @param type
     * @return
     */
    public Boolean destroyTypeFollow(User userSend, User userInbox, Integer type) {
        Optional<Notification> findNotify = notifyRepository.findTypeFollow(userSend, userInbox, type);
        if (findNotify.isPresent()) {
            notifyRepository.deleteById(findNotify.get().getID());
            return true;
        }
        return false;
    }
}
