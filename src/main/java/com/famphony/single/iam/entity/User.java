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

package com.famphony.single.iam.entity;

import com.famphony.commons.jpa.BaseEntity;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;
import org.hibernate.Hibernate;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Comment;
import org.hibernate.annotations.NaturalId;
import org.hibernate.envers.Audited;

/**
 * 用户基本信息表:记录了整个SaaS平台的用户基本信息。 用户注册后是不属于具体某个组织，一个用户可以加入多个组织.
 *
 * @author ChenQingze
 */
@Audited
@Entity
public class User extends BaseEntity {

    @Size(min = 4, max = 255, message = "Minimum username length: 4 characters")
    @Comment("用户名/账号名")
    @NaturalId
    @Column(unique = true)
    private String username;

    @Comment("登录密码")
    @Size(min = 6, message = "Minimum password length: 6 characters")
    @Column(nullable = false)
    private String passwordHash;

    @Comment("邮箱")
    @Email
    @NotBlank
    @Column(unique = true)
    private String email;

    @Comment("手机号码")
    @NotBlank
    @NaturalId
    @Column(unique = true)
    private String mobile;

    @Comment("真实姓名")
    private String realName;

    @Comment("用户性别")
    @Enumerated(EnumType.STRING)
    private Gender gender;

    @Comment("账号状态是否启用")
    @ColumnDefault("true")
    private Boolean enabled = true;

    @Comment("组织")
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "org_id")
    private Org org;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "user_role",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles = new HashSet<>();

    ;

    public void addRole(Role role) {
        this.roles.add(role);
        role.getUsers().add(this);
    }

    public void removeRole(Role role) {
        this.roles.remove(role);
        role.getUsers().remove(this);
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public Org getOrg() {
        return org;
    }

    public void setOrg(Org org) {
        this.org = org;
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
        User user = (User) o;
        return getId() != null && Objects.equals(getId(), user.getId());
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
                + "username = "
                + getUsername()
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
                + "passwordHash = "
                + getPasswordHash()
                + ", "
                + "email = "
                + getEmail()
                + ", "
                + "mobile = "
                + getMobile()
                + ", "
                + "realName = "
                + getRealName()
                + ", "
                + "gender = "
                + getGender()
                + ", "
                + "enabled = "
                + getEnabled()
                + ")";
    }
}
