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

package com.famphony.single.commons.security.authentication;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.authentication.session.SessionAuthenticationStrategy;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.util.Assert;

/**
 * SMS OTP (one-time password). * 手机短信录认证过滤器.
 *
 * @author ChenQingze
 */
public class SmsOtpAuthenticationFilter extends AbstractAuthenticationProcessingFilter {

    public static final String SPRING_SECURITY_FORM_PHONE_NUMBER_KEY = "phoneNumber";
    public static final String SPRING_SECURITY_FORM_SMS_CODE_KEY = "smsCode";

    private String phoneNumberParameter = SPRING_SECURITY_FORM_PHONE_NUMBER_KEY;

    private String smsCodeParameter = SPRING_SECURITY_FORM_SMS_CODE_KEY;

    private static final AntPathRequestMatcher DEFAULT_ANT_PATH_REQUEST_MATCHER =
            new AntPathRequestMatcher("/login/mobile", "POST");

    private boolean postOnly = true;

    public SmsOtpAuthenticationFilter() {
        super(DEFAULT_ANT_PATH_REQUEST_MATCHER);
    }

    public SmsOtpAuthenticationFilter(
            AuthenticationManager authenticationManager, SessionAuthenticationStrategy sessionStrategy) {
        super(DEFAULT_ANT_PATH_REQUEST_MATCHER, authenticationManager);
        super.setSessionAuthenticationStrategy(sessionStrategy);
    }

    public SmsOtpAuthenticationFilter(AuthenticationManager authenticationManager) {
        super(DEFAULT_ANT_PATH_REQUEST_MATCHER, authenticationManager);
    }

    public SmsOtpAuthenticationFilter(
            RequestMatcher requestMatcher, AuthenticationManager authenticationManager) {
        super(requestMatcher, authenticationManager);
    }

    @Override
    public Authentication attemptAuthentication(
            HttpServletRequest request, HttpServletResponse response)
            throws AuthenticationException, IOException, ServletException {
        if (postOnly && !request.getMethod().equals("POST")) {
            throw new AuthenticationServiceException(
                    "Authentication method not supported: " + request.getMethod());
        }
        Assert.hasText(phoneNumberParameter, "mobile parameter must not be empty or null");

        String phoneNumber = request.getParameter(phoneNumberParameter);
        phoneNumber = (phoneNumber != null) ? phoneNumber.trim() : "";
        String smsCode = request.getParameter(smsCodeParameter);
        smsCode = (smsCode != null) ? smsCode.trim() : "";

        final SmsOtpAuthenticationToken authRequest =
                new SmsOtpAuthenticationToken(phoneNumber, smsCode);
        authRequest.setDetails(authenticationDetailsSource.buildDetails(request));

        return this.getAuthenticationManager().authenticate(authRequest);
    }

    public void setPhoneNumberParameter(String phoneNumberParameter) {
        Assert.hasText(smsCodeParameter, "phone number parameter must not be empty or null");
        this.phoneNumberParameter = phoneNumberParameter;
    }

    public void setSmsCodeParameter(String smsCodeParameter) {
        Assert.hasText(smsCodeParameter, "sms code parameter must not be empty or null");
        this.smsCodeParameter = smsCodeParameter;
    }

    public void setPostOnly(boolean postOnly) {
        this.postOnly = postOnly;
    }
}
