all:
	platex -kanji=utf8 paper
	pbibtex -kanji=utf8 paper
	platex -kanji=utf8 paper
	platex -kanji=utf8 paper
	dvipdfmx paper
	open paper.pdf

#	~/bin/makebib paper > paper.bib
