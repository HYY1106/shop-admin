package com.fh.shop.admin.controller.product;


import com.auth0.jwt.internal.org.apache.commons.lang3.StringUtils;
import com.fh.shop.admin.biz.product.ProductService;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.product.ProductParam;
import com.fh.shop.admin.po.product.Product;
import com.fh.shop.admin.util.AliyunOSSUtil;
import com.fh.shop.admin.util.RedisUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller//声明控制层
@RequestMapping("/product")//设置方法的请求路径
public class ProductController {


    //私有化service层 (@Resource的作用相当于@Autowired,只不过@Autowired按byType自动注入,而@Resource默认按 byName自动注入罢了。)
    @Resource(name="productService")
    private ProductService productService;



    //跳转
    @RequestMapping("/index")//设置方法的请求路径
    private String index(){
        return "product/index";
    }

    //查询
    @RequestMapping("queryList")
    @ResponseBody//将Java对象转换为JSON格式的数据
    public DataTableResult queryList(ProductParam productParam){
        DataTableResult dataTableResult = productService.queryList(productParam);
        return dataTableResult;
    }


    //跳转添加
    @RequestMapping("toAdd")
    public String toAdd(){
        return "product/add";
    }

    //添加
    @RequestMapping("addProduct")
    @ResponseBody
    public ServerResponse addProduct(Product product){
        productService.addProduct(product);
        return ServerResponse.success();
    }


    //跳转修改
    @RequestMapping("toUpdate")
    public String toUpdate(Long id){
        return "product/update";
    }

    //回显
    @RequestMapping("findProductById")
    @ResponseBody
    public ServerResponse findProductById(Long id){
        Product product = productService.findProductById(id);
        return ServerResponse.success(product);
    }

    //修改
    @RequestMapping("updateProduct")
    @ResponseBody
    public ServerResponse updateProduct(Product product,HttpServletRequest request){
        // 上传新图片
        if (StringUtils.isNotEmpty(product.getMainImagePath())) {
            // 删除老图片
            String oldMainImagePath = product.getOldMainImagePath();
            if (StringUtils.isNotEmpty(oldMainImagePath)) {
               /* String realPath = request.getServletContext().getRealPath(oldMainImagePath);
                File file = new File(realPath);
                if (file.exists()) {
                    file.delete();
                }*/
                //删除oss图片
                AliyunOSSUtil.deleteFile(oldMainImagePath);
            }
        } else {
            // 还是老图片
            product.setMainImagePath(product.getOldMainImagePath());
        }
        productService.updateProduct(product);
        return ServerResponse.success();
    }





    //删除
    @RequestMapping("deleteProduct")
    @ResponseBody
    public ServerResponse deleteProduct(Long id){
        RedisUtil.del("hotProductList");
        return productService.deleteProduct(id);
    }

    //批量删除
    @RequestMapping("/deleteBatch")
    @ResponseBody
    public ServerResponse deleteBatch(@RequestParam("ids[]") Long[] idArr) {
        return productService.deleteBatch(idArr);
    }



    //修改热销
    @RequestMapping("updateIsHotStatus")
    @ResponseBody
    public ServerResponse updateIsHotStatus(Long id,Integer status){
        return productService.updateIsHotStatus(id,status);
    }
    //修改上下架
    @RequestMapping("updatesStatus")
    @ResponseBody
    public ServerResponse updatesStatus(Long id,Integer status){
        return productService.updatesStatus(id,status);
    }




}
