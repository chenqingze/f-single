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

package com.famphony.single.iam.dto.assembler;

import com.famphony.single.iam.dto.request.CreatePermissionReq;
import com.famphony.single.iam.dto.request.UpdatePermissionReq;
import com.famphony.single.iam.dto.response.PermissionResp;
import com.famphony.single.iam.entity.Permission;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @author ChenQingze
 */
@Mapper
public interface PermissionAssembler {

    PermissionAssembler INSTANCE = Mappers.getMapper(PermissionAssembler.class);

    @ToPermission
    Permission createPermissionReqToPermission(CreatePermissionReq createPermissionReq);

    @ToPermission
    Permission updatePermissionReqToPermission(UpdatePermissionReq updatePermissionReq);

    PermissionResp permissionToPermissionResp(Permission permission);
}
