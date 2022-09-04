/**
 * 领域事件，用于解耦不同领域聚合上下文.也是微服务跨服务分布式事务最终一致性解决方案.
 *
 * <p>领域对象对相关逻辑进行处理后，发布领域事件，其他领域如果需要对相关的逻辑进行处理则在应用层的eventHandler进行订阅消费。
 *
 * @author ChenQingze
 */
package com.famphony.single.system.iam.domain.event;
