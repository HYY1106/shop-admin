package com.fh.shop.admin.biz.member;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.mapper.member.MemberMapper;
import com.fh.shop.admin.param.member.MemberSearchParam;
import com.fh.shop.admin.po.member.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

                         //而用 @Component泛指组件，当组件不好归类的时候，我们可以使用这个注解进行标注
@Service("memberService")//用于标注业务层组件,这个注解是写在类上面的，标注将这个类交给Spring容器管理，spring容器要为他创建对象
public class MemberServiceImpl implements MemberService{

    //私有化mapper层(@Resource的作用相当于@Autowired,只不过@Autowired按byType自动注入,而@Resource默认按 byName自动注入罢了。)
    @Autowired
    private MemberMapper memberMapper;


    //条件分页列表
    @Override
    public DataTableResult queryList(MemberSearchParam memberSearchParam) {
         //查询总条数
        Long totalCount = memberMapper.queryCount(memberSearchParam);
        //查询分页列表
        List<Member> memberList = memberMapper.findPageList(memberSearchParam);
        //返回数据
        return new DataTableResult(memberSearchParam.getDraw(),totalCount,totalCount,memberList);
    }
}
