/**
 * read 操作时直接用responseDto做为数据库投影进行查询.
 *
 * <ol>
 *   <li>可以使用request dto 在api层与command进行转换，然后调用service层
 *   <li>也可以直接使用request dto作为作为command直接调用service
 * </ol>
 *
 * @author ChenQingze
 */
package com.famphony.single.system.iam.dto;
