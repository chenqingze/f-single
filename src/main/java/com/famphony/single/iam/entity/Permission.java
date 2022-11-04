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
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import org.hibernate.Hibernate;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Comment;
import org.hibernate.envers.Audited;

/**
 * 权限.
 *
 * @author ChenQingze
 */
@Audited
@Entity
public class Permission extends BaseEntity {

    @Comment("权限标识符")
    @Column(unique = true, nullable = false)
    private String permit;

    @Comment("权限描述")
    private String description;

    @Comment("是否停用")
    @ColumnDefault("false")
    private Boolean disabled;

    @Comment("前端显示配置")
    private UiConfig uiConfig;

    @ManyToOne
    @JoinColumn(name = "parent_id")
    @ColumnDefault("0")
    private Permission parent;

    // @OrderBy("sort")
    @Comment("下级权限")
    @OneToMany(mappedBy = "parent", fetch = FetchType.LAZY)
    private List<Permission> children = new ArrayList<>();

    @ManyToMany(mappedBy = "permissions", fetch = FetchType.LAZY)
    private Set<Role> roles = new HashSet<>();

    /**
     * 新增子权限
     *
     * @param newChild
     * @return
     */
    public Permission addChildren(Permission newChild) {
        this.children.add(newChild);
        newChild.setParent(this);
        return newChild;
    }

    public void remove(Permission child) {
        this.children.remove(child);
        child.remove(parent);
    }

    /**
     * 修改parent
     *
     * @param newParent
     */
    public void moveParent(Permission newParent) {
        this.getParent().getChildren().remove(this);
        this.setParent(newParent);
        newParent.getChildren().add(this);
    }

    public String getPermit() {
        return permit;
    }

    public void setPermit(String permit) {
        this.permit = permit;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getDisabled() {
        return disabled;
    }

    public void setDisabled(Boolean disabled) {
        this.disabled = disabled;
    }

    public UiConfig getUiConfig() {
        return uiConfig;
    }

    public void setUiConfig(UiConfig uiConfig) {
        this.uiConfig = uiConfig;
    }

    public Permission getParent() {
        return parent;
    }

    public void setParent(Permission parent) {
        this.parent = parent;
    }

    public List<Permission> getChildren() {
        return children;
    }

    public void setChildren(List<Permission> children) {
        this.children = children;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) {
            return false;
        }
        Permission that = (Permission) o;
        return getId() != null && Objects.equals(getId(), that.getId());
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
                + "version = "
                + getVersion()
                + ", "
                + "permit = "
                + getPermit()
                + ", "
                + "description = "
                + getDescription()
                + ", "
                + "disabled = "
                + getDisabled()
                + ", "
                + "uiConfig = "
                + getUiConfig()
                + ", "
                + "parent = "
                + getParent()
                + ")";
    }
}
