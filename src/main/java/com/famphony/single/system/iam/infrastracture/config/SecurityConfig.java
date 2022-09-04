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

package com.famphony.single.system.iam.infrastracture.config;

import static org.springframework.security.config.Customizer.withDefaults;

import com.famphony.single.system.iam.infrastracture.security.authentication.PhoneAuthenticationFilter;
import com.famphony.single.system.iam.infrastracture.security.authentication.PhoneAuthenticationProvider;
import com.famphony.single.system.iam.infrastracture.security.userdetails.JpaUserDetailsService;
import com.famphony.single.system.iam.infrastracture.security.userdetails.PhoneUserDetailsService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;

/**
 * Web安全配置.
 *
 * @author ChenQingze
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig implements WebSecurityCustomizer {

    private final JpaUserDetailsService jpaUserDetailsService;
    private final PhoneUserDetailsService phoneUserDetailsService;

    public SecurityConfig(
            JpaUserDetailsService jpaUserDetailsService,
            PhoneUserDetailsService phoneUserDetailsService) {
        this.jpaUserDetailsService = jpaUserDetailsService;
        this.phoneUserDetailsService = phoneUserDetailsService;
    }

    /**
     * 配置SecurityFilterChain. 注意:如果前端设置 Access-Control-Allow-Credentials 为 true 来携带 Cookie 发起请求，则服务端
     * Access-Control-Allow-Origin 不能设置为 *。
     *
     * @param http {@link HttpSecurity}
     * @return {@link SecurityFilterChain}
     * @throws Exception 异常
     */
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        // @formatter:off
        http.httpBasic(withDefaults())
            .userDetailsService(jpaUserDetailsService)
            .sessionManagement(session -> session.maximumSessions(1))
            .logout(logout->logout.deleteCookies("JSESSIONID"))
            // 使用cookie的时候开启此配置： allows angular to read XSRF cookie
            .csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse()).and()
            .authenticationProvider(new PhoneAuthenticationProvider(phoneUserDetailsService))
            .addFilterAfter(new PhoneAuthenticationFilter(http.getSharedObject(AuthenticationManager.class)),UsernamePasswordAuthenticationFilter.class)
            .authorizeRequests(
                authorize ->
                    authorize.antMatchers("/logout").permitAll()
                        .anyRequest()
                        .authenticated() // for prod
            );
        // @formatter:on
        return http.build();
    }

    @Override
    public void customize(WebSecurity web) {
        web.ignoring()
                .antMatchers(
                        HttpMethod.GET,
                        "/",
                        "/zh/**/*.*",
                        "/en/**/*.*",
                        "/**/index.html",
                        "/**/login",
                        "/**/*.js",
                        "/**/*.css",
                        "/**/*.ico",
                        "/**/*.bmp",
                        "/**/*.jpeg",
                        "/**/*.jpg",
                        "/**/*.png",
                        "/**/*.ttf",
                        "/**/*.eot",
                        "/**/*.svg",
                        "/**/*.woff",
                        "/**/*.woff2");
    }
}
