static int k = 0;
char* const buf = 0xb8000;

void sleep()
{
    for (int i = 0; i < 16; i++)
        for (int k = 0; k < 1024; k++)
            ;
}

int main32()
{
    buf[0] = 'Z';
    buf[1] = 0xF0;

    int c = 80 * 25;
    int digit = 0;
    int ascii = 0;

    char* ptr = buf;

    while (c-- > 0) {
        *ptr = (digit++) % 10 + '0';
        ptr += 1;
        *ptr = 0xF0;
        ptr += 1;
        // sleep();
    }
    return 0;
}