/**
 * 即是响应对象，ViewModel或者response DTO，也可以直接作为查询投影.
 *
 * <ol>
 *   <li>可以直接使用entity 作为projection进行数据库查询，然后在service层将查询结果entity与response dto进行转换,并返回
 *   <li>也可以直接使用request dto作为作为projection直接进行数据库查询,并直接返回request dto作为结果集（无论是否使用了CQRS
 *       pattern，都推荐这种做法，可以提高查询效率）
 * </ol>
 *
 * @author ChenQingze
 */
package com.famphony.single.system.iam.application.dto.response;
