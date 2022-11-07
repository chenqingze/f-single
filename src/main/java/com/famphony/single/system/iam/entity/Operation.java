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

package com.famphony.single.system.iam.entity;

/**
 * 权限操作类型
 *
 * @author ChenQingze
 */
public enum Operation {
    /** 页面：首页或列表页. */
    INDEX,
    /** 接口：列表查询. */
    LIST,
    /** 页面：新增页，同NEW. */
    ADD,
    /** 页面/接口：详情页，同SHOW. */
    DETAIL,
    /** 页面/接口/按钮：编辑更新. */
    EDIT,
    /** 接口/按钮：删除. */
    DELETE,
    /** 接口/按钮：导出. */
    EXPORT,
    /** 接口/按钮：导入. */
    IMPORT,
    /** 接口/按钮：上传. */
    UPLOAD,
    /** 接口/按钮：下载. */
    DOWNLOAD,
    /** 接口/按钮：打印. */
    PRINT,
    /** 接口/按钮：预览. */
    PREVIEW
}
