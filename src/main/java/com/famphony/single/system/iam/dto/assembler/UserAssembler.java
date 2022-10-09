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

package com.famphony.single.system.iam.dto.assembler;

import com.famphony.single.system.iam.dto.request.CreateUserReq;
import com.famphony.single.system.iam.dto.request.UpdateUserReq;
import com.famphony.single.system.iam.dto.response.UserResp;
import com.famphony.single.system.iam.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

/**
 * @author ChenQingze
 */
@Mapper
public interface UserAssembler {

    UserAssembler INSTANCE = Mappers.getMapper(UserAssembler.class);

    UserResp userToUserResp(User user);

    @ToUser
    User createUserReqToUser(CreateUserReq createUserReq);

    @ToUser
    User updateUserReqToUser(UpdateUserReq updateUserReq);
}
