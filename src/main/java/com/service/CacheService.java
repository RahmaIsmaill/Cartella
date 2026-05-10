package com.service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.config.RedisConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import redis.clients.jedis.Jedis;

import java.lang.reflect.Type;
import java.util.List;

public class CacheService {

    private static final Logger logger =
            LoggerFactory.getLogger(CacheService.class);

    private static final Gson gson = new Gson();
    private static final int DEFAULT_TTL_SECONDS = 300;

    public void set(String key, Object value) {
        if (!RedisConfig.isAvailable()) {
            logger.warn("Redis unavailable, skipping cache set for key: {}", key);
            return;
        }

        try (Jedis jedis = RedisConfig.getResource()) {
            String json = gson.toJson(value);
            jedis.setex(key, DEFAULT_TTL_SECONDS, json);
            logger.info("Cached key: {} with TTL: {}s", key, DEFAULT_TTL_SECONDS);
        } catch (Exception e) {
            logger.error("Cache set error for key {}: {}", key, e.getMessage());
        }
    }

    public <T> T get(String key, Class<T> type) {
        if (!RedisConfig.isAvailable()) {
            return null;
        }

        try (Jedis jedis = RedisConfig.getResource()) {
            String json = jedis.get(key);

            if (json != null) {
                logger.info("Cache hit for key: {}", key);
                return gson.fromJson(json, type);
            }

            logger.info("Cache miss for key: {}", key);
        } catch (Exception e) {
            logger.error("Cache get error for key {}: {}", key, e.getMessage());
        }

        return null;
    }

    public <T> List<T> getList(String key, Class<T> type) {
        if (!RedisConfig.isAvailable()) {
            return null;
        }

        try (Jedis jedis = RedisConfig.getResource()) {
            String json = jedis.get(key);

            if (json != null) {
                logger.info("Cache hit for key: {}", key);
                Type listType = TypeToken.getParameterized(List.class, type).getType();
                return gson.fromJson(json, listType);
            }

            logger.info("Cache miss for key: {}", key);
        } catch (Exception e) {
            logger.error("Cache get error for key {}: {}", key, e.getMessage());
        }

        return null;
    }

    public void delete(String key) {
        if (!RedisConfig.isAvailable()) {
            return;
        }

        try (Jedis jedis = RedisConfig.getResource()) {
            jedis.del(key);
            logger.info("Cache deleted for key: {}", key);
        } catch (Exception e) {
            logger.error("Cache delete error for key {}: {}", key, e.getMessage());
        }
    }

    public void deleteByPattern(String pattern) {
        if (!RedisConfig.isAvailable()) {
            return;
        }

        try (Jedis jedis = RedisConfig.getResource()) {
            java.util.Set<String> keys = jedis.keys(pattern);
            if (!keys.isEmpty()) {
                jedis.del(keys.toArray(new String[0]));
                logger.info("Cache deleted for pattern: {}, count: {}",
                        pattern, keys.size());
            }
        } catch (Exception e) {
            logger.error("Cache delete pattern error for {}: {}",
                    pattern, e.getMessage());
        }
    }
}
