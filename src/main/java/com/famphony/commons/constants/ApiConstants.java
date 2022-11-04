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

package com.famphony.commons.constants;

/**
 * @author ChenQingze
 */
public interface ApiConstants {

    String REGEX_FOR_NUMBERS = "^\\d+$";
    String MESSAGE_FOR_REGEX_NUMBER_MISMATCH = "ID should contains integers only";
    String MESSAGE_FOR_INVALID_PARAMETERS_ERROR = "Invalid Parameters";
    String MESSAGE_FOR_INVALID_BODY_ERROR = "Invalid Method Body. Check JSON Objects";
    String DATE_FORMAT = "dd-MM-yyyy hh:mm:ss";
}
