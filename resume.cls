\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2015/05/25 An elegant Résumé class]
\LoadClass[11pt]{article}

% disable indent globally
\setlength{\parindent}{0pt}
% some general improvements, defines the XeTeX logo
\RequirePackage{xltxtra}
% use xifthen
\RequirePackage{xifthen}
% key-value argument parsing for experience environment
\RequirePackage{xkeyval}
% ---- Language switch ----
% Use \langcntrue in document preamble to enable Chinese output mode
\newif\iflangcn
\langcnfalse
% use progress bar for skill
\RequirePackage{progressbar}
% use hyperlink for email and url
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{url}
\urlstyle{tt}
% use fontawesome
\RequirePackage{fontawesome}
% use xcolor for customizing color
%\RequirePackage[usenames,dvipsnames]{xcolor}
% loading fonts
\RequirePackage{fontspec}
% Main document font
\setmainfont[
  Path = fonts/Main/ ,
  Extension = .otf ,
  UprightFont = *-regular ,
  BoldFont = *-bold ,
  ItalicFont = *-italic ,
  BoldItalicFont = *-bolditalic ,
  SmallCapsFont = Fontin-SmallCaps
]{texgyretermes}

\RequirePackage[
	a4paper,
	left=0.8in,
	right=0.8in,
	top=0.70in,
	bottom=0.55in,
	nohead
]{geometry}

\RequirePackage{titlesec}
\RequirePackage{enumitem}
\setlist{noitemsep} % removes spacing from items but leaves space around the whole list
%\setlist{nosep} % removes all vertical spacing within and around the list
\setlist[itemize]{topsep=0.25em, leftmargin=1.5pc}
\setlist[enumerate]{topsep=0.25em, leftmargin=1.5pc}
\RequirePackage[super]{nth}

\titleformat{\section}         % Customise the \section command 
  {\Large\scshape\raggedright} % Make the \section headers large (\Large),
                               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
  {}                           % Can be used to insert code before the heading
  [{\titlerule[1.0pt]}]                % Inserts a horizontal line after the heading
\titlespacing*{\section}{0cm}{*1.8}{*1.8}

\titleformat{\subsection}
  {\large\raggedright}
  {}{0em}
  {}
\titlespacing*{\subsection}{0cm}{*1.8}{*0.6}

\newcommand{\datedsection}[2]{%
  \section[#1]{#1 \hfill #2}%
}
\newcommand{\datedsubsection}[2]{%
  \subsection[#1]{#1 \hfill #2}%
}
\newcommand{\datedline}[2]{%
  {\par #1 \hfill #2 \par}%
}

\newcommand{\name}[1]{
  \centerline{\Huge\scshape{#1}}
  \vspace{1.25ex}
}

% defines one's name
% usage: \name{<name>}
\newcommand{\nameTest}[1]{
  {\large\scshape{#1}}
}

% defines one's email
% usage: \email{<email>}
\newcommand{\email}[1]{\faEnvelope\ \href{mailto:#1}{#1}}
% defines one's phone
% usage: \phone{<phone>}
\newcommand{\phone}[1]{\faPhone\ {#1}}
% defines one's linkedin
% usage: \linkedin{<linkedin>}
\newcommand{\linkedin}[2][]{\faLinkedin\ 
  \ifthenelse{\isempty{#1}}%
    {\href{#2}{#2}}
    {\href{#2}{#1}}}
% defines one's GitHub
% usage: \github{<github>}
\newcommand{\github}[2][]{\faGithub\ 
  \ifthenelse{\isempty{#1}}%
    {\href{#2}{#2}}
    {\href{#2}{#1}}}
% defines one's homepage
% usage: \homepage{<homepage>}
\newcommand{\homepage}[2][]{\faLink\ 
  \ifthenelse{\isempty{#1}}%
    {\href{#2}{#2}}
    {\href{#2}{#1}}}

% defines progress bar with text
% usage: \pbar[3][width]{Text}{percentage}
\newcommand{\pbar}[3][10em]{{#2}\ 
  \progressbar[heightr=1, width=#1, borderwidth=0pt, roundnessr=0.45, filledcolor=green!40, subdivisions=1]{#3}
}

\newcommand{\basicInfo}[1]{
  \centerline{\sffamily\large{#1}}
  \vspace{1.5ex}
}

\newcommand{\role}[2]{
  {\par \textit{#1} ~ #2 \par}
  \vspace{-0.25ex}
}
\definecolor{gray76}{RGB}{118, 118, 118}

% 论文条目命令
% 用法: \paper[code链接]{年份}{会议/期刊名}{会议/期刊链接}{作者}{论文标题}
\newcommand{\paper}[6][]{% #1(可选):code链接 #2:年份 #3:会议名 #4:会议链接 #5:作者 #6:标题
  \textcolor{gray76}{\textbf{[#2\ |\ \ifthenelse{\isempty{#4}}{#3}{\href{#4}{#3}}%
  \ifthenelse{\isempty{#1}}{}{\ |\ \faGithub\ \href{#1}{Code}}%
  ]}}\ #5\ \textit{#6}%
}
% ============================================================
% Bilingual Experience Environment
% ============================================================

% English month abbreviations (argument: 1-12)
\newcommand{\@monthname}[1]{%
  \ifcase#1\or Jan.\or Feb.\or Mar.\or Apr.\or May\or Jun.%
  \or Jul.\or Aug.\or Sep.\or Oct.\or Nov.\or Dec.\fi%
}

% Format a date given year and month number
% Chinese: 2025 年 6 月 | English: Jun. 2025
\newcommand{\@formatdate}[2]{%
  \iflangcn
    #1\ 年\ #2\ 月%
  \else
    \@monthname{#2}\ #1%
  \fi
}

% xkeyval schema for \begin{experience}{...}
\define@key{experience}{cn-company}{\def\exp@cncompany{#1}}
\define@key{experience}{en-company}{\def\exp@encompany{#1}}
\define@key{experience}{start-year}{\def\exp@startyear{#1}}
\define@key{experience}{start-month}{\def\exp@startmonth{#1}}
\define@key{experience}{end-year}{\def\exp@endyear{#1}}
\define@key{experience}{end-month}{\def\exp@endmonth{#1}}
\define@key{experience}{ongoing}{\def\exp@ongoing{#1}}
\define@key{experience}{role}{\def\exp@role{#1}}
\define@key{experience}{topic}{\def\exp@topic{#1}}

% experience environment
% Usage:
%   \begin{experience}{
%     cn-company = {腾讯 光子工作室},
%     en-company = {Tencent LightSpeed},
%     start-year = 2025, start-month = 4,
%     end-year   = 2025, end-month   = 8,  % omit when ongoing=true
%     ongoing    = true,                   % optional, default false
%     role       = {Research Intern},
%     topic      = {Reinforcement Learning | AI Memory},
%   }
%     \biitem{中文内容}{English content}
%   \end{experience}
\newenvironment{experience}[1]{%
  % reset optional fields to defaults before each entry
  \def\exp@endyear{}\def\exp@endmonth{}%
  \def\exp@ongoing{false}\def\exp@role{}\def\exp@topic{}%
  \setkeys{experience}{#1}%
  % Select company name by language
  \iflangcn
    \def\exp@company{\exp@cncompany}%
  \else
    \def\exp@company{\exp@encompany}%
  \fi
  % Build start date
  \def\exp@startdate{\@formatdate{\exp@startyear}{\exp@startmonth}}%
  % Build end date
  \ifthenelse{\equal{\exp@ongoing}{true}}{%
    \iflangcn
      \def\exp@enddate{至今}%
    \else
      \def\exp@enddate{Present}%
    \fi
  }{%
    \def\exp@enddate{\@formatdate{\exp@endyear}{\exp@endmonth}}%
  }%
  % Subsection header with date range
  \datedsubsection{\textbf{\exp@company}}{\exp@startdate\ --\ \exp@enddate}%
  % Role + Topic line (always English, shown in both language versions)
  \ifthenelse{\isempty{\exp@role}}{}{%
    \role{\exp@role}{%
      \ifthenelse{\isempty{\exp@topic}}{}{\textbf{\textit{Topic:\ \exp@topic}}}%
    }%
  }%
  \begin{enumerate}
}{%
  \end{enumerate}
}

% \biitem{Chinese content}{English content}
% Outputs the appropriate item based on current language mode
\newcommand{\biitem}[2]{%
  \iflangcn
    \item #1%
  \else
    \item #2%
  \fi
}

% \biline{Chinese content}{English content}
% Outputs a plain (non-list) bilingual line
\newcommand{\biline}[2]{%
  \iflangcn #1\else #2\fi
}

% ============================================================
% Bilingual Education Environment
% ============================================================
\define@key{edu}{cn-school}  {\def\edu@cnschool{#1}}
\define@key{edu}{en-school}  {\def\edu@enschool{#1}}
\define@key{edu}{cn-location}{\def\edu@cnlocation{#1}}
\define@key{edu}{en-location}{\def\edu@enlocation{#1}}
\define@key{edu}{start-year} {\def\edu@startyear{#1}}
\define@key{edu}{start-month}{\def\edu@startmonth{#1}}
\define@key{edu}{end-year}   {\def\edu@endyear{#1}}
\define@key{edu}{end-month}  {\def\edu@endmonth{#1}}
\define@key{edu}{ongoing}    {\def\edu@ongoing{#1}}

% Usage:
%   \begin{education}{
%     cn-school   = {西安交通大学},  en-school   = {XJTU},
%     cn-location = {西安, 陕西},    en-location = {Xi'an, China},
%     start-year  = 2025, start-month = 9,
%     ongoing     = true,
%   }
%   \biline{\textit{在读研究生}\ 计算机技术}{\textit{M.Eng.} in Computer Technology}
%   \end{education}
\newenvironment{education}[1]{%
  \def\edu@cnlocation{}\def\edu@enlocation{}%
  \def\edu@endyear{}\def\edu@endmonth{}\def\edu@ongoing{false}%
  \setkeys{edu}{#1}%
  \iflangcn
    \def\edu@school{\edu@cnschool}%
    \def\edu@loc{\edu@cnlocation}%
  \else
    \def\edu@school{\edu@enschool}%
    \def\edu@loc{\edu@enlocation}%
  \fi
  \def\edu@startdate{\@formatdate{\edu@startyear}{\edu@startmonth}}%
  \ifthenelse{\equal{\edu@ongoing}{true}}{%
    \iflangcn\def\edu@enddate{至今}\else\def\edu@enddate{Present}\fi
  }{%
    \def\edu@enddate{\@formatdate{\edu@endyear}{\edu@endmonth}}%
  }%
  \ifthenelse{\isempty{\edu@loc}}{%
    \datedsubsection{\textbf{\edu@school}}{\edu@startdate\ --\ \edu@enddate}%
  }{%
    \datedsubsection{\textbf{\edu@school},\ \edu@loc}{\edu@startdate\ --\ \edu@enddate}%
  }%
  \ignorespaces
}{%
  \ignorespacesafterend
}

% ============================================================
% Bilingual Award Line
% ============================================================
% \biaward{cn-text}{en-text}{year}{month}
\newcommand{\biaward}[4]{%
  \iflangcn
    \item \textcolor{gray76}{\textbf{[#3]}}\ #1%
  \else
    \item \textcolor{gray76}{\textbf{[#3]}}\ #2%
  \fi
}
