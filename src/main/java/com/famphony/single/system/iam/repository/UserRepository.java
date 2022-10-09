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

package com.famphony.single.system.iam.repository;

import com.famphony.single.system.iam.entity.User;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @author ChenQingze
 */
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByUsernameOrMobileOrEmail(String username, String mobile, String email);

    Optional<User> findByMobile(String mobile);

    Optional<User> findById(String mobile);

    // Optional<TenantUser> findByMobileAndPasswordAndEnabled(String mobile, String
    // password,
    // boolean enabled);
    //
    // Optional<TenantUser> findByUsernameAndPasswordAndEnabled(String username, String
    // password, boolean enabled);
    //
    // Optional<TenantUser> findByEmailAndPasswordAndEnabled(String email, String
    // password,
    // boolean enabled);

    Optional<User> findByUsername(String username);
}
