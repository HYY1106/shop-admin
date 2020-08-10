package com.fh.shop.admin.mapper.user;

import com.fh.shop.admin.param.user.UserSearchParam;
import com.fh.shop.admin.po.user.User;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;


public interface UserMapper  {

    //获取总条数
    Long queryCount(UserSearchParam userSearchParam);
    //获取分页列表
    List<User> findPageList(UserSearchParam userSearchParam);

    //添加
    void addUser(User user);
    //回显
    void findUser(Long id);
    //修改
    void updateUser(User user);
    //删除
    void deleteUser(Long id);




    public User findUserByUserName(String userName);
    // 更新数据库中的登录次数为1
    void updateLoginCount(Long userId);
    // 同一天，次数加1
    void incrLoginCount(Long userId);
    // 将logtime更新为当前时间
    void updateLoginTime(@Param("userId") Long userId, @Param("currTime") Date date);


}
