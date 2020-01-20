cat messages.txt | grep -v "#' | while IFS= read -r line; do
	((++i))
	echo "$line" > messages/message_$(printf %04d $i).txt
done
