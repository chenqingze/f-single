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

package com.famphony.single.system.iam.service.impl;

import com.famphony.single.system.iam.dto.assembler.PermissionAssembler;
import com.famphony.single.system.iam.dto.request.CreatePermissionReq;
import com.famphony.single.system.iam.dto.request.UpdatePermissionReq;
import com.famphony.single.system.iam.dto.response.PermissionResp;
import com.famphony.single.system.iam.entity.Permission;
import com.famphony.single.system.iam.exception.BusinessExceptionCode;
import com.famphony.single.system.iam.repository.PermissionRepository;
import com.famphony.single.system.iam.service.PermissionService;
import java.awt.print.Book;
import java.lang.reflect.Field;
import java.util.List;
import java.util.Map;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.server.ResponseStatusException;

/**
 * @author ChenQingze
 */
@Service
public class PermissionServiceImpl implements PermissionService {

    private final PermissionRepository permissionRepository;

    public PermissionServiceImpl(PermissionRepository permissionRepository) {
        this.permissionRepository = permissionRepository;
    }

    @Override
    public PermissionResp getPermissionById(Long id) {
        return permissionRepository
                .findById(id)
                .map(PermissionAssembler.INSTANCE::permissionToPermissionResp)
                .orElseThrow(
                        () ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        String.format(BusinessExceptionCode.PERMISSION_NOT_FOUND.getMsg(), id)));
    }

    @Override
    public List<PermissionResp> getPermissionByParentId(Long id) {
        return permissionRepository.findPermissionsByParentId(id).stream()
                .map(PermissionAssembler.INSTANCE::permissionToPermissionResp)
                .toList();
    }

    @Override
    public Page<PermissionResp> getPermissionList(Pageable pageable) {
        return permissionRepository
                .findAll(pageable)
                .map(PermissionAssembler.INSTANCE::permissionToPermissionResp);
    }

    @Override
    public PermissionResp createPermission(CreatePermissionReq createPermissionReq) {
        Permission permission =
                PermissionAssembler.INSTANCE.createPermissionReqToPermission(createPermissionReq);
        permission.setParent(permissionRepository.getReferenceById(createPermissionReq.parentId()));
        return PermissionAssembler.INSTANCE.permissionToPermissionResp(
                permissionRepository.save(permission));
    }

    @Override
    public PermissionResp updatePermission(Long id, UpdatePermissionReq updatePermissionReq) {
        Permission updatePermission =
                PermissionAssembler.INSTANCE.updatePermissionReqToPermission(updatePermissionReq);
        updatePermission.setId(id);
        updatePermission.setParent(
                permissionRepository.getReferenceById(updatePermissionReq.parentId()));
        return PermissionAssembler.INSTANCE.permissionToPermissionResp(
                permissionRepository.save(updatePermission));
    }

    @Override
    public Permission partialUpdatePermission(Long id, Map<String, Object> fields) {

        return permissionRepository
                .findById(id)
                .map(
                        permission -> {
                            fields.forEach(
                                    (key, value) -> {
                                        Field field = ReflectionUtils.findField(Book.class, key);
                                        field.setAccessible(true);
                                        ReflectionUtils.setField(field, permission, value);
                                    });
                            return permissionRepository.save(permission);
                        })
                .orElseThrow(
                        () ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        String.format(BusinessExceptionCode.PERMISSION_NOT_FOUND.getMsg(), id)));
    }

    @Override
    public void deletePermissionById(Long id) {
        permissionRepository.deleteById(id);
    }
}
