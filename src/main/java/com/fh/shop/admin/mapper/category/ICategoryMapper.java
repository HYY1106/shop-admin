package com.fh.shop.admin.mapper.category;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.po.category.Category;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ICategoryMapper extends BaseMapper<Category> {

    List<Category> queryCategory();

    void addCategory(Category category);

    void deleteCategory(List<Long> ids);

    List<Category> queryCategoryAll(int pid);


}
