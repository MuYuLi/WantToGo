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
 * log_buffer.h
 *
 *  Created on: 2015-7-28
 *      Author: yanguoyue
 */

#ifndef LOGBUFFER_H_
#define LOGBUFFER_H_

#include <zlib.h>
#include <string>
#include <stdint.h>

#include "ptrbuffer.h"
#include "autobuffer.h"

class LogBuffer {
public:
    LogBuffer(void* _pbuffer, size_t _len);
    ~LogBuffer();

public:
    PtrBuffer& GetData();
    void Flush(AutoBuffer& _buff);
    bool Write(const void* _data, size_t _length);

private:

    void __Clear();

private:
    PtrBuffer buff_;

};


#endif /* LOGBUFFER_H_ */
