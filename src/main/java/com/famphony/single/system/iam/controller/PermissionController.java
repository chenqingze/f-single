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

import com.famphony.single.system.iam.dto.request.CreatePermissionReq;
import com.famphony.single.system.iam.dto.request.UpdatePermissionReq;
import com.famphony.single.system.iam.dto.response.PermissionResp;
import com.famphony.single.system.iam.entity.Permission;
import com.famphony.single.system.iam.service.PermissionService;
import java.util.List;
import java.util.Map;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.lang.Nullable;
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
 * @author ChenQingze
 */
@RestController
@RequestMapping("/permissions")
public class PermissionController {

    private final PermissionService permissionService;

    public PermissionController(PermissionService permissionService) {
        this.permissionService = permissionService;
    }

    /**
     * ??????????????????.
     *
     * @param id ??????id
     * @return ??????
     */
    @GetMapping("/{id}")
    public PermissionResp getById(@PathVariable("id") Long id) {
        return permissionService.getPermissionById(id);
    }

    @GetMapping("/{parentId}/children")
    public List<PermissionResp> getChildren(@PathVariable("parentId") Long id) {
        return permissionService.getPermissionByParentId(id);
    }

    /**
     * ????????????????????????.
     *
     * @param page ??????
     * @param size ???????????????
     * @return ??????????????????
     */
    @GetMapping(params = {"page", "size"})
    public Page<PermissionResp> getList(
            @Nullable @RequestParam(required = false, value = "page") Integer page,
            @Nullable @RequestParam(required = false, value = "size", defaultValue = "10") Integer size) {
        return permissionService.getPermissionList(PageRequest.of(page, size));
    }

    /**
     * ????????????.
     *
     * @param createPermissionReq ?????????
     * @return permission 201
     */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public PermissionResp create(@RequestBody CreatePermissionReq createPermissionReq) {
        return permissionService.createPermission(createPermissionReq);
    }

    /**
     * ????????????????????????????????????????????????.
     *
     * @param id ??????id
     * @param updatePermissionReq ??????
     * @return ???????????????
     */
    @PutMapping("/{id}")
    public PermissionResp update(
            @PathVariable("id") Long id, @RequestBody UpdatePermissionReq updatePermissionReq) {
        return permissionService.updatePermission(id, updatePermissionReq);
    }

    /**
     * ??????????????????.
     *
     * @param id ??????id
     * @param fields ?????????????????????
     * @return Permission
     */
    @PatchMapping("/{id}")
    public Permission partialUpdate(
            @PathVariable("id") Long id, @RequestBody Map<String, Object> fields) {
        return permissionService.partialUpdatePermission(id, fields);
    }

    /**
     * ????????????.
     *
     * @param id ??????
     */
    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable("id") Long id) {
        permissionService.deletePermissionById(id);
    }
}
