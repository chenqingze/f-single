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

package com.famphony.single.system.iam.security.userdetails;

import com.famphony.commons.security.service.SecurityUserDetailsService;
import com.famphony.commons.security.userdetails.SecurityUserDetails;
import com.famphony.single.system.iam.entity.User;
import com.famphony.single.system.iam.service.UserService;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author ChenQingze
 */
@Service
public class SecurityUserDetailsServiceImpl implements SecurityUserDetailsService {

    private final UserService userService;

    public SecurityUserDetailsServiceImpl(UserService userService) {
        this.userService = userService;
    }

    @Transactional
    @Override
    public UserDetails loadUserByUsername(String usernameOrEmailOrMobile)
            throws UsernameNotFoundException {
        User user =
                userService
                        .findUserByLoginName(usernameOrEmailOrMobile)
                        .orElseThrow(
                                () ->
                                        new UsernameNotFoundException(
                                                String.format("user %s not found", usernameOrEmailOrMobile)));
        return buildUserDetails(user, loadUserAuthorities(user));
    }

    /**
     * todo :???????????????????????????
     *
     * @param mobile
     * @param smsCode
     * @return
     */
    @Override
    public boolean consumeSmsCode(String mobile, String smsCode) {
        return false;
    }

    @Override
    public UserDetails loadUserByMobile(String mobile) throws UsernameNotFoundException {
        return null;
    }

    /**
     * todo :???????????????????????????
     *
     * @param email
     * @param code
     * @return
     */
    @Override
    public boolean consumeEmailCode(String email, String code) {
        return true;
    }

    @Override
    public UserDetails loadUserByEmail(String username) throws UsernameNotFoundException {
        return null;
    }

    private SecurityUserDetails buildUserDetails(
            User user, Collection<? extends GrantedAuthority> authorities) {
        return new SecurityUserDetails(
                user.getUsername(),
                user.getPasswordHash(),
                user.getEmail(),
                user.getMobile(),
                user.getEnabled(),
                authorities);
    }

    /**
     * ??????????????????
     *
     * @param user {@link User}
     * @return ?????????????????????????????????
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
