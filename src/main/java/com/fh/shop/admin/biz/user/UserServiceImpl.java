package com.fh.shop.admin.biz.user;

import com.fh.shop.admin.common.DataTableResult;
import com.fh.shop.admin.common.ServerResponse;
import com.fh.shop.admin.mapper.user.UserMapper;
import com.fh.shop.admin.param.user.UserSearchParam;
import com.fh.shop.admin.po.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService{

    @Autowired
    private UserMapper userMapper;



    //查询
    @Override
    public DataTableResult queryList(UserSearchParam userSearchParam) {
        //获取总条数
      Long totalCount = userMapper.queryCount(userSearchParam);
      //获取分页列表
      List<User> userList = userMapper.findPageList(userSearchParam);

        return new DataTableResult(userSearchParam.getDraw(),totalCount,totalCount,userList);
    }

    //添加
    @Override
    public ServerResponse addUser(User user) {
        userMapper.addUser(user);
        return ServerResponse.success();
    }

    //回显
    @Override
    public ServerResponse findUser(Long id) {
        userMapper.findUser(id);
        return ServerResponse.success();
    }

    //修改
    @Override
    public ServerResponse updateUser(User user) {
        userMapper.updateUser(user);
        return ServerResponse.success();
    }


    //删除
    @Override
    public ServerResponse deleteUser(Long id) {
        userMapper.deleteUser(id);
        return ServerResponse.success();
    }



    @Override
    public User findUserByUserName(String userName) {
        User user = userMapper.findUserByUserName(userName);
        return user;
    }

    @Override
    public void updateLoginCount(Long userId) {
        userMapper.updateLoginCount(userId);
    }

    @Override
    public void incrLoginCount(Long userId) {
        userMapper.incrLoginCount(userId);
    }

    @Override
    public void updateLoginTime(Long userId, Date date) {
        userMapper.updateLoginTime(userId, date);
    }
}
