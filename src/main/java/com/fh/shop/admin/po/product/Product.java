package com.fh.shop.admin.po.product;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data//不用生成get/set      实现serializable
public class Product implements Serializable {

    private Long id;
    private String productName;//商品名
    private BigDecimal price;//价格

    private Long brandId;//品牌id
    //忽略这个字段
    @TableField(exist = false)
    private String brandName;//品牌名称

    //日期转化类型
    @JsonFormat(pattern = "yyyy-MM-dd",timezone="GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createDate;//创建日期
    @JsonFormat(pattern = "yyyy-MM-dd",timezone="GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date insertTime;//添加日期
    @JsonFormat(pattern = "yyyy-MM-dd",timezone="GMT+8")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;//修改日期

    private String mainImagePath;//图片
    @TableField(exist = false)
    private String oldMainImagePath;

    private Integer isHot;//热销
    private Integer status;//上下架
    private Long stock;//库存


}
