package com.fh.shop.admin.po.user;


import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data//不用get/set  实现Serializable
public class User implements Serializable {


    private Long id;
    private String userName;//用户名
    private String password;//密码
    private String realName;//真实姓名
    private Date loginTime;//登录时间
    private Integer loginCount;//登录次数

}
