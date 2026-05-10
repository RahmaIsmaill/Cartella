package com.adminPanel.app.service.rate;

import com.adminPanel.app.service.cache.CacheService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Service
public class RateLimitService {

    @Autowired
    private CacheService cacheService;

    public boolean isAllowed(String key, int maxRequests, long timeWindow, TimeUnit timeUnit) {
        try {
            String cacheKey = "rate_limit:" + key;

            if (!cacheService.exists(cacheKey)) {
                cacheService.set(cacheKey, 1, timeWindow, timeUnit);
                return true;
            }

            long currentRequests = Long.parseLong(cacheService.get(cacheKey, String.class));

            if (currentRequests >= maxRequests) {
                return false;
            }

            cacheService.increment(cacheKey);
            return true;

        } catch (Exception e) {
            return true;
        }
    }

    public boolean isAllowed(String clientIp, String endpoint, int maxRequests, long timeWindow, TimeUnit timeUnit) {
        String key = clientIp + ":" + endpoint;
        return isAllowed(key, maxRequests, timeWindow, timeUnit);
    }
}
