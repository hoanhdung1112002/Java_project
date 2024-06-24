package com.springmvc.demo.repositories;

import com.springmvc.demo.models.Category;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

public interface CategoryRepository extends CrudRepository<Category, Long> {

    /**
     * Get all categories and total posts
     * @return
     */
    @Query("SELECT c FROM Category c WHERE c.status = 1")
    Iterable<Category> findAllCategory();

    /**
     * Get categories and total posts
     * @param pageable
     * @return
     */
    @Query("SELECT c, COUNT(c.ID) FROM Category c JOIN Post p ON p.categoryID = c.ID GROUP BY c.ID ORDER BY COUNT(c.ID) DESC")
    List<Object[]> getCategoryAndTotalPost(Pageable pageable);
}
