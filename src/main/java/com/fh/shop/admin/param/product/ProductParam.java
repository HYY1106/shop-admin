package com.fh.shop.admin.param.product;

import com.fh.shop.admin.param.Page;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Data//不用生成get/set  继承extends Page    实现serializable
public class ProductParam extends Page implements Serializable {

    private String productName;//商品名称

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date minDate;//日期
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date maxDate;

    private BigDecimal minPrice;//价格
    private BigDecimal maxPrice;

    private Long brandId;//品牌id
}
