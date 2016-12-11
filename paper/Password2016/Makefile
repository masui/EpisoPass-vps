all: cameraready.tex
	pdflatex cameraready
	bibtex cameraready
	pdflatex cameraready
	pdflatex cameraready
	open cameraready.pdf

submission: paper.tex
	pdflatex paper
	bibtex paper
	pdflatex paper
	pdflatex paper
	open paper.pdf

david: david.tex
	pdflatex david
	bibtex david
	pdflatex david
	pdflatex david
	open david.pdf

zip:
	zip paper29source \
		cameraready.tex \
		cameraready.bib \
		figures/01e5507d090eb494a20bcbc47c86b1d2.png \
		figures/0e2820c279afc70520482e0fc53b6ed9.png \
		figures/2c3b4ce5a6f60dd19004fda35e40cef0.png \
		figures/345031fec4354879e3071acdd2ef8040.png \
		figures/429eec261024dc6c85351f51c12f09b4.png \
		figures/43272f2003ed8c78307110c621eb12e5.png \
		figures/4d13e6804ba790624c1f8e2b8255bde5.png \
		figures/8447eaba1ede0f678b3ce6fea63681f3.png \
		figures/ab4517dd593c1cabab5fecef546f7e88.png \
		figures/aeff16ffcab956e554364e9e5aca8359.png \
		figures/ba8f5aeaa935ad63437969f4d746746b.png \
		figures/c1bd6e7f67698c70978f528ccd2339d9.png \
		llncs.cls \
		splncs03.bst \
		cameraready.pdf \
		copyright_masui.pdf
