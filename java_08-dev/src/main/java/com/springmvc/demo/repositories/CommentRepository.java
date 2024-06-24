package com.springmvc.demo.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.springmvc.demo.models.Comment;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.User;

public interface CommentRepository  extends CrudRepository<Comment, Long> {

    /**
     * Get comments by postID
     * @param postID
     * @return
     */
    @Query("SELECT c FROM Comment c JOIN User u ON c.userID = u.ID WHERE c.postID = :post ORDER BY c.createdAt DESC")
    Iterable<Comment> getCommentsByPostID(@Param("post") Post post);

    /**
     * Get comments by parentID
     * @param parentID
     * @return
     */
    @Query("SELECT c FROM Comment c WHERE c.parentID = :parentID ORDER BY c.createdAt DESC")
    List<Comment> getCommentByParentID(@Param("parentID") Long parentID);

    /**
     * Get all post by userID
     * @param userID
     * @return
     */
    @Query("SELECT c FROM Comment c JOIN User u ON c.userID = u.ID WHERE c.userID = :userID ORDER BY c.createdAt DESC")
    Iterable<Comment> getAllCommentByUserID(@Param("userID") User userID);
}
