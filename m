Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218794A539F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiBAAAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBAAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:00:04 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CB3C061714;
        Mon, 31 Jan 2022 16:00:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i65so14268728pfc.9;
        Mon, 31 Jan 2022 16:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pOvdxwNu0aCxPhjOkTQG4+wa9GYqirD+kwvDetyDjpk=;
        b=Sho7e8/eoHtTyCU8+A18o2EYGFcGkbVajS2+AUq75ecTJ/FzwIqwCO7QtCmbkP3D6C
         C90Fy9K+cyhpDJxx1vH3bXofZNiiGBhM52AotrcPLpmZTA+ASOsTWH2ru6qxNvFEdZgU
         egeVWjrqnpTqgmnoKT3rdp2DGmSVjI5Y519e+X6bHrEnwNW/U0s18vRI19ff7Szq4AWL
         M3XmbBX3yJXMLhOJn123ykp+GU7gANfpA51V7iRnf+nB9z/ZImbpj/l/gxQMjUpZL37S
         uY5nG4N55laW66tTHtOh2uu4d40BmmSLT1l3tNjR0isuchF++R/rWpS9btrSkI3CzUxf
         RI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pOvdxwNu0aCxPhjOkTQG4+wa9GYqirD+kwvDetyDjpk=;
        b=Vhv9IgrV1uRkpJdWZU4bhtYVxQyTJn7WdwHO4Yu/EIYyVkaDRthUXbiVdXSQIErB2X
         wiGEjpzphhvlHImESuFfNOuFZukKXgZkdLBtDDeH2Rx8kiJCUyMO7rJ3nTNsyIxhfsFe
         TAVuraXriVkNfMQOYQbl3uMAduFlia5VrTnTz45N86JVnFuqo+fZh952tJ8Ym4t6pCvw
         acDjB/WtKqewhU2+mrtuYgulspu/yCd4fb9gQ0yrLiycShQchsdLh7x5WMRUsk3ddHMX
         CTXwH+w+WpicH2VTrBDpbfHmRuyrk9sP2tPt3MpuYKTZcqggT+mEk3T6aa9LJBQCvJGy
         zu3w==
X-Gm-Message-State: AOAM530UzFqqbGIRtHlgbpiEcfEghMxfPuCV8kRu+iMa0Eb112lKng92
        pfnA1zMLWYLfWb4fzqARnGMZtiMBrAI=
X-Google-Smtp-Source: ABdhPJwnw80vuMi8nIQOiUXPls0N87Lns5agH4rI24kKwyY/obU2gdUtbkQtKicxKj3gulyq4I+Raw==
X-Received: by 2002:a62:15c3:: with SMTP id 186mr22294832pfv.59.1643673603549;
        Mon, 31 Jan 2022 16:00:03 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id pc4sm437936pjb.3.2022.01.31.16.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 16:00:02 -0800 (PST)
Message-ID: <e52b4718-7909-25be-fbc1-76800aa62ae3@gmail.com>
Date:   Tue, 1 Feb 2022 08:59:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: [PATCH 1/5] docs: pdfdocs: Tweak width params of TOC
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx has its own set of width parameters of Table of Contents (TOC)
for LaTeX defined in its class definition of sphinxmanual.cls.
It also inherits parameters for chapter entries from report.cls of
original LaTeX base.

However, they are optimized assuming small documents with tens of
pages and chapters/sections of less than 10.

To cope with some of kernel-doc documents with more than 1000
pages and several tens of chapters/sections, definitions of those
parameters need to be adjusted.

Unfortunately, those parameters are hard coded in the class
definitions and need low-level LaTeX coding tricks to redefine.

As Sphinx 1.7.9 does not have \sphinxtableofcontentshook,
which defines those parameters in later Sphinx versions,
for compatibility with both pre-1.8 and later Sphinx versions,
empty the hook altogether and redefine \@pnumwidth, \l@chapter,
\l@section, and \@subsection commands originally defined in
report.cls.

Summary of parameter changes:

  Width of page number (\@pnumwidth): 1.55em  -> 2.7em
  Width of chapter number:  1.5em -> 1.8em
  Indent of section number: 1.5em -> 1.8em
  Width of section number:  2.6em -> 3.2em
  Indent of subsection number: 4.1em -> 5em
  Width of subsection number:  3.5em -> 4.3em

Notes:
1. Parameters for subsection become relevant only when
   ":maxdepth: 3" is specified under "toctree::" (e.g., RCU/index.rst).
   They can hold subsection numbers up to 5 digits such as "18.7.13"
   (in RCU.pdf).

2. Number of chapters in driver-api.pdf is getting closer to 100.
   When it reaches 100, another set of tweaks will be necessary.

3. The low-level LaTeX trick is mentioned in "Unofficial LaTeX2e
   reference manual" at:
        http://latexref.xyz/Table-of-contents-etc_002e.html

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index f07f2e9b9f2c..e5c13dee2de8 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -409,6 +409,37 @@ latex_elements = {
 
     # Additional stuff for the LaTeX preamble.
     'preamble': '''
+	% Custom width parameters for TOC --- Redefine low-level commands
+	% defined in report.cls
+	\\makeatletter
+	%% Redefine \\@pnumwidth (page number width)
+	\\renewcommand*\\@pnumwidth{2.7em}
+	%% Redefine \\l@chapter (chapter list entry)
+	\\renewcommand*\\l@chapter[2]{%
+	  \\ifnum \\c@tocdepth >\\m@ne
+	    \\addpenalty{-\\@highpenalty}%
+	    \\vskip 1.0em \\@plus\\p@
+	    \\setlength\\@tempdima{1.8em}%
+	    \\begingroup
+	      \\parindent \\z@ \\rightskip \\@pnumwidth
+	      \\parfillskip -\\@pnumwidth
+	      \\leavevmode \\bfseries
+	      \\advance\\leftskip\\@tempdima
+	      \\hskip -\\leftskip
+	      #1\\nobreak\\hfil
+	      \\nobreak\\hb@xt@\\@pnumwidth{\\hss #2%
+	                                 \\kern-\\p@\\kern\\p@}\\par
+	      \\penalty\\@highpenalty
+	    \\endgroup
+	  \\fi}
+	%% Redefine \\l@section and \\l@subsection
+	\\renewcommand*\\l@section{\\@dottedtocline{1}{1.8em}{3.2em}}
+	\\renewcommand*\\l@subsection{\\@dottedtocline{2}{5em}{4.3em}}
+	\\makeatother
+	%% Sphinx < 1.8 doesn't have \\sphinxtableofcontentshook
+	\\providecommand{\\sphinxtableofcontentshook}{}
+	%% Undefine it for compatibility with Sphinx 1.7.9
+	\\renewcommand{\\sphinxtableofcontentshook}{} % Empty the hook
 	% Prevent column squeezing of tabulary.
 	\\setlength{\\tymin}{20em}
         % Use some font with UTF-8 support with XeLaTeX
-- 
2.17.1


