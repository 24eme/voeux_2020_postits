#!/bin/bash

. bin/config.inc

touch messages/messages.txt
if test "$MESSAGES_URL" ; then
	wget -q -O messages/messages.txt.tmp "$MESSAGES_URL"
	if test $(md5sum  messages/messages.txt.tmp | sed 's/ .*//') = $(md5sum  messages/messages.txt | sed 's/ .*//') ; then
		rm messages/messages.txt.tmp
		exit 0;
	fi
	mv messages/messages.txt.tmp messages/messages.txt
fi


cat messages/messages.txt | grep -v '#' | while IFS= read -r line; do
	((++i))
	amessage="messages/message_"$(printf %04d $i)".txt"
	echo "$line" > $amessage".tmp"
	if ! test $(md5sum $amessage".tmp" | sed 's/ .*//') = $(cat $amessage | md5sum | sed 's/ .*//' ) ; then
		mv $amessage".tmp" $amessage
	else
		rm $amessage".tmp"
	fi
done
