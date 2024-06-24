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
import javax.validation.constraints.NotBlank;

import com.springmvc.demo.Utilities.Functions;

@Entity
@Table(name = "posts")
public class Post {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID;

    @Column(name = "category_id")
    private Long categoryID;  

    @Column(name = "tags")
    private String tags;

    @Column(name = "avatar")
    private String avatar;

    @NotBlank(message = "Tiêu đề bài viết bắt buộc nhập")
    @Column(name = "title")
    private String title;

    @Column(name = "slug")
    private String slug;

    @Column(name = "content")
    private String content;

    @Column(name = "total_view")
    private Integer totalView = 0;

    @Column(name = "total_like")
    private Integer totalLike = 0;

    @Column(name = "total_comment")
    private Integer totalComment = 0;

    @Column(name = "total_share")
    private Integer totalShare = 0;

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

    @OneToMany(mappedBy = "postID", cascade = CascadeType.ALL)
    private List<Comment> comments;

    @OneToMany(mappedBy = "postID", cascade = CascadeType.ALL)
    private List<LikesHistory> likesHistory;

    public String convertCreatedAt() {
        return Functions.convertTime(this.createdAt);
    }
    
    public Post(){}
    public Post(Long ID,
                User userID,
                Long categoryID,
                String tags,
                String avatar,
                String title,
                String slug,
                String content,
                Integer totalView,
                Integer totalLike,
                Integer totalComment,
                Integer totalShare,
                Integer status,
                Date createdAt, 
                Date updatedAt)
    {
        this.ID = ID;
        this.userID = userID;
        this.categoryID = categoryID;
        this.tags = tags;
        this.avatar = avatar;
        this.title = title;
        this.slug = slug;
        this.content = content;
        this.totalView = totalView;
        this.totalLike = totalLike;
        this.totalComment = totalComment;
        this.totalShare = totalShare;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Long getID() {
        return ID;
    }
    public void setID(Long ID) {
        this.ID = ID;
    }

    public User getUserID() {
        return userID;
    }
    public void setUserID(User userID) {
        this.userID = userID;
    }

    public Long getCategoryID() {
        return categoryID;
    }
    public void setCategoryID(Long categoryID) {
        this.categoryID = categoryID;
    }

    public String getTags() {
        return tags;
    }
    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getAvatar() {
        return avatar;
    }
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getSlug() {
        return slug;
    }
    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public Integer getTotalView() {
        return totalView;
    }
    public void setTotalView(Integer totalView) {
        this.totalView = totalView;
    }

    public Integer getTotalLike() {
        return totalLike;
    }
    public void setTotalLike(Integer totalLike) {
        this.totalLike = totalLike;
    }

    public Integer getTotalComment() {
        return totalComment;
    }
    public void setTotalComment(Integer totalComment) {
        this.totalComment = totalComment;
    }

    public Integer getTotalShare() {
        return totalShare;
    }
    public void setTotalShare(Integer totalShare) {
        this.totalShare = totalShare;
    }

    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreateAt() {
        return createdAt;
    }
    public void setCreateAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdateAt() {
        return updatedAt;
    }
    public void setUpdateAt(Date updateAt) {
        this.updatedAt = new Date();
    }
}