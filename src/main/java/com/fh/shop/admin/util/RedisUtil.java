package com.fh.shop.admin.util;

import redis.clients.jedis.Jedis;

public class RedisUtil {

    public static void del(String key){
        Jedis resource = null;
        try {
            resource = RedisPool.getResource();
            resource.del(key);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            if (resource != null){
                resource.close();
            }
        }
    }

    public static void set(String key , String value){
        Jedis resource = null;
        try {
            resource = RedisPool.getResource();
            resource.set(key , value);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            if (resource != null){
                resource.close();
            }
        }
    }

    public static String get(String key){
        Jedis resource = null;
        String result = "";
        try {
            resource = RedisPool.getResource();
            result = resource.get(key);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } finally {
            if (resource != null){
                resource.close();
            }
        }
        return result;
    }
}
