package com.fh.shop.admin.biz.brand;


import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.brand.BrandSearchParam;
import com.fh.shop.admin.po.brand.Brand;

public interface BrandService {




    //品牌下拉框
    ServerResponse findAllBrandList();
    //查询
    DataTableResult findBrandList(BrandSearchParam brandSearchParam);
    //添加
    ServerResponse addBrand(Brand brand);
}
