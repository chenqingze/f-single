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

import java.io.Serializable;
import javax.persistence.Embeddable;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Comment;

/**
 * UI展现配置[也可以扩展资源组（UiConfig Group)].
 *
 * @author ChenQingze
 */
@Embeddable
public class UiConfig implements Serializable {

    @Comment("UI类型")
    @Enumerated(EnumType.STRING)
    UiType uiType;

    @Comment("页面显示标题/菜单显示标题")
    private String title;

    @Comment("是否支持路由器复用/是否缓存")
    @ColumnDefault("false")
    private Boolean cached = false;

    @Comment("是否在菜单中显示")
    @ColumnDefault("false")
    private Boolean shownInMenu;

    @Comment("排序")
    private Integer sort;

    @Comment("是否有子节点/是否可展开")
    @ColumnDefault("false")
    private Boolean expandable;

    @Comment("是否在面包屑导航中隐藏")
    @ColumnDefault("false")
    private Boolean hiddenInBreadcrumb;

    @Comment("请求地址/路由路径/外部链接")
    private String path;

    @Comment("是否外部链接")
    @ColumnDefault("false")
    private Boolean externalLink;

    @Comment("外部链接打开方式：_blank | _self | _parent | _top")
    @Enumerated(EnumType.STRING)
    private TargetAttribute target;

    @Comment("图标")
    private String icon;

    public UiType getPermitLevel() {
        return uiType;
    }

    public void setPermitLevel(UiType uiType) {
        this.uiType = uiType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Boolean getCached() {
        return cached;
    }

    public void setCached(Boolean cached) {
        this.cached = cached;
    }

    public Boolean getShownInMenu() {
        return shownInMenu;
    }

    public void setShownInMenu(Boolean shownInMenu) {
        this.shownInMenu = shownInMenu;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public UiType getUiType() {
        return uiType;
    }

    public void setUiType(UiType uiType) {
        this.uiType = uiType;
    }

    public Boolean getExpandable() {
        return expandable;
    }

    public void setExpandable(Boolean expandable) {
        this.expandable = expandable;
    }

    public Boolean getHiddenInBreadcrumb() {
        return hiddenInBreadcrumb;
    }

    public void setHiddenInBreadcrumb(Boolean hiddenInBreadcrumb) {
        this.hiddenInBreadcrumb = hiddenInBreadcrumb;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Boolean getExternalLink() {
        return externalLink;
    }

    public void setExternalLink(Boolean externalLink) {
        this.externalLink = externalLink;
    }

    public TargetAttribute getTarget() {
        return target;
    }

    public void setTarget(TargetAttribute target) {
        this.target = target;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    @Override
    public String toString() {
        return getClass().getSimpleName()
                + "("
                + "uiType = "
                + uiType
                + ", "
                + "title = "
                + title
                + ", "
                + "cached = "
                + cached
                + ", "
                + "shownInMenu = "
                + shownInMenu
                + ", "
                + "sort = "
                + sort
                + ", "
                + "expandable = "
                + expandable
                + ", "
                + "hiddenInBreadcrumb = "
                + hiddenInBreadcrumb
                + ", "
                + "path = "
                + path
                + ", "
                + "externalLink = "
                + externalLink
                + ", "
                + "target = "
                + target
                + ", "
                + "icon = "
                + icon
                + ")";
    }
}
