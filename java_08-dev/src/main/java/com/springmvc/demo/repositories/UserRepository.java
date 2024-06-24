package com.springmvc.demo.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.springmvc.demo.models.User;

public interface UserRepository  extends CrudRepository<User, Long> {

    /**
     * Get all user role != 0 (Admin)
     * @return
     */
    @Query("SELECT u FROM User u WHERE u.role <> 0")
    Iterable<User> findAllUsersNotAdmin();

    /**
     * Check account login
     * @param email
     * @param password
     * @return
     */
    @Query("SELECT u FROM User u WHERE (u.email = :email OR u.username = :email) AND u.password = :password")
    Iterable<User> authentication(@Param("email") String email, @Param("password") String password);

    /**
     * Check email exists when create user 
     * @param email
     * @return
     */
    @Query("SELECT u FROM User u WHERE u.email = :email ")
    Optional<User> checkEmailExists(@Param("email") String email);

    /**
     * Checks username exist when create user
     * @param username
     * @return
     */
    @Query("SELECT u FROM User u WHERE u.username = :username ")
    Optional<User> checkUsernameExists(@Param("username") String username);

    /**
     * Get top users
     * @param username
     * @return
     */
    @Query("SELECT u, SUM(p.totalView), SUM(p.totalLike), COUNT(u.ID) FROM User u JOIN Post p ON p.userID = u.ID GROUP BY u.ID ORDER BY SUM(p.totalView) DESC")
    List<Object[]> getTopUser(Pageable pageable);
}

