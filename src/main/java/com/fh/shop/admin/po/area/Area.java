package com.fh.shop.admin.po.area;


import lombok.Data;

import java.io.Serializable;

@Data//不用生成get/set       实现serializable
public class Area implements Serializable {

    private Long id;
    private String areaName;//地区名
    private Long pid;//pid
}
