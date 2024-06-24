package com.springmvc.demo.controllers.admin;

import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Category;
import com.springmvc.demo.repositories.CategoryRepository;

import java.util.Date;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(path = "admin/categories")
public class AdminCategoryController extends BaseController{

    /**
     * Init category
     */
    @Autowired
    private CategoryRepository categoryRepository;

    /**
     * Show list of categories
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String getAllCategories(ModelMap modelMap) {
        Iterable<Category> categories = categoryRepository.findAll();
        modelMap.addAttribute("categories", categories);
        return "admin/category/index";
    }

    /**
     * Show view create category
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap modelMap) {
        modelMap.addAttribute("categories", categoryRepository.findAllCategory());
        modelMap.addAttribute("category", new Category());
        return "admin/category/create";
    }

    /**
     * Handle create category
     * @param modelMap
     * @param category
     * @param bindingResult
     * @return View admin/category/create
     */
    @RequestMapping(value = "/store", method = RequestMethod.POST)
    public String store(
        ModelMap modelMap,
        @Valid @ModelAttribute("category") Category category,
        BindingResult bindingResult)
    {
        if (!bindingResult.hasErrors()) {
            try {
                category.setStatus(1);
                categoryRepository.save(category);

                modelMap.addAttribute("success", "Danh mục đã được tạo thành công");
            } catch (Exception e) {
                modelMap.addAttribute("error", "Đã có lỗi xảy ra");
            }
        }
        modelMap.addAttribute("categories", categoryRepository.findAllCategory());
        return "admin/category/create";
    }

    /**
     * Show view edit category
     * @param modelMap
     * @param ID
     * @return
     */
    @RequestMapping(value = "/edit/{ID}", method = RequestMethod.GET)
    public String edit(ModelMap modelMap, @PathVariable Long ID) {
        modelMap.addAttribute("categories", categoryRepository.findAllCategory());
        modelMap.addAttribute("category", categoryRepository.findById(ID).get());
        return "admin/category/edit";
    }

    /**
     * Handle update category by ID
     * @param modelMap
     * @param category
     * @param bindingResult
     * @param ID
     * @return View(admin/category/edit)
     */
    @RequestMapping(value = "/update/{ID}", method = RequestMethod.POST)
    public String update(
        ModelMap modelMap,
        @Valid @ModelAttribute("category") Category category,
        BindingResult bindingResult,
        @PathVariable Long ID)
    {
        if (!bindingResult.hasErrors()) {
            try {
                if (categoryRepository.findById(ID).isPresent()) {
                    Category findCategory = categoryRepository.findById(ID).get();

                    if (!category.getCategoryName().trim().isEmpty()) findCategory.setCategoryName(category.getCategoryName());
                    if (!category.getDescription().trim().isEmpty()) findCategory.setDescription(category.getDescription());
                    if (category.getLevel() != null) findCategory.setLevel(category.getLevel());
                    if (category.getParentID() != null) findCategory.setParentID(category.getParentID());
                    findCategory.setUpdateAt(new Date());

                    categoryRepository.save(findCategory);
                    modelMap.addAttribute("success", "Cập nhật thông tin danh mục thành công");
                }
            } catch (Exception e) {
                modelMap.addAttribute("error", "Đã có lỗi xảy ra");
            }
        }
        modelMap.addAttribute("categories", categoryRepository.findAllCategory());
        return "admin/category/edit";
    }

    /**
     * Change status category
     * @param ID
     * @param value
     * @return
     */
    @RequestMapping(value = "/change-status", method = RequestMethod.POST)
    public ResponseEntity<String> changeStatus(@RequestParam("id") Long ID, @RequestParam("value") Integer value) {
        try {
            Optional<Category> findCategory = categoryRepository.findById(ID);
            if (findCategory.isPresent()) {
                Category category = findCategory.get();
                category.setStatus(value); // 0: HIDE; 1: SHOW
                categoryRepository.save(category);
                return new ResponseEntity<>("Successfully", HttpStatus.OK);
            }
        } catch (Exception e) {}
        return new ResponseEntity<>("INTERNAL_SERVER_ERROR", HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
