package com.fh.shop.admin.biz.product;


import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.product.ProductMapper;
import com.fh.shop.admin.param.product.ProductParam;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.util.AliyunOSSUtil;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.vo.product.ProductVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

                          //而用 @Component泛指组件，当组件不好归类的时候，我们可以使用这个注解进行标注
@Service("productService")//用于标注业务层组件,这个注解是写在类上面的，标注将这个类交给Spring容器管理，spring容器要为他创建对象
public class ProductServiceImpl implements ProductService{

    //私有化mapper层(@Resource的作用相当于@Autowired,只不过@Autowired按byType自动注入,而@Resource默认按 byName自动注入罢了。)
    @Autowired
    private ProductMapper productMapper;

    //查询
    @Override
    public DataTableResult queryList(ProductParam productParam) {
        //查询总条数
        Long totalCount = productMapper.findCount(productParam);
        //查询分页列表
        List<Product> list = productMapper.findPageList(productParam);

        //
        List<ProductVo> productVoList = new ArrayList();
        for(Product product:list){
            ProductVo productVo  = new ProductVo();
            productVo.setId(product.getId());
            productVo.setProductName(product.getProductName());
            productVo.setPrice(product.getPrice().toString());
            productVo.setBrandName(product.getBrandName());
            productVo.setCreateDate(DateUtil.date2str(product.getCreateDate(), DateUtil.Y_M_D));
            productVo.setInsertTime(DateUtil.date2str(product.getInsertTime(),DateUtil.FULL_TIME));
            productVo.setUpdateTime(DateUtil.date2str(product.getUpdateTime(),DateUtil.FULL_TIME));
            productVo.setMainImagePath(product.getMainImagePath());
            productVo.setIsHot(product.getIsHot());
            productVo.setStatus(product.getStatus());
            productVo.setStock(product.getStock());
            productVoList.add(productVo);
        }
        DataTableResult dataTableResult =   new DataTableResult(productParam.getDraw(),totalCount,totalCount,productVoList);
        return dataTableResult;
    }

    //添加
    @Override
    public void addProduct(Product product) {
        // 赋值录入时间
        Date now = new Date();
        product.setInsertTime(now);
        product.setUpdateTime(now);
        productMapper.insert(product);
    }

    //回显
    @Override
    public Product findProductById(Long id) {
        Product product = productMapper.selectById(id);
        return product;
    }

    //修改
    @Override
    public void updateProduct(Product product) {
        //回显
        //Product  oldProduct= productMapper.selectById(product.getId());
        //进行非空判断
       /* if(!product.getMainImagePath().equals(oldProduct.getMainImagePath())){
            AliyunOSSUtil.deleteFile(oldProduct.getMainImagePath());
        }*/

        product.setUpdateTime(new Date());
        productMapper.updateById(product);
    }



    //删除
    @Override
    public ServerResponse deleteProduct(Long id) {
        Product product = productMapper.selectById(id);
        AliyunOSSUtil.deleteFile(product.getMainImagePath());
        productMapper.deleteById(id);
        return ServerResponse.success();
    }



    //修改热销
    @Override
    public ServerResponse updateIsHotStatus(Long id, int status) {
        Product product = new Product();
        product.setId(id);
        product.setIsHot(status);
        productMapper.updateById(product);
        return ServerResponse.success();
    }
    //修改上下架
    @Override
    public ServerResponse updatesStatus(Long id, int status) {
        Product product = new Product();
        product.setId(id);
        product.setStatus(status);
        productMapper.updateById(product);
        return ServerResponse.success();
    }


    //批量删除
    @Override
    public ServerResponse deleteBatch(Long[] idArr) {
        List<Long> idList = Arrays.asList(idArr);
        productMapper.deleteBatchIds(idList);
        return ServerResponse.success();
    }


}
