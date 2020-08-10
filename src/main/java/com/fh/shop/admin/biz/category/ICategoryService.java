package com.fh.shop.admin.biz.category;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.category.Category;

import java.util.List;

public interface ICategoryService {

    ServerResponse queryCategory();

    ServerResponse addCategory(Category category);

    void deleteCategory(List<Long> ids);

    List<Category> queryCategoryAll(int id);
}
