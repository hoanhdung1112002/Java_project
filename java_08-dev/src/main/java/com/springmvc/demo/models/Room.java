package com.springmvc.demo.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.springmvc.demo.Utilities.Functions;

@Entity
@Table(name = "chatroom")
public class Room {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID;

    @Column(name = "code")
    private String code;  

    @ManyToOne
    @JoinColumn(name = "user_create")
    private User userCreate;

    @ManyToOne
    @JoinColumn(name = "user_room")
    private User userRoom;

    @Column(name = "type")
    private String type;

    @Column(name = "type_id")
    private Integer typeID;

    @Column(name = "status", columnDefinition = "integer default 1")
    private Integer status = 0;

    @Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt = new Date();

    @Column(name = "updated_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt = new Date();

    public String convertCreatedAt() {
        return Functions.convertTime(this.createdAt);
    }

    // Default constructor
    public Room() {
        // You can initialize default values here if needed
    }

    // Parameterized constructor
    public Room(String code, User userCreate, User userRoom, String type, Integer typeID) {
        this.code = code;
        this.userCreate = userCreate;
        this.userRoom = userRoom;
        this.type = type;
        this.typeID = typeID;
    }

    // Setters and Getters
    public Long getID() {
        return ID;
    }

    public void setID(Long ID) {
        this.ID = ID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public User getUserCreate() {
        return userCreate;
    }

    public void setUserCreate(User userCreate) {
        this.userCreate = userCreate;
    }

    public User getUserRoom() {
        return userRoom;
    }

    public void setUserRoom(User userRoom) {
        this.userRoom = userRoom;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getTypeID() {
        return typeID;
    }

    public void setTypeID(Integer typeID) {
        this.typeID = typeID;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
}