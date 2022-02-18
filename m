Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9344BBA7C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbiBROOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:14:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiBROOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:14:02 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF1253BD2;
        Fri, 18 Feb 2022 06:13:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u12so7243608plf.13;
        Fri, 18 Feb 2022 06:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PIykARYKz5D/E4VeGdy3fd1R6w5FO8woGzQD6F4K/Mc=;
        b=DeHrHVfQ2592Il+wSugobuvQkEaD8QEX8TWIY/oHqUzlMeRiHrtejpTlb+tGKDHMoq
         fAmA2mpioH56uMcmb9xDRu+isbWzevzgS1d1D5dbqI0uEX1QMaGPoWVEqgyjMtIyT8tC
         JGjZprnXI9sgpUK27BqqrZ/u6LNL6DL0wv0M72t+/z1w3vnMFZCh7Scwpb14d5D7CTjU
         OPl41AqpULw0HFKZQ+B9cjtng837ZQ3XRLSOruTN22b42rLC/jdxKBhu3pgb6JJF0PvZ
         PjPAj1hUA9FGT/z7fGXwQh6nBGZUS1IjFiQgIweJPAQz7Nh4Y40SdRLXoFVDsmsKORDw
         JVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PIykARYKz5D/E4VeGdy3fd1R6w5FO8woGzQD6F4K/Mc=;
        b=6GtditdFA9j4ZB9JogrXJ2PxT9P9OPQQOvgRxR6wtj6MK96yVGqdAXftmkWqU4TfuP
         Ai7EAUQQR7TbaExGAbZ6apGQg04nxTOgHQsUeEqLJlOT4q/lP1KzE02HPvZWn7FdLZ9m
         Qg4ksuduUkGskV6wby2buBt19oiqXYqbzKSsR9BLr3v8bhDUi6kxFrHeeS33lhBieKCa
         H2rQu+SpNbw3ovomevCbz7oKVCj3XrHES1uHRBb847uXDOFOufr9eesIq6K5r+a6akuu
         eZHKvpeXvKJN3K2opgmIBAZfKhmYyeqDL7EPcF/ccjfgmI547hqpyVesKgRzAZPoZn13
         WJlA==
X-Gm-Message-State: AOAM530aSjBU4+jv9HftJJvdUuHsyK8vH7qNcBbg/sugiGsSYfimTsTC
        rPfpsRiUv7KqLd0LVdQ308hdx69tgLw=
X-Google-Smtp-Source: ABdhPJz2NEOuAUvZh30laIAPbuEU3znilgIyHpPR/53I2D500pSspyvAfiu3WtHH7kAdUBdOZpp4vA==
X-Received: by 2002:a17:90a:588c:b0:1b8:8780:5ce with SMTP id j12-20020a17090a588c00b001b8878005cemr8463935pji.187.1645193624619;
        Fri, 18 Feb 2022 06:13:44 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x1sm3267354pfh.54.2022.02.18.06.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 06:13:44 -0800 (PST)
Message-ID: <bce9261b-1950-3146-07b2-07bd2ec79158@gmail.com>
Date:   Fri, 18 Feb 2022 23:13:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: [PATCH 2/3] docs: kerneldoc-preamble.sty: Expand comments in LaTeX
 code
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <aaa9dca1-27c0-c414-77f3-c5587db0cc5b@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <aaa9dca1-27c0-c414-77f3-c5587db0cc5b@gmail.com>
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

Expand comments in LaTeX code and mention some of important points
told in changelogs of conf.py changes.
Hopefully they can help future contributors in this area.

No code change involved.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/kerneldoc-preamble.sty | 61 ++++++++++++++++-----
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/Documentation/sphinx/kerneldoc-preamble.sty b/Documentation/=
sphinx/kerneldoc-preamble.sty
index 4e56ccea1dbd..5e59900e994d 100644
--- a/Documentation/sphinx/kerneldoc-preamble.sty
+++ b/Documentation/sphinx/kerneldoc-preamble.sty
@@ -15,8 +15,20 @@
 %
 % Copyright (C) 2022  Akira Yokosawa
=20
-% Custom width parameters for TOC --- Redefine low-level commands
-% defined in report.cls
+% Custom width parameters for TOC
+%  - Redefine low-level commands defined in report.cls.
+%  - Indent of 2 chars is preserved for ease of comparison.
+% Summary of changes from default params:
+%   Width of page number (\@pnumwidth): 1.55em -> 2.7em
+%   Width of chapter number:            1.5em  -> 1.8em
+%   Indent of section number:           1.5em  -> 1.8em
+%   Width of section number:            2.6em  -> 3.2em
+%   Indent of sebsection number:        4.1em  -> 5em
+%   Width of subsection number:         3.5em  -> 4.3em
+%
+% These params can have 4 digit page counts, 2 digit chapter counts,
+% section counts of 4 digits + 1 period (e.g., 18.10), and subsection co=
unts
+% of 5 digits + 2 periods (e.g., 18.7.13).
 \makeatletter
 %% Redefine \@pnumwidth (page number width)
 \renewcommand*\@pnumwidth{2.7em}
@@ -46,7 +58,10 @@
 \providecommand{\sphinxtableofcontentshook}{}
 %% Undefine it for compatibility with Sphinx 1.7.9
 \renewcommand{\sphinxtableofcontentshook}{} % Empty the hook
-% Prevent column squeezing of tabulary.
+
+% Prevent column squeezing of tabulary.  \tymin is set by Sphinx as:
+%   \setlength{\tymin}{3\fontcharwd\font`0 }
+% , which is too short.
 \setlength{\tymin}{20em}
=20
 % Adjust \headheight for fancyhdr
@@ -56,8 +71,12 @@
 % Translations have Asian (CJK) characters which are only displayed if
 % xeCJK is used
 \IfFontExistsTF{Noto Sans CJK SC}{
-    % This is needed for translations
+    % Load xeCJK when CJK font is available
     \usepackage{xeCJK}
+    % Noto CJK fonts don't provide slant shape. [AutoFakeSlant] permits
+    % its emulation.
+    % Select KR variant at the beginning of each document so that quotat=
ion
+    % and apostorph symbols of half-width is used in TOC of Latin docume=
nts.
     \IfFontExistsTF{Noto Serif CJK KR}{
 	\setCJKmainfont{Noto Serif CJK KR}[AutoFakeSlant]
     }{
@@ -65,9 +84,11 @@
     }
     \setCJKsansfont{Noto Sans CJK KR}[AutoFakeSlant]
     \setCJKmonofont{Noto Sans Mono CJK KR}[AutoFakeSlant]
+    % Teach xeCJK of half-width symbols
     \xeCJKDeclareCharClass{HalfLeft}{`=E2=80=9C,`=E2=80=98}
     \xeCJKDeclareCharClass{HalfRight}{`=E2=80=9D,`=E2=80=99}
     % CJK Language-specific font choices
+    %% for Simplified Chinese
     \IfFontExistsTF{Noto Serif CJK SC}{
 	\newCJKfontfamily[SCmain]\scmain{Noto Serif CJK SC}[AutoFakeSlant]
 	\newCJKfontfamily[SCserif]\scserif{Noto Serif CJK SC}[AutoFakeSlant]
@@ -77,6 +98,7 @@
     }
     \newCJKfontfamily[SCsans]\scsans{Noto Sans CJK SC}[AutoFakeSlant]
     \newCJKfontfamily[SCmono]\scmono{Noto Sans Mono CJK SC}[AutoFakeSlan=
t]
+    %% for Traditional Chinese
     \IfFontExistsTF{Noto Serif CJK TC}{
 	\newCJKfontfamily[TCmain]\tcmain{Noto Serif CJK TC}[AutoFakeSlant]
 	\newCJKfontfamily[TCserif]\tcserif{Noto Serif CJK TC}[AutoFakeSlant]
@@ -86,6 +108,7 @@
     }
     \newCJKfontfamily[TCsans]\tcsans{Noto Sans CJK TC}[AutoFakeSlant]
     \newCJKfontfamily[TCmono]\tcmono{Noto Sans Mono CJK TC}[AutoFakeSlan=
t]
+    %% for Korean
     \IfFontExistsTF{Noto Serif CJK KR}{
 	\newCJKfontfamily[KRmain]\krmain{Noto Serif CJK KR}[AutoFakeSlant]
 	\newCJKfontfamily[KRserif]\krserif{Noto Serif CJK KR}[AutoFakeSlant]
@@ -95,6 +118,7 @@
     }
     \newCJKfontfamily[KRsans]\krsans{Noto Sans CJK KR}[AutoFakeSlant]
     \newCJKfontfamily[KRmono]\krmono{Noto Sans Mono CJK KR}[AutoFakeSlan=
t]
+    %% for Japanese
     \IfFontExistsTF{Noto Serif CJK JP}{
 	\newCJKfontfamily[JPmain]\jpmain{Noto Serif CJK JP}[AutoFakeSlant]
 	\newCJKfontfamily[JPserif]\jpserif{Noto Serif CJK JP}[AutoFakeSlant]
@@ -108,34 +132,39 @@
     \providecommand{\onehalfspacing}{}
     \providecommand{\singlespacing}{}
     % Define custom macros to on/off CJK
+    %% One and half spacing for CJK contents
     \newcommand{\kerneldocCJKon}{\makexeCJKactive\onehalfspacing}
     \newcommand{\kerneldocCJKoff}{\makexeCJKinactive\singlespacing}
+    % Define custom macros for switching CJK font setting
+    %% for Simplified Chinese
     \newcommand{\kerneldocBeginSC}{%
 	\begingroup%
 	\scmain%
-	\xeCJKDeclareCharClass{FullLeft}{`=E2=80=9C,`=E2=80=98}%
-	\xeCJKDeclareCharClass{FullRight}{`=E2=80=9D,`=E2=80=99}%
+	\xeCJKDeclareCharClass{FullLeft}{`=E2=80=9C,`=E2=80=98}% Full-width in =
SC
+	\xeCJKDeclareCharClass{FullRight}{`=E2=80=9D,`=E2=80=99}% Full-width in=
 SC
 	\renewcommand{\CJKrmdefault}{SCserif}%
 	\renewcommand{\CJKsfdefault}{SCsans}%
 	\renewcommand{\CJKttdefault}{SCmono}%
-	\xeCJKsetup{CJKspace =3D false}%
+	\xeCJKsetup{CJKspace =3D false}% gobble white spaces by ' '
 	% For CJK ascii-art alignment
 	\setmonofont{Noto Sans Mono CJK SC}[AutoFakeSlant]%
     }
     \newcommand{\kerneldocEndSC}{\endgroup}
+    %% for Traditional Chinese
     \newcommand{\kerneldocBeginTC}{%
 	\begingroup%
 	\tcmain%
-	\xeCJKDeclareCharClass{FullLeft}{`=E2=80=9C,`=E2=80=98}%
-	\xeCJKDeclareCharClass{FullRight}{`=E2=80=9D,`=E2=80=99}%
+	\xeCJKDeclareCharClass{FullLeft}{`=E2=80=9C,`=E2=80=98}% Full-width in =
TC
+	\xeCJKDeclareCharClass{FullRight}{`=E2=80=9D,`=E2=80=99}% Full-width in=
 TC
 	\renewcommand{\CJKrmdefault}{TCserif}%
 	\renewcommand{\CJKsfdefault}{TCsans}%
 	\renewcommand{\CJKttdefault}{TCmono}%
-	\xeCJKsetup{CJKspace =3D false}%
+	\xeCJKsetup{CJKspace =3D false}% gobble white spaces by ' '
 	% For CJK ascii-art alignment
 	\setmonofont{Noto Sans Mono CJK TC}[AutoFakeSlant]%
     }
     \newcommand{\kerneldocEndTC}{\endgroup}
+    %% for Korean
     \newcommand{\kerneldocBeginKR}{%
 	\begingroup%
 	\krmain%
@@ -147,29 +176,35 @@
 	\setmonofont{Noto Sans Mono CJK KR}[AutoFakeSlant]%
     }
     \newcommand{\kerneldocEndKR}{\endgroup}
+    %% for Japanese
     \newcommand{\kerneldocBeginJP}{%
 	\begingroup%
 	\jpmain%
 	\renewcommand{\CJKrmdefault}{JPserif}%
 	\renewcommand{\CJKsfdefault}{JPsans}%
 	\renewcommand{\CJKttdefault}{JPmono}%
-	\xeCJKsetup{CJKspace =3D false}%
+	\xeCJKsetup{CJKspace =3D false}% gobble white space by ' '
 	% For CJK ascii-art alignment
 	\setmonofont{Noto Sans Mono CJK JP}[AutoFakeSlant]%
     }
     \newcommand{\kerneldocEndJP}{\endgroup}
+
     % Single spacing in literal blocks
     \fvset{baselinestretch=3D1}
     % To customize \sphinxtableofcontents
     \usepackage{etoolbox}
     % Inactivate CJK after tableofcontents
     \apptocmd{\sphinxtableofcontents}{\kerneldocCJKoff}{}{}
-    \xeCJKsetup{CJKspace =3D true} % For inter-phrase space of Korean TO=
C
+    \xeCJKsetup{CJKspace =3D true}% For inter-phrase space of Korean TOC=

 }{ % No CJK font found
-    % Custom macros to on/off CJK (Dummy)
+    % Custom macros to on/off CJK and switch CJK fonts (Dummy)
     \newcommand{\kerneldocCJKon}{}
     \newcommand{\kerneldocCJKoff}{}
+    %% By defining \kerneldocBegin(SC|TC|KR|JP) as commands with an argu=
ment
+    %% and ignore the argument (#1) in their definitions, whole contents=
 of
+    %% CJK chapters can be ignored.
     \newcommand{\kerneldocBeginSC}[1]{%
+	%% Put a note on missing CJK fonts in place of zh_CN translation.
 	\begin{sphinxadmonition}{note}{Note:}
 	    ``Noto Sans CJK'' fonts are not found while building this PDF\@.
 	    Translations of zh\_CN, zh\_TW, ko\_KR, and ja\_JP are skipped.
--=20
2.17.1


