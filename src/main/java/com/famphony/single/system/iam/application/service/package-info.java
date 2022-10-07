/**
 * 本项目未使用CQRS pattern. 直接使用application service.
 *
 * <p>如需要使用请关注{@link com.famphony.single.system.iam.application.cqrs}包,并忽略{@link
 * com.famphony.single.system.iam.application.service}包.
 *
 * <p>应用程序服务层会调用基础设施服务、域服务和域实体来完成工作.
 * 应用服务对象是“命令”对象。也就是说，就命令/查询分离而言:对于命令我们需要调用领域服务；对于查询我们直接调用repository即可.
 *
 * @author ChenQingze
 */
package com.famphony.single.system.iam.application.service;
