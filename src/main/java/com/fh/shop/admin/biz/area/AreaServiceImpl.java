package com.fh.shop.admin.biz.area;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.area.AreaMapper;
import com.fh.shop.admin.po.area.Area;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

                       //而用 @Component泛指组件，当组件不好归类的时候，我们可以使用这个注解进行标注
@Service("areaService")//用于标注业务层组件,这个注解是写在类上面的，标注将这个类交给Spring容器管理，spring容器要为他创建对象
public class AreaServiceImpl implements AreaService{

    //私有化mapper层(@Resource的作用相当于@Autowired,只不过@Autowired按byType自动注入,而@Resource默认按 byName自动注入罢了。)
    @Autowired
    private AreaMapper areaMapper;


    //查询
    @Override
    public List<Area> queryList() {
        return areaMapper.queryList();
    }

    //添加
    @Override
    public void addArea(Area area) {
        areaMapper.addArea(area);
     }

    //删除
    @Override
    public void deleteArea(List<Long> ids) {
        areaMapper.deleteArea(ids);
   }


   //回显
   @Override
   public Area findById(Long id) {
     return areaMapper.findById(id);
   }

   //修改
   @Override
   public void updateArea(Area area) {
       areaMapper.updateArea(area);
    }


    //地区下拉框
    @Override
    public ServerResponse findChilds(Long id) {
        List<Area> childs =  areaMapper.findChilds(id);
         return ServerResponse.success(childs);
       }


 }
