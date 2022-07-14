#include "utils.h"

const int bufsize = 4096;

int main(int argc, char** argv)
{
    xassert(argc >= 3, "too few arguments");

    char* in = argv[1];
    char* out = argv[2];

    int fd_in = open(in, O_RDONLY);
    xassert(fd_in >= 0, "open %s fail", in);

    int fd_out = open(out, O_RDWR);
    xassert(fd_out >= 0, "open %s fail", out);

    char* buf = malloc(bufsize);
    xassert(buf != 0, "out of memory");

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