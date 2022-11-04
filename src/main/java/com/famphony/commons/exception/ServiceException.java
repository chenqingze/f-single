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

package com.famphony.single.commons.exception;

import org.springframework.core.NestedExceptionUtils;
import org.springframework.http.HttpStatus;
import org.springframework.lang.Nullable;
import org.springframework.util.Assert;

/**
 * 微服务全链路追踪的项目使用此异常代替ResponseStatusException.
 *
 * <p>单体应用项目不需要使用此异常,直接使用ResponseStatusException 即可.
 *
 * @author ChenQingze
 */
public class ServiceException extends RuntimeException {

    private final int status;

    @Nullable private final String reason;

    @Nullable private final String tracingId;

    public ServiceException(HttpStatus status) {
        this(status, null, null);
    }

    public ServiceException(HttpStatus status, @Nullable String reason, @Nullable String tracingId) {
        super("");
        Assert.notNull(status, "HttpStatus is required");
        this.status = status.value();
        this.reason = reason;
        this.tracingId = tracingId;
    }

    public ServiceException(
            HttpStatus status,
            @Nullable String reason,
            @Nullable String tracingId,
            @Nullable Throwable cause) {
        super(null, cause);
        Assert.notNull(status, "HttpStatus is required");
        this.status = status.value();
        this.reason = reason;
        this.tracingId = tracingId;
    }

    public ServiceException(
            int rawStatusCode,
            @Nullable String reason,
            @Nullable String tracingId,
            @Nullable Throwable cause) {
        super(null, cause);
        this.status = rawStatusCode;
        this.reason = reason;
        this.tracingId = tracingId;
    }

    public HttpStatus getStatus() {
        return HttpStatus.valueOf(this.status);
    }

    public int getRawStatusCode() {
        return this.status;
    }

    @Nullable
    public String getReason() {
        return this.reason;
    }

    @Nullable
    public String getTracingId() {
        return this.tracingId;
    }

    @Override
    public String getMessage() {
        HttpStatus code = HttpStatus.resolve(this.status);
        String msg =
                (code != null ? code : this.status)
                        + (this.reason != null ? " \"" + this.reason + "\"" : "");
        return NestedExceptionUtils.buildMessage(msg, getCause());
    }
}
