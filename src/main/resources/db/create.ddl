create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：'_blank' | '_self' | '_parent' | '_top'';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean      default false,
    "disabled"             boolean      default false,
    "external_link"        boolean      default false,
    "hidden_in_breadcrumb" boolean      default false,
    "icon"                 varchar(255),
    "opened"               boolean      default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean      default false,
    "target"               varchar(255) default _tab,
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean      default false,
    "disabled"             boolean      default false,
    "external_link"        boolean      default false,
    "hidden_in_breadcrumb" boolean      default false,
    "icon"                 varchar(255),
    "opened"               boolean      default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean      default false,
    "target"               varchar(255) default _tab,
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean      default false,
    "disabled"             boolean      default false,
    "external_link"        boolean      default false,
    "hidden_in_breadcrumb" boolean      default false,
    "icon"                 varchar(255),
    "opened"               boolean      default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean      default false,
    "target"               varchar(255) default '_tab',
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "enabled"       boolean default true,
    "landline"      varchar(255),
    "level"         integer,
    "name"          varchar(255),
    "sort"          integer,
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "parent_id"     bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "tenant_id"     bigint,
    "user_id"       bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by_id"        bigint,
    "updated_by_id"        bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "description"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"            bigint not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "area_code"     varchar(255),
    "country_code"  varchar(255),
    "line_number"   varchar(255),
    "name"          varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    "user_id"       bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by_id" bigint,
    "updated_by_id" bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FK5osqkketfn5o6hault87d88v" foreign key ("created_by_id") references "user";
alter table if exists "org" add constraint "FK2ra6se6e36mwfi4d8227oo2qc" foreign key ("updated_by_id") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKr5f1d9cbr8of08fdsi73fl1y9" foreign key ("created_by_id") references "user";
alter table if exists "group" add constraint "FKrngqunurvutosx9e4qjlfod6y" foreign key ("updated_by_id") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKb1sxas7m3txbny8dlxqij72b0" foreign key ("created_by_id") references "user";
alter table if exists "organization" add constraint "FKj65ukwnvgyx2n1y6g4yogig55" foreign key ("updated_by_id") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKk7arc0i9na5ohtrhx78fxhu70" foreign key ("created_by_id") references "user";
alter table if exists "permission" add constraint "FKe447vkb567w7wxprydv5i43sl" foreign key ("updated_by_id") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FK39lcar1n4bkth5k4cmcssksu8" foreign key ("created_by_id") references "user";
alter table if exists "role" add constraint "FKjdxrcpj9e433nirxrslxst0gi" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKilgohlemonn0weu0m9kxkcpp3" foreign key ("created_by_id") references "user";
alter table if exists "tenant" add constraint "FKja8jd2fd5qli1p8t2lgkny1f4" foreign key ("updated_by_id") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKafkm2kr97ap7c0nv9l59okoay" foreign key ("created_by_id") references "user";
alter table if exists "user" add constraint "FK4fol2gywb2a7tlsugg5vv9r92" foreign key ("updated_by_id") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "tenant_user"
(
    "user_id"   bigint not null,
    "tenant_id" bigint not null,
    primary key ("user_id", "tenant_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "tenant_user" add constraint "FKdw2n9pmm2kn84vwbbhtgj3v6v" foreign key ("tenant_id") references "tenant";
alter table if exists "tenant_user" add constraint "FKf8lrwdx50im6dg24826c6ef3j" foreign key ("user_id") references "user";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "department_user"
(
    "department_id" bigint not null,
    "user_id"       bigint not null,
    primary key ("department_id", "user_id")
);
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "department_user" add constraint "FKn6e5tv966l72lm8ufgy8nxt2e" foreign key ("user_id") references "user";
alter table if exists "department_user" add constraint "FK4j7fp7tdtlhtfnn6675xoqvxk" foreign key ("department_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "opened"               boolean default false,
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "disabled"             boolean default false,
    "expanded"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "permit_level"         varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."expanded" is '菜单是否展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/或外部链接';
comment
on column "permission"."permit_level" is '许可级别';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expanded"             boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expanded" is '菜单是否展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '菜单是否展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "enabled"     boolean default true,
    "landline"    varchar(255),
    "level"       integer,
    "name"        varchar(255),
    "sort"        integer,
    "created_by"  bigint,
    "updated_by"  bigint,
    "parent_id"   bigint,
    "user_id"     bigint,
    primary key ("id")
);
comment
on column "org"."description" is '部门描述';
comment
on column "org"."enabled" is '是否启用';
comment
on column "org"."landline" is '座机/电话';
comment
on column "org"."level" is '部门层级';
comment
on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment
on column "org"."sort" is '排序';
comment
on column "org"."parent_id" is '上级部门id';
comment
on column "org"."user_id" is '部门负责人';
create table "group"
(
    "id"         bigint not null,
    "created_at" timestamp(6),
    "updated_at" timestamp(6),
    "name"       varchar(255),
    "created_by" bigint,
    "updated_by" bigint,
    "parent_id"  bigint,
    primary key ("id")
);
comment
on column "group"."name" is '用户组名称';
comment
on column "group"."parent_id" is '父用户组';
create table "organization"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "tenant_id"    bigint,
    "user_id"      bigint,
    primary key ("id")
);
create table "permission"
(
    "id"                   bigint       not null,
    "created_at"           timestamp(6),
    "updated_at"           timestamp(6),
    "description"          varchar(255),
    "disabled"             boolean default false,
    "permit"               varchar(255) not null,
    "sort"                 integer,
    "cached"               boolean default false,
    "expandable"           boolean default false,
    "external_link"        boolean default false,
    "hidden_in_breadcrumb" boolean default false,
    "icon"                 varchar(255),
    "path"                 varchar(255),
    "shown_in_menu"        boolean default false,
    "target"               varchar(255),
    "title"                varchar(255),
    "ui_type"              varchar(255),
    "created_by"           bigint,
    "updated_by"           bigint,
    "parent_id"            bigint,
    primary key ("id")
);
comment
on column "permission"."description" is '权限描述';
comment
on column "permission"."disabled" is '是否停用';
comment
on column "permission"."permit" is '权限标识符';
comment
on column "permission"."sort" is '排序';
comment
on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment
on column "permission"."expandable" is '是否有子节点/是否可展开';
comment
on column "permission"."external_link" is '是否外部链接';
comment
on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment
on column "permission"."icon" is '图标';
comment
on column "permission"."path" is '请求地址/路由路径/外部链接';
comment
on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment
on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment
on column "permission"."title" is '页面显示标题/菜单显示标题';
comment
on column "permission"."ui_type" is 'UI类型';
create table "role"
(
    "id"          bigint not null,
    "created_at"  timestamp(6),
    "updated_at"  timestamp(6),
    "description" varchar(255),
    "name"        varchar(255),
    "created_by"  bigint,
    "updated_by"  bigint,
    primary key ("id")
);
comment
on column "role"."description" is '角色描述';
comment
on column "role"."name" is '角色名称';
create table "tenant"
(
    "id"           bigint not null,
    "created_at"   timestamp(6),
    "updated_at"   timestamp(6),
    "area_code"    varchar(255),
    "country_code" varchar(255),
    "line_number"  varchar(255),
    "name"         varchar(255),
    "created_by"   bigint,
    "updated_by"   bigint,
    "user_id"      bigint,
    primary key ("id")
);
comment
on column "tenant"."name" is '租户名称/机构名称';
create table "user"
(
    "id"            bigint       not null,
    "created_at"    timestamp(6),
    "updated_at"    timestamp(6),
    "email"         varchar(255),
    "enabled"       boolean default true,
    "gender"        smallint,
    "mobile"        varchar(255),
    "name"          varchar(255),
    "password_hash" varchar(255) not null,
    "username"      varchar(255),
    "created_by"    bigint,
    "updated_by"    bigint,
    "dept_id"       bigint,
    primary key ("id")
);
comment
on column "user"."email" is '邮箱';
comment
on column "user"."enabled" is '账号状态是否启用';
comment
on column "user"."gender" is '用户性别';
comment
on column "user"."mobile" is '手机号码';
comment
on column "user"."name" is '真实姓名';
comment
on column "user"."password_hash" is '登录密码';
comment
on column "user"."username" is '用户名/账号名';
comment
on column "user"."dept_id" is '部门';
create table "role_permission"
(
    "role_id"       bigint not null,
    "permission_id" bigint not null,
    primary key ("role_id", "permission_id")
);
create table "user_role"
(
    "user_id" bigint not null,
    "role_id" bigint not null,
    primary key ("user_id", "role_id")
);
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username)
VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456',
        'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '部门描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '部门层级';
comment on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级部门id';
comment on column "org"."user_id" is '部门负责人';
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
comment on column "group"."parent_id" is '父用户组';
create table "organization" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "created_by" bigint, "updated_by" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "name" varchar(255), "password_hash" varchar(255) not null, "username" varchar(255), "created_by" bigint, "updated_by" bigint, "dept_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."name" is '真实姓名';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."dept_id" is '部门';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '部门描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '部门层级';
comment on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级部门id';
comment on column "org"."user_id" is '部门负责人';
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
comment on column "group"."parent_id" is '父用户组';
create table "organization" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "created_by" bigint, "updated_by" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "name" varchar(255), "password_hash" varchar(255) not null, "username" varchar(255), "created_by" bigint, "updated_by" bigint, "dept_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."name" is '真实姓名';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."dept_id" is '部门';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '部门描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '部门层级';
comment on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级部门id';
comment on column "org"."user_id" is '部门负责人';
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
comment on column "group"."parent_id" is '父用户组';
create table "organization" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "created_by" bigint, "updated_by" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "name" varchar(255), "password_hash" varchar(255) not null, "username" varchar(255), "created_by" bigint, "updated_by" bigint, "dept_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."name" is '真实姓名';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."dept_id" is '部门';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '部门描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '部门层级';
comment on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级部门id';
comment on column "org"."user_id" is '部门负责人';
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
comment on column "group"."parent_id" is '父用户组';
create table "organization" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "created_by" bigint, "updated_by" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "name" varchar(255), "password_hash" varchar(255) not null, "username" varchar(255), "created_by" bigint, "updated_by" bigint, "dept_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."name" is '真实姓名';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."dept_id" is '部门';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '部门描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '部门层级';
comment on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级部门id';
comment on column "org"."user_id" is '部门负责人';
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
comment on column "group"."parent_id" is '父用户组';
create table "organization" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "created_by" bigint, "updated_by" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "name" varchar(255), "password_hash" varchar(255) not null, "username" varchar(255), "created_by" bigint, "updated_by" bigint, "dept_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."name" is '真实姓名';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."dept_id" is '部门';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 1, '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '部门描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '部门层级';
comment on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级部门id';
comment on column "org"."user_id" is '部门负责人';
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
comment on column "group"."parent_id" is '父用户组';
create table "organization" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "created_by" bigint, "updated_by" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "name" varchar(255), "password_hash" varchar(255) not null, "username" varchar(255), "created_by" bigint, "updated_by" bigint, "dept_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."name" is '真实姓名';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."dept_id" is '部门';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '部门描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '部门层级';
comment on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级部门id';
comment on column "org"."user_id" is '部门负责人';
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
comment on column "group"."parent_id" is '父用户组';
create table "organization" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "created_by" bigint, "updated_by" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "name" varchar(255), "password_hash" varchar(255) not null, "username" varchar(255), "created_by" bigint, "updated_by" bigint, "dept_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."name" is '真实姓名';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."dept_id" is '部门';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '部门描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '部门层级';
comment on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级部门id';
comment on column "org"."user_id" is '部门负责人';
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
comment on column "group"."parent_id" is '父用户组';
create table "organization" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "created_by" bigint, "updated_by" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "name" varchar(255), "password_hash" varchar(255) not null, "username" varchar(255), "created_by" bigint, "updated_by" bigint, "dept_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."name" is '真实姓名';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."dept_id" is '部门';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "dept_seq" start with 1 increment by 50;
create sequence "group_seq" start with 1 increment by 50;
create sequence "organization_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '部门描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '部门层级';
comment on column "org"."name" is '部门名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级部门id';
comment on column "org"."user_id" is '部门负责人';
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
comment on column "group"."parent_id" is '父用户组';
create table "organization" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "created_by" bigint, "updated_by" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "name" varchar(255), "password_hash" varchar(255) not null, "username" varchar(255), "created_by" bigint, "updated_by" bigint, "dept_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."name" is '真实姓名';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."dept_id" is '部门';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "org" add constraint "FKb1fvxb270qokd37d52osu3r8f" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKn3nyaipqccmkq8foo4v3emqsj" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKpl3vrhypw17tsh5kf4hgp6loa" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKd6oangxd2qujbpou36omlriyt" foreign key ("user_id") references "user";
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "group" add constraint "FK9lmw6yavyb0s3bwbsg6vsojqu" foreign key ("parent_id") references "group";
alter table if exists "organization" add constraint "FKsjn1ux3bcq79luc9bom0kgr7t" foreign key ("created_by") references "user";
alter table if exists "organization" add constraint "FK2rass5hkm9r6s2nq2fnmc09dl" foreign key ("updated_by") references "user";
alter table if exists "organization" add constraint "FK6eaxs064byevqcilsbi8k5hdi" foreign key ("tenant_id") references "tenant";
alter table if exists "organization" add constraint "FK97yo6jsdixx56v5ofnfihm3k5" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FK78ebq13b4xfaepkp1a2ueek47" foreign key ("dept_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, real_name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, real_name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint not null, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_t8tbwelrnviudxdaggwr1kd9b unique ("mobile", "username");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, email, enabled, gender, mobile, real_name, password_hash, username) VALUES (1, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', 'ChenQingze', '{noop}123456', 'chenqingze');
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint not null, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_t8tbwelrnviudxdaggwr1kd9b unique ("mobile", "username");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public.user (id,email, enabled, gender, mobile, real_name, password_hash, username, created_by,org_id);
VALUES (1,'chenqingze107@gmail.com2', true, 'male', '1885139968282', 'ChenQi1n12gze', '{noop}123456', 'che21nqi1ngze',0,null);
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint not null, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_t8tbwelrnviudxdaggwr1kd9b unique ("mobile", "username");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public.user;
(id,email, enabled, gender, mobile, real_name, password_hash, username, created_by, org_id);
VALUES;
(0,'root@famphony.com', true, 'MALE', '18853996892', 'SuperRoot', '{noop}123456', 'root', 0, null),;
(1,'chenqingze107@gmail.com', true, 'MALE', '18853996882', 'ChenQingze', '{noop}123456','chenqingze', 0, null);
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint not null, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_t8tbwelrnviudxdaggwr1kd9b unique ("mobile", "username");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public.user;
(id,email, enabled, gender, mobile, real_name, password_hash, username, created_by, org_id);
VALUES;
(0,'root@famphony.com', true, 'MALE', '18853996892', 'SuperRoot', '{noop}123456', 'root', 0, null),;
(1,'chenqingze107@gmail.com', true, 'MALE', '18853996882', 'ChenQingze', '{noop}123456','chenqingze', 0, null);
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint not null, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_t8tbwelrnviudxdaggwr1kd9b unique ("mobile", "username");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, created_at, updated_at, version, email, enabled, gender, mobile, password_hash, real_name, username, created_by, updated_by, org_id) VALUES (0, '2022-10-04 13:43:09.000000', null, null, 'root@famphony.com', true, 'MALE', '18853996892', '{noop}123456', 'SuperRoot', 'root', 0, null, null);
INSERT INTO public."user" (id, created_at, updated_at, version, email, enabled, gender, mobile, password_hash, real_name, username, created_by, updated_by, org_id) VALUES (1, '2022-10-04 13:43:13.000000', null, null, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', '{noop}123456', 'ChenQingze', 'chenqingze', 0, null, null);
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint not null, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_t8tbwelrnviudxdaggwr1kd9b unique ("mobile", "username");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, created_at, updated_at, version, email, enabled, gender, mobile, password_hash, real_name, username, created_by, updated_by, org_id) VALUES (0, '2022-10-04 13:43:09.000000', null, null, 'root@famphony.com', true, 'MALE', '18853996892', '{noop}123456', 'SuperRoot', 'root', 0, null, null);
INSERT INTO public."user" (id, created_at, updated_at, version, email, enabled, gender, mobile, password_hash, real_name, username, created_by, updated_by, org_id) VALUES (1, '2022-10-04 13:43:13.000000', null, null, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', '{noop}123456', 'ChenQingze', 'chenqingze', 0, null, null);
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "sort" integer, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."sort" is '排序';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint not null, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_t8tbwelrnviudxdaggwr1kd9b unique ("mobile", "username");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, created_at, updated_at, version, email, enabled, gender, mobile, password_hash, real_name, username, created_by, updated_by, org_id) VALUES (0, '2022-10-04 13:43:09.000000', null, null, 'root@famphony.com', true, 'MALE', '18853996892', '{noop}123456', 'SuperRoot', 'root', 0, null, null);
INSERT INTO public."user" (id, created_at, updated_at, version, email, enabled, gender, mobile, password_hash, real_name, username, created_by, updated_by, org_id) VALUES (1, '2022-10-04 13:43:13.000000', null, null, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', '{noop}123456', 'ChenQingze', 'chenqingze', 0, null, null);
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "sort" integer, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."sort" is '排序';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint not null, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_t8tbwelrnviudxdaggwr1kd9b unique ("mobile", "username");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, created_at, updated_at, version, email, enabled, gender, mobile, password_hash, real_name, username, created_by, updated_by, org_id) VALUES (0, '2022-10-04 13:43:09.000000', null, null, 'root@famphony.com', true, 'MALE', '18853996892', '{noop}123456', 'SuperRoot', 'root', 0, null, null);
INSERT INTO public."user" (id, created_at, updated_at, version, email, enabled, gender, mobile, password_hash, real_name, username, created_by, updated_by, org_id) VALUES (1, '2022-10-04 13:43:13.000000', null, null, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', '{noop}123456', 'ChenQingze', 'chenqingze', 0, null, null);
create sequence "group_seq" start with 1 increment by 50;
create sequence "org_seq" start with 1 increment by 50;
create sequence "permission_seq" start with 1 increment by 50;
create sequence "role_seq" start with 1 increment by 50;
create sequence "tenant_seq" start with 1 increment by 50;
create sequence "user_seq" start with 1 increment by 50;
create table "group" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "group"."name" is '用户组名称';
create table "org" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "enabled" boolean default true, "landline" varchar(255), "level" integer, "name" varchar(255), "sort" integer, "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, "tenant_id" bigint, "user_id" bigint, primary key ("id"));
comment on column "org"."description" is '组织描述';
comment on column "org"."enabled" is '是否启用';
comment on column "org"."landline" is '座机/电话';
comment on column "org"."level" is '组织层级';
comment on column "org"."name" is '组织名称,同一组织机构内部门名称不能重复';
comment on column "org"."sort" is '排序';
comment on column "org"."parent_id" is '上级组织';
comment on column "org"."tenant_id" is '所属租户';
comment on column "org"."user_id" is '组织负责人';
create table "permission" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "disabled" boolean default false, "permit" varchar(255) not null, "cached" boolean default false, "expandable" boolean default false, "external_link" boolean default false, "hidden_in_breadcrumb" boolean default false, "icon" varchar(255), "path" varchar(255), "shown_in_menu" boolean default false, "sort" integer, "target" varchar(255), "title" varchar(255), "ui_type" varchar(255), "created_by" bigint not null, "updated_by" bigint, "parent_id" bigint, primary key ("id"));
comment on column "permission"."description" is '权限描述';
comment on column "permission"."disabled" is '是否停用';
comment on column "permission"."permit" is '权限标识符';
comment on column "permission"."cached" is '是否支持路由器复用/是否缓存';
comment on column "permission"."expandable" is '是否有子节点/是否可展开';
comment on column "permission"."external_link" is '是否外部链接';
comment on column "permission"."hidden_in_breadcrumb" is '是否在面包屑导航中隐藏';
comment on column "permission"."icon" is '图标';
comment on column "permission"."path" is '请求地址/路由路径/外部链接';
comment on column "permission"."shown_in_menu" is '是否在菜单中显示';
comment on column "permission"."sort" is '排序';
comment on column "permission"."target" is '外部链接打开方式：_blank | _self | _parent | _top';
comment on column "permission"."title" is '页面显示标题/菜单显示标题';
comment on column "permission"."ui_type" is 'UI类型';
create table "role" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "description" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, primary key ("id"));
comment on column "role"."description" is '角色描述';
comment on column "role"."name" is '角色名称';
create table "tenant" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "city" varchar(255), "country" varchar(255), "county" varchar(255), "province" varchar(255), "area_code" varchar(255), "country_code" varchar(255), "line_number" varchar(255), "name" varchar(255), "created_by" bigint not null, "updated_by" bigint, "user_id" bigint, primary key ("id"));
comment on column "tenant"."name" is '租户名称/机构名称';
comment on column "tenant"."user_id" is '组织负责人';
create table "user" ("id" bigint not null, "created_at" timestamp(6), "updated_at" timestamp(6), "version" bigint, "email" varchar(255), "enabled" boolean default true, "gender" varchar(255), "mobile" varchar(255), "password_hash" varchar(255) not null, "real_name" varchar(255), "username" varchar(255), "created_by" bigint not null, "updated_by" bigint, "org_id" bigint, primary key ("id"));
comment on column "user"."email" is '邮箱';
comment on column "user"."enabled" is '账号状态是否启用';
comment on column "user"."gender" is '用户性别';
comment on column "user"."mobile" is '手机号码';
comment on column "user"."password_hash" is '登录密码';
comment on column "user"."real_name" is '真实姓名';
comment on column "user"."username" is '用户名/账号名';
comment on column "user"."org_id" is '组织';
create table "role_permission" ("role_id" bigint not null, "permission_id" bigint not null, primary key ("role_id", "permission_id"));
create table "user_role" ("user_id" bigint not null, "role_id" bigint not null, primary key ("user_id", "role_id"));
alter table if exists "permission" add constraint UK_12n0e43hh6pv7prqnhstg6l2d unique ("permit");
alter table if exists "role" add constraint UK_8sewwnpamngi6b1dwaa88askk unique ("name");
alter table if exists "tenant" add constraint UK_dcxf3ksi0gyn1tieeq0id96lm unique ("name");
alter table if exists "user" add constraint UK_t8tbwelrnviudxdaggwr1kd9b unique ("mobile", "username");
alter table if exists "user" add constraint UK_ob8kqyqqgmefl0aco34akdtpe unique ("email");
alter table if exists "user" add constraint UK_cnjwxx5favk5ycqajjt17fwy1 unique ("mobile");
alter table if exists "user" add constraint UK_sb8bbouer5wak8vyiiy4pf2bx unique ("username");
alter table if exists "group" add constraint "FKjn19deaptpx1feijjcg85xj6v" foreign key ("created_by") references "user";
alter table if exists "group" add constraint "FK9spmo2kp5epav3wphkw92ns77" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKdui9tcxr5e5a24algl0qrcvp9" foreign key ("created_by") references "user";
alter table if exists "org" add constraint "FKf2jhrc3kwfg53tiqwuhjtyuud" foreign key ("updated_by") references "user";
alter table if exists "org" add constraint "FKfqedk54wei88k683qq84s72el" foreign key ("parent_id") references "org";
alter table if exists "org" add constraint "FKmiyy53puouj1k7otutji3dx4h" foreign key ("tenant_id") references "tenant";
alter table if exists "org" add constraint "FKlurng4nwa3csy52xsaj4rtlpc" foreign key ("user_id") references "user";
alter table if exists "permission" add constraint "FKc0u3ck0ln52uloldjbitnxhxa" foreign key ("created_by") references "user";
alter table if exists "permission" add constraint "FKd2kq8x0henvaq6hgpx5cvgale" foreign key ("updated_by") references "user";
alter table if exists "permission" add constraint "FKdc86i98xy4kg74hggiqjgcw3b" foreign key ("parent_id") references "permission";
alter table if exists "role" add constraint "FKmll0g5nue2hsfl32cint6s6po" foreign key ("created_by") references "user";
alter table if exists "role" add constraint "FKq40ld1yi1bubk4n78oim6b1h8" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FK89slnmc3frmmi6jvisg5u3ip1" foreign key ("created_by") references "user";
alter table if exists "tenant" add constraint "FK2134w2t5967pgvwxqqapaauag" foreign key ("updated_by") references "user";
alter table if exists "tenant" add constraint "FKbvdfikwftielsfwtn2x1dxwge" foreign key ("user_id") references "user";
alter table if exists "user" add constraint "FKtgx1nsmw2irw5u69hibdx5t8b" foreign key ("created_by") references "user";
alter table if exists "user" add constraint "FKap4v54a63igjjm8tegdgji11m" foreign key ("updated_by") references "user";
alter table if exists "user" add constraint "FKep88i5ne2u4xpcigqednj1tuo" foreign key ("org_id") references "org";
alter table if exists "role_permission" add constraint "FK28fyyigl7pt1rfdf7o736vxe" foreign key ("permission_id") references "permission";
alter table if exists "role_permission" add constraint "FKp9q4vdsx41116ra1enydewgre" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKka3w3atry4amefp94rblb52n7" foreign key ("role_id") references "role";
alter table if exists "user_role" add constraint "FKhjx9nk20h4mo745tdqj8t8n9d" foreign key ("user_id") references "user";
INSERT INTO public."user" (id, created_at, updated_at, version, email, enabled, gender, mobile, password_hash, real_name, username, created_by, updated_by, org_id) VALUES (0, '2022-10-04 13:43:09.000000', null, null, 'root@famphony.com', true, 'MALE', '18853996892', '{noop}123456', 'SuperRoot', 'root', 0, null, null);
INSERT INTO public."user" (id, created_at, updated_at, version, email, enabled, gender, mobile, password_hash, real_name, username, created_by, updated_by, org_id) VALUES (1, '2022-10-04 13:43:13.000000', null, null, 'chenqingze107@gmail.com', true, 'MALE', '18853996882', '{noop}123456', 'ChenQingze', 'chenqingze', 0, null, null);