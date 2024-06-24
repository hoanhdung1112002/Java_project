package com.springmvc.demo.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.springmvc.demo.models.LikesHistory;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.Report;
import com.springmvc.demo.models.User;

public interface ReportRepository  extends CrudRepository<Report, Long> {

    /**
     * Get report of post
     * @return Iterable<Report>
     */
    @Query("SELECT rp FROM Report rp WHERE rp.postID IS NOT NULL AND rp.commentID IS NULL AND rp.status = 1 ORDER BY rp.createdAt DESC")
    Iterable<Report> getReportPosts();

    /**
     * Find report by post ID
     * @return Optional<Report>
     */
    @Query("SELECT rp FROM Report rp WHERE rp.postID = :postID")
    Optional<Report> findReportByPostID(@Param("postID") Post postID);
}
