package com.adminPanel.app.service.cache;

import com.fasterxml.jackson.databind.ObjectMapper;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
public class CacheService {

    private final JedisPool jedisPool;
    private final ObjectMapper objectMapper;

    public CacheService(JedisPool jedisPool) {
        this.jedisPool = jedisPool;
        this.objectMapper = new ObjectMapper();
    }

    public void set(String key, Object value, long ttl, TimeUnit timeUnit) {
        try (Jedis jedis = jedisPool.getResource()) {
            String jsonValue = objectMapper.writeValueAsString(value);
            long ttlSeconds = timeUnit.toSeconds(ttl);
            jedis.setex(key, ttlSeconds, jsonValue);
        } catch (Exception e) {
            throw new RuntimeException("Cache set error", e);
        }
    }

    public <T> T get(String key, Class<T> clazz) {
        try (Jedis jedis = jedisPool.getResource()) {
            String value = jedis.get(key);
            if (value == null) return null;
            return objectMapper.readValue(value, clazz);
        } catch (Exception e) {
            throw new RuntimeException("Cache get error", e);
        }
    }

    public void delete(String key) {
        try (Jedis jedis = jedisPool.getResource()) {
            jedis.del(key);
        }
    }

    public boolean exists(String key) {
        try (Jedis jedis = jedisPool.getResource()) {
            return jedis.exists(key);
        }
    }

    public void increment(String key) {
        try (Jedis jedis = jedisPool.getResource()) {
            jedis.incr(key);
        }
    }

    public void expire(String key, long ttl, TimeUnit timeUnit) {
        try (Jedis jedis = jedisPool.getResource()) {
            long ttlSeconds = timeUnit.toSeconds(ttl);
            jedis.expire(key, ttlSeconds);
        }
    }
}