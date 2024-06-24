package com.springmvc.demo.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.springmvc.demo.models.Room;
import com.springmvc.demo.models.User;

public interface RoomRepository  extends CrudRepository<Room, Long> {

    /**
     * Get list RoomChat by userID
     * @param userID
     * @return
     */
    @Query("SELECT r FROM Room r " +
        "WHERE r.userCreate = :userID OR r.userRoom = :userID " +
        "ORDER BY r.updatedAt DESC")
    Iterable<Room> getListRoomByUserID(@Param("userID") User userID);

    /**
     * Find RoomChat by code (string)
     * @param code
     * @return
     */
    @Query("SELECT r FROM Room r WHERE r.code = :code")
    Optional<Room> findByCode(@Param("code") String code);
    
    /**
     * Check room exists
     * @param userRoom
     * @param userCreate
     * @return
     */
    @Query("SELECT r FROM Room r " + 
        "WHERE (r.userRoom = :userRoom AND r.userCreate = :userCreate) " + 
        "OR (r.userCreate = :userRoom AND r.userRoom = :userCreate)")
    Optional<Room> checkRoomExists(@Param("userRoom") User userRoom, @Param("userCreate") User userCreate);

    /**
     * Get count unread conversations by user
     * @param user
     * @return
     */
    @Query("SELECT r FROM Room r " +
        "JOIN Messages m ON m.roomID = r.ID " + 
        "WHERE m.viewDate IS NULL AND m.userID != :user AND (r.userCreate = :user OR r.userRoom = :user) " + 
        "GROUP BY r.ID")
    List<Room> countUnreadConversations(@Param("user") User user);
}
