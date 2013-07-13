all:
	platex -kanji=utf8 paper
	pbibtex paper
	platex paper
	platex paper
	dvipdfmx paper
	open paper.pdf

#	~/bin/makebib paper > paper.bib
