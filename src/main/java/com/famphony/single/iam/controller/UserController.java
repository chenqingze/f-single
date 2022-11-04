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

import com.famphony.single.system.iam.dto.request.CreateUserReq;
import com.famphony.single.system.iam.dto.request.UpdateUserPasswordReq;
import com.famphony.single.system.iam.dto.request.UpdateUserReq;
import com.famphony.single.system.iam.dto.response.UserResp;
import com.famphony.single.system.iam.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

/**
 * 用户控制器
 *
 * @author ChenQingze
 */
@RestController
@RequestMapping("/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    /**
     * 查看用户信息.
     *
     * @param id 用户id
     * @return 用户
     */
    @GetMapping("/{id}")
    public UserResp findById(@PathVariable("id") Long id) {
        return userService.findUserById(id);
    }

    /**
     * 分页获取用户列表.
     *
     * @param page 页码
     * @param size 每页记录数
     * @return 用户分页数据
     */
    @GetMapping(params = {"page", "size"})
    public Page<UserResp> getList(
            @RequestParam(required = false, value = "page") Integer page,
            @RequestParam(required = false, value = "size", defaultValue = "10") Integer size) {

        return userService.getUserList(PageRequest.of(page, size));
    }

    /**
     * 创建用户.
     *
     * @param createUserReq 新用户
     * @return user 201
     */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public UserResp create(@RequestBody CreateUserReq createUserReq) {
        return userService.createUser(createUserReq);
    }

    /**
     * 属性存在则更新，属性不存在则新增.
     *
     * @param id 用户id
     * @param updateUserReq 用户
     * @return 无返回数据
     */
    @PutMapping("/{id}")
    public UserResp update(@PathVariable("id") Long id, @RequestBody UpdateUserReq updateUserReq) {
        return userService.updateUser(id, updateUserReq);
    }

    /**
     * 修改用户密码.
     *
     * @param id 用户id
     * @param updateUserPasswordReq 修改的属性对象
     * @return User
     */
    @PatchMapping("/{id}")
    public UserResp updateUserPassword(
            @PathVariable("id") Long id, @RequestBody UpdateUserPasswordReq updateUserPasswordReq) {
        return userService.updateUserPassword(id, updateUserPasswordReq);
    }

    /**
     * 删除权限.
     *
     * @param id 主键
     */
    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable("id") Long id) {
        userService.deleteUserById(id);
    }
}
