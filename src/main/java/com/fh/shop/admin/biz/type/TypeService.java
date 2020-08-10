package com.fh.shop.admin.biz.type;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.type.TypeSearchParam;
import com.fh.shop.admin.po.type.Type;

public interface TypeService {

    ServerResponse addType(Type type);

    DataTableResult findList(TypeSearchParam typeSearchParam);

    ServerResponse deleteType(Long id);

    ServerResponse findType(Long id);

    ServerResponse updateType(Type type);





    ServerResponse findAll();

}
