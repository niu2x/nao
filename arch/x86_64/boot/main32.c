static int k = 0;
char* const buf = 0xb8000;

int main32()
{

    buf[0] = 65;
    buf[1] = 0xF0;

    return 0;
}