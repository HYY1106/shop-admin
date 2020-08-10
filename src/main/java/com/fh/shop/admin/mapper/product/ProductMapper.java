package com.fh.shop.admin.mapper.product;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.param.product.ProductParam;
import com.fh.shop.admin.po.product.Product;

import java.util.List;

//继承extends BaseMapper
public interface ProductMapper extends BaseMapper<Product> {

    //查询总条数
    Long findCount(ProductParam productParam);
    //查询分页列表
    List<Product> findPageList(ProductParam productParam);

}
