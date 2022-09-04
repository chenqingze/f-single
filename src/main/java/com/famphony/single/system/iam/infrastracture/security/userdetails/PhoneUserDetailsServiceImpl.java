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

package com.famphony.single.system.iam.infrastracture.security.userdetails;

import com.famphony.single.system.iam.domain.entity.User;
import com.famphony.single.system.iam.domain.service.UserService;
import java.util.ArrayList;
import java.util.List;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * @author ChenQingze
 */
@Service
public class PhoneUserDetailsServiceImpl implements PhoneUserDetailsService {

    private final UserService userService;

    public PhoneUserDetailsServiceImpl(UserService userService) {
        this.userService = userService;
    }

    /**
     * todo :完善短信验证码消费
     *
     * @param phoneNumber
     * @param smsCode
     * @return
     */
    @Override
    public boolean consumeSmsCode(String phoneNumber, String smsCode) {
        return true;
    }

    @Override
    public UserDetails loadUserByPhoneNumber(String phoneNumber) throws PhoneNumberNotFoundException {
        User user =
                userService
                        .findUserByMobile(phoneNumber)
                        .orElseThrow(
                                () ->
                                        new UsernameNotFoundException(
                                                String.format("phone %s not found", phoneNumber)));
        return new org.springframework.security.core.userdetails.User(
                user.getUsername(), user.getPasswordHash(), loadUserAuthorities(user));
    }

    /**
     * 获取权限列表
     *
     * @param user {@link User}
     * @return 处理后的权限字符串列表
     */
    private List<GrantedAuthority> loadUserAuthorities(User user) {
        List<GrantedAuthority> authorityList = new ArrayList<>();
        user.getRoles()
                .forEach(
                        role -> {
                            role.getPermissions()
                                    .forEach(
                                            permission ->
                                                    authorityList.add(new SimpleGrantedAuthority(permission.getPermit())));
                        });
        return authorityList;
    }
}
