package com.fh.shop.admin.controller.brand;

import com.fh.shop.admin.biz.brand.BrandService;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.brand.BrandSearchParam;
import com.fh.shop.admin.po.brand.Brand;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;


@Controller//声明控制层
@RequestMapping("/brand")//设置方法的请求路径
public class BrandController {


    //私有化service层 (@Resource的作用相当于@Autowired,只不过@Autowired按byType自动注入,而@Resource默认按 byName自动注入罢了。)
    @Resource(name="brandService")
    private BrandService brandService;

    //品牌下拉框
    @RequestMapping("/all")//设置方法的请求路径
    @ResponseBody//将Java对象转换为JSON格式的数据
    public ServerResponse findAllBrandList() {
        System.out.println("============品牌列表");
        ServerResponse serverResponse = brandService.findAllBrandList();
        return serverResponse;
    }


    //跳转
    @RequestMapping(value = "/toList", method = RequestMethod.GET)
    public String toList() {
        return "brand/list";
    }
    //查询
    @RequestMapping(value="/list", method = RequestMethod.POST)
    @ResponseBody
    public DataTableResult findBrandList(BrandSearchParam brandSearchParam) {
        return brandService.findBrandList(brandSearchParam);
    }


    //跳转添加
    @RequestMapping(value = "/toAdd", method = RequestMethod.GET)
    public String toAdd() {
        return "brand/add";
    }
    //添加
    @RequestMapping(value="/add", method = RequestMethod.POST)
    @ResponseBody
    public ServerResponse addBrand(Brand brand) {
        return brandService.addBrand(brand);
    }









}
