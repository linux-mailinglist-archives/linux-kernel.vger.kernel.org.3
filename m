Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C534BBA74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiBROLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:11:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbiBROLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:11:38 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5032B2E36;
        Fri, 18 Feb 2022 06:11:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so8655276pjm.2;
        Fri, 18 Feb 2022 06:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=TJHOJEnEZG6Xh9UtQolS5QzKWCInclvC6StKN5vFLE4=;
        b=pxvYWXnwBUIH4D6CLWJa4rDFnNYjdFzNMbYhSv48BVhTdyoYHyxBPTVQ1Jbz9CErLi
         UiTrWkWMohnNzRXD7/LLxgqSqXY8yD9V6mm2XzM8U9ExHBMrlxOlWSwtAewjmdzg86lU
         T0JHUSLszox5uPR+2fl3Dy+KtRfxO2WuIlAA+LJJvDuhfr1eSACBlOylsBEH4Cnswy7l
         9VJDBymY8BmPWWF+tB+tFVyJhysl28Qlje9XJCs4BjaxzxliuWlehz2YUbABPpBeU0Ia
         2gi4sJLtjWi/X3Fjh/w/TRaQlA4o6SMNQPaaIduKX9yeYkdFidLgxb6Q7nMpT3nk4c3T
         /SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=TJHOJEnEZG6Xh9UtQolS5QzKWCInclvC6StKN5vFLE4=;
        b=Mf3WgJkj1YVL/WXo0F830j7iYYnznPJIEibc8Ngr4hUXA9YhTiFQifCslbTIjthtyX
         kUTDnZ3+KqDxqO018HJ/eHf8oLQbHRe31G6XVNWitxmGdY8pE8wxLZiLZ0GlEpcTehmS
         jfcfuGBWT2AbQw3OkOHWve6M4M5Jx7jt49L3+65y3nogwBcjEpK84t2n07egLuh4foRE
         3PwqdHxk66Do/Kh5mMlL9oF/v8/2NKqYIIIK5mo2QAWBTqTRjKjkKuBIdhiDlrCJ7aRy
         a558cQcyNXytPDfCCtIZX//AzO2nhGEn7Ax3wyHjLVv4EsluJZB2/KFbWpviECUcjyqI
         pUCQ==
X-Gm-Message-State: AOAM531sYF4croP8E6wtGKtIeSS+KlgYtZHc87vNUSkXEu53wqU/Calm
        ge4BERu+w5P64cAlGdwaOuo=
X-Google-Smtp-Source: ABdhPJyNB7iynVnGvq/YkAv2yP7d8Be+XQzqpW4zgUHp4nWtKVrPcXY5lmIR1naFKNkgveV9c9ITQg==
X-Received: by 2002:a17:902:7892:b0:14e:c520:e47d with SMTP id q18-20020a170902789200b0014ec520e47dmr7526391pll.105.1645193480920;
        Fri, 18 Feb 2022 06:11:20 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id qe7sm4748814pjb.25.2022.02.18.06.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 06:11:20 -0800 (PST)
Message-ID: <aaa9dca1-27c0-c414-77f3-c5587db0cc5b@gmail.com>
Date:   Fri, 18 Feb 2022 23:11:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 1/3] docs: pdfdocs: Pull LaTeX preamble part out of conf.py
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Jon's remark [1]:

    I do notice that Documentation/conf.py is getting large and
    unapproachable.  At some future point, it might be nice to pull
    all of the latex stuff out into a separate file where it won't
    scare people who stumble into it by accident.

Pull LaTeX preamble settings added since commit 3b4c963243b1 ("docs:
conf.py: adjust the LaTeX document output") out into
sphinx/kerneldoc-preamble.sty.

It will be copied to the build directory by the added
"latex_additional_files" setting in conf.py.

As a bonus, LaTeX/TeX code can be maintained without escaping backslashes=
=2E

To compensate the loss of change history in sphinx/kerneldoc-preamble.sty=
,
here is a list of changes made in conf.py:

  - f7ebe6b76940 ("docs: Activate exCJK only in CJK chapters")
  - 0afd4df0d16a ("docs: pdfdocs: Prevent column squeezing by tabulary")
  - 659653c9e546 ("docs: pdfdocs: Refactor config for CJK document")
  - e291ff6f5a03 ("docs: pdfdocs: Add CJK-language-specific font settings=
")
  - 7eb368cc319b ("docs: pdfdocs: Choose Serif font as CJK mainfont if po=
ssible")
  - 35382965bdd2 ("docs: pdfdocs: Preserve inter-phrase space in Korean t=
ranslations")
  - 77abc2c230b1 ("docs: pdfdocs: One-half spacing for CJK translations")=

  - 788d28a25799 ("docs: pdfdocs: Permit AutoFakeSlant for CJK fonts")
  - 29ac9822358f ("docs: pdfdocs: Teach xeCJK about character classes of =
quotation marks")
  - 7c5c18bdb656 ("docs: pdfdocs: Fix typo in CJK-language specific font =
settings")
  - aa872e0647dc ("docs: pdfdocs: Adjust \headheight for fancyhdr")
  - 8716ef413aa5 ("docs: pdfdocs: Tweak width params of TOC")
  - 66939df53948 ("docs: pdfdocs: Switch default CJK font to KR variants"=
)
  - 7b686a2ea1e4 ("docs: pdfdocs: Enable CJKspace in TOC for Korean title=
s")
  - 5d9158e3c762 ("docs/translations: Skip CJK contents if suitable fonts=
 not found")
  - b774cc46313b ("docs: pdfdocs: Move CJK monospace font setting to main=
 conf.py")

[1]: https://lore.kernel.org/all/87zgmr66cn.fsf@meer.lwn.net/

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi Jon,

Pulling LaTeX preamble code out of conf.py becomes a set of three
patches.
1/3 is the essential change, 2/3 and 3/3 are comments and note message
changes.

If you don't like the way I quoted your message, please feel free to
amend/remove it.

If there arises the need to rebase some of the changes listed above,
their hashes need be amended.

        Thanks, Akira
--
 Documentation/conf.py                       | 184 ++------------------
 Documentation/sphinx/kerneldoc-preamble.sty | 184 ++++++++++++++++++++
 2 files changed, 197 insertions(+), 171 deletions(-)
 create mode 100644 Documentation/sphinx/kerneldoc-preamble.sty

diff --git a/Documentation/conf.py b/Documentation/conf.py
index fb8f69fc4d38..072ee31a301d 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -409,188 +409,25 @@ latex_elements =3D {
=20
     # Additional stuff for the LaTeX preamble.
     'preamble': '''
-	% Custom width parameters for TOC --- Redefine low-level commands
-	% defined in report.cls
-	\\makeatletter
-	%% Redefine \\@pnumwidth (page number width)
-	\\renewcommand*\\@pnumwidth{2.7em}
-	%% Redefine \\l@chapter (chapter list entry)
-	\\renewcommand*\\l@chapter[2]{%
-	  \\ifnum \\c@tocdepth >\\m@ne
-	    \\addpenalty{-\\@highpenalty}%
-	    \\vskip 1.0em \\@plus\\p@
-	    \\setlength\\@tempdima{1.8em}%
-	    \\begingroup
-	      \\parindent \\z@ \\rightskip \\@pnumwidth
-	      \\parfillskip -\\@pnumwidth
-	      \\leavevmode \\bfseries
-	      \\advance\\leftskip\\@tempdima
-	      \\hskip -\\leftskip
-	      #1\\nobreak\\hfil
-	      \\nobreak\\hb@xt@\\@pnumwidth{\\hss #2%
-	                                 \\kern-\\p@\\kern\\p@}\\par
-	      \\penalty\\@highpenalty
-	    \\endgroup
-	  \\fi}
-	%% Redefine \\l@section and \\l@subsection
-	\\renewcommand*\\l@section{\\@dottedtocline{1}{1.8em}{3.2em}}
-	\\renewcommand*\\l@subsection{\\@dottedtocline{2}{5em}{4.3em}}
-	\\makeatother
-	%% Sphinx < 1.8 doesn't have \\sphinxtableofcontentshook
-	\\providecommand{\\sphinxtableofcontentshook}{}
-	%% Undefine it for compatibility with Sphinx 1.7.9
-	\\renewcommand{\\sphinxtableofcontentshook}{} % Empty the hook
-	% Prevent column squeezing of tabulary.
-	\\setlength{\\tymin}{20em}
         % Use some font with UTF-8 support with XeLaTeX
         \\usepackage{fontspec}
         \\setsansfont{DejaVu Sans}
         \\setromanfont{DejaVu Serif}
         \\setmonofont{DejaVu Sans Mono}
-        % Adjust \\headheight for fancyhdr
-        \\addtolength{\\headheight}{1.6pt}
-        \\addtolength{\\topmargin}{-1.6pt}
-     ''',
+    ''',
 }
=20
-# Translations have Asian (CJK) characters which are only displayed if
-# xeCJK is used
-
-latex_elements['preamble']  +=3D '''
-    \\IfFontExistsTF{Noto Sans CJK SC}{
-	% This is needed for translations
-	\\usepackage{xeCJK}
-	\\IfFontExistsTF{Noto Serif CJK KR}{
-	    \\setCJKmainfont{Noto Serif CJK KR}[AutoFakeSlant]
-	}{
-	    \\setCJKmainfont{Noto Sans CJK KR}[AutoFakeSlant]
-	}
-	\\setCJKsansfont{Noto Sans CJK KR}[AutoFakeSlant]
-	\\setCJKmonofont{Noto Sans Mono CJK KR}[AutoFakeSlant]
-	\\xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}
-	\\xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}
-	% CJK Language-specific font choices
-	\\IfFontExistsTF{Noto Serif CJK SC}{
-	    \\newCJKfontfamily[SCmain]\\scmain{Noto Serif CJK SC}[AutoFakeSlant=
]
-	    \\newCJKfontfamily[SCserif]\\scserif{Noto Serif CJK SC}[AutoFakeSla=
nt]
-	}{
-	    \\newCJKfontfamily[SCmain]\\scmain{Noto Sans CJK SC}[AutoFakeSlant]=

-	    \\newCJKfontfamily[SCserif]\\scserif{Noto Sans CJK SC}[AutoFakeSlan=
t]
-	}
-	\\newCJKfontfamily[SCsans]\\scsans{Noto Sans CJK SC}[AutoFakeSlant]
-	\\newCJKfontfamily[SCmono]\\scmono{Noto Sans Mono CJK SC}[AutoFakeSlant=
]
-	\\IfFontExistsTF{Noto Serif CJK TC}{
-	    \\newCJKfontfamily[TCmain]\\tcmain{Noto Serif CJK TC}[AutoFakeSlant=
]
-	    \\newCJKfontfamily[TCserif]\\tcserif{Noto Serif CJK TC}[AutoFakeSla=
nt]
-	}{
-	    \\newCJKfontfamily[TCmain]\\tcmain{Noto Sans CJK TC}[AutoFakeSlant]=

-	    \\newCJKfontfamily[TCserif]\\tcserif{Noto Sans CJK TC}[AutoFakeSlan=
t]
-	}
-	\\newCJKfontfamily[TCsans]\\tcsans{Noto Sans CJK TC}[AutoFakeSlant]
-	\\newCJKfontfamily[TCmono]\\tcmono{Noto Sans Mono CJK TC}[AutoFakeSlant=
]
-	\\IfFontExistsTF{Noto Serif CJK KR}{
-	    \\newCJKfontfamily[KRmain]\\krmain{Noto Serif CJK KR}[AutoFakeSlant=
]
-	    \\newCJKfontfamily[KRserif]\\krserif{Noto Serif CJK KR}[AutoFakeSla=
nt]
-	}{
-	    \\newCJKfontfamily[KRmain]\\krmain{Noto Sans CJK KR}[AutoFakeSlant]=

-	    \\newCJKfontfamily[KRserif]\\krserif{Noto Sans CJK KR}[AutoFakeSlan=
t]
-	}
-	\\newCJKfontfamily[KRsans]\\krsans{Noto Sans CJK KR}[AutoFakeSlant]
-	\\newCJKfontfamily[KRmono]\\krmono{Noto Sans Mono CJK KR}[AutoFakeSlant=
]
-	\\IfFontExistsTF{Noto Serif CJK JP}{
-	    \\newCJKfontfamily[JPmain]\\jpmain{Noto Serif CJK JP}[AutoFakeSlant=
]
-	    \\newCJKfontfamily[JPserif]\\jpserif{Noto Serif CJK JP}[AutoFakeSla=
nt]
-	}{
-	    \\newCJKfontfamily[JPmain]\\jpmain{Noto Sans CJK JP}[AutoFakeSlant]=

-	    \\newCJKfontfamily[JPserif]\\jpserif{Noto Sans CJK JP}[AutoFakeSlan=
t]
-	}
-	\\newCJKfontfamily[JPsans]\\jpsans{Noto Sans CJK JP}[AutoFakeSlant]
-	\\newCJKfontfamily[JPmono]\\jpmono{Noto Sans Mono CJK JP}[AutoFakeSlant=
]
-	% Dummy commands for Sphinx < 2.3 (no 'extrapackages' support)
-	\\providecommand{\\onehalfspacing}{}
-	\\providecommand{\\singlespacing}{}
-	% Define custom macros to on/off CJK
-	\\newcommand{\\kerneldocCJKon}{\\makexeCJKactive\\onehalfspacing}
-	\\newcommand{\\kerneldocCJKoff}{\\makexeCJKinactive\\singlespacing}
-	\\newcommand{\\kerneldocBeginSC}{%
-	    \\begingroup%
-	    \\scmain%
-	    \\xeCJKDeclareCharClass{FullLeft}{`=E2=80=9C,`=E2=80=98}%
-	    \\xeCJKDeclareCharClass{FullRight}{`=E2=80=9D,`=E2=80=99}%
-	    \\renewcommand{\\CJKrmdefault}{SCserif}%
-	    \\renewcommand{\\CJKsfdefault}{SCsans}%
-	    \\renewcommand{\\CJKttdefault}{SCmono}%
-	    \\xeCJKsetup{CJKspace =3D false}%
-	    % For CJK ascii-art alignment
-	    \\setmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]%
-	}
-	\\newcommand{\\kerneldocEndSC}{\\endgroup}
-	\\newcommand{\\kerneldocBeginTC}{%
-	    \\begingroup%
-	    \\tcmain%
-	    \\xeCJKDeclareCharClass{FullLeft}{`=E2=80=9C,`=E2=80=98}%
-	    \\xeCJKDeclareCharClass{FullRight}{`=E2=80=9D,`=E2=80=99}%
-	    \\renewcommand{\\CJKrmdefault}{TCserif}%
-	    \\renewcommand{\\CJKsfdefault}{TCsans}%
-	    \\renewcommand{\\CJKttdefault}{TCmono}%
-	    \\xeCJKsetup{CJKspace =3D false}%
-	    % For CJK ascii-art alignment
-	    \\setmonofont{Noto Sans Mono CJK TC}[AutoFakeSlant]%
-	}
-	\\newcommand{\\kerneldocEndTC}{\\endgroup}
-	\\newcommand{\\kerneldocBeginKR}{%
-	    \\begingroup%
-	    \\krmain%
-	    \\renewcommand{\\CJKrmdefault}{KRserif}%
-	    \\renewcommand{\\CJKsfdefault}{KRsans}%
-	    \\renewcommand{\\CJKttdefault}{KRmono}%
-	    % \\xeCJKsetup{CJKspace =3D true} % true by default
-	    % For CJK ascii-art alignment (still misaligned for Hangul)
-	    \\setmonofont{Noto Sans Mono CJK KR}[AutoFakeSlant]%
-	}
-	\\newcommand{\\kerneldocEndKR}{\\endgroup}
-	\\newcommand{\\kerneldocBeginJP}{%
-	    \\begingroup%
-	    \\jpmain%
-	    \\renewcommand{\\CJKrmdefault}{JPserif}%
-	    \\renewcommand{\\CJKsfdefault}{JPsans}%
-	    \\renewcommand{\\CJKttdefault}{JPmono}%
-	    \\xeCJKsetup{CJKspace =3D false}%
-	    % For CJK ascii-art alignment
-	    \\setmonofont{Noto Sans Mono CJK JP}[AutoFakeSlant]%
-	}
-	\\newcommand{\\kerneldocEndJP}{\\endgroup}
-	% Single spacing in literal blocks
-	\\fvset{baselinestretch=3D1}
-	% To customize \\sphinxtableofcontents
-	\\usepackage{etoolbox}
-	% Inactivate CJK after tableofcontents
-	\\apptocmd{\\sphinxtableofcontents}{\\kerneldocCJKoff}{}{}
-	\\xeCJKsetup{CJKspace =3D true} % For inter-phrase space of Korean TOC
-    }{ % No CJK font found
-	% Custom macros to on/off CJK (Dummy)
-	\\newcommand{\\kerneldocCJKon}{}
-	\\newcommand{\\kerneldocCJKoff}{}
-	\\newcommand{\\kerneldocBeginSC}[1]{%
-	    \\begin{sphinxadmonition}{note}{Note:}
-		``Noto Sans CJK'' fonts are not found while building this PDF\\@.
-		Translations of zh\\_CN, zh\\_TW, ko\\_KR, and ja\\_JP are
-		skipped.
-	    \\end{sphinxadmonition}}
-	\\newcommand{\\kerneldocEndSC}{}
-	\\newcommand{\\kerneldocBeginTC}[1]{}
-	\\newcommand{\\kerneldocEndTC}{}
-	\\newcommand{\\kerneldocBeginKR}[1]{}
-	\\newcommand{\\kerneldocEndKR}{}
-	\\newcommand{\\kerneldocBeginJP}[1]{}
-	\\newcommand{\\kerneldocEndJP}{}
-    }
-'''
-
 # Fix reference escape troubles with Sphinx 1.4.x
 if major =3D=3D 1:
     latex_elements['preamble']  +=3D '\\renewcommand*{\\DUrole}[2]{ #2 }=
\n'
=20
+
+# Load kerneldoc specific LaTeX settings
+latex_elements['preamble'] +=3D '''
+        % Load kerneldoc specific LaTeX settings
+	\\input{kerneldoc-preamble.sty}
+'''
+
 # With Sphinx 1.6, it is possible to change the Bg color directly
 # by using:
 #	\definecolor{sphinxnoteBgColor}{RGB}{204,255,255}
@@ -652,6 +489,11 @@ for fn in os.listdir('.'):
 # If false, no module index is generated.
 #latex_domain_indices =3D True
=20
+# Additional LaTeX stuff to be copied to build directory
+latex_additional_files =3D [
+    'sphinx/kerneldoc-preamble.sty',
+]
+
=20
 # -- Options for manual page output ------------------------------------=
---
=20
diff --git a/Documentation/sphinx/kerneldoc-preamble.sty b/Documentation/=
sphinx/kerneldoc-preamble.sty
new file mode 100644
index 000000000000..4e56ccea1dbd
--- /dev/null
+++ b/Documentation/sphinx/kerneldoc-preamble.sty
@@ -0,0 +1,184 @@
+% -*- coding: utf-8 -*-
+% SPDX-License-Identifier: GPL-2.0
+%
+% LaTeX preamble for "make latexdocs" or "make pdfdocs" including:
+%   - TOC width settings
+%   - Setting of tabulary (\tymin)
+%   - Headheight setting for fancyhdr
+%   - Fontfamily settings for CJK (Chinese, Japanese, and Korean) transl=
ations
+%
+% Note on the suffix of .sty:
+%   This is not implemented as a LaTeX style file, but as a file contain=
ing
+%   plain LaTeX code to be included into preamble.
+%   ".sty" is chosen because ".tex" would cause the build scripts to con=
fuse
+%   this file with a LaTeX main file.
+%
+% Copyright (C) 2022  Akira Yokosawa
+
+% Custom width parameters for TOC --- Redefine low-level commands
+% defined in report.cls
+\makeatletter
+%% Redefine \@pnumwidth (page number width)
+\renewcommand*\@pnumwidth{2.7em}
+%% Redefine \l@chapter (chapter list entry)
+\renewcommand*\l@chapter[2]{%
+  \ifnum \c@tocdepth >\m@ne
+    \addpenalty{-\@highpenalty}%
+    \vskip 1.0em \@plus\p@
+    \setlength\@tempdima{1.8em}%
+    \begingroup
+      \parindent \z@ \rightskip \@pnumwidth
+      \parfillskip -\@pnumwidth
+      \leavevmode \bfseries
+      \advance\leftskip\@tempdima
+      \hskip -\leftskip
+      #1\nobreak\hfil
+      \nobreak\hb@xt@\@pnumwidth{\hss #2%
+                                 \kern-\p@\kern\p@}\par
+      \penalty\@highpenalty
+    \endgroup
+  \fi}
+%% Redefine \l@section and \l@subsection
+\renewcommand*\l@section{\@dottedtocline{1}{1.8em}{3.2em}}
+\renewcommand*\l@subsection{\@dottedtocline{2}{5em}{4.3em}}
+\makeatother
+%% Sphinx < 1.8 doesn't have \sphinxtableofcontentshook
+\providecommand{\sphinxtableofcontentshook}{}
+%% Undefine it for compatibility with Sphinx 1.7.9
+\renewcommand{\sphinxtableofcontentshook}{} % Empty the hook
+% Prevent column squeezing of tabulary.
+\setlength{\tymin}{20em}
+
+% Adjust \headheight for fancyhdr
+\addtolength{\headheight}{1.6pt}
+\addtolength{\topmargin}{-1.6pt}
+
+% Translations have Asian (CJK) characters which are only displayed if
+% xeCJK is used
+\IfFontExistsTF{Noto Sans CJK SC}{
+    % This is needed for translations
+    \usepackage{xeCJK}
+    \IfFontExistsTF{Noto Serif CJK KR}{
+	\setCJKmainfont{Noto Serif CJK KR}[AutoFakeSlant]
+    }{
+	\setCJKmainfont{Noto Sans CJK KR}[AutoFakeSlant]
+    }
+    \setCJKsansfont{Noto Sans CJK KR}[AutoFakeSlant]
+    \setCJKmonofont{Noto Sans Mono CJK KR}[AutoFakeSlant]
+    \xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}
+    \xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}
+    % CJK Language-specific font choices
+    \IfFontExistsTF{Noto Serif CJK SC}{
+	\newCJKfontfamily[SCmain]\scmain{Noto Serif CJK SC}[AutoFakeSlant]
+	\newCJKfontfamily[SCserif]\scserif{Noto Serif CJK SC}[AutoFakeSlant]
+    }{
+	\newCJKfontfamily[SCmain]\scmain{Noto Sans CJK SC}[AutoFakeSlant]
+	\newCJKfontfamily[SCserif]\scserif{Noto Sans CJK SC}[AutoFakeSlant]
+    }
+    \newCJKfontfamily[SCsans]\scsans{Noto Sans CJK SC}[AutoFakeSlant]
+    \newCJKfontfamily[SCmono]\scmono{Noto Sans Mono CJK SC}[AutoFakeSlan=
t]
+    \IfFontExistsTF{Noto Serif CJK TC}{
+	\newCJKfontfamily[TCmain]\tcmain{Noto Serif CJK TC}[AutoFakeSlant]
+	\newCJKfontfamily[TCserif]\tcserif{Noto Serif CJK TC}[AutoFakeSlant]
+    }{
+	\newCJKfontfamily[TCmain]\tcmain{Noto Sans CJK TC}[AutoFakeSlant]
+	\newCJKfontfamily[TCserif]\tcserif{Noto Sans CJK TC}[AutoFakeSlant]
+    }
+    \newCJKfontfamily[TCsans]\tcsans{Noto Sans CJK TC}[AutoFakeSlant]
+    \newCJKfontfamily[TCmono]\tcmono{Noto Sans Mono CJK TC}[AutoFakeSlan=
t]
+    \IfFontExistsTF{Noto Serif CJK KR}{
+	\newCJKfontfamily[KRmain]\krmain{Noto Serif CJK KR}[AutoFakeSlant]
+	\newCJKfontfamily[KRserif]\krserif{Noto Serif CJK KR}[AutoFakeSlant]
+    }{
+	\newCJKfontfamily[KRmain]\krmain{Noto Sans CJK KR}[AutoFakeSlant]
+	\newCJKfontfamily[KRserif]\krserif{Noto Sans CJK KR}[AutoFakeSlant]
+    }
+    \newCJKfontfamily[KRsans]\krsans{Noto Sans CJK KR}[AutoFakeSlant]
+    \newCJKfontfamily[KRmono]\krmono{Noto Sans Mono CJK KR}[AutoFakeSlan=
t]
+    \IfFontExistsTF{Noto Serif CJK JP}{
+	\newCJKfontfamily[JPmain]\jpmain{Noto Serif CJK JP}[AutoFakeSlant]
+	\newCJKfontfamily[JPserif]\jpserif{Noto Serif CJK JP}[AutoFakeSlant]
+    }{
+	\newCJKfontfamily[JPmain]\jpmain{Noto Sans CJK JP}[AutoFakeSlant]
+	\newCJKfontfamily[JPserif]\jpserif{Noto Sans CJK JP}[AutoFakeSlant]
+    }
+    \newCJKfontfamily[JPsans]\jpsans{Noto Sans CJK JP}[AutoFakeSlant]
+    \newCJKfontfamily[JPmono]\jpmono{Noto Sans Mono CJK JP}[AutoFakeSlan=
t]
+    % Dummy commands for Sphinx < 2.3 (no 'extrapackages' support)
+    \providecommand{\onehalfspacing}{}
+    \providecommand{\singlespacing}{}
+    % Define custom macros to on/off CJK
+    \newcommand{\kerneldocCJKon}{\makexeCJKactive\onehalfspacing}
+    \newcommand{\kerneldocCJKoff}{\makexeCJKinactive\singlespacing}
+    \newcommand{\kerneldocBeginSC}{%
+	\begingroup%
+	\scmain%
+	\xeCJKDeclareCharClass{FullLeft}{`=E2=80=9C,`=E2=80=98}%
+	\xeCJKDeclareCharClass{FullRight}{`=E2=80=9D,`=E2=80=99}%
+	\renewcommand{\CJKrmdefault}{SCserif}%
+	\renewcommand{\CJKsfdefault}{SCsans}%
+	\renewcommand{\CJKttdefault}{SCmono}%
+	\xeCJKsetup{CJKspace =3D false}%
+	% For CJK ascii-art alignment
+	\setmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]%
+    }
+    \newcommand{\kerneldocEndSC}{\endgroup}
+    \newcommand{\kerneldocBeginTC}{%
+	\begingroup%
+	\tcmain%
+	\xeCJKDeclareCharClass{FullLeft}{`=E2=80=9C,`=E2=80=98}%
+	\xeCJKDeclareCharClass{FullRight}{`=E2=80=9D,`=E2=80=99}%
+	\renewcommand{\CJKrmdefault}{TCserif}%
+	\renewcommand{\CJKsfdefault}{TCsans}%
+	\renewcommand{\CJKttdefault}{TCmono}%
+	\xeCJKsetup{CJKspace =3D false}%
+	% For CJK ascii-art alignment
+	\setmonofont{Noto Sans Mono CJK TC}[AutoFakeSlant]%
+    }
+    \newcommand{\kerneldocEndTC}{\endgroup}
+    \newcommand{\kerneldocBeginKR}{%
+	\begingroup%
+	\krmain%
+	\renewcommand{\CJKrmdefault}{KRserif}%
+	\renewcommand{\CJKsfdefault}{KRsans}%
+	\renewcommand{\CJKttdefault}{KRmono}%
+	% \xeCJKsetup{CJKspace =3D true} % true by default
+	% For CJK ascii-art alignment (still misaligned for Hangul)
+	\setmonofont{Noto Sans Mono CJK KR}[AutoFakeSlant]%
+    }
+    \newcommand{\kerneldocEndKR}{\endgroup}
+    \newcommand{\kerneldocBeginJP}{%
+	\begingroup%
+	\jpmain%
+	\renewcommand{\CJKrmdefault}{JPserif}%
+	\renewcommand{\CJKsfdefault}{JPsans}%
+	\renewcommand{\CJKttdefault}{JPmono}%
+	\xeCJKsetup{CJKspace =3D false}%
+	% For CJK ascii-art alignment
+	\setmonofont{Noto Sans Mono CJK JP}[AutoFakeSlant]%
+    }
+    \newcommand{\kerneldocEndJP}{\endgroup}
+    % Single spacing in literal blocks
+    \fvset{baselinestretch=3D1}
+    % To customize \sphinxtableofcontents
+    \usepackage{etoolbox}
+    % Inactivate CJK after tableofcontents
+    \apptocmd{\sphinxtableofcontents}{\kerneldocCJKoff}{}{}
+    \xeCJKsetup{CJKspace =3D true} % For inter-phrase space of Korean TO=
C
+}{ % No CJK font found
+    % Custom macros to on/off CJK (Dummy)
+    \newcommand{\kerneldocCJKon}{}
+    \newcommand{\kerneldocCJKoff}{}
+    \newcommand{\kerneldocBeginSC}[1]{%
+	\begin{sphinxadmonition}{note}{Note:}
+	    ``Noto Sans CJK'' fonts are not found while building this PDF\@.
+	    Translations of zh\_CN, zh\_TW, ko\_KR, and ja\_JP are skipped.
+	\end{sphinxadmonition}}
+    \newcommand{\kerneldocEndSC}{}
+    \newcommand{\kerneldocBeginTC}[1]{}
+    \newcommand{\kerneldocEndTC}{}
+    \newcommand{\kerneldocBeginKR}[1]{}
+    \newcommand{\kerneldocEndKR}{}
+    \newcommand{\kerneldocBeginJP}[1]{}
+    \newcommand{\kerneldocEndJP}{}
+}

base-commit: b62ef3a1cca0553613adce16515f3640400725b4
--=20
2.17.1

