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

import com.famphony.commons.jpa.BaseEntity;
import javax.persistence.Entity;
import org.hibernate.annotations.Comment;

/**
 * todo:实现用户组逻辑 用户组:主要用于方便管理授权，公司不大人员不是非常超级多的时候用不到 可以把部门看作一个用户组.
 *
 * @author ChenQingze
 */
@Entity
public class Group extends BaseEntity {

    @Comment("用户组名称")
    private String name;
}
