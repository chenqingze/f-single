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

package com.famphony.single;

import com.famphony.single.iam.entity.QUser;
import com.querydsl.core.Tuple;
import com.querydsl.jpa.impl.JPAQueryFactory;
import java.util.List;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class FSingleApplicationTests {

    @Autowired JPAQueryFactory query;

    @Test
    void contextLoads() {
        System.out.println("=================>" + "contextLoads");
    }

    @Test
    void executeFindMethod() {
        System.out.println("=================>" + "executeFindMethod");

        QUser user = QUser.user;
        List<Tuple> result =
                query.select(user.id, user.username, user.realName, user.email).from(user).fetch();
        System.out.println("=================>" + result);
        for (Tuple row : result) {
            System.out.println("realName " + row.get(user.realName));
            System.out.println("email " + row.get(user.email));
            System.out.println("mobile " + row.get(user.mobile));
        }
    }
}
