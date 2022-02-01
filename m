Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18B14A53AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiBAAEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiBAAEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:04:44 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07F7C061714;
        Mon, 31 Jan 2022 16:04:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k17so14034206plk.0;
        Mon, 31 Jan 2022 16:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CEEo2n33BUrBfLTjQUqFbQ013BsFfsxgxTbhBfnlILU=;
        b=jsqoWp3F7r7B6FaiIB2/L3BmTS37N3WZj8qUxWpLd4lbL0WffX4t7Xhhbkb8+wSs9r
         M20NVdIf1Lfocd97Zo2FBm+kZGD9fLYqHYXT9lWfHuz+f/00oUdPH1PVN3PkSCVvvYsa
         Msu2L35exs1rXtIBk22Xd9wE748g3nqTfLqNYDEid8IVp4qWY6ovemh+gkTKvQDooMuF
         E7eXjv9pzKL72acDUNhvD0Pn+2EIXr77/P0VcNB7XPEE07oYIiwceCq+7/911NThFFWo
         +xVxqyVHV2A1CNFsCIMkZswBZOn8K+AnsxX/w29gkBhkFWDmPdyKzK1jonweHK/294WN
         dfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CEEo2n33BUrBfLTjQUqFbQ013BsFfsxgxTbhBfnlILU=;
        b=ymusOtPkUAMD+qhDUrTfOGkyD9mZhI9P+eoHbK8xH8KrPoLYYILdrO7Zw1Hd64De70
         HWyMOxdWqQ2W4wXTB06A5+08e2x4CTfwXqrkkEpGSIVfoRdL5dGe0eM6jB6Nh0zHzBlz
         6gFyX0+6gFrS1em0QETUlwP/aOGvu1mdtFUA/QgCzFOEEd4LbQkaaJC2ZJ1PPmrmAmSt
         wbZ3iDGgWe/nfEK0eltS8CqB73OQG20OIeuWIl0VES7s5kCIBxRAclzbqK8HLtrEDvCy
         jAsH0RCXymBq1poSrQKKbhQGjhv6TmfeU5MHhRj+MtGwp41L39WfsD8mxrx2BTfMhRPb
         Ht8w==
X-Gm-Message-State: AOAM530Wyor3zLjpYzlZcQwZZ88SrKFWRNAwAHBmA5+0HHE7i2tYF6UM
        ijdSgPwyCccNJirUBi2QbHM=
X-Google-Smtp-Source: ABdhPJw9vUT4PgB56q99z2nirH/GgAnDdBqkKOExaJex6C22nDbqZEytFnY96ws2OA7Z0+YC7FWz1w==
X-Received: by 2002:a17:902:da8b:: with SMTP id j11mr23435910plx.90.1643673884221;
        Mon, 31 Jan 2022 16:04:44 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id mi11sm396601pjb.37.2022.01.31.16.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 16:04:43 -0800 (PST)
Message-ID: <3359ca41-b81d-b2c7-e437-7618efbe241d@gmail.com>
Date:   Tue, 1 Feb 2022 09:04:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: [PATCH 4/5] docs/translations: Skip CJK contents if suitable fonts
 not found
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b5b948b7-8e41-3bd6-1a52-44785c89c965@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems without "Noto Sans CJK" fonts, CJK chapters in
translations.pdf are full of "TOFU" boxes, with a long build time and
a large log file containing lots of missing-font warnings.

Avoid such waste of time and resources by skipping CJK chapters when
CJK fonts are not available.

To skip whole chapters, change the definition of
\kerneldocBegin{SC|TC|KR|JP} commands so that they can have an argument
to be ignored.
This works as far as the argument (#1) is not used in the command.
In place of skipped contents, put a note on skipped contents at the
beginning of the PDF.

Change the call sites in index.rst of CJK translations accordingly.

When CJK fonts are available, existing command definitions with
no argument just work.  LaTeX engine will see additional pairs of
"{" and "}", which add a level of grouping without having any effect
on typesetting.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py                      | 13 +++++++++----
 Documentation/translations/ja_JP/index.rst |  4 ++--
 Documentation/translations/ko_KR/index.rst |  5 ++---
 Documentation/translations/zh_CN/index.rst |  4 ++--
 Documentation/translations/zh_TW/index.rst |  4 ++--
 5 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index ded49b8e9bf6..62cd0e472b3b 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -563,13 +563,18 @@ latex_elements['preamble']  +=3D '''
 	% Custom macros to on/off CJK (Dummy)
 	\\newcommand{\\kerneldocCJKon}{}
 	\\newcommand{\\kerneldocCJKoff}{}
-	\\newcommand{\\kerneldocBeginSC}{}
+	\\newcommand{\\kerneldocBeginSC}[1]{%
+	    \\begin{sphinxadmonition}{note}{Note:}
+		``Noto Sans CJK'' fonts are not found while building this PDF\\@.
+		Translations of zh\\_CN, zh\\_TW, ko\\_KR, and ja\\_JP are
+		skipped.
+	    \\end{sphinxadmonition}}
 	\\newcommand{\\kerneldocEndSC}{}
-	\\newcommand{\\kerneldocBeginTC}{}
+	\\newcommand{\\kerneldocBeginTC}[1]{}
 	\\newcommand{\\kerneldocEndTC}{}
-	\\newcommand{\\kerneldocBeginKR}{}
+	\\newcommand{\\kerneldocBeginKR}[1]{}
 	\\newcommand{\\kerneldocEndKR}{}
-	\\newcommand{\\kerneldocBeginJP}{}
+	\\newcommand{\\kerneldocBeginJP}[1]{}
 	\\newcommand{\\kerneldocEndJP}{}
     }
 '''
diff --git a/Documentation/translations/ja_JP/index.rst b/Documentation/t=
ranslations/ja_JP/index.rst
index 88d4d98eed15..20738c931d02 100644
--- a/Documentation/translations/ja_JP/index.rst
+++ b/Documentation/translations/ja_JP/index.rst
@@ -3,7 +3,7 @@
 	\renewcommand\thesection*
 	\renewcommand\thesubsection*
 	\kerneldocCJKon
-	\kerneldocBeginJP
+	\kerneldocBeginJP{
=20
 Japanese translations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -15,4 +15,4 @@ Japanese translations
=20
 .. raw:: latex
=20
-	\kerneldocEndJP
+	}\kerneldocEndJP
diff --git a/Documentation/translations/ko_KR/index.rst b/Documentation/t=
ranslations/ko_KR/index.rst
index f636b482fb4c..4add6b2fe1f2 100644
--- a/Documentation/translations/ko_KR/index.rst
+++ b/Documentation/translations/ko_KR/index.rst
@@ -3,7 +3,7 @@
 	\renewcommand\thesection*
 	\renewcommand\thesubsection*
 	\kerneldocCJKon
-	\kerneldocBeginKR
+	\kerneldocBeginKR{
=20
 =ED=95=9C=EA=B5=AD=EC=96=B4 =EB=B2=88=EC=97=AD
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -26,5 +26,4 @@
=20
 .. raw:: latex
=20
-    \normalsize
-    \kerneldocEndKR
+    }\kerneldocEndKR
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/t=
ranslations/zh_CN/index.rst
index 46e14ec9963d..3d8e130a5a92 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -5,7 +5,7 @@
 	\renewcommand\thesection*
 	\renewcommand\thesubsection*
 	\kerneldocCJKon
-	\kerneldocBeginSC
+	\kerneldocBeginSC{
=20
 .. _linux_doc_zh:
=20
@@ -198,4 +198,4 @@ TODOList:
=20
 .. raw:: latex
=20
-	\kerneldocEndSC
+	}\kerneldocEndSC
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/t=
ranslations/zh_TW/index.rst
index f56f78ba7860..e1ce9d8c06f8 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -5,7 +5,7 @@
 	\renewcommand\thesection*
 	\renewcommand\thesubsection*
 	\kerneldocCJKon
-	\kerneldocBeginTC
+	\kerneldocBeginTC{
=20
 .. _linux_doc_zh_tw:
=20
@@ -174,4 +174,4 @@ TODOList:
=20
 .. raw:: latex
=20
-	\kerneldocEndTC
+	}\kerneldocEndTC
--=20
2.17.1


