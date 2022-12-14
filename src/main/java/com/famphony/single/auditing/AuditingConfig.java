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

package com.famphony.single.auditing;

import com.famphony.commons.security.userdetails.SecurityUserDetails;
import java.util.Optional;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * @author ChenQingze
 */
@Configuration
@EnableJpaAuditing(auditorAwareRef = "auditorProvider")
public class AuditingConfig {

    @Bean
    public AuditorAware<String> auditorProvider() {
        return () ->
                Optional.ofNullable(SecurityContextHolder.getContext())
                        .map(SecurityContext::getAuthentication)
                        .filter(Authentication::isAuthenticated)
                        .map(Authentication::getPrincipal)
                        .map(SecurityUserDetails.class::cast)
                        .map(SecurityUserDetails::getUsername);
    }

    /**
     * Lambda表达式的方式
     *
     * @param userRepository
     * @return
     */
    //    @Bean
    //    AuditorAware<User> auditorProvider(UserRepository userRepository) {
    //        // Lookup Author instance corresponding to logged in user
    //        return () -> Optional.ofNullable(SecurityContextHolder.getContext())
    //            .map(SecurityContext::getAuthentication)
    //            .filter(Authentication::isAuthenticated)
    //            .map(Authentication::getName)
    //            .flatMap(userRepository::findByUsername);
    //    }
}
