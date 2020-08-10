package com.fh.shop.admin.biz.area;

import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.po.area.Area;

import java.util.List;

public interface AreaService {

    //查询
    List<Area> queryList();
    //添加
    void addArea(Area area);
    //删除
    void deleteArea(List<Long> ids);
    //回显
    Area findById(Long id);
    //修改
    void updateArea(Area area);

    //地区下拉框
    ServerResponse findChilds(Long id);
}
