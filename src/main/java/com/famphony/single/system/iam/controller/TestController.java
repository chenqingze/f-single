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

package com.famphony.single.system.iam.controller;

import java.util.HashMap;
import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author ChenQingze
 */
@RestController
public class TestController {

    @GetMapping("/test")
    @ResponseBody
    public Map<String, String> testInfo() {
        Map<String, String> model = new HashMap<>();
        model.put("data", "测试信息。。。天下无敌");
        return model;
    }

    @GetMapping("/getTest")
    @ResponseBody
    public Map<String, String> getTestInfo() {
        Map<String, String> model = new HashMap<>();
        model.put("test get", "测试信息。。。天下无敌");
        return model;
    }

    @PostMapping("/postTest")
    @ResponseBody
    public Map<String, String> postTestInfo() {
        Map<String, String> model = new HashMap<>();
        model.put("test post", "测试信息。。。天下无敌");
        return model;
    }
}
