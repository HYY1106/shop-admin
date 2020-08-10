package com.fh.shop.admin.po.member;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

@Data//不用生成get/set      实现serializable
public class Member implements Serializable {

    private Long id;
    private String memberName;//会员名
    private String password;//密码
    private String realName;//真实姓名
    //日期转化类型
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date birthday;//出生日期
    private String mail;//邮箱
    private String phone;//手机号

    private String areaName;//地区名




}
