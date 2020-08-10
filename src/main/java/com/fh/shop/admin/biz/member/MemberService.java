package com.fh.shop.admin.biz.member;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.param.member.MemberSearchParam;

public interface MemberService {

    //条件分页列表
    DataTableResult queryList(MemberSearchParam memberSearchParam);
}
