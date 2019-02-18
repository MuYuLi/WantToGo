//
// Created by liudelong01 on 2019/1/16.
//

#ifndef ALOG_ALOGBASE_H
#define ALOG_ALOGBASE_H

#include <sys/time.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    kLevelVerbose = 0,
    kLevelDebug,    // Detailed information on the flow through the system.
    kLevelInfo,     // Interesting runtime events (startup/shutdown), should be conservative and keep to a minimum.
    kLevelWarn,     // Other runtime situations that are undesirable or unexpected, but not necessarily "wrong".
    kLevelError,    // Other runtime errors or unexpected conditions.
    kLevelFatal,    // Severe errors that cause premature termination.
} TLogLevel;

typedef struct ALogInfo_t {
    TLogLevel level;
    const char* process;
    const char* tag;
    char filename[64];

    struct timeval timeval;
    int pid;
    long tid;
    const char* msg;
} ALogInfo;


void setLogDir(const char* logDir);
void aLog_write(ALogInfo* _info);

#ifdef __cplusplus
}
#endif

#endif //ALOG_ALOGBASE_H
