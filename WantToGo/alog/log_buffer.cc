// Tencent is pleased to support the open source community by making Mars available.
// Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.

// Licensed under the MIT License (the "License"); you may not use this file except in 
// compliance with the License. You may obtain a copy of the License at
// http://opensource.org/licenses/MIT

// Unless required by applicable law or agreed to in writing, software distributed under the License is
// distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied. See the License for the specific language governing permissions and
// limitations under the License.

/*
 * log_buffer.cpp
 *
 *  Created on: 2015-7-28
 *      Author: yanguoyue
 */

#include "log_buffer.h"

#include <cstdio>
#include <time.h>
#include <algorithm>
#include <sys/time.h>
#include <string.h>
#include <errno.h>
#include <assert.h>


LogBuffer::LogBuffer(void* _pbuffer, size_t _len) {
    buff_.Attach(_pbuffer, _len);
}

LogBuffer::~LogBuffer() {
}

PtrBuffer& LogBuffer::GetData() {
    return buff_;
}


void LogBuffer::Flush(AutoBuffer& _buff) {
    _buff.Write(buff_.Ptr(), buff_.Length());
    __Clear();
}

bool LogBuffer::Write(const void* _data, size_t _length) {
    if (NULL == _data || 0 == _length) {
        return false;
    }

    buff_.Write(_data, _length);

    return true;
}

void LogBuffer::__Clear() {
    memset(buff_.Ptr(), 0, buff_.MaxLength());
    buff_.Length(0, 0);
}

