%%%%%% 
%%%%%    wissbase11.cls 
%%%               Jul 30,2002       Hisashi Aoki
%%
%       (converted from jst11.sty)
%
%
% jst11.sty 19 Nov 87 by Hideki ISOZAKI isozaki@ntt-20.ntt.junet
%  modified  31 Jan 88 by Yoshio OHNO    ohno@keio.junet
% based on art11.sty 23 Sep 85

\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand{\baselinestretch}{} \itemsep 2pt plus 0.5pt minus 0.5pt

\renewcommand{\normalsize}{%
	\@setfontsize\normalsize{10.5\p@}{12\p@}%
	\abovedisplayskip 8\p@ \@plus2\p@ \@minus4\p@
	\abovedisplayshortskip \z@ \@plus2\p@
	\belowdisplayshortskip 4.4\p@ \@plus2.4\p@ \@minus3\p@
	\belowdisplayskip \abovedisplayskip}

\newcommand{\small}{%
	\@setfontsize\small\@xpt{12\p@}%
	\abovedisplayskip 7.5\p@ \@plus1.5\p@ \@minus4\p@
	\abovedisplayshortskip \z@ \@plus2\p@
	\belowdisplayshortskip 4.5\p@ \@plus2\p@ \@minus1\p@
	\belowdisplayskip \abovedisplayskip
	\def\@listi{\topsep 6\p@ \@plus2\p@ \@minus2\p@
			\parsep 3\p@ \@plus2\p@ \@minus1\p@
			\itemsep \parsep}}

\newcommand{\footnotesize}{%
	\@setfontsize\footnotesize\@ixpt{11\p@}%
	\abovedisplayskip 8\p@ \@plus2\p@ \@minus4\p@
	\abovedisplayshortskip \z@ \@plus1\p@
	\belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
	\belowdisplayskip \abovedisplayskip
	\def\@listi{\topsep 4\p@ \@plus2\p@ \@minus2\p@
			\parsep 2\p@ \@plus1\p@ \@minus1\p@
			\itemsep \parsep}}

\newcommand{\scriptsize}{\@setfontsize\scriptsize\@viiipt{9.5\p@}}
\newcommand{\tiny}{\@setfontsize\tiny\@vipt{7\p@}}
\newcommand{\large}{\@setfontsize\large\@xiipt{14\p@}}
\newcommand{\Large}{\@setfontsize\Large\@xivpt{18\p@}}
\newcommand{\LARGE}{\@setfontsize\LARGE\@xviipt{22\p@}}
\newcommand{\huge}{\@setfontsize\huge\@xxpt{25\p@}}
\newcommand{\Huge}{\@setfontsize\Huge\@xxvpt{30\p@}}

\normalsize 

\setlength\oddsidemargin{-5.4mm} % left/right margin 20mm
\setlength\evensidemargin{-5.4mm} % left/right margin 20mm
\setlength\marginparwidth{29.1662mm} % untouched 83\p@
\setlength\marginparsep{3.514mm} % untouched 10\p@
\setlength\topmargin{0mm} % top margin 25.4mm 
\setlength\headheight{4.2168mm} % untouched  12\p@
\setlength\headsep{5.271mm} % untouched 15\p@
\setlength\footskip{3.514mm} % untouched 10\p@

\textheight236mm % 297 - 25.4(top) - 25.4 (bottom) - 4.2168(headheight) - 5.271(headsep) 
\textwidth170mm %

\setlength\footnotesep{7.7\p@}%
\setlength{\skip\footins}{10\p@ \@plus4\p@ \@minus2\p@}
\setlength\floatsep{12\p@ \@plus2\p@ \@minus2\p@}
\setlength\textfloatsep{20\p@ \@plus2\p@ \@minus4\p@}
\setlength\intextsep{12\p@ \@plus2\p@ \@minus2\p@}
\setlength\dblfloatsep{12\p@ \@plus2\p@ \@minus2\p@}
\setlength\dbltextfloatsep{20\p@ \@plus2\p@ \@minus4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
\setlength\marginparpush{5\p@}

\setlength\parskip{0\p@ \@plus 1\p@}
\setlength\parindent{1em}
%\setlength\parindent{17\p@}
\setlength\topsep{3\p@ \@plus 1\p@ \@minus 1.5\p@}
\setlength\partopsep{3\p@ \@plus 1\p@ \@minus 2\p@}
\setlength\itemsep{1\p@ \@plus 0.5\p@ \@minus 0.5\p@}
\@lowpenalty 51
\@medpenalty 151
\@highpenalty 301 
\@beginparpenalty -\@lowpenalty
\@endparpenalty -\@lowpenalty
\@itempenalty -\@lowpenalty 

%%%%%%%%%% the following block is untouched by HA
\def\part{\par \addvspace{4ex} \@afterindentfalse \secdef\@part\@spart} 
\def\@part[#1]#2{\ifnum \c@secnumdepth >\m@ne \refstepcounter{part}\fi
 { \parindent 0pt \raggedright 
 \ifnum \c@secnumdepth >\m@ne \Large \bfseries Part \thepart \par\nobreak \fi \huge
\bfseries #2\markboth{}{}\par } \nobreak \vskip 3ex \@afterheading } 
\def\@spart#1{{\parindent 0pt \raggedright 
 \huge \bfseries 
 #1\par} \nobreak \vskip 3ex \@afterheading } 
%%%%%%%%%%

\def\sec@font{\large\bfseries}
\def\subsec@font{\normalsize\bfseries}
\def\subsubsec@font{\normalsize\bfseries}
\def\para@font{\normalsize\bfseries}
\def\subpara@font{\normalsize\bfseries}

\newcommand{\section}{\@startsection{section}{1}{\z@}%
	{2.4ex \@plus.5ex \@minus.1ex}%
	{1.1ex \@plus.1ex}%
	{\reset@font\sec@font}}
\newcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
	{2ex \@plus.5ex \@minus.1ex}%
	{0.7ex \@plus-.1ex}%
	{\reset@font\subsec@font}}
\newcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
	{2ex \@plus.5ex \@minus.1ex}%
	{0.7ex \@plus-.1ex}%
	{\reset@font\subsubsec@font}}
\newcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
	{2ex \@plus.5ex \@minus.1ex}%
	{-.5em}%
	{\reset@font\para@font}}
\newcommand{\subparagraph}{\@startsection{subparagraph}{\parindent}%
	{2ex \@plus.5ex \@minus.1ex}%
	{-.5em}%
	{\reset@font\subpara@font}}

% \newcommand{\section}{\@startsection{section}{1}{\z@}%
% 	{-2.4ex \@plus-.5ex \@minus-.1ex}%
% 	{1.1ex \@plus.1ex}%
% 	{\reset@font\sec@font}}
% \newcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
% 	{-2ex \@plus-.5ex \@minus-.1ex}%
% 	{0.7ex \@plus-.1ex}%
% 	{\reset@font\subsec@font}}
% \newcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
% 	{-2ex \@plus-.5ex \@minus-.1ex}%
% 	{0.7ex \@plus-.1ex}%
% 	{\reset@font\subsubsec@font}}
% \newcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
% 	{2ex \@plus.5ex \@minus.1ex}%
% 	{-.5em}%
% 	{\reset@font\para@font}}
% \newcommand{\subparagraph}{\@startsection{subparagraph}{\parindent}%
% 	{2ex \@plus.5ex \@minus.1ex}%
% 	{-.5em}%
% 	{\reset@font\subpara@font}}

%%%%%%%%%% the following block is untouched by HA
\setcounter{secnumdepth}{3}

\def\appendix{\par
 \setcounter{section}{0}
 \setcounter{subsection}{0}
 \def\thesection{\Alph{section}}}
%%%%%%%%%%

\setlength\leftmargini{2.5em}
\setlength\leftmarginii{2.2em}
\setlength\leftmarginiii{1.87em}
\setlength\leftmarginiv{1.7em}
\setlength\leftmarginv{1em}
\setlength\leftmarginvi{1em}
\setlength\leftmargin{\leftmargini}

%%%%%%%%%% the following block is untouched by HA
\labelwidth\leftmargini\advance\labelwidth-\labelsep
\labelsep .5em
\parsep 4.5pt plus 2pt minus 1pt
\def\@listi{\leftmargin\leftmargini}
\def\@listii{\leftmargin\leftmarginii
 \labelwidth\leftmarginii\advance\labelwidth-\labelsep
 \topsep 4.5pt plus 2pt minus 1pt
 \parsep 2pt plus 1pt minus 1pt
 \itemsep \parsep}
\def\@listiii{\leftmargin\leftmarginiii
 \labelwidth\leftmarginiii\advance\labelwidth-\labelsep
 \topsep 2pt plus 1pt minus 1pt 
 \parsep \z@ \partopsep 1pt plus 0pt minus 1pt
 \itemsep \topsep}
\def\@listiv{\leftmargin\leftmarginiv
 \labelwidth\leftmarginiv\advance\labelwidth-\labelsep}
\def\@listv{\leftmargin\leftmarginv
 \labelwidth\leftmarginv\advance\labelwidth-\labelsep}
\def\@listvi{\leftmargin\leftmarginvi
 \labelwidth\leftmarginvi\advance\labelwidth-\labelsep}
%%
%% Enf of file
