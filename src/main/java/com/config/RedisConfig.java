package com.config;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RedisConfig {

    private static final Logger logger =
            LoggerFactory.getLogger(RedisConfig.class);

    private static final String REDIS_HOST = "localhost";
    private static final int REDIS_PORT = 6379;

    private static JedisPool jedisPool;

    static {
        try {
            JedisPoolConfig poolConfig = new JedisPoolConfig();
            poolConfig.setMaxTotal(10);
            poolConfig.setMaxIdle(5);
            poolConfig.setMinIdle(1);

            jedisPool = new JedisPool(poolConfig, REDIS_HOST, REDIS_PORT);
            logger.info("Redis connection pool initialized");
        } catch (Exception e) {
            logger.error("Failed to initialize Redis pool: {}",
                    e.getMessage());
        }
    }

    public static Jedis getResource() {
        return jedisPool.getResource();
    }

    public static boolean isAvailable() {
        try (Jedis jedis = jedisPool.getResource()) {
            return "PONG".equals(jedis.ping());
        } catch (Exception e) {
            logger.warn("Redis is not available: {}", e.getMessage());
            return false;
        }
    }
}
