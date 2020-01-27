PDFs=$(sort $(patsubst %.txt,%.pdf,$(wildcard messages/message_*.txt)))

all: postit postits21_trame.pdf postits21.pdf

postit: download_messages

postits21_trame.pdf: postits_trame.pdf
	pdfjam postits_trame.pdf --nup 3x7 --outfile postits21_trame.pdf

postits21.pdf: postits.pdf
	pdfjam postits.pdf --nup 3x7 --outfile postits21.pdf

postits_trame.pdf: postits_trame.md
	pandoc  -V fontsize=9pt --from latex --pdf-engine xelatex -V geometry:"left=7mm,right=6mm,top=3mm,bottom=2mm,paperwidth=60mm,paperheight=39mm" -o postits_trame.pdf postits_trame.md

postits.pdf: $(PDFs)
	pdftk $(PDFs) cat output postits.pdf

message_%.pdf: message_%.latex
	cp $< amessage.latex
	pdflatex amessage.latex
	pdftk amessage.pdf cat 1 output $@
	rm amessage.*

message_%.latex: message_%.sed  message.template
	cp message.template $@
	sed -i -f $< $@

message_%.sed: message_%.txt
	echo -n "s/MESSAGE/" > $@
	cat $< | tr '\n' ' '   >> $@
	echo "/" >> $@

download_messages:
	mkdir -p messages
	bash bin/generate_messages.sh
	make postits21.pdf

clean:
	rm -f messages/* *pdf
