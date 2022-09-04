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

import com.famphony.single.system.iam.domain.entity.User;
import com.famphony.single.system.iam.domain.exception.UserNotFoundException;
import com.famphony.single.system.iam.infrastracture.repository.UserSpringDataJpaRepository;
import java.awt.print.Book;
import java.lang.reflect.Field;
import java.util.Map;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.util.ReflectionUtils;
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

    private final UserSpringDataJpaRepository userRepository;

    public UserController(UserSpringDataJpaRepository userRepository) {
        this.userRepository = userRepository;
    }

    /**
     * 查看用户信息.
     *
     * @param id 用户id
     * @return 用户
     */
    @GetMapping("/{id}")
    public User findById(@PathVariable("id") Long id) {
        return userRepository
                .findById(id)
                .orElseThrow(() -> new UserNotFoundException(String.format("user %s not found", id)));
    }

    /**
     * 分页获取用户列表.
     *
     * @param page 页码
     * @param size 每页记录数
     * @return 用户分页数据
     */
    @GetMapping(params = {"page", "size"})
    public Page<User> findAll(
            @RequestParam(required = false, value = "page") Integer page,
            @RequestParam(required = false, value = "size", defaultValue = "10") Integer size) {
        if (page == null) {
            return userRepository.findAll(Pageable.unpaged());
        }
        return userRepository.findAll(PageRequest.of(page, size));
    }

    /**
     * 创建用户.
     *
     * @param newUser 新用户
     * @return user 201
     */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public User save(@RequestBody User newUser) {
        return userRepository.save(newUser);
    }

    /**
     * 属性存在则更新，属性不存在则新增.
     *
     * @param id 用户id
     * @param newUser 用户
     * @return 无返回数据
     */
    @PutMapping("/{id}")
    public User update(@PathVariable("id") Long id, @RequestBody User newUser) {
        return userRepository
                .findById(id)
                .map(
                        user -> {
                            newUser.setId(id);
                            return userRepository.save(newUser);
                        })
                .orElseThrow(() -> new UserNotFoundException(String.format("user %s not found", id)));
    }

    /**
     * 修改用户属性.
     *
     * @param id 用户id
     * @param fields 修改的属性对象
     * @return User
     */
    @PatchMapping("/{id}")
    public User patch(@PathVariable("id") Long id, @RequestBody Map<String, Object> fields) {
        return userRepository
                .findById(id)
                .map(
                        user -> {
                            fields.forEach(
                                    (key, value) -> {
                                        Field field = ReflectionUtils.findField(Book.class, key);
                                        field.setAccessible(true);
                                        ReflectionUtils.setField(field, user, value);
                                    });
                            return userRepository.save(user);
                        })
                .orElseThrow(() -> new UserNotFoundException(String.format("user %s not found", id)));
    }

    /**
     * 删除权限.
     *
     * @param id 主键
     */
    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable("id") Long id) {
        userRepository.deleteById(id);
    }
}
