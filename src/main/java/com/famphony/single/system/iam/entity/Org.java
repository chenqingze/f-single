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

import com.famphony.single.common.base.BaseEntity;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import org.hibernate.Hibernate;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Comment;
import org.hibernate.envers.Audited;

/**
 * 组织.
 *
 * @author ChenQingze
 */
@Audited
@Entity
public class Org extends BaseEntity {

    @Comment("组织名称,同一组织机构内部门名称不能重复")
    private String name;

    @Comment("组织层级")
    private Integer level;

    @Comment("组织描述")
    private String description;

    @Comment("排序")
    private Integer sort;

    @Comment("是否启用")
    @ColumnDefault("true")
    private Boolean enabled = true;

    @Comment("座机/电话")
    private String landline;

    @Comment("上级组织")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id")
    private Org parent;

    @Comment("所有下级组织")
    @OneToMany(mappedBy = "parent", fetch = FetchType.LAZY)
    private List<Org> children = new ArrayList<>();

    @Comment("所属租户")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tenant_id")
    private Tenant tenant;

    @Comment("组织负责人")
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    public Org addChildren(Org newChild) {
        this.children.add(newChild);
        newChild.setParent(this);
        return newChild;
    }

    public void remove(Org child) {
        this.children.remove(child);
        child.remove(parent);
    }

    public void moveParent(Org newParent) {
        this.getParent().getChildren().remove(this);
        this.setParent(newParent);
        newParent.getChildren().add(this);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public String getLandline() {
        return landline;
    }

    public void setLandline(String landline) {
        this.landline = landline;
    }

    public Org getParent() {
        return parent;
    }

    public void setParent(Org parent) {
        this.parent = parent;
    }

    public List<Org> getChildren() {
        return children;
    }

    public void setChildren(List<Org> children) {
        this.children = children;
    }

    public Tenant getTenant() {
        return tenant;
    }

    public void setTenant(Tenant tenant) {
        this.tenant = tenant;
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
        Org org = (Org) o;
        return getId() != null && Objects.equals(getId(), org.getId());
    }

    @Override
    public int hashCode() {
        return getClass().hashCode();
    }

    @Override
    public String toString() {
        return getClass().getSimpleName()
                + "("
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
                + "name = "
                + getName()
                + ", "
                + "level = "
                + getLevel()
                + ", "
                + "description = "
                + getDescription()
                + ", "
                + "sort = "
                + getSort()
                + ", "
                + "enabled = "
                + getEnabled()
                + ", "
                + "landline = "
                + getLandline()
                + ")";
    }
}
