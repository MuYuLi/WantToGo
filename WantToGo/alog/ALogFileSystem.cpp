//
// Created by liudelong01 on 2019/1/17.
//

#include "ALogFileSystem.h"
//#include "boost/filesystem.hpp"
//
//
//void __del_files(const std::string& _forder_path) {
//
//    boost::filesystem::path path(_forder_path);
//    if (!boost::filesystem::is_directory(path)) {
//        return;
//    }
//
//    boost::filesystem::directory_iterator end_iter;
//    for (boost::filesystem::directory_iterator iter(path); iter != end_iter; ++iter) {
//        if (boost::filesystem::is_regular_file(iter->status()))
//        {
//            boost::filesystem::remove(iter->path());
//        }
//    }
//}
//
//void __del_timeout_file(const std::string& _log_path) {
//    time_t now_time = time(NULL);
//
//    boost::filesystem::path path(_log_path);
//
//    if (boost::filesystem::exists(path) && boost::filesystem::is_directory(path)){
//        boost::filesystem::directory_iterator end_iter;
//        for (boost::filesystem::directory_iterator iter(path); iter != end_iter; ++iter) {
//            time_t fileModifyTime = boost::filesystem::last_write_time(iter->path());
//
//            if (now_time > fileModifyTime && now_time - fileModifyTime > kMaxLogAliveTime) {
//                if (boost::filesystem::is_regular_file(iter->status())) {
//                    boost::filesystem::remove(iter->path());
//                }
//                else if (boost::filesystem::is_directory(iter->status())) {
//                    __del_files(iter->path().string());
//                }
//            }
//        }
//    }
//}
