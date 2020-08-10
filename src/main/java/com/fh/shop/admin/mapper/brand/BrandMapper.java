package com.fh.shop.admin.mapper.brand;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.param.brand.BrandSearchParam;
import com.fh.shop.admin.po.brand.Brand;

import java.util.List;


//继承extends BaseMapper
public interface BrandMapper extends BaseMapper<Brand> {

    //品牌下拉框
    List<Brand> findAllBrandList();
    // 获取总条数
    Long findBrandListCount(BrandSearchParam brandSearchParam);
    // 获取分页列表
    List<Brand> findBrandPageList(BrandSearchParam brandSearchParam);
}
