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

package com.famphony.single.iam.exception;

import com.famphony.commons.exception.ExceptionCode;
import java.util.StringJoiner;

/**
 * @author ChenQingze
 */
public enum BusinessExceptionCode implements ExceptionCode {
    REAL_NAME_CANT_BE_NULL(1000, "姓名不能为空！"),
    ENTITY_NOT_FOUND(1001, "%s %s not found"),
    PERMISSION_NOT_FOUND(1002, "Permission %s not found"),

    TENANT_NOT_FOUND(1003, "Tenant %s not found"),
    USER_NOT_FOUND(1004, "User %s not found");
    private final int code;
    private final String msg;

    BusinessExceptionCode(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    @Override
    public int getCode() {
        return this.code;
    }

    @Override
    public String getMsg() {
        return this.msg;
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", BusinessExceptionCode.class.getSimpleName() + "[", "]")
                .add("code=" + code)
                .add("msg='" + msg + "'")
                .toString();
    }
}
