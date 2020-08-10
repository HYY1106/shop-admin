package com.fh.shop.admin.util;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisPool {

    // Redis 连接池
    private static JedisPool jedisPool;

    private RedisPool(){

    }

    private static void initPool(){
        // 连接池配置
        JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
        // 最大连接数
        jedisPoolConfig.setMaxTotal(1000);
        // 最小空闲连接数
        jedisPoolConfig.setMinIdle(500);
        // 最大空闲连接数
        jedisPoolConfig.setMaxIdle(500);
        // 测试 是否能正常连接
        jedisPoolConfig.setTestOnReturn(true);
        jedisPoolConfig.setTestOnBorrow(true);

        // 给 JedisPool 赋值        配置                 Linux IP地址     redis 端口号
        jedisPool = new JedisPool(jedisPoolConfig , "192.168.9.128" , 7020);

    }

    // 静态块 调用静态方法
    // 加载类的时候 指定静态块的 静态方法  且只会执行一次
    static {
        initPool();
    }

    public static Jedis getResource(){
        return jedisPool.getResource();
    }

}
