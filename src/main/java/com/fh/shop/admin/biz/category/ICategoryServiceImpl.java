package com.fh.shop.admin.biz.category;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.category.ICategoryMapper;
import com.fh.shop.admin.po.category.Category;
import com.fh.shop.admin.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("categoryService")
public class ICategoryServiceImpl implements ICategoryService {

    @Autowired
    private ICategoryMapper categoryMapper;

    // 查询分类列表
    @Override
    public ServerResponse queryCategory() {
        // 先查缓存
        String categoryListJson = RedisUtil.get("categoryJson");
        // 缓存中有数据直接返回
        if (StringUtils.isNotEmpty(categoryListJson)){
            // 将json格式的字符串转为Java对象
            List<Category> categories = JSONObject.parseArray(categoryListJson, Category.class);
            return ServerResponse.success(categories);
        }
        // 缓存中没有数据 从数据库中查找数据 并把数据往缓存中放一份 再返回
        List<Category> list = categoryMapper.selectList(null);
        // 将java对象转换为json格式的字符串
        String cateJsonStr = JSONObject.toJSONString(list);
        // 将数据 存入 Redis 缓存 一份
        RedisUtil.set("categoryJson" , cateJsonStr);
        // 再将数据返回到前台
        return ServerResponse.success(list);
    }

    // 新增分类
    @Override
    public ServerResponse addCategory(Category category) {
        categoryMapper.addCategory(category);
        RedisUtil.del("categoryJson");
        // 缓存中没有数据 从数据库中查找数据 并把数据往缓存中放一份 再返回
        List<Category> list = categoryMapper.selectList(null);
        // 将java对象转换为json格式的字符串
        String cateJsonStr = JSONObject.toJSONString(list);
        // 将数据 存入 Redis 缓存 一份
        RedisUtil.set("categoryJson" , cateJsonStr);
        return ServerResponse.success(category.getId());
    }

    @Override
    public void deleteCategory(List<Long> ids) {
        categoryMapper.deleteCategory(ids);
    }


    @Override
    public List<Category> queryCategoryAll(int id) {
        return categoryMapper.queryCategoryAll(id);
    }


}
