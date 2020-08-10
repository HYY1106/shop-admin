package com.fh.shop.admin.vo.product;

import lombok.Data;

import java.io.Serializable;

@Data
public class ProductVo implements Serializable {

    private Long id;

    private String productName;

    private String price;

    private String brandName;

    private String createDate;

    private String insertTime;

    private String updateTime;

    private String mainImagePath;

    private Integer isHot;

    private Integer status;

    private Long stock;


    }
