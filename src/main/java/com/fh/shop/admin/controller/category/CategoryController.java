package com.fh.shop.admin.controller.category;

import com.fh.shop.admin.biz.category.ICategoryService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.category.Category;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("category")
@CrossOrigin
public class CategoryController {

    @Resource(name = "categoryService")
    private ICategoryService cateGoryService;

    @RequestMapping("toList")
    public String toList(){
        return "category/list";
    }

    // 查询
    @RequestMapping("queryCategory")
    @ResponseBody
    public ServerResponse queryCategory(){
        return cateGoryService.queryCategory();
    }

    // 查询
    @RequestMapping("queryCategoryAll")
    @ResponseBody
    public ServerResponse queryCategoryAll(int id){
        List<Category> list = cateGoryService.queryCategoryAll(id);
        return ServerResponse.success(list);
    }

    // 新增
    @RequestMapping("addCategory")
    @ResponseBody
    public ServerResponse addCategory(Category category){
        return cateGoryService.addCategory(category);
    }

    // 删除
    @RequestMapping("deleteCategory")
    @ResponseBody
    public ServerResponse deleteCategory(@RequestParam("ids[]") List<Long> ids ){
        cateGoryService.deleteCategory(ids);
        return ServerResponse.success();
    }


}
