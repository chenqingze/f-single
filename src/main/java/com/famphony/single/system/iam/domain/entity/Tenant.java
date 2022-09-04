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

package com.famphony.single.system.iam.domain.entity;

import com.famphony.single.system.iam.infrastracture.base.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.validation.constraints.Size;
import java.util.Objects;
import org.hibernate.Hibernate;
import org.hibernate.annotations.Comment;
import org.hibernate.annotations.NaturalId;

/**
 * 租户信息.
 *
 * <p>一个租户可以看作一个组织机构/企业/团队等.但是一个组织机构/企业/团队也可以在同一个iaas/paas/saas平台可以注册多个租户.
 *
 * @author ChenQingze
 */
@Entity
public class Tenant extends BaseEntity {

    @Size(min = 4, max = 255, message = "Minimum username length: 4 characters")
    @Comment("租户名称/机构名称")
    @NaturalId(mutable = true)
    @Column(unique = true)
    private String name;

    @Comment("机构地址")
    @Embedded
    private Address address;

    @Comment("座机")
    @Embedded
    private Landline landline;

    @Comment("组织负责人")
    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public Landline getLandline() {
        return landline;
    }

    public void setLandline(Landline landline) {
        this.landline = landline;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) {
            return false;
        }
        Tenant tenant = (Tenant) o;
        return getId() != null && Objects.equals(getId(), tenant.getId());
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }

    @Override
    public String toString() {
        return getClass().getSimpleName()
                + "("
                + "name = "
                + getName()
                + ", "
                + "id = "
                + getId()
                + ", "
                + "createdAt = "
                + getCreatedAt()
                + ", "
                + "updatedAt = "
                + getUpdatedAt()
                + ", "
                + "createdBy = "
                + getCreatedBy()
                + ", "
                + "updatedBy = "
                + getUpdatedBy()
                + ", "
                + "version = "
                + getVersion()
                + ", "
                + "address = "
                + getAddress()
                + ", "
                + "landline = "
                + getLandline()
                + ", "
                + "user = "
                + getUser()
                + ")";
    }
}
