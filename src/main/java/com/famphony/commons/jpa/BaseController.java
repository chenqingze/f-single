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

package com.famphony.commons.jpa;

import static com.famphony.single.system.iam.exception.BusinessExceptionCode.ENTITY_NOT_FOUND;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.Map;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.http.HttpStatus;
import org.springframework.util.ReflectionUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.server.ResponseStatusException;

/**
 * @author ChenQingze
 * @deprecated
 */
@Deprecated
public class BaseController<T extends BaseEntity, R extends JpaRepository<T, Long>> {

    private final R repository;

    public BaseController(R repository) {
        this.repository = repository;
    }

    /**
     * ??????????????????.
     *
     * @param id ??????
     * @return ????????????
     */
    @GetMapping("/{id}")
    public T getById(@PathVariable("id") Long id) {
        return repository
                .findById(id)
                .orElseThrow(
                        () ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        String.format(ENTITY_NOT_FOUND.getMsg(), getTClass().getSimpleName(), id)));
    }

    /**
     * ??????????????????????????????.
     *
     * @param page ??????
     * @param size ???????????????
     * @return ????????????????????????
     */
    @GetMapping(params = {"page", "size"})
    public Page<T> getList(
            @RequestParam(required = false, value = "page") Integer page,
            @RequestParam(required = false, value = "size", defaultValue = "10") Integer size) {
        if (page == null) {
            return repository.findAll(Pageable.unpaged());
        }
        return repository.findAll(PageRequest.of(page, size));
    }

    /**
     * ??????????????????.
     *
     * @param newT ???????????????
     * @return T ???????????? 201
     */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public T create(@RequestBody T newT) {
        return repository.save(newT);
    }

    /**
     * ????????????????????????????????????????????????.
     *
     * @param id ??????
     * @param newT ????????????
     * @return ???????????????
     */
    @PutMapping("/{id}")
    public T update(@PathVariable("id") Long id, @RequestBody T newT) {
        Optional<T> studentOptional = repository.findById(id);
        newT.setId(id);
        return repository.save(newT);
    }

    /**
     * ????????????????????????.
     *
     * @param id ??????
     * @param fields ?????????????????????
     * @return T
     */
    @PatchMapping("/{id}")
    public T update(@PathVariable("id") Long id, @RequestBody Map<String, Object> fields) {
        return repository
                .findById(id)
                .map(
                        t -> {
                            fields.forEach(
                                    (key, value) -> {
                                        Field field = ReflectionUtils.findField(getTClass(), key);
                                        field.setAccessible(true);
                                        ReflectionUtils.setField(field, t, value);
                                    });
                            return repository.save(t);
                        })
                .orElseThrow(
                        () ->
                                new ResponseStatusException(
                                        HttpStatus.NOT_FOUND,
                                        String.format(ENTITY_NOT_FOUND.getMsg(), getTClass().getSimpleName(), id)));
    }

    /**
     * ??????????????????.
     *
     * @param id ??????
     */
    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable("id") Long id) {
        repository.deleteById(id);
    }

    /** ?????? T.class */
    @SuppressWarnings("unchecked")
    protected Class<T> getTClass() {
        return (Class<T>)
                ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
    }
}
