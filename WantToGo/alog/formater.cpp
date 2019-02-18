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
 * log_formater.cpp
 *
 *  Created on: 2013-3-8
 *      Author: yerungui
 */


#include <assert.h>
#include <stdio.h>
#include <limits.h>
#include <algorithm>

#include "ptrbuffer.h"
#include "ALogBase.h"

#include <inttypes.h>
//#include <android/log.h>

const char* ExtractFileName(const char* _path);

void log_formater(ALogInfo* _info, PtrBuffer& _log) {
    static const char* levelStrings[] = {
        "V",
        "D",  // debug
        "I",  // info
        "W",  // warn
        "E",  // error
        "F"   // fatal
    };

    if (NULL != _info) {
        //const char* filename = ExtractFileName(_info->filename);

        char temp_time[128] = {0};

        if (0 != _info->timeval.tv_sec) {
            time_t sec = _info->timeval.tv_sec;
            tm tm = *localtime((const time_t*)&sec);
            snprintf(temp_time, sizeof(temp_time), "%02d-%02d %02d:%02d:%02d.%.3ld", 1 + tm.tm_mon, tm.tm_mday,
                     tm.tm_hour, tm.tm_min, tm.tm_sec, _info->timeval.tv_usec / 1000);

            char temp_filename[64] = {0};
            snprintf(temp_filename, sizeof(temp_filename), "%s-%d-%02d-%02d", _info->process, 1900 + tm.tm_year,
                    1 + tm.tm_mon, tm.tm_mday);
            strncpy(_info->filename, temp_filename, sizeof(_info->filename));
        }

        // _log.AllocWrite(30*1024, false);
        int ret = snprintf((char*)_log.PosPtr(), 1024, "%s %d-%ld %s/%s: ", temp_time, _info->pid, _info->tid, levelStrings[_info->level], _info->tag);
        _log.Length(_log.Pos() + ret, _log.Length() + ret);
        //      memcpy((char*)_log.PosPtr() + 1, "\0", 1);
    }

    if (NULL != _info->msg) {
        // in android 64bit, in strnlen memchr,  const unsigned char*  end = p + n;  > 4G!!!!! in stack array

        size_t bodylen =  _log.MaxLength() - _log.Length() > 130 ? _log.MaxLength() - _log.Length() - 130 : 0;
        bodylen = bodylen > 0xFFFFU ? 0xFFFFU : bodylen;
        bodylen = strnlen(_info->msg, bodylen);
        bodylen = bodylen > 0xFFFFU ? 0xFFFFU : bodylen;
        _log.Write(_info->msg, bodylen);
    } else {
        _log.Write("error!! NULL==_logbody");
    }

    char nextline = '\n';

    if (*((char*)_log.PosPtr() - 1) != nextline) _log.Write(&nextline, 1);
}

const char* ExtractFileName(const char* _path) {
    if (NULL == _path) return "";

    const char* pos = strrchr(_path, '\\');

    if (NULL == pos) {
        pos = strrchr(_path, '/');
    }

    if (NULL == pos || '\0' == *(pos + 1)) {
        return _path;
    } else {
        return pos + 1;
    }
}

