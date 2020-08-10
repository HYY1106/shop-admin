package com.fh.shop;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import org.junit.Test;

import java.io.FileInputStream;
import java.io.InputStream;

public class TestOSS {


    //测试添加图片
    @Test
    public void test1(){
        // Endpoint以杭州为例，其它Region请按实际情况填写。
        String endpoint = "http://oss-cn-beijing.aliyuncs.com";
        // 云账号AccessKey有所有API访问权限，建议遵循阿里云安全最佳实践，创建并使用RAM子账号进行API访问或日常运维，
        // 请登录 https://ram.console.aliyun.com 创建。
        String accessKeyId = "LTAI4GJ5TSP5VtC4jbieo2UH";
        String accessKeySecret = "xBAfxrMBpe2nhUygtEY3W8Shu6saeY";

        // 创建OSSClient实例。
        OSS ossClient = null;
        try {
            // 创建OSSClient实例。
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
            // 上传文件流。
            InputStream inputStream = new FileInputStream("D:/飞虎教育学习资料/lixian/23.jpg");
            ossClient.putObject("fh-1907a", "fh/23.jpg", inputStream);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null != ossClient) {
                //关闭ossclient
                ossClient.shutdown();
              }
            }
        }


    //测试修改图片
    @Test
    public void test2(){
        // Endpoint以杭州为例，其它Region请按实际情况填写。
        String endpoint = "http://oss-cn-beijing.aliyuncs.com";
        // 云账号AccessKey有所有API访问权限，建议遵循阿里云安全最佳实践，创建并使用RAM子账号进行API访问或日常运维，
        // 请登录 https://ram.console.aliyun.com 创建。
        String accessKeyId = "LTAI4GJ5TSP5VtC4jbieo2UH";
        String accessKeySecret = "xBAfxrMBpe2nhUygtEY3W8Shu6saeY";
        String bucketName = "fh-1907a";
        //路径和文件名
        String objectName = "2020-07-15/82ff6448d4034b0fac6ed7ea17b9f4e3.jpg";

        // 创建OSSClient实例。
        OSS ossClient = null;
        try {
            // 创建OSSClient实例。
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
            //删除文件，如需删除文件夹，请将objectName设置为对应的文件夹名称，如果文件夹非空，则需要将文件夹下的所有object删除后才能删除
            ossClient.deleteObject(bucketName, objectName);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            if (null != ossClient) {
                //关闭ossclient
                ossClient.shutdown();
            }
        }
    }


}

