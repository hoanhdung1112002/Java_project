package com.springmvc.demo.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc.demo.models.Comment;
import com.springmvc.demo.repositories.CommentRepository;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    /**
     * Get list comments by postID
     * @return
     */
    // public Iterable<Comment> getAllUsers() {
    //     return commentRepository.findAll();
    // }
}
