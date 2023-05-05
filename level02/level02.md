# Level 02

Login as `level02`

```bash
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level02
level02@192.168.1.64's password: f2av5il02puano7naaf6adaaf
```

A `.pcap` file is located in home directory. Pcap files are data files containing the **packet data of a network**.

```bash
level02@SnowCrash:~$ ls -l
total 12
----r--r-- 1 flag02  level02 8302 Aug 30  2015 level02.pcap
```

Copy `level02.pcap` from the VM to the your local machine. It's not readable, so change the permissions with `chmod +r`

We open the file with **Wireshark** and follow the TCP Stream from the `43 packet`.  

It seems `ft_wandr...NDRel.L0L`. But we can't use it to login to `flag02`.  

If we switch the data to display as `Hex Dump`, we get this:

```
Packet	  Hexadecimal					     ASCII
000000D6  00 0d 0a 50 61 73 73 77  6f 72 64 3a 20            ...Passw ord: 
000000B9  66                                                 f
000000BA  74                                                 t
000000BB  5f                                                 _
000000BC  77                                                 w
000000BD  61                                                 a
000000BE  6e                                                 n
000000BF  64                                                 d
000000C0  72                                                 r
000000C1  7f                                                 .
000000C2  7f                                                 .
000000C3  7f                                                 .
000000C4  4e                                                 N
000000C5  44                                                 D
000000C6  52                                                 R
000000C7  65                                                 e
000000C8  6c                                                 l
000000C9  7f                                                 .
000000CA  4c                                                 L
000000CB  30                                                 0
000000CC  4c                                                 L
000000CD  0d                                                 .
```

Non-printable characters are represented with dots.  

So, as we have the decimal representation of the character, `7f -> DEL`  
In the end we get: `ft_wandr...NDRel.L0L  --->   ft_waNDReL0L`  

Login as `flag02` and get the flag

```bash
level02@SnowCrash:~$ su flag02
Password: ft_waNDReL0L
Don't forget to launch getflag !
flag02@SnowCrash:~$ getflag
Check flag.Here is your token : kooda2puivaav1idi4f57q8iq
```
