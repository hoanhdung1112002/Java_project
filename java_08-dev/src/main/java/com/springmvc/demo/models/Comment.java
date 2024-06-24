package com.springmvc.demo.models;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.springmvc.demo.Utilities.Functions;

@Entity
@Table(name = "comments")
public class Comment {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID;

    @Column(name = "content")
    private String content;

    @Column(name = "parent_id")
    private Long parentID = 0L;

    @Column(name = "total_like")
    private Integer totalLike = 0;

    @Column(name = "total_replies")
    private Integer totalReplies = 0;

    @Column(name = "status", columnDefinition = "integer default 1")
    private Integer status = 0;

    @Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt = new Date();

    @Column(name = "updated_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt = new Date();

    @ManyToOne
    @JoinColumn(name = "user_create")
    private User userID;

    @ManyToOne
    @JoinColumn(name = "post_id")
    private Post postID;

    @OneToMany(mappedBy = "commentID", cascade = CascadeType.ALL)
    private List<LikesHistory> likesHistory;

    public String convertCreatedAt() {
        return Functions.convertTime(this.createdAt);
    }
    
    public Comment(){}
    public Comment(Long ID,
                Long parentID,
                User userID,
                Post postID,
                String content,
                Integer totalLike,
                Integer totalReplies,
                Integer status,
                Date createdAt, 
                Date updatedAt)
    {
        this.ID = ID;
        this.userID = userID;
        this.postID = postID;
        this.parentID = parentID;
        this.totalLike = totalLike;
        this.totalReplies = totalReplies;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getID() {return ID;}
    public void setID(Long ID) {this.ID = ID;}

    public User getUserID() {return userID;}
    public void setUserID(User userID) {this.userID = userID;}

    public Post getPostID() {return postID;}
    public void setPostID(Post postID) {this.postID = postID;}

    public Long getParentID() {return parentID;}
    public void setParentID(Long parentID) {this.parentID = parentID;}

    public String getContent() {return content;}
    public void setContent(String content) {this.content = content;}

    public Integer getTotalLike() {return totalLike;}
    public void setTotalLike(Integer totalLike) {this.totalLike = totalLike;}

    public Integer getTotalReplies() {return totalReplies;}
    public void setTotalReplies(Integer totalReplies) {this.totalReplies = totalReplies;}

    public Integer getStatus() {return status;}
    public void setStatus(Integer status) {this.status = status;}

    public Date getCreateAt() {return createdAt;}
    public void setCreateAt(Date createdAt) {this.createdAt = createdAt;}

    public Date getUpdateAt() {return updatedAt;}
    public void setUpdateAt(Date updateAt) {this.updatedAt = new Date();}
}