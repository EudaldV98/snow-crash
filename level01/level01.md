# Level01

Login as `level00`

```
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level00
level00@192.168.1.64's password: x24ti5gi3x0ol2eh4esiuxias
```

There is no file or binary to play with, and unlike `level00` there is no file owned by *flag01*.

```
level01@SnowCrash:~$ ls -l
total 0
```

By looking at `/etc/passwd` we notice and encrypted password -> *42hDRfypTqqnw*.

```
level01@SnowCrash:~$ cat /etc/passwd
...
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
...
```

Copy the file into local machine or **Kali VM** for this kind of purposes 😎

Use [John](https://github.com/openwall/john) to crack the password:

```
root@mypc:~$ john --show <file>
?:abcdefg

1 password hash cracked, 0 left
```

or

```
root@mypc:~$ john --show <(echo 42hDRfypTqqnw)
?:abcdefg

1 password hash cracked, 0 left
```

If first run of john, the cracked password can be found in `.john/john.pot`:

```
root@mypc:~$ cat .john/john.pot
42hDRfypTqqnw:abcdefg
```

Login as `flag01` and get the flag.

```
level01@SnowCrash:~$ su flag01
Password: abcdefg
Don't forget to launch getflag !
flag01@SnowCrash:~$ getflag
Check flag.Here is your token : f2av5il02puano7naaf6adaaf
```
