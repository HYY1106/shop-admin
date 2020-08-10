package com.fh.shop.admin.biz.brand;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.brand.BrandMapper;
import com.fh.shop.admin.param.brand.BrandSearchParam;
import com.fh.shop.admin.po.brand.Brand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

//而用 @Component泛指组件，当组件不好归类的时候，我们可以使用这个注解进行标注
@Service("brandService")//用于标注业务层组件,这个注解是写在类上面的，标注将这个类交给Spring容器管理，spring容器要为他创建对象
public class BrandServiceImpl implements BrandService{

    //私有化mapper层(@Resource的作用相当于@Autowired,只不过@Autowired按byType自动注入,而@Resource默认按 byName自动注入罢了。)
    @Autowired
    private BrandMapper brandMapper;

                              //品牌下拉框
                              @Override
                              public ServerResponse findAllBrandList() {
                                  List<Brand> allBrandList = brandMapper.findAllBrandList();
                                  return ServerResponse.success(allBrandList);
                              }
                               //查询
                              @Override
                              public DataTableResult findBrandList(BrandSearchParam brandSearchParam) {
                                  // 获取总条数
                                  Long totalCount = brandMapper.findBrandListCount(brandSearchParam);
                                  // 获取分页列表
                                  List<Brand> brandList = brandMapper.findBrandPageList(brandSearchParam);
                                  // 组装数据
                                  return new DataTableResult(brandSearchParam.getDraw(), totalCount, totalCount, brandList);
                              }

                              //添加
                              @Override
                              public ServerResponse addBrand(Brand brand) {
                                  brandMapper.insert(brand);
                                  return ServerResponse.success();
                              }


}
