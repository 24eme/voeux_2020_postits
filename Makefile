all: postits21.pdf

postits21.pdf: postit.pdf
	pdfjam postit.pdf --nup 3x7 --outfile postit21.pdf

postit.pdf: postit.md Makefile
	pandoc  -V fontsize=9pt --from latex --pdf-engine xelatex -V geometry:"left=7mm,right=6mm,top=3mm,bottom=2mm,paperwidth=60mm,paperheight=39mm" -o postit.pdf postit.md
