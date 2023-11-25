# Level11

Login as `level11`

```bash
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level11
level11@192.168.1.64's password: feulo4b72j7edeahuete3no7c
```

We have a `SUID Lua binary` in our home directory:

```bash
level11@SnowCrash:~$ ls -l
total 4
-rwsr-sr-x 1 flag11 level11 668 Mar  5  2016 level11.lua
```

We run the script and we notice that something is running on `localhost:5151`:

```bash
level11@SnowCrash:~$ ./level11.lua
lua: ./level11.lua:3: address already in use
stack traceback:
	[C]: in function 'assert'
	./level11.lua:3: in main chunk
	[C]: ?c
```

The `-z` flag of nc allows us to scan for listening daemons `without sending any data`:

```bash
-z      Specifies that nc should just scan for listening daemons, without
        sending any data to them.  It is an error to use this option in
        conjunction with the -l option.
```

This combined with the `-v` flag allows us to scan in verbosee mode.

```bash
level11@SnowCrash:~$ nc -zv localhost 5151
Connection to localhost 5151 port [tcp/pcrd] succeeded!
```

The `hash()` function gets the input that is received from the client. Then it calls `popen` (process open) inserting user input as echo's argument.

```bash
prog = io.popen(echo "..pass.." | sha1sum", "r")
```