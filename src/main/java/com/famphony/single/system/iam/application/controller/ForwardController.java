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

package com.famphony.single.system.iam.application.controller;

import java.util.Locale;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * 控制前端路由转发.
 *
 * @author ChenQingze
 */
@Controller
public class ForwardController {

    /**
     * 根据浏览器accept-language转发对应的前端SPA资源路径.
     *
     * @param locale 浏览器默认语言
     * @return 单页面应用SPA
     */
    @GetMapping(value = {"/"})
    public String forwardViewRootPath(Locale locale) {
        return switch (locale.getLanguage().toLowerCase()) {
            case "en" -> "forward:/en/";
            case "zh" -> "forward:/zh/";
            default -> "forward:/zh/";
        };
    }

    /**
     * 对应的前端SPA入口.
     *
     * @return SPA入口页面
     */
    @GetMapping(value = "/{path:zh|en}/")
    public String indexView(@PathVariable String path) {
        return switch (path.toLowerCase()) {
            case "en" -> "/en/index.html";
            case "zh" -> "/zh/index.html";
            default -> "/zh/index.html";
        };
    }

    /** 转发前端路由，防止刷新页面404. */
    @GetMapping(
            value = {
                "/{lang}/{path:[^\\.]*}",
                "/{lang}/*/{path:[^\\.]*}",
                "/{lang}/*/{path:[^\\.]*}",
                "/{lang}/*/*/{path:[^\\.]*}",
                "/{lang}/*/*/*/{path:[^\\.]*}"
            })
    public String forwardFrontEnd(@PathVariable String lang) {
        // Forward to home page so that route is preserved.
        return switch (lang.toLowerCase()) {
            case "en" -> "forward:/en/";
            case "zh" -> "forward:/zh/";
            default -> "forward:/zh/";
        };
    }
}
