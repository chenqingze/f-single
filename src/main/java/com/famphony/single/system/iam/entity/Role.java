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
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import org.hibernate.Hibernate;
import org.hibernate.annotations.Comment;
import org.hibernate.envers.Audited;

/**
 * 角色:权限组（role:permission group）.
 *
 * @author ChenQingze
 */
// @SQLDelete(sql = "UPDATE role SET deleted = true WHERE id = ? AND version = ?", check =
// ResultCheckStyle.COUNT)
// @Where(clause = "deleted <> 'true'")
@Audited
@Entity
public class Role extends BaseEntity {

    @Comment("角色名称")
    @Column(unique = true)
    private String name;

    @Comment("角色描述")
    private String description;

    @ManyToMany(mappedBy = "roles", fetch = FetchType.LAZY)
    private Set<User> users = new HashSet<>();

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "role_permission",
            joinColumns = @JoinColumn(name = "role_id"),
            inverseJoinColumns = @JoinColumn(name = "permission_id"))
    private Set<Permission> permissions = new HashSet<>();

    public void addPermission(Permission permission) {
        this.permissions.add(permission);
        permission.getRoles().add(this);
    }

    public void removePermission(Permission permission) {
        this.permissions.remove(permission);
        permission.getRoles().remove(this);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }

    public Set<Permission> getPermissions() {
        return permissions;
    }

    public void setPermissions(Set<Permission> permissions) {
        this.permissions = permissions;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) {
            return false;
        }
        Role role = (Role) o;
        return getId() != null && Objects.equals(getId(), role.getId());
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
                + "description = "
                + getDescription()
                + ")";
    }
}
