package com.fh.shop.admin.controller.area;


import com.fh.shop.admin.biz.area.AreaService;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.area.Area;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller//声明控制层
@RequestMapping("/area")//设置方法的请求路径
public class AreaController {

    //私有化service层 (@Resource的作用相当于@Autowired,只不过@Autowired按byType自动注入,而@Resource默认按 byName自动注入罢了。)
    @Resource(name="areaService")
    private AreaService areaService;


    //跳转路径
    @RequestMapping("/index")//设置方法的请求路径
    private String index(){
        return "area/index";
    }

    //查询
    @RequestMapping("/queryList")
    @ResponseBody//将Java对象转换为JSON格式的数据
    public ServerResponse queryList(){
        List<Area> areaList = areaService.queryList();
        return ServerResponse.success(areaList);
    }


    //添加
    @RequestMapping("addArea")
    @ResponseBody
    public ServerResponse addArea(Area area){
        areaService.addArea(area);
        return ServerResponse.success(area.getId());
    }

    //删除
    @RequestMapping("deleteArea")
    @ResponseBody
    public ServerResponse deleteArea(@RequestParam("ids[]") List<Long> ids){
        areaService.deleteArea(ids);
        return ServerResponse.success();
    }

    //回显
    @RequestMapping("findById")
    @ResponseBody
    public ServerResponse findById(Long id){
        Area area = areaService.findById(id);
        return ServerResponse.success(area);
    }
    //修改
    @RequestMapping("updateArea")
    @ResponseBody
    public ServerResponse updateArea(Area area){
        areaService.updateArea(area);
        return ServerResponse.success();
    }



    //地区下拉框
    @RequestMapping("findChilds")
    @ResponseBody
    public ServerResponse findChilds(Long id){
        return areaService.findChilds(id);
    }

}
