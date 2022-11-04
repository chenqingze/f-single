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

package com.famphony.commons.exception;

import com.famphony.commons.dto.error.HttpErrorStatusResponse;
import com.famphony.commons.dto.error.PathVariableValidationErrorResponse;
import com.famphony.commons.dto.error.ProgressStatusConvertErrorResponse;
import com.famphony.commons.dto.error.ServiceErrorResponse;
import com.famphony.commons.dto.error.ValidationErrorResponse;
import java.util.stream.Collectors;
import javax.validation.ConstraintViolationException;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

/**
 * @author ChenQingze
 */
@RestControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    /**
     * for microservice application.
     *
     * @param ex 微服务业务异常
     * @return
     */
    @ExceptionHandler(ServiceException.class)
    public ResponseEntity<ServiceErrorResponse> handleServiceError(ServiceException ex) {
        var body = new ServiceErrorResponse(ex.getTracingId(), ex.getStatus(), ex.getReason());
        return ResponseEntity.status(body.getStatus()).body(body);
    }

    /**
     * for monolithic application.
     *
     * @param ex 单体应用业务异常
     * @return
     */
    @ExceptionHandler(ResponseStatusException.class)
    public ResponseEntity<HttpErrorStatusResponse> handleStatusError(ResponseStatusException ex) {
        var body = new HttpErrorStatusResponse(ex.getStatus(), ex.getReason());
        return ResponseEntity.status(body.getStatus()).body(body);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ValidationErrorResponse> handleValidationError(
            MethodArgumentNotValidException ex) {
        var errors =
                ex.getFieldErrors().stream()
                        .collect(
                                Collectors.groupingBy(
                                        FieldError::getField,
                                        Collectors.mapping(
                                                DefaultMessageSourceResolvable::getDefaultMessage, Collectors.toList())));
        var body = new ValidationErrorResponse(HttpStatus.BAD_REQUEST, errors);

        return ResponseEntity.status(body.getStatus()).body(body);
    }

    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResponseEntity<ProgressStatusConvertErrorResponse> handleConvertStatus(
            MethodArgumentTypeMismatchException ex) {
        var body =
                new ProgressStatusConvertErrorResponse(HttpStatus.BAD_REQUEST, ex.getLocalizedMessage());

        return ResponseEntity.status(body.getStatus()).body(body);
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<PathVariableValidationErrorResponse> handleConstraintViolationException(
            ConstraintViolationException ex) {
        var body = new PathVariableValidationErrorResponse(HttpStatus.BAD_REQUEST, ex.getMessage());
        return ResponseEntity.status(body.getStatus()).body(body);
    }
}
