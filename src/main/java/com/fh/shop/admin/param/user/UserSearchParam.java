package com.fh.shop.admin.param.user;

import com.fh.shop.admin.param.Page;
import lombok.Data;

@Data
public class UserSearchParam extends Page {

    private String userName;
    private String realName;


}
