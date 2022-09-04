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

import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * web mvc 配置.
 *
 * @author ChenQingze
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // @formatter:off
        registry.addResourceHandler("/zh/**")
                .addResourceLocations("file:/Users/chenqingze/repositories/famphony/f-spa-angular/dist/f-spa-angular/zh/")
                .setCacheControl(CacheControl.noCache()).resourceChain(true);
        registry.addResourceHandler("/en/**")
                .addResourceLocations("file:/Users/chenqingze/repositories/famphony/f-spa-angular/dist/f-spa-angular/en/")
                .setCacheControl(CacheControl.noCache()).resourceChain(true);
        registry.addResourceHandler("/**")
                .addResourceLocations("classpath:/public/", "classpath:/static/")
                .setCacheControl(CacheControl.noCache()).resourceChain(true);
             // .setCacheControl(CacheControl.maxAge(Duration.ofDays(365)));
        // @formatter:on
    }

    //    @Override
    //    public void addViewControllers(ViewControllerRegistry registry) {
    //        registry.addViewController("/").setViewName("index.html");
    //        registry.addViewController("/{path:[^\\.]*}").setViewName("forward:/");
    //    }

}
