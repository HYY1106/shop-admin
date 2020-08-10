package com.fh.shop.admin.controller.type;

import com.fh.shop.admin.biz.type.TypeService;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.type.TypeSearchParam;
import com.fh.shop.admin.po.type.Type;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("/type")
public class TypeController {

    @Resource(name="typeService")
    private TypeService typeService;



    @RequestMapping("/toList")
    public String toList() {
        return "type/list";
    }
    @RequestMapping("/list")
    @ResponseBody
    public DataTableResult list(TypeSearchParam typeSearchParam) {
        return typeService.findList(typeSearchParam);
    }

    @RequestMapping("/toAdd")
    public String toAdd() {
        return "type/add";
    }
    @RequestMapping("/add")
    @ResponseBody
    public ServerResponse add(Type type) {
        return typeService.addType(type);
    }

    @RequestMapping("/delete")
    @ResponseBody
    public ServerResponse deleteType(Long id) {
        return typeService.deleteType(id);
    }



    @RequestMapping("/toEdit")
    public String toEdit() {
        return "type/edit";
    }
    @RequestMapping("/find")
    @ResponseBody
    public ServerResponse findType(Long id) {
        return typeService.findType(id);
    }
    @RequestMapping("/update")
    @ResponseBody
    public ServerResponse update(Type type) {
        return typeService.updateType(type);
    }

    @RequestMapping("/all")
    @ResponseBody
    public ServerResponse findAll() {
        return typeService.findAll();
    }
}
