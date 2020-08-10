package com.fh.shop.admin.po.brand;

import lombok.Data;

import java.io.Serializable;

@Data//不用生成get/set    实现serializable
public class Brand implements Serializable {

    private Long id;

    private String brandName;//品牌名称

    private String logo;//图片
}
