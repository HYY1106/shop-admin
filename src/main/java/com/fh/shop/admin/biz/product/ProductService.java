package com.fh.shop.admin.biz.product;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.product.ProductParam;
import com.fh.shop.admin.po.product.Product;

public interface ProductService {


    //查询
    DataTableResult queryList(ProductParam productParam);
    //添加
    void addProduct(Product product);
    //回显
    Product findProductById(Long id);
    //修改
    void updateProduct(Product product);
    //删除
    ServerResponse deleteProduct(Long id);


    //修改热销
    ServerResponse updateIsHotStatus(Long id, int status);
    //修改上下架
    ServerResponse updatesStatus(Long id, int status);

    //批量删除
    ServerResponse deleteBatch(Long[] idArr);
}
