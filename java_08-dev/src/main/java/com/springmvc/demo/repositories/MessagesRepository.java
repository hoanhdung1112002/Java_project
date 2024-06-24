package com.springmvc.demo.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.springmvc.demo.models.Messages;
import com.springmvc.demo.models.Room;
import org.springframework.data.domain.Pageable;

public interface MessagesRepository  extends CrudRepository<Messages, Long> {

    /**
     * Get messages mới nhất by roomID ORDER BY m.createdAt DESC
     * @param roomID
     * @return
     */
    @Query("SELECT m FROM Messages m WHERE m.roomID = :roomID ORDER BY m.createdAt DESC")
    List<Messages> getFirstMessagesByRoomID(@Param("roomID") Room roomID, Pageable pageable);

    /**
     * Get messages by roomID ORDER BY m.createdAt ASC
     * @param roomID
     * @return
     */
    @Query("SELECT m FROM Messages m WHERE m.roomID = :roomID ORDER BY m.createdAt ASC")
    List<Messages> getMessagesByRoomID(@Param("roomID") Room roomID, Pageable pageable);
}
