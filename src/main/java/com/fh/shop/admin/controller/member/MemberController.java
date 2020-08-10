package com.fh.shop.admin.controller.member;

import com.fh.shop.admin.biz.member.MemberService;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.member.MemberSearchParam;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller//声明控制层
@RequestMapping("/member")//设置方法的请求路径
public class MemberController {

    //私有化service层 (@Resource的作用相当于@Autowired,只不过@Autowired按byType自动注入,而@Resource默认按 byName自动注入罢了。)
    @Resource(name="memberService")
    private MemberService memberService;


    //跳转页面
    //@RequestMapping//设置方法的请求路径
    @RequestMapping("/index")
    private String index(){
        return "member/index";
    }

    //条件分页列表
    @RequestMapping("queryList")//@ResponseBody//将Java对象转换为JSON格式的数据
    public @ResponseBody DataTableResult queryList(MemberSearchParam memberSearchParam){
        return memberService.queryList(memberSearchParam);
    }




}
