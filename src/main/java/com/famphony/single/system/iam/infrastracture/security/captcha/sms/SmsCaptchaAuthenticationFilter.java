/*
 * Copyright (C) 2022-2022 ChenQingze . All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package com.famphony.single.system.iam.infrastracture.security.captcha.sms;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.ApplicationEventPublisherAware;
import org.springframework.core.log.LogMessage;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.util.Assert;
import org.springframework.web.filter.GenericFilterBean;

/**
 * 短信验证码过滤器
 *
 * @author ChenQingze
 */
public class SmsCaptchaAuthenticationFilter extends GenericFilterBean
        implements ApplicationEventPublisherAware {

    private AuthenticationManager authenticationManager;

    private RequestMatcher requiresAuthenticationRequestMatcher;

    private boolean continueChainBeforeSuccessfulAuthentication = false;

    /**
     * 构造器.
     *
     * @param authenticationManager {@link AuthenticationManager}
     * @param requiresAuthenticationRequestMatcher {@link RequestMatcher }
     */
    public SmsCaptchaAuthenticationFilter(
            AuthenticationManager authenticationManager,
            RequestMatcher requiresAuthenticationRequestMatcher) {
        this.authenticationManager = authenticationManager;
        this.requiresAuthenticationRequestMatcher = requiresAuthenticationRequestMatcher;
        setRequiresAuthenticationRequestMatcher(requiresAuthenticationRequestMatcher);
        setAuthenticationManager(authenticationManager);
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        doFilter((HttpServletRequest) request, (HttpServletResponse) response, chain);
    }

    private void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (!requiresAuthentication(request, response)) {
            chain.doFilter(request, response);
            return;
        }
        try {
            boolean authenticationSuccess = attemptAuthentication(request, response);
            if (authenticationSuccess) {
                // return immediately as subclass has indicated that it hasn't completed
                return;
            }
            // Authentication success
            if (this.continueChainBeforeSuccessfulAuthentication) {
                chain.doFilter(request, response);
            }
            successfulAuthentication(request, response, chain);
        } catch (InternalAuthenticationServiceException failed) {
            this.logger.error(
                    "An internal error occurred while trying to authenticate sms captcha.", failed);
            unsuccessfulAuthentication(request, response, failed);
        } catch (AuthenticationException ex) {
            // Authentication failed
            unsuccessfulAuthentication(request, response, ex);
        }
    }

    @Override
    public void setApplicationEventPublisher(ApplicationEventPublisher applicationEventPublisher) {}

    @Override
    public void afterPropertiesSet() {
        Assert.notNull(this.authenticationManager, "authenticationManager must be specified");
    }

    public boolean attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
            throws AuthenticationException, IOException, ServletException {
        // todo:验证处理逻辑
        return false;
    }

    protected void successfulAuthentication(
            HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // SecurityContext context = SecurityContextHolder.createEmptyContext();
        // context.setAuthentication(authResult);
        // SecurityContextHolder.setContext(context);
        // todo: 验证成功后处理短信验证码
        // if (this.eventPublisher != null) { //todo:可以利用事件机制异步做一些处理
        // this.eventPublisher.publishEvent(new
        // InteractiveAuthenticationSuccessEvent(authResult, this.getClass()));
        // }
    }

    protected void unsuccessfulAuthentication(
            HttpServletRequest request, HttpServletResponse response, AuthenticationException failed)
            throws IOException, ServletException {
        // todo:验证失败后的处理
        // SecurityContextHolder.clearContext();
        // this.logger.trace("Failed to process authentication command", failed);
        // this.logger.trace("Cleared SecurityContextHolder");
        // this.logger.trace("Handling authentication failure");
    }

    public void setAuthenticationManager(AuthenticationManager authenticationManager) {
        this.authenticationManager = authenticationManager;
    }

    public final void setRequiresAuthenticationRequestMatcher(RequestMatcher requestMatcher) {
        Assert.notNull(requestMatcher, "requestMatcher cannot be null");
        this.requiresAuthenticationRequestMatcher = requestMatcher;
    }

    protected boolean requiresAuthentication(
            HttpServletRequest request, HttpServletResponse response) {
        if (this.requiresAuthenticationRequestMatcher.matches(request)) {
            return true;
        }
        if (this.logger.isTraceEnabled()) {
            this.logger.trace(
                    LogMessage.format(
                            "Did not match command to %s", this.requiresAuthenticationRequestMatcher));
        }
        return false;
    }
}
