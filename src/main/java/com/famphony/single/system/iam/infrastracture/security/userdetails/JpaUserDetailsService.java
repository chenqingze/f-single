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
import java.util.HashSet;
import java.util.Set;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 用户认证和鉴权信息获取服务.
 *
 * @author ChenQingze
 */
@Service
public class JpaUserDetailsService implements UserDetailsService {

    private final UserService userService;

    public JpaUserDetailsService(UserService userService) {
        this.userService = userService;
    }

    @Transactional
    @Override
    public UserDetails loadUserByUsername(String loginName) throws UsernameNotFoundException {
        User user =
                userService
                        .findUserByLoginName(loginName)
                        .orElseThrow(
                                () -> new UsernameNotFoundException(String.format("user %s not found", loginName)));
        return new SecurityUserDetails(user, loadUserAuthorities(user));
    }

    /**
     * 获取权限列表
     *
     * @param user {@link User}
     * @return 处理后的权限字符串列表
     */
    private Set<GrantedAuthority> loadUserAuthorities(User user) {
        Set<GrantedAuthority> authoritySet = new HashSet<>();
        user.getRoles()
                .forEach(
                        role -> {
                            role.getPermissions()
                                    .forEach(
                                            permission ->
                                                    authoritySet.add(new SimpleGrantedAuthority(permission.getPermit())));
                        });
        return authoritySet;
    }
}
