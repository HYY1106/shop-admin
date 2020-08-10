package com.fh.shop.admin.interceptor;

import com.fh.shop.admin.common.SystemConstant;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor extends HandlerInterceptorAdapter {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,Object handle)throws Exception{
        System.out.println("============拦截器");
        //获取标识
        Object userInfo = request.getSession().getAttribute(SystemConstant.CURR_USER);
        if (null != userInfo){
            // 合法用户,放行
            return true;
        }else{
            // 就是普通请求
           response.sendRedirect(SystemConstant.LOGIN_PAGE);
           return false;
        }
    }
}
