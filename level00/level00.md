# Level00

Login as `level00`

```
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level00
level00@192.168.1.64's password: level00
```

No file or binary to play with

```
level00@SnowCrash:~$ ls -l
total 0
```

Wil gives a clue in intra video:

>**FIND** this first file who can run only as *flag00*

So, we do so:

```
level00@SnowCrash:~$ find / -user flag00 -exec ls -l {} \; 2>/dev/null
----r--r-- 1 flag00 flag00 15 Mar  5  2016 /usr/sbin/john
----r--r-- 1 flag00 flag00 15 Mar  5  2016 /rofs/usr/sbin/john
level00@SnowCrash:~$ cat /usr/sbin/john
cdiiddwpgswtgt
```

The string we got: *cdiiddwpgswtgt* is encrypted.  
We use [rot13.com](https://rot13.com/) to decode it.  
The result we got with ROT11 makes sense, which is: *nottoohardhere*.

In addition, to find out which was the shift made, you can use [dcode.fr](https://www.dcode.fr/rot-cipher).

Finally, login as `flag00` and get the flag

```
level00@SnowCrash:~$ su flag00
Password: nottoohardhere
Don't forget to launch getflag !
flag00@SnowCrash:~$ getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
```
