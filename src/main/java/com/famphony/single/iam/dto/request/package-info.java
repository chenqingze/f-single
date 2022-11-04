/**
 *
 *
 * <ol>
 *   <li>可以使用request dto 先在api层转换为command，然后将command
 *       传入并调用service层,复杂的业务场景或者前后端非同步更新的场景，及公开的api建议讲command和dto分开，因为这有利于向后兼容
 *   <li>也可以直接使用request dto作为作为command直接传入调用service，如果客户端和服务端api可以同时更新部署的场景下可以使用此方案
 * </ol>
 *
 * @author ChenQingze
 */
package com.famphony.single.iam.dto.request;
