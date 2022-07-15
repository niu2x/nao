#include "utils.h"

const int bufsize = 4096;

int main(int argc, char** argv)
{
    int c;
    int index;
    int seek = 0;

    while ((c = getopt(argc, argv, "hs:")) != -1) {
        switch (c) {
            case 'h':
                break;
            case 's':
                seek = atoi(optarg);
                break;
            default:
                die("unsupport argument");
        }
    }

    xassert(argc - optind >= 2, "too few arguments");

    char* in = argv[optind];
    char* out = argv[optind + 1];

    int fd_in = open(in, O_RDONLY);
    xassert(fd_in >= 0, "open %s fail", in);

    int fd_out = open(out, O_RDWR);
    xassert(fd_out >= 0, "open %s fail", out);

    char* buf = malloc(bufsize);
    xassert(buf != 0, "out of memory");

    if (seek) {
        if (lseek(fd_out, seek, SEEK_SET) < 0)
            diep("fd_out seek");
    }

    do {
        int n = read(fd_in, buf, bufsize);
        if (n == 0) {
            break;
        } else if (n < 0) {
            diep("read file fail");
        } else {
            if (n != write(fd_out, buf, n)) {
                diep("write file fail");
            }
        }
    } while (1);

    free(buf);
    close(fd_in);
    close(fd_out);

    return 0;
}