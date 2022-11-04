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

package com.famphony.single.iam.controller;

import com.famphony.single.iam.entity.Tenant;
import com.famphony.single.iam.exception.BusinessExceptionCode;
import com.famphony.single.iam.repository.TenantRepository;
import java.awt.print.Book;
import java.lang.reflect.Field;
import java.util.Map;
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
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

/**
 * 租户控制器.
 *
 * @author ChenQingze
 */
@RestController
@RequestMapping("/tenants")
public class TenantController {

    private final TenantRepository tenantRepository;

    public TenantController(TenantRepository tenantRepository) {
        this.tenantRepository = tenantRepository;
    }

    /**
     * 查看租户信息.
     *
     * @param id 租户id
     * @return 租户
     */
    @GetMapping("/{id}")
    public Tenant getById(@PathVariable("id") Long id) {
        return tenantRepository
                .findById(id)
                .orElseThrow(
                        () ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        String.format(BusinessExceptionCode.TENANT_NOT_FOUND.getMsg(), id)));
    }

    /**
     * 创建租户.
     *
     * @param newTenant 新租户
     * @return Tenant 201
     */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Tenant post(@RequestBody Tenant newTenant) {
        return tenantRepository.save(newTenant);
    }

    /**
     * 属性存在则更新，属性不存在则新增.
     *
     * @param id 租户id
     * @param newTenant 租户
     * @return 无返回数据
     */
    @PutMapping("/{id}")
    public Tenant put(@PathVariable("id") Long id, @RequestBody Tenant newTenant) {
        newTenant.setId(id);
        return tenantRepository.save(newTenant);
    }

    /**
     * 修改租户属性.
     *
     * @param id 租户id
     * @param fields 修改的属性对象
     * @return Tenant
     */
    @PatchMapping("/{id}")
    public Tenant patch(@PathVariable("id") Long id, @RequestBody Map<String, Object> fields) {
        return tenantRepository
                .findById(id)
                .map(
                        tenant -> {
                            fields.forEach(
                                    (key, value) -> {
                                        Field field = ReflectionUtils.findField(Book.class, key);
                                        field.setAccessible(true);
                                        ReflectionUtils.setField(field, tenant, value);
                                    });
                            return tenantRepository.save(tenant);
                        })
                .orElseThrow(
                        () ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        String.format(BusinessExceptionCode.TENANT_NOT_FOUND.getMsg(), id)));
    }

    /**
     * 删除租户.
     *
     * @param id 主键
     */
    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable("id") Long id) {
        tenantRepository.deleteById(id);
    }
}
