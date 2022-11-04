/**
 * Identity and Access Management (IAM) Solutions.
 *
 * <p>身份验证与访问控制,主要包含5个部分：
 *
 * <ul>
 *   <li>账号（Account）
 *   <li>认证（Authentication）
 *   <li>权限[授权/鉴权]（Authorization）
 *   <li>应用（Application）
 *   <li>审计（Audit）
 * </ul>
 *
 * <p>从使用场景上划分，IAM主要有有三大类.
 *
 * <ol>
 *   <li>EIAM EIAM是 Employee Identity and Access Management
 *       的缩写，指管理企业内部员工的IAM，主要解决员工使用的便捷性和企业管理的安全性相关问题。 在产品形态上，EIAM有以下特点：
 *       <ul>
 *         <li>强调授权的灵活性和企业管理的安全性
 *         <li>需要集成不同的身份源
 *         <li>SSO和MFA很常用
 *         <li>不同企业所需的访问控制力度不同
 *       </ul>
 *   <li>CIAM CIAM是 Customer Identity and Access Management
 *       的缩写，指管理企业外部客户/用户的IAM，主要解决用户数据的打通和开发成本与标准化相关问题。在产品形态上，CIAM有以下特点：
 *       <ul>
 *         <li>在用户端常见到的是单点登录和授权登录
 *         <li>提供通用的组件给开发者直接使用
 *         <li>更强调高性能和高可用
 *       </ul>
 *   <li>云厂商IAM/RAM 云厂商的IAM，有时称为RAM（Resource and Access
 *       Management），指管理企业云资源的IAM，主要用于管理云资源的访问控制。在产品形态上，云厂商IAM有以下特点：
 *       <ul>
 *         <li>强调授权的灵活性和企业管理的安全性
 *         <li>支持多种类型的账号进行认证或被调用
 *         <li>一般只关注管理自家的云资源
 *       </ul>
 * </ol>
 *
 * @author ChenQingze
 */
package com.famphony.single.iam;
