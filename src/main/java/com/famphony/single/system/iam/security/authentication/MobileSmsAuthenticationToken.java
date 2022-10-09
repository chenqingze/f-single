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

package com.famphony.single.system.iam.security.authentication;

import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Assert;

/**
 * 手机短信登录认证对象.
 *
 * @author ChenQingze
 */
public class MobileSmsAuthenticationToken extends AbstractAuthenticationToken {

    private final Object principal;

    private Object credentials;

    public MobileSmsAuthenticationToken(String phoneNumber, String smsCode) {
        super(null);
        this.principal = phoneNumber;
        this.credentials = smsCode;
        setAuthenticated(false);
    }

    public MobileSmsAuthenticationToken(UserDetails userDetails) {
        super(userDetails.getAuthorities());
        this.principal = userDetails;
    }

    @Override
    public Object getCredentials() {
        return this.credentials;
    }

    @Override
    public Object getPrincipal() {
        return this.principal;
    }

    @Override
    public void setAuthenticated(boolean isAuthenticated) throws IllegalArgumentException {
        Assert.isTrue(
                !isAuthenticated,
                "Cannot set this token to trusted - use constructor which takes a GrantedAuthority list instead");
        super.setAuthenticated(false);
    }

    @Override
    public void eraseCredentials() {
        super.eraseCredentials();
        this.credentials = null;
    }
}
