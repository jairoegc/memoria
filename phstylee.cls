%
% $Id: phstyle.cls,v 1.10 1996/12/06 15:01:13 hanes Exp $
%

% phstyle.cls -- Macros for formatting Prentice-Hall Books
%               -- Compiled by J.K. Shultis, Dec. 1993
%               -- Modified and enhanced for LaTeX2e mdh/rlm 1997/02

\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{phstylee}[1997/02/20 Prentice Hall Book Class, February 1997]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions%

%  Base everything on the default class 'article'.
\LoadClass{report}%


%================================================================================
% 1. Page layout dimensions
% 2. Parameters for float placement
% 3. Define new fonts for headings
% 4. Define LaTeX logos (usually ot needed)
% 5. Redefines the way "figure" amd "table" are formated in a \caption
% 6. Defines a \capt macro which defines (1) \captwidth, (2) \captsize
%    and \beforetableskip.
% 7. New Environemnts:  Eqnarray, reflist, exerlist
% 8. Defines and modifies FANCYHDS.STY for headers and foots
% 9. Change sectioning headings to bold sans serif fonts
%10. Turn off leader dots in Table of Contents
%======================================================================

%====================== Page Layout
\oddsidemargin 0.750in   \evensidemargin 0.250in %0.750in  %\textwidth 5.00in
\textwidth 5.50in
\topmargin     0.75in%0.50in    
\headheight     0.3in    \headsep  0.2in
%\textheight    7.3in     %\footheight .2in        
\textheight    8.0in
\footskip      0.3in
\parskip       0ex       \marginparwidth 1.00in  \marginparsep 0.5in
%\setlength\arraycolsep{1pt}


%===================== Float placement parameters
\renewcommand{\topfraction}{.9}
\renewcommand{\bottomfraction}{.9}
\renewcommand{\textfraction}{.05}
\renewcommand{\floatpagefraction}{.05}

%====================== Define special fonts
\newfont{\BIG}{cminch}                             %--- One-inch font
\newfont{\sfbHuge}{cmssbx10 scaled\magstep5}       %-- 25pt sans serif bold
\newfont{\sfbLarge}{cmssbx10 scaled\magstep2}      %-- ?pt sans serif bold
\newfont{\sfblarge}{cmssbx10 scaled\magstep1}      %-- 12pt sans serif bold
\newfont{\sfbeleven}{cmssbx10 scaled\magstephalf}  %-- 11pt sans serif bold
\newfont{\sfb}{cmssbx10}                           %-- 10pt sans serif bold
\newfont{\sfeight}{cmss8}                          %-- 8pt sans serif

\newfont{\defnem}{cmbxti10}                    %-- 10pt sans serif bold
\def\spacingset#1{\def\baselinestretch{#1}\small\normalsize}


%===================== LaTeX and TeX type logos
\newcount\TestCount
\def\La{\TestCount=\the\fam \leavevmode L\raise.42ex
         \hbox{$\fam\TestCount\scriptstyle\kern-.3em A$}}
\def\LaTeX{\La\kern-.15em\TeX}
\def\AllTeX{{(\La)\TeX}}


%
% -- Exercise environment ------------------------------------------------
%

\newcounter{exercisectr}[chapter]
  \def\theexercisectr{\arabic{chapter}.\arabic{exercisectr}}


\newenvironment{exercise}[1]{\renewcommand{\labelenumi}{(\alph{enumi})}%
  \refstepcounter{exercisectr}\bigskip\par%
%  \addcontentsline{loe}{exercise}{\protect\numberline{\theexercisectr}%
%      {\ignorespaces #1}}%
% Changed to the def of addcontentsline from latex.ltx
% Parms were directly entered, and \thepage part was commented out.
% see also computer
  \addtocontents{loe}{\protect\contentsline{exercise}%
        {\protect\numberline{\theexercisectr}{\ignorespaces #1}}{}}
  \noindent{\bfseries\mathversion{bold}Exercise~\theexercisectr: #1}
  \nopagebreak[4]\par\nopagebreak[4]}{\par}


\def\listofexercises{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
  \fi\chapter*{List of Exercises}
  \renewcommand\@pnumwidth{0em}
  \@starttoc{loe}\if@restonecol
  \twocolumn\fi}

\def\l@exercise{\noindent\@dottedtocline{1}{0em}{3.5em}}

%
% Theorem hack
%

\def\@begintheorem#1#2{\trivlist
   \item[\hskip \labelsep{\bfseries #1\ #2:}]\itshape}

%
% -- Computer Exercise environment -------------------------------------------
%


\newcounter{computerctr}[chapter]

\def\thecomputerctr{C\arabic{chapter}.\arabic{exercisectr}}

\def\compseparator{\bigskip\par\vbox{\noindent\rule{\textwidth}{1pt}%
        \section*{Computer Exercises}}}

\newenvironment{computer}[1]{\renewcommand{\labelenumi}{(\alph{enumi})}%
  \refstepcounter{exercisectr}\bigskip\par%
  \addtocontents{loe}{\protect\contentsline{exercise}%
        {\protect\numberline{C\theexercisectr}{\ignorespaces #1}}{}}
%  \addcontentsline{loe}{exercise}{\protect\numberline{\thecomputerctr}%
%  {\ignorespaces #1}}
  \noindent{\bf Exercise~\thecomputerctr: #1}\par\nopagebreak}{\par}



%===================== Redefine the \@makecaption command
   \long\def\@makecaption#1#2{\vskip 10\p@
%% \setbox\@tempboxa\hbox{#1: #2}%         %% original label definition
   \setbox\@tempboxa\hbox{\textbf{#1.} #2}%   %% bold and . instead of :
   \ifdim \wd\@tempboxa >\hsize
%%     #1: #2\par                   %% original definition
       \textbf{#1.} #2\par             %% bold and . instead of :
   \else
    \hbox to\hsize{\hfil\box\@tempboxa\hfil}%   %% original
%%      \hbox to\hsize{\box\@tempboxa\hfil}%             %% no centering
   \fi}

%===================== New caption macro
\newlength{\captsize}         \let\captsize=\footnotesize
\newlength{\captwidth}        \setlength{\captwidth}{\textwidth}
\newlength{\beforetableskip}  \setlength{\beforetableskip}{.5\baselineskip}
\newcommand{\capt}[1]{\begin{minipage}{\captwidth}
          \let\normalsize=\captsize
          \caption[#1]{#1}
          \end{minipage}\\ \vspace{\beforetableskip}}

%---------- Change Figure Label
\newcommand{\thefigurename}{Figura}   %-- set default: Figure
\def\fnum@figure{\thefigurename\ \thefigure}

%       This is to get the equation numbers in the form (section.equation),
%       and to have the equation counter reset every time the section 
%       counter is incremented.

\def\theequation{\thesection.\arabic{equation}}
\@addtoreset{equation}{section}

%===================== New Environments

%------ Reference List Macro
\newenvironment{reflist}{\begin{list}{}{\leftmargin 1em \labelwidth 0in
\labelsep 0in \itemsep 0ex  \rightmargin 0in}}{\end{list}}
\newcommand{\refitem}{\item \hspace*{-1em}}   %--- item for ref list
\newcommand{\SC}{\scriptsize}  %--- small capitals for reference lists


%------ New environment for better spacing in Eqnarray
\def\eqnarray{%
   \stepcounter{equation}%
   \def\@currentlabel{\p@equation\theequation}%
   \global\@eqnswtrue
   \m@th
   \global\@eqcnt\z@
   \tabskip\@centering
   \let\\\@eqncr
   $$\everycr{}\halign to\displaywidth\bgroup
       \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel
      &\global\@eqcnt\@ne\hskip \arraycolsep \hfil${##}$\hfil
      &\global\@eqcnt\tw@ \hskip \arraycolsep
         $\displaystyle{##}$\hfil\tabskip\@centering
      &\global\@eqcnt\thr@@ \hb@xt@\z@\bgroup\hss##\egroup
         \tabskip\z@skip
      \cr
}





%\newenvironment{Eqnarray}{\arraycolsep 0.14em\begin{eqnarray}}{\end{eqnarray}}

% The hangitem environment -- like description, but text lines up with 
%    the item descriptor.  You give an additional argument containing text
%    of the width that you want indentations.
%
\def\hangitem#1{\list{}{\settowidth\labelwidth{#1}
        \leftmargin\labelwidth\advance\leftmargin\labelsep }}
\let\endhangitem\endlist

%------ Problem List Macro
\newcounter{probnum}
\newenvironment{exerlist}%
  {\begin{list}{\bf \theprobnum.}%
  {\usecounter{probnum} \itemsep 1ex  \leftmargin 2.0em \labelsep 0.5em
   \rightmargin 0in}}{\end{list}}




%===================== Define FANCYHDS.STY
% fancyheadings.sty version 1.1
% Fancy headers and footers.
% Piet van Oostrum, Dept of Computer Science, University of Utrecht
% Padualaan 14, P.O. Box 80.089, 3508 TB Utrecht, The Netherlands
% Telephone: +31-30-531806. piet@cs.ruu.nl (mcvax!hp4nl!ruuinf!piet)
% Sep 23, 1992.

\def\lhead{\@ifnextchar[{\@xlhead}{\@ylhead}}
\def\@xlhead[#1]#2{\gdef\@elhead{#1}\gdef\@olhead{#2}}
\def\@ylhead#1{\gdef\@elhead{#1}\gdef\@olhead{#1}}

\def\chead{\@ifnextchar[{\@xchead}{\@ychead}}
\def\@xchead[#1]#2{\gdef\@echead{#1}\gdef\@ochead{#2}}
\def\@ychead#1{\gdef\@echead{#1}\gdef\@ochead{#1}}

\def\rhead{\@ifnextchar[{\@xrhead}{\@yrhead}}
\def\@xrhead[#1]#2{\gdef\@erhead{#1}\gdef\@orhead{#2}}
\def\@yrhead#1{\gdef\@erhead{#1}\gdef\@orhead{#1}}

\def\lfoot{\@ifnextchar[{\@xlfoot}{\@ylfoot}}
\def\@xlfoot[#1]#2{\gdef\@elfoot{#1}\gdef\@olfoot{#2}}
\def\@ylfoot#1{\gdef\@elfoot{#1}\gdef\@olfoot{#1}}

\def\cfoot{\@ifnextchar[{\@xcfoot}{\@ycfoot}}
\def\@xcfoot[#1]#2{\gdef\@ecfoot{#1}\gdef\@ocfoot{#2}}
\def\@ycfoot#1{\gdef\@ecfoot{#1}\gdef\@ocfoot{#1}}

\def\rfoot{\@ifnextchar[{\@xrfoot}{\@yrfoot}}
\def\@xrfoot[#1]#2{\gdef\@erfoot{#1}\gdef\@orfoot{#2}}
\def\@yrfoot#1{\gdef\@erfoot{#1}\gdef\@orfoot{#1}}

\newdimen\headrulewidth
\newdimen\footrulewidth
\newdimen\plainheadrulewidth
\newdimen\plainfootrulewidth
\newdimen\headwidth
\newif\if@fancyplain \@fancyplainfalse
\def\fancyplain#1#2{\if@fancyplain#1\else#2\fi}

% Initialization of the head and foot text.

\headrulewidth 0.4pt
\footrulewidth\z@
\plainheadrulewidth\z@
\plainfootrulewidth\z@

\lhead[\fancyplain{}{\sl\rightmark}]{\fancyplain{}{\sl\leftmark}}
%  i.e. empty on ``plain'' pages \rightmark on even, \leftmark on odd pages
\chead{}
\rhead[\fancyplain{}{\sl\leftmark}]{\fancyplain{}{\sl\rightmark}}
%  i.e. empty on ``plain'' pages \leftmark on even, \rightmark on odd pages
\lfoot{}
\cfoot{\rm\thepage} % page number
\rfoot{}

% Put together a header or footer given the left, center and
% right text, fillers at left and right and a rule.
% The \lap commands put the text into an hbox of zero size,
% so overlapping text does not generate an errormessage.

\def\@fancyhead#1#2#3#4#5{#1\hbox to\headwidth{\vbox{\hbox
{\rlap{\parbox[b]{\headwidth}{\raggedright#2\strut}}\hfill
\parbox[b]{\headwidth}{\centering#3\strut}\hfill
\llap{\parbox[b]{\headwidth}{\raggedleft#4\strut}}}\headrule}}#5}


\def\@fancyfoot#1#2#3#4#5{#1\hbox to\headwidth{\vbox{\footrule
\hbox{\rlap{\parbox[t]{\headwidth}{\raggedright#2\strut}}\hfill
\parbox[t]{\headwidth}{\centering#3\strut}\hfill
\llap{\parbox[t]{\headwidth}{\raggedleft#4\strut}}}}}#5}

\def\headrule{{\if@fancyplain\headrulewidth\plainheadrulewidth\fi
\hrule\@height\headrulewidth\@width\headwidth \vskip-\headrulewidth}}

\def\footrule{{\if@fancyplain\footrulewidth\plainfootrulewidth\fi
\vskip-0.3\normalbaselineskip\vskip-\footrulewidth
\hrule\@width\headwidth\@height\footrulewidth\vskip0.3\normalbaselineskip}}

\def\ps@fancy{
\let\@mkboth\markboth
\@ifundefined{chapter}{\def\sectionmark##1{\markboth
{\uppercase{\ifnum \c@secnumdepth>\z@
 \thesection\hskip 1em\relax \fi ##1}}{}}
\def\subsectionmark##1{\markright {\ifnum \c@secnumdepth >\@ne
 \thesubsection\hskip 1em\relax \fi ##1}}}
%
{\def\chaptermark##1{\markboth {\uppercase{\ifnum \c@secnumdepth>\m@ne
 \@chapapp\ \thechapter. \ \fi ##1}}{}}
\def\sectionmark##1{\markright{\uppercase{\ifnum \c@secnumdepth >\z@
 \thesection. \ \fi ##1}}}}
\ps@@fancy
\headwidth\textwidth}
\def\ps@fancyplain{\ps@fancy \let\ps@plain\ps@plain@fancy}
\def\ps@plain@fancy{\@fancyplaintrue\ps@@fancy}
\def\ps@@fancy{
\def\@oddhead{\@fancyhead\relax\@olhead\@ochead\@orhead\hss}
\def\@oddfoot{\@fancyfoot\relax\@olfoot\@ocfoot\@orfoot\hss}
\def\@evenhead{\@fancyhead\hss\@elhead\@echead\@erhead\relax}
\def\@evenfoot{\@fancyfoot\hss\@elfoot\@ecfoot\@erfoot\relax}
}
%------------------- Modify Headers for Prentice-Hall Book Style
%---------- Setup headers and footers
\pagestyle{fancyplain}
\plainfootrulewidth 0pt             %---- no foot rule for chapter page
\footrulewidth 0pt                  %---- no rule for foot
%--- Redefine Headers
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
%
\lhead[\fancyplain{}{\bf\thepage}]{\fancyplain{}{\sfeight\rightmark}}
%
%\rhead[\fancyplain{}{\footnotesize\sf\CHHEAD}]{\fancyplain{}{\bf\thepage}}
 \rhead[\fancyplain{}{\sfeight\leftmark}]{\fancyplain{}{\bf\thepage}}
%--- Empty footers on every page (except initial chapter page which has
%--- page number) and optionally a small date stamp
\cfoot[\fancyplain{}{}]{\fancyplain{}{}}
\rfoot[\fancyplain{}{}]{\fancyplain{\bf\thepage}{}}
\lfoot[\fancyplain{\bf\thepage}{}]{\fancyplain{}{}}
%-- replace the two lines above with the two below for a date stamp footer
%\rfoot[\fancyplain{\scriptsize \today}{\scriptsize \today}]{\fancyplain{\bf\thepage}{}}
%\lfoot[\fancyplain{\bf\thepage}{}]{\fancyplain{\scriptsize \today}{\scriptsize \today}}
%--- Change format of section header
%
% rlm added chaptermark 10/11/96
\def\sectionmark#1{\markright{\ifnum \c@secnumdepth >\z@
  {\sfeight Section}~\thesection.\quad \fi #1}}
%
\def\chaptermark#1{\markboth{#1 \quad \@chapapp{}~\thechapter}{}}
\def\chaptersmark#1{\markboth{#1}{#1}}




%===================== Change Section Heads to Bold Sans Serif
% Create bolds sans serif sectioning headings.  Also the headings have
% been reduced in size with less space before and after the heading.
% Modified from macros given in BK10.STY
%
%----------------------------- part ---------------------------------
% no changes made to part

%------------------------- appendix -----------------------------------

\let\oldappendix\appendix
\def\appendix{\oldappendix\def\addchaptertoloe{}}

%------------------------- chapter -----------------------------------
\def\addchaptertoloe{%
        \addtocontents{loe}{\protect\addvspace{14pt}}%
        \addtocontents{loe}{\noindent {\bfseries Chapter~\thechapter}}%
        \addtocontents{loe}{\protect\addvspace{10pt}}%
}

\def\chapter{\clearpage \thispagestyle{plain} \global\@topnum\z@
\@afterindentfalse \secdef\@chapter\@schapter} 
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
 \refstepcounter{chapter}
 \typeout{\@chapapp\space\thechapter.}
 \addcontentsline{toc}{chapter}{\protect
 \numberline{\thechapter}\uppercase{#1}}\else
 \addcontentsline{toc}{chapter}{\uppercase{#1}}\fi
 \chaptermark{#1}
 \addchaptertoloe
 \addtocontents{lof}{\protect\addvspace{10pt}}
\addtocontents{lot}{\protect\addvspace{10pt}} \if@twocolumn
\@topnewpage[\@makechapterhead{#2}] 
 \else \@makechapterhead{#2}
 \@afterheading \fi} 
%
\def\@schapter#1{\if@twocolumn \@topnewpage[\@makeschapterhead{#1}]
 \else \@makeschapterhead{#1}\chaptersmark{#1}
 \@afterheading\fi\addcontentsline{toc}{chapter}{\uppercase{#1}}}



\def\@makechapterhead#1{\vspace*{-20pt}{\parindent0pt\raggedright
\ifnum\c@secnumdepth>\m@ne\LARGE\sf\@chapapp{}~\thechapter\par
\vskip3pt\hrule\vskip3pt\hrule
\vskip30pt\fi\raggedleft\Huge\sfbHuge\uppercase{#1}\par
\nobreak\vskip70pt}}%\chaptermark{#1}}

\def\@makeschapterhead#1{\vspace*{4pt}{\parindent0pt
\vskip3pt\hrule\vskip3pt\hrule
\vskip36pt\raggedleft\Huge\sfbHuge\uppercase{#1}\par
\nobreak\vskip70pt}}%\chaptersmark{#1}}

%------------------------ section -----------------------------------
\def\section{\@startsection{section}{1}{\z@}{-3.5ex plus-1ex
  minus -.2ex}{1.8ex}{\Large\sfbLarge}}

%--------------------- subsection -----------------------------------
\def\subsection{\@startsection{subsection}{2}{\z@}{-2.75ex plus -1ex
    minus -.2ex}{1.2ex}{\large\sfblarge}}

%-------------------- subsubsection --------------------------------
\def\subsubsection{\@startsection{subsubsection}{3}{\z@}{-2.75ex
  plus -1ex minus -.2ex}{1.2ex}{\normalsize\sfb}}

%----------------------- paragraph ----------------------------------
\def\paragraph{\@startsection{paragraph}{4}{\z@}{1.25ex plus
     1ex minus .2ex}{-1em}{\normalsize\sfb}}
%
%---------------------- subparagraph --------------------------------
\def\subparagraph{\@startsection{subparagraph}{4}{\parindent}{1.25ex
     plus 1ex minus .2ex}{-1em}{\normalsize\sfb}}



%====================== Turn off leader dots in Table of Contents
\renewcommand{\@dotsep}{500}


\def\tableofcontents{\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
 \fi\thispagestyle{plain} \@makeschapterhead{Contenido} 
 \@afterheading
 \@starttoc{toc}\if@restonecol\twocolumn\fi}

%\def\thebibliography#1{\chapter*{ Bibliograf\'ia}\list
\def\thebibliography#1{\chapter*{ Referencias}\list
% \addcontentsline{toc}{chapter}{Bibliography}
 {[\arabic{enumi}]}{\settowidth\labelwidth{}\leftmargin\labelwidth
% \advance\leftmargin\labelsep
 \usecounter{enumi}}
 \def\newblock{\hskip .11em plus .33em minus .07em}
 \sloppy\clubpenalty4000\widowpenalty4000
 \sfcode`\.=1000\relax}
\let\endthebibliography=\endlist

%% BIBLIOGRAPHY
%
%% separate citations with "], ["
\def\@citex[#1]#2{\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi
\def\@citea{}\@cite{\@for\@citeb:=#2\do {\@citea\def\@citea{],
[}\@ifundefined {b@\@citeb}{{\bf ?}\@warning {Citation `\@citeb' on
page \thepage \space undefined}}%
{\csname b@\@citeb\endcsname}}}{#1}}
 
\def\@cite#1#2{[{#1\if@tempswa, #2\fi}]}


%% index

%\def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
%\columnseprule \z@
%\columnsep 35pt\twocolumn[\@makeschapterhead{Subject Index}]
% \addcontentsline{toc}{chapter}{SUBJECT INDEX}
% \thispagestyle{plain}\parindent\z@
% \parskip\z@ plus .3pt\relax\let\item\@idxitem}

%% Original \theindex. Uses Subject Index as indexname
%\def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
%\columnseprule \z@
%\columnsep 35pt\twocolumn[\@makeschapterhead{Subject Index}]
%  \chaptersmark{Subject Index}%
% \addcontentsline{toc}{chapter}{SUBJECT INDEX}
% \thispagestyle{plain}\parindent\z@
% \parskip\z@ plus .3pt\relax\let\item\@idxitem}

%% Use Index as indexname
\def\theindex{\@restonecoltrue\if@twocolumn\@restonecolfalse\fi
\columnseprule \z@
\columnsep 35pt\twocolumn[\@makeschapterhead{\indexname}]
  \chaptersmark{\indexname}%
 \addcontentsline{toc}{chapter}{\uppercase{\indexname}}
 \thispagestyle{plain}\parindent\z@
 \parskip\z@ plus .3pt\relax\let\item\@idxitem}
