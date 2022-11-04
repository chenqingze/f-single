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

package com.famphony.single.iam.service.impl;

import com.famphony.single.iam.dto.assembler.UserAssembler;
import com.famphony.single.iam.dto.request.CreateUserReq;
import com.famphony.single.iam.dto.request.UpdateUserPasswordReq;
import com.famphony.single.iam.dto.request.UpdateUserReq;
import com.famphony.single.iam.dto.response.UserResp;
import com.famphony.single.iam.entity.User;
import com.famphony.single.iam.exception.BusinessExceptionCode;
import com.famphony.single.iam.repository.UserRepository;
import com.famphony.single.iam.service.UserService;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

/**
 * @author ChenQingze
 */
@Service
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public Page<UserResp> getUserList(Pageable pageable) {
        return userRepository.findAll(pageable).map(UserAssembler.INSTANCE::userToUserResp);
    }

    @Override
    public UserResp findUserById(Long id) {
        return userRepository
                .findById(id)
                .map(UserAssembler.INSTANCE::userToUserResp)
                .orElseThrow(
                        () ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        String.format(BusinessExceptionCode.USER_NOT_FOUND.getMsg(), id)));
    }

    @Override
    public UserResp createUser(CreateUserReq createUserReq) {
        return UserAssembler.INSTANCE.userToUserResp(
                userRepository.save(UserAssembler.INSTANCE.createUserReqToUser(createUserReq)));
    }

    @Override
    public UserResp updateUser(Long id, UpdateUserReq updateUserReq) {
        if (userRepository.existsById(id)) {
            User updateUser = UserAssembler.INSTANCE.updateUserReqToUser(updateUserReq);
            updateUser.setId(id);
            return UserAssembler.INSTANCE.userToUserResp(userRepository.save(updateUser));
        }
        throw new ResponseStatusException(
                HttpStatus.NOT_FOUND, String.format(BusinessExceptionCode.USER_NOT_FOUND.getMsg(), id));
    }

    @Override
    public UserResp updateUserPassword(Long id, UpdateUserPasswordReq updateUserPasswordReq) {
        return userRepository
                .findById(id)
                .map(
                        user -> {
                            user.setPasswordHash(updateUserPasswordReq.password());
                            return UserAssembler.INSTANCE.userToUserResp(userRepository.save(user));
                        })
                .orElseThrow(
                        () ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        String.format(BusinessExceptionCode.USER_NOT_FOUND.getMsg(), id)));
    }

    @Override
    public void deleteUserById(Long id) {
        userRepository.deleteById(id);
    }

    @Override
    public Optional<User> findUserByLoginName(String loginName) {
        return userRepository.findByUsernameOrMobileOrEmail(loginName, loginName, loginName);
    }

    @Override
    public Optional<User> findUserByMobile(String mobile) {
        return Optional.empty();
    }
}
