package com.springmvc.demo.models;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

//POJO - Plain Object Java Object
@Entity
@Table(name = "users")
public class User {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long ID;

    @NotBlank(message = "* Vui lòng nhập tài khoản")
    // @Min(value = 3, message = "Tài khoản tối thiểu 3 ký tự")
    @Column(name = "username")
    private String username;  

    @Column(name = "password")
    private String password;

    @Column(name = "role")
    private Integer role;

    @Column(name = "avatar")
    private String avatar;

    //@NotBlank(message = "* Vui lòng nhập họ và tên")
    // @Min(value = 3, message = "Họ và tên tối thiểu 3 ký tự")
    @Column(name = "full_name")
    private String fullName;

    @Column(name = "gender")
    private Integer gender;

    @Column(name = "phone")
    private String phone;

    @Email(message = "Email không hợp lệ")
    @Column(name = "email")
    private String email;

    @Column(name = "introduce")
    private String introduce;

    @Column(name = "status", columnDefinition = "integer default 1")
    private Integer status = 1;
    
    @Column(name = "total_follow")
    private Integer totalFollow = 0;

    @OneToMany(mappedBy = "userID", cascade = CascadeType.ALL)
    private List<Post> posts;

    @OneToMany(mappedBy = "userID", cascade = CascadeType.ALL)
    private List<Comment> comments;

    @OneToMany(mappedBy = "userID", cascade = CascadeType.ALL)
    private List<LikesHistory> likesHistory;

    @Column(name = "created_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt = new Date();

    @Column(name = "updated_at", columnDefinition = "TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt = new Date();
    
    public User(){}
    public User(Long ID,
                String username, 
                String password, 
                Integer role, 
                String avatar, 
                String fullName, 
                Integer gender, 
                String phone, 
                String email, 
                String introduce, 
                List<Post> posts, 
                Integer status,
                Date createdAt, 
                Date updatedAt)
    {
        this.ID = ID;
        this.username = username;
        this.password = password;
        this.role = 1;
        this.avatar = avatar;
        this.fullName = fullName;
        this.gender = gender;
        this.phone = phone;
        this.email = email;
        this.introduce = introduce;
        this.posts = posts;
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

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return username;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getRole() {
        return role;
    }
    public void setRole(Integer role) {
        this.role = role;
    }

    public String getAvatar() {
        return avatar;
    }
    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getFullName() {
        return fullName;
    }
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Integer getGender() {
        return gender;
    }
    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getIntroduce() {
        return introduce;
    }
    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }
   
    public Integer getTotalFollow() {
        return totalFollow;
    }
    public void setTotalFollow(Integer totalFollow) {
        this.totalFollow = totalFollow;
    }

    public List<Post> getPosts() {
        return posts;
    }

    public void setPosts(List<Post> posts) {
        this.posts = posts;
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
