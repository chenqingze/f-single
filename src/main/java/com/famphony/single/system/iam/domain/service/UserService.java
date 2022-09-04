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

package com.famphony.single.system.iam.domain.service;

import com.famphony.single.system.iam.domain.entity.User;
import com.famphony.single.system.iam.infrastracture.repository.UserSpringDataJpaRepository;
import java.util.Optional;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 用户服务.
 *
 * @author ChenQingze
 */
@Service
@Transactional
public class UserService {

    private final UserSpringDataJpaRepository userRepository;

    public UserService(UserSpringDataJpaRepository userRepository) {
        this.userRepository = userRepository;
    }

    public Optional<User> findUserByLoginName(String loginName) {
        return this.userRepository.findByUsernameOrMobileOrEmail(loginName, loginName, loginName);
    }

    public Optional<User> findUserByMobile(String mobile) {
        return this.userRepository.findByMobile(mobile);
    }
}