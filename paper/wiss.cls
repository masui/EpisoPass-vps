%%%%%% 
%%%%%    wiss.cls 
%%%               Sep 25,2002      Hisashi Aoki
%%
%       (converted from jst11-wiss.cls)
%       (converted from jst11-wiss.sty)


% article.sty 23 Sep 85
% jst.sty 24 Nov 87 by Hideki ISOZAKI isozaki@ntt-20.ntt.junet
% jst-macc.sty 31 Mar 92 by Hideyuki Nakashima nakashim@etl.go.jp
% MACC
% \renewcommand{\baselinestretch}{1.07} is added for MACC-92
%   by Makoto YOKOO yokoo@cslab.kecl.ntt.jp
% jst-wiss.sty 25 Dec 93 by Akikazu Takeuchi takeuchi@csl.sony.co.jp
% WISS
% jst-wiss.sty 19 Sep 97 by Toshio Hirotsu hirotsu@brl.ntt.co.jp
% \def\fnum@table{表 \thetable} is revised
% remove page number
% jst-wiss.sty 25 Sep 98 by Yasunori Harada hara@brl.ntt.co.jp
% jst-wiss.sty 22 Sep 99 by Toshihiro Takada takada@t.onlab.ntt.co.jp
%   do renewcommand{\bf} only if NTT JTeX
% jst-wiss.sty  4 Sep 00 by Toshihiro Takada takada@t.onlab.ntt.co.jp
%   WISS 2002
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{wiss}[2009/06/06 pLaTeX class for WISS]

% Default Size is 11pt
\def\@ptsize{1} \@namedef{ds@10pt}{\def\@ptsize{0}}
\@namedef{ds@12pt}{\def\@ptsize{2}} 
\def\ds@twoside{\@twosidetrue \@mparswitchtrue}
\def\ds@draft{\overfullrule5pt} 
\@options
\input wissbase1\@ptsize.cls\relax
\renewcommand{\baselinestretch}{1.07}

% \let\em=\it

\def\labelenumi{\arabic{enumi}.} 
\def\theenumi{\arabic{enumi}} 
\def\labelenumii{(\alph{enumii})}
\def\theenumii{\alph{enumii}}
\def\p@enumii{\theenumi}
\def\labelenumiii{\roman{enumiii}.}
\def\theenumiii{\roman{enumiii}}
\def\p@enumiii{\theenumi(\theenumii)}
\def\labelenumiv{\Alph{enumiv}.}
\def\theenumiv{\Alph{enumiv}} 
\def\p@enumiv{\p@enumiii\theenumiii}

\def\labelitemi{$\bullet$}
\def\labelitemii{\bfseries --}
\def\labelitemiii{$\ast$}
\def\labelitemiv{$\cdot$}

\def\verse{\let\\=\@centercr 
 \list{}{\itemsep\z@ \itemindent -1.5em\listparindent \itemindent 
 \rightmargin\leftmargin\advance\leftmargin 1.5em}\item[]}
\let\endverse\endlist
\def\quotation{\list{}{\listparindent 1.5em
 \itemindent\listparindent
 \rightmargin\leftmargin \parsep 0\p@ \@plus 1\p@}\item[]}
\let\endquotation=\endlist
\def\quote{\list{}{\rightmargin\leftmargin}\item[]}
\let\endquote=\endlist

\def\descriptionlabel#1{\hspace\labelsep \bfseries #1}
\def\description{\list{}{\labelwidth\z@ \itemindent-\leftmargin
 \let\makelabel\descriptionlabel}}
\let\enddescription\endlist

\def\theequation{\arabic{equation}}

\def\titlepage{
 \newpage \thispagestyle{empty}\c@page\z@}
\let\endtitlepage=\newpage

\arraycolsep 2\p@ \tabcolsep 6\p@ \arrayrulewidth .3\p@ \doublerulesep 2\p@ 
\tabbingsep \labelsep 

\skip\@mpfootins = \skip\footins
\fboxsep = 3\p@ \fboxrule = .4\p@ 

\def\@begintheorem#1#2{\sl \trivlist \item[\hskip
     \labelsep{\small{\bfseries #1\ #2}}]}
\def\@opargbegintheorem#1#2#3{\sl \trivlist
     \item[\hskip \labelsep{\small{\bfseries #1\ #2\ (#3)}}]}

\newcounter{part}
\newcounter{section}
\newcounter{subsection}[section]
\newcounter{subsubsection}[subsection]
\newcounter{paragraph}[subsubsection]
\newcounter{subparagraph}[paragraph]

\def\thepart{\Roman{part}}
\def\thesection{\arabic{section}}
\def\thesubsection{\thesection.\arabic{subsection}}
\def\thesubsubsection{\thesubsection.\arabic{subsubsection}}
\def\theparagraph{\thesubsubsection.\arabic{paragraph}}
\def\thesubparagraph{\theparagraph.\arabic{subparagraph}}

\def\@pnumwidth{1.55em}
\def\@tocrmarg {2.55em}
\def\@dotsep{4.5}
\setcounter{tocdepth}{3}

\def\acknowledgements#1{\vspace{5mm}\par
             \noindent{{\bfseries 謝辞 }}#1}
\def\endacknowledgements{\par}

\def\thebibliography#1{\section*{{\bfseries 参考文献}\markboth
 {REFERENCES}{REFERENCES}\vspace{2mm}}\list
 {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
 \advance\leftmargin\labelsep
 \usecounter{enumi}}
 \def\newblock{\hskip .11em \@plus .33em \@minus -.07em}
 \sloppy
 \sfcode`\.=1000\relax\small\baselineskip=1\p@ \itemsep=\z@}
\let\endthebibliography=\endlist

\def\received#1{{\noindent\small Received\ #1}}

\def\footnoterule{\kern-3\p@ 
 \hrule width .4\columnwidth 
 \kern 2.6\p@} 

\long\def\@makefntext#1{\@setpar{\@@par\@tempdima \hsize
   \advance\@tempdima-10\p@\parshape \@ne 10\p@ \@tempdima}\par
   \parindent 1em\noindent \hbox to \z@{\hss$^{\@thefnmark}$}
   \hspace*{0.3mm}#1}

\setcounter{topnumber}{2}
\def\topfraction{.7}
\setcounter{bottomnumber}{1}
\def\bottomfraction{.3}
\setcounter{totalnumber}{3}
\def\textfraction{.2}
\def\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.7}
\def\dblfloatpagefraction{.5}

\long\def\@makecaption#1#2{
 \vskip 10\p@ 
 \setbox\@tempboxa\hbox{\footnotesize\bfseries #1. \rmfamily #2}
 \ifdim \wd\@tempboxa >0.7\hsize \unhbox\@tempboxa
     \leftskip=0.1in \rightskip=0.1in \hangindent=0.3in
     \par
\else \hbox to\hsize{\hfil\box\@tempboxa\hfil} 
 \fi}

\newcounter{figure}
\def\thefigure{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{図 \thefigure}
\def\figure{\@float{figure}}
\let\endfigure\end@float
\@namedef{figure*}{\@dblfloat{figure}}
\@namedef{endfigure*}{\end@dblfloat}

\newcounter{table}
\def\thetable{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{表 \thetable}
\def\table{\@float{table}}
\let\endtable\end@float
\@namedef{table*}{\@dblfloat{table}}
\@namedef{endtable*}{\end@dblfloat}

% \and is used in \author. Copied from latex.tex.
% It is used when an article is written by some authors
% in different organizations.
\def\and{%%                             % \begin{tabular} 
\end{tabular}\hskip 1em \@plus .17fil\begin{tabular}[t]{l}%% \end{tabular}
} % Flushleft Organizations

\def\maketitle{
\par
 \begingroup
 \setcounter{footnote}{0} % Reset Thanks Counter
 \def\thefootnote{\fnsymbol{footnote}} % Use asterisks and daggers
 \def\@makefnmark{\hbox 
   to 0\p@{$^{\@thefnmark}$\hss}} 
 \newpage
 \global\@topnum\z@ \@maketitle \thispagestyle{empty}\@thanks
 \endgroup
 \setcounter{footnote}{0}
} % Reset Footnote Counter

%%%%%%%%%%%%%%%%%
\newbox\@abstractbox
\def\abstract{
 \global\let\@abstract\relax
 \global\setbox\@abstractbox\hbox\bgroup
 \begin{minipage}[b]{160mm} 
   \begin{small}
   \setlength\parindent{1.5em}
   \noindent{\bfseries Summary.\ }
}
\def\endabstract{\end{small}\end{minipage}\egroup}
\def\@abstract{abstract}
%%%%%%%%%%%%%%%%%

\def\copyrightnotice#1{%
  \let\savefootnotemark\footnotemark
  \let\footnotemark\relax
  \thanks{#1}
  \let\footnotemark\savefootnotemark}

\def\@maketitle{\newpage
\twocolumn[
%\leftline{\rule{\textwidth}{1mm}}
%\leftline{\rule{\textwidth}{0.5\p@}}

\setlength{\unitlength}{0.17mm}
\begin{picture}(1000,10)
\put(900,0){\line(-1,0){900}}
\put(900,2){\line(-1,0){900}}
\put(900,4){\line(-1,0){900}}
\put(900,6){\line(-1,0){900}}
\put(900,8){\line(-1,0){900}}
\put(900,0){\line(0,1){8}}
\put(898,0){\line(0,1){8}}
\put(896,0){\line(0,1){8}}
\put(894,0){\line(0,1){8}}
\put(892,0){\line(0,1){8}}
\put(920,0){\textsf{\tiny WISS2013}}
\end{picture}

\begin{flushleft}
 {\Large\bfseries\bfseries \@title%
%   \copyrightnotice{\copyright~2006~日本ソフトウェア科学会ISS研究会．} \par} \vskip 3\p@
%% begin of modify 2006/07/12 (akita)
   \copyrightnotice{Copyright is held by the author(s).} \par} \vskip 3\p@
%% end of modify
 {\small\bfseries \@etitle \par}
 \vskip 1.2em {\large \lineskip 3\p@ \@plus1\p@ \@minus1\p@
\begin{tabular}[t]{l}{\bfseries\bfseries \@author} % Flushleft Organizations
 \end{tabular}\par}
\end{flushleft}
\oldjtoc % Read old jjssst-toc.tex and write again
{\def\\{ }\let\thanks\@gobble\def\and{, }\jtoc{\@title}{\@author}}
%Add this article to jjssst-toc.tex
\par
%%% \vskip 2.5em
\vskip 1.5em \@plus \baselineskip
\centerline{\@abstract\box\@abstractbox}
\vskip 2.5em \@plus \baselineskip
]}

\def\affil{\thanks}

\mark{{}{}} 

% \journal{Vol}{No}{Year}
% \journalhead{Abbreviated Title}
\def\journal#1#2#3{\gdef\volume@j{#1}\gdef\number@j{#2}\gdef\year@j{#3}}
\journal{0}{0}{\the\year}
\def\journalhead#1{\gdef\title@j{#1}}
\journalhead{\@etitle}
\def\booktitle#1{\gdef\head@j{#1}}
\booktitle{WISS 2013}
\def\etitle#1{\gdef\@etitle{#1}}

\def\ps@headings{\def\@oddfoot{}\def\@evenfoot{}
%%% \def\@evenhead{\footnotesize\rmfamily%
%%% \thepage\hfil \head@j \hfil}
%%% \def\@oddhead{\hbox{}\hfil\footnotesize\rmfamily\title@j \hfil\rmfamily\thepage}
\def\@evenhead{\footnotesize\rmfamily \ \hfil \head@j \hfil}
\def\@oddhead{\hbox{}\hfil\footnotesize\rmfamily\title@j \hfil\rmfamily\ }
\def\sectionmark##1{\markboth {\uppercase{\ifnum \c@secnumdepth
>\z@
 \thesection\hskip 1em\relax \fi ##1}}{}}\def\subsectionmark##1{\markright
{\ifnum \c@secnumdepth >\@ne
 \thesubsection\hskip 1em\relax \fi ##1}}}


\def\ps@myheadings{\def\@oddhead{\hbox{}\sl\rightmark \hfil
\rmfamily\thepage}\def\@oddfoot{}\def\@evenhead{\rmfamily \thepage\hfil\sl\leftmark\hbox
{}}\def\@evenfoot{}\def\sectionmark##1{}\def\subsectionmark##1{}}


\def\today{\ifcase\month\or
 January\or February\or March\or April\or May\or June\or
 July\or August\or September\or October\or November\or December\fi
 \space\number\day, \number\year}


\ps@plain \pagenumbering{arabic} \onecolumn \if@twoside\else\raggedbottom\fi 

\date{}
\pagestyle{headings}

%
%  JJSSST Table Of Contents
%

% \journaltoc ..... Switch to make a Table of Contents for Journal
% Default Values for \oldjtoc and \jtoc
\let\oldjtoc\relax
\let\jtoc\@gobbletwo
\let\post@mble\relax

\def\journaltoc{
\typeout{Making Table Of Contents for Journal}
\newwrite\@tocfile
%   File to write Table Of Contents

\gdef\jtoc{\@bsphack\begingroup\@sanitize\@wrjtoc\@tocfile}
%   New Item For Table Of Contents

\gdef\oldjtoc{
\@input{jjssst-toc.tex}
\immediate\openout\@tocfile=jjssst-toc.tex\relax
}

\gdef\post@mble{
\newcount\nextpage \nextpage=\value{page} \advance\nextpage by 1
% The First Page of The Next Article
%
%\write\@tocfile{\string\setcounter{page}{\the\nextpage}}
% Send The Value of The First Page to The Next Article
%
}}

\twocolumn      %
\columnsep24\p@ %

\def\enddocument{%
%    Redefining \end{document}
\post@mble
%
\@checkend{document}\clearpage\begingroup
\if@filesw \immediate\closeout\@mainaux 
\def\global\@namedef##1##2{}\def\newlabel{\@testdef r}%
\def\bibcite{\@testdef b}\@tempswafalse \makeatletter\input \jobname.aux
\if@tempswa \@warning{Label(s) may have changed.  Rerun to get
cross-references right}\fi\fi\endgroup\deadcycles\z@\@@end}

\def\@citex[#1]#2{\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi
	\def\@citea{}\@cite{\@for\@citeb:=#2\do
		{\@citea\def\@citea{,\penalty\@m\ }\@ifundefined
			{b@\@citeb}{{\bfseries ?}\@warning
			{Citation `\@citeb' on page \thepage \space undefined}}%
	{\csname b@\@citeb\endcsname}}}{#1}}


\def\@wrjtoc#1#2#3{\let\thepage\relax
   \xdef\@gtempa{\write#1{\string
      \jjsssttoc{#2}{#3}{\thepage}}}\endgroup\@gtempa
   \if@nobreak \ifvmode\nobreak\fi\fi\@esphack}
%
\def\jjsssttoc#1#2#3{\write\@tocfile{\string\jjsssttoc{#1}{#2}{#3}}}
% #1=title #2=author #3=page

%% % if NTT JTeX
%% \ifx\gtfam\undefined
%%   \renewcommand{\bfseries}{\protect\pdg\protect\pbf}
%% \fi
