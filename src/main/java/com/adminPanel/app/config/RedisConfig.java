package com.adminPanel.app.config;

import com.adminPanel.app.service.cache.CacheService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

@Configuration
public class RedisConfig {

    @Bean
    public JedisPool jedisPool() {
        JedisPoolConfig poolConfig = new JedisPoolConfig();
        poolConfig.setMaxTotal(10);
        poolConfig.setMaxIdle(5);
        poolConfig.setMinIdle(1);
        poolConfig.setTestOnBorrow(true);

        return new JedisPool(poolConfig, "localhost", 6379);
    }

    @Bean
    public CacheService cacheService(JedisPool jedisPool) {
        return new CacheService(jedisPool);
    }
}
