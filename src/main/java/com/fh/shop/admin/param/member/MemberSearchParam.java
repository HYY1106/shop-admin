package com.fh.shop.admin.param.member;

import com.fh.shop.admin.param.Page;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

@Data//不用生成get/set  继承extends Page    实现serializable
public class MemberSearchParam extends Page implements Serializable {

    private String memberName;//会员名
    private String realName;//真实姓名
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minDate;//最晚时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxDate;//最早时间

     private Integer shengId;//省id
     private Integer shiId;//市id
     private Integer xianId;//县id



}
