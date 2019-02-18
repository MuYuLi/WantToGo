//
// Created by liudelong01 on 2019/1/16.
//

#include <sys/mman.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>

#include <string>
//#include <android/log.h>

#include "ALogBase.h"
#include "ptrbuffer.h"
#include "log_buffer.h"


extern void log_formater(ALogInfo* _info, PtrBuffer& _log);

static const long kMaxLogAliveTime = 10 * 24 * 60 * 60;	// 10 days in second
static const unsigned int kBufferBlockLength = 400 * 1024;


static std::string sg_logdir;
static std::string sg_filename;


static int sg_fd;
static LogBuffer* sg_log_buff = NULL;


void setLogDir(const char* logDir) {
//    __android_log_write(ANDROID_LOG_DEBUG, "ALog", logDir);
    sg_logdir = logDir;
	//boost::filesystem::create_directories(logDir);
}

void aLog_write(ALogInfo* info) {
    if (info == NULL) {
        return;
    }

    char temp[16 * 1024] = {0};
    PtrBuffer log(temp, 0, sizeof(temp));
    log_formater(info, log);

    std::string fname = sg_logdir + info->filename + ".mmap";
//    __android_log_write(ANDROID_LOG_DEBUG, "ALog", fname.c_str());
    if (sg_filename.empty()) {
//        __android_log_write(ANDROID_LOG_DEBUG, "ALog", "NULL");
        sg_filename = fname;
        sg_fd = open(fname.c_str(), O_RDWR|O_CREAT, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
        if (sg_fd < 0) {
//            __android_log_write(ANDROID_LOG_DEBUG, "ALog", "error open");
            return;
        }
        char *s = "This is a TEST!!!";
        if (write(sg_fd, s, strlen(s)) < 0) {
//            __android_log_write(ANDROID_LOG_DEBUG, "ALog", "error write");
        }
        //close(sg_fd);

        struct stat finfo;
        stat(fname.c_str(), &finfo);
        int size = finfo.st_size;
        char test[24];
        snprintf(test, sizeof(test), "file size %d", size);
//        __android_log_write(ANDROID_LOG_DEBUG, "ALog", test);

        // 扩充文件大小 [http://www.cnblogs.com/huxiao-tee/p/4660352.html]
        ftruncate(sg_fd, kBufferBlockLength);
        lseek(sg_fd, 0, SEEK_SET);

        void* mptr = mmap(0, kBufferBlockLength, PROT_WRITE | PROT_READ, MAP_SHARED, sg_fd, 0);
        if (mptr == MAP_FAILED) {
//            __android_log_write(ANDROID_LOG_DEBUG, "ALog", "error mmap");
            return;
        } else {
//            __android_log_print(ANDROID_LOG_DEBUG, "ALog", "mmap -- %p", mptr);
        }

        sg_log_buff = new LogBuffer(mptr, kBufferBlockLength);
        if (sg_log_buff == NULL) {
//            __android_log_write(ANDROID_LOG_DEBUG, "ALog", "error LogBuffer");
            return;
        }
        if (size <= 0) {
            return;
        } else {
        }

        AutoBuffer buffer;
        sg_log_buff->GetData().Length(0, size);
        sg_log_buff->Flush(buffer);
//        __android_log_write(ANDROID_LOG_DEBUG, "ALog", "NULL-4");
        if (buffer.Ptr()) {
//            __android_log_print(ANDROID_LOG_DEBUG, "ALog", "begin of mmap - %s", buffer.Ptr());
            //__log2file(buffer.Ptr(), buffer.Length());
//            __android_log_write(ANDROID_LOG_DEBUG, "ALog", "end of mmap");
        }

    } else if (!sg_filename.compare(info->filename)) {
//        __android_log_write(ANDROID_LOG_DEBUG, "ALog", "NOT EQUAL");

    } else {
//        __android_log_write(ANDROID_LOG_DEBUG, "ALog", "EQUAL");
        if (!sg_log_buff->Write(log.Ptr(), log.Length()))   return;
    }
}
