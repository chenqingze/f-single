# f-single
- [ ] 多租户考虑：使用Flyway vs. Liquibase vs. Redgate Deploy
- [ ] 单表查询使用spring jpa 并dto投影进行查询，以便于提升效率。复杂查询使用querydsl。基本写操作用jpa就好。
- [ ] dto使用validator

## 多租户方案：
- 独立数据库
- 共享数据库独立schema
- 共享数据库共享schema
  - 通过字段鉴别器区分不同租户
  - 或者使用类似Postgres的行级别安全策略来实现。[具体参考文档](https://www.postgresql.org/docs/current/ddl-rowsecurity.html)

Multi-Factor Authentication (MFA).

# DDD总结

## 关于 DDD domain service vs application service

Unlike Application Services which get/return Data Transfer Objects, a Domain Service gets/returns
domain objects (like entities or value types).

A Domain Service can be used by Application Services and other Domain Services, but not directly by
the presentation layer (application services are for that).

## 关于 DDD CQRS pattern

### CQRS pattern 中command 与 query的区别

write（写）操作需要command 通过调用domain layer 操作.
read（查询）操作不需要调用domain layer。application layer 的 service 直接调用repository就好.

# hibernate 使用总结

### 关于jpa @Entity 注解的实体是否等同与domain model entity

1. 从概念上讲jpa中的实体并不代表领域中的实体。因为jpa中的entity是数据持久化关系的映射, 属于data model
   ,它不等同与领域模型中的entity（domain
   model)。
2. 从开发的角度讲如果讲逻辑放在领域对象本身上，则可以粗略的视为相等。
    * 一方面，许多人以人们常说的贫血模型的方式实现域对象：主要是使用 ORM
      映射的属性，但域对象本身没有真正的逻辑。他们将逻辑放在域服务中。
    * 另一方面，领域驱动设计的支持者将逻辑放在领域对象本身上。 无论哪种方式，这些都是您系统中的域对象。JPA
      实体是您使用@Entity、@Column、@ManyToOne 等注释的类。这是一种实现域对象的方法。如上所述，你可以决定将域逻辑放在对象本身上，还是领域服务上这都无关紧要。

### 关于业务对象的操作：

一定要用纯面向对象的思维去操作对象，不要用数据库操作的思维，除特殊情况尽量不要单独操作id的方式来操作对象

### 关于集合映射类型：

@ManyToMany associations 尽量使用Set，多对多关系映射 使用List效率很低
@OneToMany or @ManyToOne associations 如果需要排序使用List 不需要排序使用Set 或者List都可以
动态映射的是可以可以使用Map

### 关于性能：

1. 尽量使用延迟加载。
2. @ManyToMany 多对多关系中不要使用及联删除，CascadeTypes.REMOVE and CascadeTypes.ALL(includes
   REMOVE)
3. 查询时使用DTO（DTO projection）投影进行查询，效率高于实体投影（entity projection)，当然结果集也使用DTO映射,也可以使用动态投影。
   [参考](https://thorben-janssen.com/result-set-mapping-constructor-result-mappings/)
   [参考](https://thorben-janssen.com/spring-data-jpa-query-projections/)

### 关于逻辑删除和默认删除过滤：

可以使用：@SQLDelete 和@Where(clause = "deleted <> 'true'")
[参考](https://thorben-janssen.com/permanently-remove-when-using-soft-delete/)

### 关于bean验证：

新建和更新使用不同的验证规则，可使用
javax.persistence.validation.group.pre-persist
javax.persistence.validation.group.pre-update
javax.persistence.validation.group.pre-remove
[参考](https://thorben-janssen.com/hibernate-tips-how-to-perform-different-validations-for-persist-and-update/)

### 关于删除

尽量不要使用额外的删除字段处理相应的逻辑删除，即使使用额外的列处理逻辑删除，也要定期将已删除的记录移动到记录删除的表里
推荐直接使用额外的表来记录删除的记录