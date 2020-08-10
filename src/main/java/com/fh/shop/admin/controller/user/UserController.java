package com.fh.shop.admin.controller.user;


import com.fh.shop.admin.biz.user.UserService;
import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ResponseEnum;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.common.SystemConstant;
import com.fh.shop.admin.param.user.UserSearchParam;
import com.fh.shop.admin.po.user.User;
import com.fh.shop.admin.util.DateUtil;
import com.fh.shop.admin.util.MD5Util;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource(name="userService")
    private UserService userService;

    @Autowired
    private HttpServletRequest request;


    //跳转查询
    @RequestMapping("toList")
    private String toList(){
        return "user/list";
    }

    //查询
    @RequestMapping("queryList")
    @ResponseBody
    public DataTableResult queryList(UserSearchParam userSearchParam){
        return userService.queryList(userSearchParam);
    }


    //跳转添加
    @RequestMapping("/toAdd")
    public String toAdd() {
        return "user/add";
    }
    //添加
    @RequestMapping("/add")
    @ResponseBody
    public ServerResponse add(User user) {
        return userService.addUser(user);
    }

    //回显
    @RequestMapping("/findUser")
    @ResponseBody
    public ServerResponse findUser(Long id) {
        return userService.findUser(id);
    }
    //跳转回显
    @RequestMapping("/toEdit")
    public String toEdit() {
        return "user/update";
    }
    //修改
    @RequestMapping("/update")
    @ResponseBody
    public ServerResponse updateUser(User user) {
        return userService.updateUser(user);
    }

    //删除
    @RequestMapping("/deleteUser")
    @ResponseBody
    public ServerResponse deleteUser(Long id){
        return userService.deleteUser(id);
    }


    //退出
    @RequestMapping("/logout")
    public String logout() {
        // 清空session中
        request.getSession().invalidate();
        // 跳转到登录页面[重定向到登录页面]
        return "redirect:/login.jsp";
    }

    //登录
    @RequestMapping("/login")
    @ResponseBody
    public ServerResponse login(User user, HttpServletRequest request) {
        String userName = user.getUserName();
        String password = user.getPassword();
        if (StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)) {
            return ServerResponse.error(ResponseEnum.USERNAME_PASSWORD_IS_NULL);
        }
        User userDB = userService.findUserByUserName(userName);
        if (userDB == null) {
            // 用户名不存在
            return ServerResponse.error(ResponseEnum.USERNAME_IS_NOT_EXIST);
        }
        // 判断密码
        String userDBPassword = userDB.getPassword();
        if (!MD5Util.md5(password).equals(userDBPassword)) {
            // 密码错误
            return ServerResponse.error(ResponseEnum.USER_PASSWORD_IS_ERROR);
        }
        // 发放门禁卡[标识]，存到什么地方【session:跨越多个请求的】
        // 存放在session中的数据，存到了 缓存 中。
        // 1.给了一个合法的标识，方便在拦截器中进行判断
        // 2.在后续操作过程中，可以直接通过session获取登录用户的信息，而不需要再次查询数据库
        Long userId = userDB.getId();
        // 当前登录的时间精确到天
        Date date = DateUtil.str2date(DateUtil.date2str(new Date(), DateUtil.Y_M_D), DateUtil.Y_M_D);
        // 数据库中记录的登录时间 精确到天
        Date loginTime = userDB.getLoginTime();
        if (loginTime == null) {
            // 证明就是第一次登录
            userDB.setLoginCount(1);
            // 更新数据库中的登录次数为1
            userService.updateLoginCount(userId);
        } else {
            Date dbDate = DateUtil.str2date(DateUtil.date2str(loginTime, DateUtil.Y_M_D), DateUtil.Y_M_D);
            if (date.after(dbDate)) {
                // 不是同一天,重置为1
                userDB.setLoginCount(1);
                userService.updateLoginCount(userId);
            } else {
                // 同一天，次数加1
                userDB.setLoginCount(userDB.getLoginCount()+1);
                userService.incrLoginCount(userId);
            }
        }
        request.getSession().setAttribute(SystemConstant.CURR_USER, userDB);
        // 将logtime更新为当前时间
        userService.updateLoginTime(userId, new Date());
        System.out.println("============login");
        return ServerResponse.success();
    }
}
