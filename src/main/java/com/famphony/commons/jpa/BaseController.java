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

package com.famphony.commons.base;

import com.famphony.single.system.iam.exception.EntityNotFoundException;
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

/**
 * @author ChenQingze
 */
public class BaseController<T extends BaseEntity, R extends JpaRepository<T, Long>> {

    private final R repository;

    public BaseController(R repository) {
        this.repository = repository;
    }

    /**
     * 查看实体信息.
     *
     * @param id 主键
     * @return 实体对象
     */
    @GetMapping("/{id}")
    public T getById(@PathVariable("id") Long id) {
        return repository
                .findById(id)
                .orElseThrow(
                        () ->
                                new EntityNotFoundException(
                                        String.format("%s %s not found", getTClass().getSimpleName(), id)));
    }

    /**
     * 分页获取实体对象列表.
     *
     * @param page 页码
     * @param size 每页记录数
     * @return 实体对象分页数据
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
     * 创建实体对象.
     *
     * @param newT 新实体对象
     * @return T 实体对象 201
     */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public T create(@RequestBody T newT) {
        return repository.save(newT);
    }

    /**
     * 属性存在则更新，属性不存在则新增.
     *
     * @param id 主键
     * @param newT 修改实体
     * @return 无返回数据
     */
    @PutMapping("/{id}")
    public T update(@PathVariable("id") Long id, @RequestBody T newT) {
        Optional<T> studentOptional = repository.findById(id);
        newT.setId(id);
        return repository.save(newT);
    }

    /**
     * 修改实体对象属性.
     *
     * @param id 主键
     * @param fields 修改的属性对象
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
                                new EntityNotFoundException(
                                        String.format("%s %s not found", getTClass().getSimpleName(), id)));
    }

    /**
     * 删除实体对象.
     *
     * @param id 主键
     */
    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable("id") Long id) {
        repository.deleteById(id);
    }

    /** 获取 T.class */
    @SuppressWarnings("unchecked")
    protected Class<T> getTClass() {
        return (Class<T>)
                ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
    }
}
