#ifndef NAO_TOOLS_UTILS_H
#define NAO_TOOLS_UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#define die(...)                                                               \
    do {                                                                       \
        fprintf(stderr, __VA_ARGS__);                                          \
        fprintf(stderr, "\n");                                                 \
        exit(1);                                                               \
    } while (0);

#define diep(msg)                                                              \
    do {                                                                       \
        perror(msg);                                                           \
        exit(1);                                                               \
    } while (0);

#define xassert(cond, ...)                                                     \
    if (!(cond))                                                               \
        die(__VA_ARGS__);

#endif