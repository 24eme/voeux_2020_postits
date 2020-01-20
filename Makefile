all: postits21_trame.pdf postits21.pdf

postits21_trame.pdf: postits_trame.pdf
	pdfjam postits_trame.pdf --nup 3x7 --outfile postits21_trame.pdf

postits21.pdf: postits.pdf
	pdfjam postits.pdf --nup 3x7 --outfile postits21.pdf

postits_trame.pdf: postits_trame.md Makefile
	pandoc  -V fontsize=9pt --from latex --pdf-engine xelatex -V geometry:"left=7mm,right=6mm,top=3mm,bottom=2mm,paperwidth=60mm,paperheight=39mm" -o postits_trame.pdf postits_trame.md

postits.pdf: postits.md Makefile
	pandoc  -V fontsize=9pt --from latex --pdf-engine xelatex -V geometry:"left=8mm,right=7mm,top=3mm,bottom=2mm,paperwidth=60mm,paperheight=39mm" -o postits.pdf postits.md

