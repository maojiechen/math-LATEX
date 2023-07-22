
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{BHCexam}
 

\newif\if@sixteenkpaper \@sixteenkpaperfalse
\DeclareOption{16kpaper}{\@sixteenkpapertrue}
\newif\if@marginline \@marginlinefalse
\DeclareOption{marginline}{\@marginlinetrue}
\newif\if@noindent \@noindentfalse
\DeclareOption{noindent}{\@noindenttrue}
\DeclareOption{answers}{\PassOptionsToClass{\CurrentOption}{exam}}

\newif\if@printbox \@printboxfalse
\DeclareOption{printbox}{\@printboxtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessOptions
\LoadClass[addpoints]{exam}
\RequirePackage{ctex}
\RequirePackage{ifpdf,ifxetex}
\RequirePackage{amsmath,amssymb,amsthm,bm,bbding}
\RequirePackage{mathtools}
\RequirePackage{paralist,cases,tabularx}
\RequirePackage{pstricks,pst-plot,xcolor,graphicx,tikz,pgfplots,pgfmath,tikz-3dplot}
\RequirePackage{esvect,stmaryrd}
\usetikzlibrary{calc,math,arrows.meta,graphs,intersections}
\RequirePackage[hidelinks]{hyperref}

%column
\RequirePackage{booktabs}
\RequirePackage{colortbl}
\RequirePackage{multirow}
%column
\if@marginline
\marginparwidth = 2cm
\if@sixteenkpaper
\RequirePackage[papersize={184mm,260mm},hmargin={2cm,2cm},
vmargin={2cm,2cm},marginparsep=0.5cm,hoffset=0cm,voffset=0cm,
footnotesep=0.5cm,headsep=0.5cm,twoside]{geometry}
\else
\RequirePackage[paper=a4paper,hmargin={2cm,2cm},vmargin={2cm,2cm},
marginparsep=0.5cm,hoffset=0cm,voffset=0cm,footnotesep=0.5cm,
headsep=0.5cm,twoside]{geometry}
\fi
\else
\if@sixteenkpaper
\RequirePackage[papersize={184mm,260mm},hmargin={2cm,2cm},
vmargin={2cm,2cm},marginparsep=0.5cm,hoffset=0cm,voffset=0cm,
footnotesep=0.5cm,headsep=0.5cm]{geometry}
\else
\RequirePackage[papersize={210mm,297mm},hmargin={2cm,2cm},vmargin={2cm,2cm},
marginparsep=0.5cm,hoffset=0cm,voffset=0cm,footnotesep=0.5cm,
headsep=0.5cm]{geometry}
\fi
\fi
\renewcommand{\baselinestretch}{1.5}
\pagestyle{headandfoot}
\header{}{}{}
\footer{}{\small 数学试题卷\quad 第~\thepage~页(共~\numpages~页)}{}
\pointname{分}
\pointformat{\kaishu (\thepoints)}
\renewcommand{\questionshook}{
  \settowidth{\leftmargin}{22.\hskip\labelsep}
  \if@noindent \setlength\leftmargin{0pt} \fi
}
%%partno自定义样式
\renewcommand{\thepartno}{\arabic{partno}}
\renewcommand{\partlabel}{(\thepartno)}
\renewcommand{\partshook}{
  \settowidth{\leftmargin}{(3).\hskip\labelsep}
  \if@noindent \setlength\leftmargin{0pt} \fi
}
\newif\if@cancelspace \@cancelspacetrue
\renewcommand{\solutiontitle}{\noindent 解：\noindent}
\renewenvironment{solution}%
  {%
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \if@cancelspace
        %\unskip
      \else
        \par
        \penalty 0
        \vfill%
        \if@printbox \if@houpinfen \houpinfen \fi \fi
      \fi
      \setbox\z@\vbox\bgroup
    \fi
  }{%
    \ifprintanswers
      \end{TheSolution}%
      \endgroup
    \else
      \egroup
    \fi
  }%
\if@marginline
\newsavebox{\zdxl}
\sbox{\zdxl}{
\begin{minipage}{0.7\paperheight}
\begin{center}
\heiti 班级\underline{\hspace{15ex}} \quad
姓名 \underline{\hspace{15ex}} \quad
学号 \underline{\hspace{15ex}} \quad \\
\vspace{3ex}
\dotfill 装 \dotfill 订 \dotfill 线 \dotfill
\end{center}
\end{minipage}
}
\newsavebox{\zdxr}
\sbox{\zdxr}{
\begin{minipage}{0.7\paperheight}
\begin{center}
\heiti \hfill 请 \hfill 不 \hfill 要 \hfill 在 \hfill
 装 \hfill 订 \hfill 线 \hfill 内 \hfill 答 \hfill 题 \hfill \\
\vspace{3ex}
\dotfill 装 \dotfill 订 \dotfill 线 \dotfill
\end{center}
\end{minipage}
}
\newcommand{\printmlol}{
\marginpar{\rotatebox{90}{\usebox{\zdxl}}}
}
\newcommand{\printmlor}{
\marginpar{\rotatebox{-90}{\usebox{\zdxr}}}
}
\reversemarginpar
\fi
\newcommand\biaoti[1]{\def\@biaoti{#1}}
\newcommand\fubiaoti[1]{\def\@fubiaoti{#1}}
\renewcommand\maketitle{
  \begin{center}{\heiti \Large{\@biaoti}}\end{center}
  \begin{center}{\heiti \Large{\@fubiaoti}}\end{center}
}

\newcommand{\notice}{
  {\heiti 注意事项：
  \begin{enumerate}
 	   \item 你拿到的试卷满分为150分，考试时间为120分钟。
          \item 本试卷包括“试题卷”和“答题卷”两部分。“试题卷”共4页，“答题卷”共6页。
          \item 请务必在“答题卷”上答题，在“试题卷”上答题是无效的。
          \item 考试结束后，请将“试题卷”和“答题卷”一并交回。
  \end{enumerate}
}
}

\newcounter{@dati}
\newif\if@houpinfen \@houpinfenfalse

\newcommand\xuanze{
  \stepcounter{@dati}
  \fullwidth{
      \heiti \chinese{@dati}、 选择题(本大题共~10~题，每小题~4~分，满分~40~分)
  }
}
\newcommand{\onech}[4]{
\renewcommand\arraystretch{1.4}
\begin{tabularx}{\linewidth}{XXXX}
\setlength\tabcolsep{0pt}
%(A) #1 & (B) #2 & (C) #3 & (D) #4 \\
A. #1 & B. #2 & C. #3 & D. #4 \\
\end{tabularx}
\unskip \unskip}
\newcommand{\onechx}[4]{
\renewcommand\arraystretch{1.6}
\begin{tabularx}{\linewidth}{XXXX}
\setlength\tabcolsep{0pt}
%(A) #1 & (B) #2 & (C) #3 & (D) #4 \\
A. #1 & B. #2 & C. #3 & D. #4 \\
\end{tabularx}
\unskip \unskip}
\newcommand{\twoch}[4]{
\renewcommand\arraystretch{1.4}
\begin{tabularx}{\linewidth}{XX}
\setlength\tabcolsep{0pt}
A. #1 & B. #2 \\
C. #3 & D. #4
\end{tabularx}
\unskip \unskip}
\newcommand{\twochx}[4]{
\renewcommand\arraystretch{1.6}
\begin{tabularx}{\linewidth}{XX}
\setlength\tabcolsep{0pt}
A. #1 & B. #2 \\
C. #3 & D. #4
\end{tabularx}
\unskip \unskip}
\newcommand{\fourch}[4]{
\renewcommand\arraystretch{1.4}
\begin{tabularx}{\linewidth}{X}
\setlength\tabcolsep{0pt}
A. #1 \\
B. #2 \\
C. #3 \\
D. #4 \\
\end{tabularx}
\unskip \unskip}
\newcommand{\fourchx}[4]{
\renewcommand\arraystretch{1.6}
\begin{tabularx}{\linewidth}{X}
\setlength\tabcolsep{0pt}
A. #1 \\
B. #2 \\
C. #3 \\
D. #4 \\
\end{tabularx}
\unskip \unskip}

\newcommand{\xx}[1]{
  \ifprintanswers
    \hfill(\hspace{0.5em}~#1~\hspace{0.5em})
  \else
    \hfill{~\hspace{1cm}~}
  \fi}

\newcommand\tiankong{
  \stepcounter{@dati}
  \fullwidth{
    \heiti \chinese{@dati}、 填空题(本大题共~4~小题，每小题~5~分，满分~20~分)
  }
}
\newcommand{\stk}[1]{
  \ifprintanswers
    \underline{~#1~}
  \else
    \underline{~\hspace{1cm}~}
  \fi}
\newcommand{\mtk}[1]{
  \ifprintanswers
    \underline{~#1~}
  \else
    \underline{~\hspace{2cm}~}
  \fi}
\newcommand{\ltk}[1]{
  \ifprintanswers
    \underline{~#1~}
  \else
    \underline{~\hspace{3cm}~}
  \fi}

\newcommand\jiandaa{
  \stepcounter{@dati}
  \fullwidth{
      \heiti \chinese{@dati}、（本大题共~2~小题，每小题~8~分，满分~16~分）
  }
}

\newcommand\jiandab{
  \stepcounter{@dati}
  \fullwidth{
      \heiti \chinese{@dati}、（本大题共~2~小题，每小题~8~分，满分~16~分）
  }
}

\newcommand\jiandac{
  \stepcounter{@dati}
  \fullwidth{
      \heiti \chinese{@dati}、（本大题共~2~小题，每小题~10~分，满分~20~分）
  }
}

\newcommand\jiandad{
  \stepcounter{@dati}
  \fullwidth{
      \heiti \chinese{@dati}、（本题满分~12~分）
  }
}

\newcommand\jiandae{
  \stepcounter{@dati}
  \fullwidth{
      \heiti \chinese{@dati}、（本题满分~12~分）
  }
}

\newcommand\jiandaf{
  \stepcounter{@dati}
  \fullwidth{
      \heiti \chinese{@dati}、（本题满分~14~分）
  }
}
\delimitershortfall-1sp
\newcommand{\abs}[1]{\left| #1 \right|}
\renewcommand{\geq}{\geqslant}
\renewcommand{\ge}{\geqslant}
\renewcommand{\leq}{\leqslant}
\renewcommand{\le}{\leqslant}
\newcommand{\xx}{\hfill(\hspace{2.5em})}
\newcommand{\tk}{\underline{\hspace{3em}}}
\newcommand{\qs}{\question}
\newcommand{\inR}{\in\mathbf{R}}
\newcommand{\inN}{\in\mathbf{N}}
\newcommand{\inZ}{\in\mathbf{Z}}
\newcommand{\kongbai}{\vspace{20em}}
\newcommand{\kb}{\vspace{20em}}
\renewcommand{\baselinestretch}{1.35}

\RequirePackage{fontspec,txfonts,setspace}
\setmainfont{Times New Roman}

\setlength\abovedisplayshortskip{5pt}
\setlength\belowdisplayshortskip{5pt}
\setlength{\lineskiplimit}{2.625bp}
\setlength{\lineskip}{2.625bp}
%\setlength\abovedisplayshortskip{5pt}
%\setlength\belowdisplayshortskip{5pt}
%\setlength{\lineskiplimit}{3bp}
%\setlength{\lineskip}{3bp}
%\setstretch{1.4}
%罗马字体
\newcommand{\rmnum}[1]{\romannumeral #1}
\newcommand{\Rmnum}[1]{\expandafter\@slowromancap\romannumeral #1@}
%
%%3dplot
\newcommand{\swht}[2][0.7]{\begin{tikzpicture}[scale=#1,tdplot_main_coords,>=latex]%
#2%
\end{tikzpicture}%
}
%%
\tdplotsetmaincoords{80}{100}
%\AtEndOfPackage{\makeatletter\input{BHCexam.cfg}\makeatother}





\endinput
%%
%% End of file `BHCexam.cls'.
