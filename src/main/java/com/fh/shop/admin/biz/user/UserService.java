package com.fh.shop.admin.biz.user;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.param.user.UserSearchParam;
import com.fh.shop.admin.po.user.User;

import java.util.Date;

public interface UserService {


    //查询
    DataTableResult queryList(UserSearchParam userSearchParam);
    //添加
    ServerResponse addUser(User user);
    //回显
    ServerResponse findUser(Long id);
    //修改
    ServerResponse updateUser(User user);
    //删除
    ServerResponse deleteUser(Long id);



    public User findUserByUserName(String userName);
    // 更新数据库中的登录次数为1
    void updateLoginCount(Long userId);
    // 同一天，次数加1
    void incrLoginCount(Long userId);
    // 将logtime更新为当前时间
    void updateLoginTime(Long userId, Date date);
}
