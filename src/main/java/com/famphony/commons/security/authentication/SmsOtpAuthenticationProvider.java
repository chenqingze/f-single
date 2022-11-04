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

import com.famphony.single.commons.security.service.SmsOtpUserDetailsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.MessageSource;
import org.springframework.context.MessageSourceAware;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.security.authentication.AccountStatusUserDetailsChecker;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.SpringSecurityMessageSource;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsChecker;
import org.springframework.util.Assert;

/**
 * SMS OTP (one-time password). 手机短信录认证.
 *
 * @author ChenQingze
 */
public class SmsOtpAuthenticationProvider
        implements AuthenticationProvider, InitializingBean, MessageSourceAware {

    private final Logger logger = LoggerFactory.getLogger(SmsOtpAuthenticationProvider.class);

    protected MessageSourceAccessor messages = SpringSecurityMessageSource.getAccessor();
    private final SmsOtpUserDetailsService smsOtpUserDetailsService;

    private final UserDetailsChecker postAuthenticationChecks = new AccountStatusUserDetailsChecker();

    public SmsOtpAuthenticationProvider(SmsOtpUserDetailsService smsOtpUserDetailsService) {
        this.smsOtpUserDetailsService = smsOtpUserDetailsService;
    }

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
        Assert.isInstanceOf(
                SmsOtpAuthenticationToken.class,
                authentication,
                messages.getMessage(
                        "AbstractUserDetailsAuthenticationProvider.onlySupports",
                        "Only SmsOtpAuthenticationToken is supported"));
        final SmsOtpAuthenticationToken smsOtpAuthenticationToken =
                (SmsOtpAuthenticationToken) authentication;

        final String phoneNumber = (String) smsOtpAuthenticationToken.getPrincipal();
        final String smsCode = (String) smsOtpAuthenticationToken.getCredentials();

        if (!smsOtpUserDetailsService.consumeSmsCode(phoneNumber, smsCode)) {
            throw new BadCredentialsException(
                    messages.getMessage(
                            "AbstractUserDetailsAuthenticationProvider.badCredentials", "Bad credentials"));
        }

        UserDetails user = smsOtpUserDetailsService.loadUserByMobile(phoneNumber);

        postAuthenticationChecks.check(user);
        this.logger.debug("Authenticated user");
        return new SmsOtpAuthenticationToken(user);
    }

    @Override
    public boolean supports(Class<?> authentication) {

        return (SmsOtpAuthenticationToken.class.isAssignableFrom(authentication));
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        Assert.notNull(this.messages, "A message source must be set");
        Assert.notNull(this.smsOtpUserDetailsService, "A smsOtpUserDetailsService must be set.");
        Assert.notNull(this.postAuthenticationChecks, "A postAuthenticationChecks must be set.");
    }

    @Override
    public void setMessageSource(MessageSource messageSource) {
        this.messages = new MessageSourceAccessor(messageSource);
    }
}
