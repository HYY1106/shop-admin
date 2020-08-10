package com.fh.shop.admin.biz.type;


import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.type.TypeMapper;
import com.fh.shop.admin.param.type.TypeSearchParam;
import com.fh.shop.admin.po.type.Type;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("typeService")
public class TypeServiceImpl implements TypeService{

    @Autowired
    private TypeMapper typeMapper;


    @Override
    public ServerResponse addType(Type type) {
        typeMapper.insert(type);
        return ServerResponse.success();
    }

    @Override
    public DataTableResult findList(TypeSearchParam typeSearchParam) {
        // 获取总条数
        Long count = typeMapper.findListCount(typeSearchParam);
        // 获取分页列表
        List<Type> typeList = typeMapper.findPageList(typeSearchParam);
        return new DataTableResult(typeSearchParam.getDraw(), count, count, typeList);
    }

    @Override
    public ServerResponse deleteType(Long id) {
        // 删除类型表
        typeMapper.deleteById(id);
        return ServerResponse.success();
    }

    @Override
    public ServerResponse findType(Long id) {
        typeMapper.selectById(id);
        return ServerResponse.success();
    }

    @Override
    public ServerResponse updateType(Type type) {
        typeMapper.updateById(type);
        return ServerResponse.success();
    }

    @Override
    public ServerResponse findAll() {
        List<Type> types = typeMapper.selectList(null);
        return ServerResponse.success(types);
    }
}
