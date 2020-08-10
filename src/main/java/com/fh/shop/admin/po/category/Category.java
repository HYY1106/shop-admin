package com.fh.shop.admin.po.category;

import lombok.Data;

import java.io.Serializable;

@Data
public class Category implements Serializable {


    private Long id;
    private Long pid;
    private String categoryName;
    private Integer type;

}
