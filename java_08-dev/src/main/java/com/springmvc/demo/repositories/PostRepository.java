package com.springmvc.demo.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.User;

public interface PostRepository  extends CrudRepository<Post, Long> {

    /**
     * Get all post status = 1
     * @param pageable
     * @return
     */
    @Query("SELECT p FROM Post p JOIN User u ON p.userID = u.ID JOIN Category c ON c.ID = p.categoryID WHERE p.status = 1 ORDER BY p.createdAt DESC")
    Page<Post> getAllPosts(Pageable pageable);

    /**
     * Get all posts by categoryID
     * @param categoryID
     * @return
     */
    @Query("SELECT p FROM Post p JOIN User u ON p.userID = u.ID JOIN Category c ON c.ID = p.categoryID WHERE (p.categoryID = :categoryID OR c.parentID = :categoryID) AND p.status = 1 ORDER BY p.createdAt DESC")
    Page<Post> findAllByCategoryID(@Param("categoryID") Long categoryID, Pageable pageable);
    
    /**
     * Get post of user following
     * @param user
     * @param pageable
     * @return
     */
    @Query("SELECT p FROM Post p JOIN User u ON p.userID = u.ID JOIN Follow fl ON fl.followingID = p.userID WHERE fl.followerID = :user AND p.status = 1 ORDER BY p.createdAt DESC")
    Page<Post> getPostFollowing(@Param("user") User user, Pageable pageable);

    /**
     * Get recent posts
     * @param pageable
     * @return
     */
    @Query("SELECT p FROM Post p JOIN User u ON p.userID = u.ID AND p.status = 1 ORDER BY p.createdAt DESC")
    List<Post> findRecentPosts(Pageable pageable);

    /**
     * Search post by title or content
     * @param search
     * @return
     */
    @Query("SELECT p FROM Post p JOIN User u ON p.userID = u.ID WHERE p.title LIKE %:search% AND p.status = 1 ORDER BY p.createdAt DESC")
    Page<Post> searchPost(@Param("search") String search, Pageable pageable);

    /**
     * Get all post by userID
     * @param userID
     * @return
     */
    @Query("SELECT p FROM Post p JOIN User u ON p.userID = u.ID WHERE p.userID = :userID AND p.status = 1 ORDER BY p.createdAt DESC")
    Iterable<Post> getAllPostByUserID(@Param("userID") User userID);

    /**
     * Get top like of user
     * @param pageable
     * @return
     */
    @Query("SELECT p FROM Post p JOIN User u ON p.userID = u.ID WHERE p.userID = :userID AND p.status = 1 ORDER BY p.totalLike DESC")
    List<Post> getTopLikeByUserID(@Param("userID") User userID, Pageable pageable);

    /**
     * Get top view of user
     * @param pageable
     * @return
     */
    @Query("SELECT p FROM Post p JOIN User u ON p.userID = u.ID WHERE p.userID = :userID AND p.status = 1 ORDER BY p.totalView DESC")
    List<Post> getTopViewByUserID(@Param("userID") User userID, Pageable pageable);
    
    /**
     * Get top like all user
     * @param pageable
     * @return
     */
    @Query("SELECT p FROM Post p WHERE p.status = 1 ORDER BY p.totalLike DESC")
    List<Post> getTopLike(Pageable pageable);

    /**
     * Get top view all user
     * @param pageable
     * @return
     */
    @Query("SELECT p FROM Post p WHERE p.status = 1 ORDER BY p.totalView DESC")
    List<Post> getTopView(Pageable pageable);
}
