package com.fh.shop.admin.util;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.UUID;

//封装oss图片上传
public class AliyunOSSUtil {

    // Endpoint以杭州为例，其它Region请按实际情况填写。
    public static final String ENDPOINT = "http://oss-cn-beijing.aliyuncs.com";
    // 云账号AccessKey有所有API访问权限，建议遵循阿里云安全最佳实践，创建并使用RAM子账号进行API访问或日常运维，
    // 请登录 https://ram.console.aliyun.com 创建。
    public static final String ACCESSKEYID = "LTAI4GJ5TSP5VtC4jbieo2UH";
    public static final String ACCESSKEYSECRET = "xBAfxrMBpe2nhUygtEY3W8Shu6saeY";
    //oss桶名
    public static final String BUCKET = "fh-1907a";
    //带桶名的上传的路径
    public static final String BUCKETURL = "http://fh-1907a.oss-cn-beijing.aliyuncs.com/";


    //添加图片上传
    public static String uploadFile(InputStream is,String fileName) {
        // 创建OSSClient实例。
        OSS ossClient = null;
        try {
            // 创建OSSClient实例。
            ossClient = new OSSClientBuilder().build(ENDPOINT, ACCESSKEYID, ACCESSKEYSECRET);
            // 上传文件流。
            //InputStream inputStream = new FileInputStream("D:/飞虎教育学习资料/lixian/23.jpg");
            String suffix = FileUtil.getSuffix(fileName);
            String uploadFileName = UUID.randomUUID().toString().replace("-", "") + suffix;
            //每天上传日期变动
            String ymd = DateUtil.date2str(new Date(),DateUtil.Y_M_D);
            ossClient.putObject(BUCKET,ymd+"/"+uploadFileName, is);
            //返回上传路径
            return BUCKETURL + ymd+"/"+uploadFileName;
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            if (null != is) {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null != ossClient) {
                //关闭ossclient
                ossClient.shutdown();
            }
        }
    }


    //删除图片
    public static void deleteFile(String url){
        //路径和文件名
        String objectName = url.replace(BUCKETURL,"");

        OSS  ossClient = null;
        try {
            //创建ossclient实例
            ossClient = new OSSClientBuilder().build(ENDPOINT, ACCESSKEYID, ACCESSKEYSECRET);
            //删除文件，如需删除文件夹，请将objectName设置为对应的文件夹名称，如果文件夹非空，则需要将文件夹下的所有object删除后才能删除
            ossClient.deleteObject(BUCKET,objectName);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            if (null != ossClient){
                //关闭ossclient
                ossClient.shutdown();
            }
        }
    }

}

