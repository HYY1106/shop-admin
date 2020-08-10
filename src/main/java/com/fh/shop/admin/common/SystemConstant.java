package com.fh.shop.admin.common;

public class SystemConstant {

    // login登录 获取标识
    public static final String CURR_USER = "user";

    //oss图片上传
    public static final String UPLOAD_IMAGE_PATH = "/uploadImages/";

    // 就是普通请求
    public static final String LOGIN_PAGE = "/login.jsp";



    public static final String TEMPLATE_PATH = "/template/";

    public static final String PDF_TEMPLATE = "productPdfTemplate.html";

    public static final String WORD_TEMPLATE = "productWordTemplate.xml";

    public static final String UPLOAD_FILE_PATH = "f:/fh1906b/";

    public static final String WORD_SAVE_PATH = "f:/";

    public static final String WORD_SUFFIX = ".docx";

    public static final Integer STATUS_OK = 1;

    public static final Integer STATUS_ERROR = 0;

    public static final String LOGIN_METHOD = "login";

    public static final Integer NEED_UPDATE_CHILDS = 1;

    public static final String CATELIST_KEY = "cateList";

    public static final int CATELIST_KEY_EXPIRE = 10 * 60;

    public static final String AREALIST_KEY = "areaList";

    public static final int AREALIST_KEY_EXPIRE = 60;

    public static final int BATCH_SIZE = 500;

    public static final String HOT_GOODS_LIST_KEY = "hotGoodsList";

    public static final String RECOMMEND_BRAND_LIST = "recommendBrandList";

}
