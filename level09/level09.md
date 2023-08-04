# Level09

Login as `level09`

```bash
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level09
level09@192.168.1.64's password: 25749xKZ8L7DkSCwJkT9dyv6f
```

As in the previous level, we have a `SUID binary` and a `token` file.

```bash
level09@SnowCrash:~$ ls -l
total 12
-rwsr-sr-x 1 flag09 level09 7640 Mar  5  2016 level09
----r--r-- 1 flag09 level09   26 Mar  5  2016 token
```

This time we can read the token file:

And it seems that the token file contains `non ASCII` characters too.

```bash
level09@SnowCrash:~$ ./level09
You need to provied only one arg.
level09@SnowCrash:~$ ./level09 token
tpmhr
level09@SnowCrash:~$ cat token
f4kmm6p|=��p�n��DB�Du{���
```

After multiple test we can notice that the executable is addingt the previous index to the actual current charcter:

```bash
level09@SnowCrash:~$ ./level09 "a"
a
level09@SnowCrash:~$ ./level09 "aa"
ab
level09@SnowCrash:~$ ./level09 "aaa"
abc
level09@SnowCrash:~$ ./level09 "0123456789"
02468:<>@B
level09@SnowCrash:~$ ./level09 "abcdefghij"
acegikmoqs
```

It is an encrypting algorithm.

Using `ltrace` to intercept dynamic library calls and system calls executed gives this:

```bash
level09@SnowCrash:~$ ltrace ./level09 "abcdefghij"
__libc_start_main(0x80487ce, 2, 0xbffff7d4, 0x8048aa0, 0x8048b10 <unfinished ...>
ptrace(0, 0, 1, 0, 0xb7e2fe38) = -1
puts("You should not reverse this"You should not reverse this) = 28
+++ exited (status 1) +++
```

After noticing those 2 things (what the binary does + "*You should not reverse this*" using ltrace) we can deduce that we can reverse the output.

For this purpose we can write a `python script` for example, which will substract the index position from each character

```bash
level09@SnowCrash:~$ vim /tmp/reverse.py
#!/usr/bin/python
import sys
i = -1
content = open("/home/user/level09/token").readlines()[0]
for c in content:
   i += 1
     try:
        sys.stdout.write(chr(ord(c) - i))
     except:
        pass
print "\n",
```

So we run it and we get:

```bash
level09@SnowCrash:~$ python /tmp/reverse.py
f3iji1ju5yuevaus41q1afiuq
```

Finally log as `flag09` and get the flag:

```bash
level09@SnowCrash:~$ su flag09
Password: f3iji1ju5yuevaus41q1afiuq
Don't forget to launch getflag !
flag09@SnowCrash:~$ getflag
Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
```