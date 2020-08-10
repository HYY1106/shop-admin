package com.fh.shop.admin.mapper.member;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.fh.shop.admin.param.member.MemberSearchParam;
import com.fh.shop.admin.po.member.Member;

import java.util.List;
//继承extends BaseMapper
public interface MemberMapper extends BaseMapper<Member> {

    //查询总条数
    Long queryCount(MemberSearchParam memberSearchParam);
    //查询分页列表
    List<Member> findPageList(MemberSearchParam memberSearchParam);
}
