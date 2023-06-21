\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{BHCexam}
  [2015/10/10 v0.4 BHCexam
   document class]


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
\RequirePackage{amsmath,amssymb,amsthm,bm,bbding,pifont,dsfont}
\RequirePackage{mathtools}
\RequirePackage{paralist,cases,tabularx}
\RequirePackage{pstricks,pst-plot,xcolor,graphicx,tikz,pgfplots,pgfmath,tikz-3dplot}
\RequirePackage{esvect,stmaryrd}
\usetikzlibrary{calc,math,arrows.meta,graphs,intersections}
\RequirePackage[colorlinks,linkcolor=blue]{hyperref}  %hyperref超链接目录
%\RequirePackage{hyperref}

%column
\RequirePackage{booktabs}
\RequirePackage{colortbl}
\RequirePackage{multirow}

%column
\if@marginline
\marginparwidth = 2cm
\if@sixteenkpaper
\RequirePackage[papersize={184mm,260mm},hmargin={3cm,2cm},
vmargin={2cm,2cm},marginparsep=0.5cm,hoffset=0cm,voffset=0cm,
footnotesep=0.5cm,headsep=0.5cm,twoside]{geometry}
\else
\RequirePackage[paper=a4paper,hmargin={3cm,2cm},vmargin={2cm,2cm},
marginparsep=0.5cm,hoffset=0cm,voffset=0cm,footnotesep=-1cm,
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

\pagestyle{headandfoot}
\header{}{}{}
\footer{}{\small \quad 第~\thepage~页(共~\numpages~页)}{}
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
\renewcommand{\solutiontitle}{\noindent 解：\par \noindent}
\renewenvironment{solution}%
  {%
    \ifprintanswers
      \begingroup
      \Solution@Emphasis
      \begin{TheSolution}%
    \else
      \if@cancelspace
        %\unskippar
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
\newcommand\xinxi[2]{
  \def\@zongfen{#1}
  \def\@shijian{#2}
}
\newcommand\mininotice{
  \begin{center}{
    \kaishu (本试卷满分~\@zongfen~分, 考试时间~\@shijian~分钟)}
  \end{center}
}
\newcommand{\notice}{
  %\heiti 注意事项： 
  \songti
  \begin{enumerate}
  \item 你拿到的试卷共~\numquestions{}~道试题, 满分~\@zongfen~分,考试时间~\@shijian~分钟.
%  \item 你拿到的试卷满分为~\@zongfen~分,考试时间~\@shijian~分钟。
  \item 本试卷包括“试题卷”和“答题卷”两部分。“试题卷”共4页，“答题卷”共6页。
 \item 请务必在“答题卷”上答题，在“试题卷”上答题是无效的。
  \item 考试结束后，请将“试题卷”和“答题卷"一并交回。
  \end{enumerate}
}
\newlength\@boxwidth
\setlength\@boxwidth{0ex}
\if@printbox \setlength\@boxwidth{18ex} \fi
\newcommand\pinfen{
  \heiti
  \begin{minipage}{\@boxwidth}
  \begin{tabular}{|c|c|}
  \hline
  得分 & 评卷人\\
  \hline
      &       \\
  \hline
  \end{tabular}
  \end{minipage}
}
\newcommand{\houpinfen}{
  \hfill
  \begin{tabular}{|l|l|}
    \hline
    得分 & \hspace*{1.5cm}\\
    \hline
  \end{tabular}
  \bigskip
}
\newcounter{@dati}
\newif\if@houpinfen \@houpinfenfalse
\newcommand\settk[3]{
  \def\@tiankong@zongfen{#1}
  \def\@tiankong@tishu{#2}
  \def\@tiankong@fen{#3}
}
\newcommand\tiankong{
  \@houpinfenfalse
  \stepcounter{@dati}
  \fullwidth{
    \if@printbox \pinfen \fi
    \begin{minipage}{\textwidth-\@boxwidth}
    \heiti \chinese{@dati}. 填空题：本大题共~\@tiankong@tishu~题，满分~\@tiankong@zongfen~分. 请在横线上方填写最终的、最准确的、最完整的结果. 每题填写正确得~\@tiankong@fen~分，否则一律得0分.
    \end{minipage}
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
\newcommand\setxz[3]{
  \def\@xuanze@zongfen{#1}
  \def\@xuanze@tishu{#2}
  \def\@xuanze@fen{#3}
}
\newcommand\xuanze{
  \@houpinfenfalse
  \stepcounter{@dati}
  \fullwidth{
    \if@printbox \pinfen \fi
    \begin{minipage}{\textwidth-\@boxwidth}
      \heiti \chinese{@dati}. 选择题：本大题共~\@xuanze@tishu~题，满分~\@xuanze@zongfen~分. 请选择你认为最正确的答案（每小题有且只有一个）写在括号内. 每题填写正确得~\@xuanze@fen~分，否则得0分.
    \end{minipage}
  }
}
\newcommand{\onech}[4]{
\renewcommand\arraystretch{1.4}
\begin{tabularx}{\linewidth}{XXXX}
\setlength\tabcolsep{0pt}
(A) #1 & (B) #2 & (C) #3 & (D) #4 \\
\end{tabularx}
\unskip \unskip}
\newcommand{\onechx}[4]{
\renewcommand\arraystretch{1.6}
\begin{tabularx}{\linewidth}{XXXX}
\setlength\tabcolsep{0pt}
(A) #1 & (B) #2 & (C) #3 & (D) #4 \\
\end{tabularx}
\unskip \unskip}
\newcommand{\twoch}[4]{
\renewcommand\arraystretch{1.4}
\begin{tabularx}{\linewidth}{XX}
\setlength\tabcolsep{0pt}
(A) #1 & (B) #2 \\
(C) #3 & (D) #4
\end{tabularx}
\unskip \unskip}
\newcommand{\twochx}[4]{
\renewcommand\arraystretch{1.6}
\begin{tabularx}{\linewidth}{XX}
\setlength\tabcolsep{0pt}
(A) #1 & (B) #2 \\
(C) #3 & (D) #4
\end{tabularx}
\unskip \unskip}
\newcommand{\fourch}[4]{
\renewcommand\arraystretch{1.4}
\begin{tabularx}{\linewidth}{X}
\setlength\tabcolsep{0pt}
(A) #1 \\
(B) #2 \\
(C) #3 \\
(D) #4 \\
\end{tabularx}
\unskip \unskip}
\newcommand{\fourchx}[4]{
\renewcommand\arraystretch{1.6}
\begin{tabularx}{\linewidth}{X}
\setlength\tabcolsep{0pt}
(A) #1 \\
(B) #2 \\
(C) #3 \\
(D) #4 \\
\end{tabularx}
\unskip \unskip}
\newcommand\setjd[2]{
  \def\@jianda@zongfen{#1}
  \def\@jianda@tishu{#2}
}
\newcommand\jianda{
  \@cancelspacefalse
  \@houpinfentrue
  \stepcounter{@dati}
  \fullwidth{
    \if@printbox \pinfen \fi
    \begin{minipage}{\textwidth-\@boxwidth}
      \heiti \chinese{@dati}. 简答题：本大题共~\@jianda@tishu~题，满分~\@jianda@zongfen~分. 请在题后空处写出必要的推理计算过程.
    \end{minipage}
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
\renewcommand{\baselinestretch}{1.5}

%定义向量数量积
\newcommand{\xl}[2]{\vv{#1}\bm\cdot\vv{#2}}
%定义画图形格式命令
\newcommand{\zj}[1]{\vspace{-1em}\begin{center}\begin{tikzpicture}#1\end{tikzpicture}\end{center}}
%例题样式
\newcounter{example}
\renewcommand{\theexample}{\arabic{example}}
\newenvironment{example}[1][]{\par \hspace{-1.5em}\refstepcounter{example}\textbf{\color{magenta}例 \theexample:\ #1} \hspace{0.5em}}{\hspace{\stretch{4}} \par  }
%\newcommand{\da}[1]{\noindent {\kaishu \textbf{解:}#1}}
%\newtheorem{lemma}{\textbf{例}}[section]
%\newtheorem{theroem}{\hspace{2em }定理}[section]
%\newcommand{\lt}[1]{\noindent\textbf{例：}#1\par}
%\newcommand{\jd}[1]{\noindent {\kaishu \textbf{解：}#1\par}}
%\qformat{\indent \textbf 例 \thequestion:\thequestiontitle\hfill}%定制question样式
%定义数学定义
\newcounter{dingyi}[section]
\renewcommand{\thedingyi}{\arabic{dingyi}}
\newenvironment{gongli}[1][]{\refstepcounter{dingyi}\noindent\textbf{定义 \thedingyi:\ #1} }{\hspace{\stretch{1}}\par  }%\rule{1ex}{1ex}


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
\AtEndOfPackage{\makeatletter\input{BHCexam.cfg}\makeatother}





\endinput
%%
%% End of file `BHCexam.cls'.
