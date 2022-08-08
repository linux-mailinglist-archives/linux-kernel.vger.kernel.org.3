Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8432658C51A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbiHHIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbiHHIyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:54:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB513E38;
        Mon,  8 Aug 2022 01:54:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id m2so7967785pls.4;
        Mon, 08 Aug 2022 01:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=89RXExJvICSdGLslAQ+t5/WCvotGC3pEcqn9PBFWRu8=;
        b=KeKpTWsRUHIOzuDbn0dVtsxGdBBxXqTgwdHV7hmaCDUaZyKhU4M8oW9E+D2XQRZC5l
         yVth9gnxB3uZB394DZp5OMUKKsnQaajdzEV8oYOYEIxsWAQ4XKotImR4x0bU+NAlB283
         mLd+x4xnLac+wj5EnJHKejB6/Vpt6LiPoJsefE271USQVXVs29tu20X8LDfPYvU1g9Gj
         IcDukjidWM4v21u4KoDVIxDDgK8zw3xDjyAkhrJpB9ZTMjBFP+E59bwlfGe6rtxoHATQ
         O7ALj/8mtifQU26prXNaJQrJI+FG7TN0zTHiVUyCiYLl3xgNHz/9N+vei0jpHlrW5OES
         Ur8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=89RXExJvICSdGLslAQ+t5/WCvotGC3pEcqn9PBFWRu8=;
        b=Cve2Xqmg4r3o1QdUOZfIY30+0DFTUvD/6xFQjLFQnfEk/ZDQlWFL5nQDiUO/x1U52F
         9MsFN1D2FcTTjxS1Yr199iLOH1L2xeEkgRX84HypHzQSijx2Pn1PbuyDg/tup9qzvm47
         DScWutoYaP+d3ujippljFeai9aEyq8jfhQaIMknOW5qdhNWSLzwmrp9dQwd+RkidDGyB
         sy3nm7Cc1g/+Q0FFZKxKq8f6hFawSsFDS3eKoi9mI3qSjS/t6ZN3P6hmYO7OXQkNg6GK
         mb+DP2dVtmrVydhw1yPZMBwIhp3FgkhjtBJZUEqUXwxZt/ZBKDj2sNdtU3KG8/Be9zoD
         BMng==
X-Gm-Message-State: ACgBeo0TZNVL1vuiQOyaAUQJj8MVpIov5XRYvNnZIF3rA+309FbSRiNS
        qmvPZZIXyuJn8WJdZNa7KpI=
X-Google-Smtp-Source: AA6agR5nQdHpiWToQQjE8bHyLPjZ+oNt57nNTovn52WQM6ec8XfuEYv78ihtO6vhlE0zFF6basg9NA==
X-Received: by 2002:a17:902:8f8a:b0:170:8df4:eebd with SMTP id z10-20020a1709028f8a00b001708df4eebdmr9622323plo.116.1659948840811;
        Mon, 08 Aug 2022 01:54:00 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b0016c59b38254sm8175092pln.127.2022.08.08.01.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:54:00 -0700 (PDT)
Message-ID: <c24c2a87-70b2-5342-bcc9-de467940466e@gmail.com>
Date:   Mon, 8 Aug 2022 17:53:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH v2 3/3] docs: kerneldoc-preamble: Test xeCJK.sty before
 loading
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <c41cab17-afd6-bc99-56a1-e4e73b8c1ef6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On distros whose texlive packaging is fine-grained, texlive-xecjk
can be installed/removed independently of other texlive packages.
Conditionally loading xeCJK depending only on the existence of the
"Noto Sans CJK SC" font might end up in xelatex error of
"xeCJK.sty not found!".

Improve the situation by testing existence of xeCJK.sty before
loading it.

This is useful on RHEL 9 and its clone distros where texlive-xecjk
doesn't work at the moment due to a missing dependency [1].
"make pdfdocs" for non-CJK contents should work after removing
texlive-xecjk.

Link: [1] https://bugzilla.redhat.com/show_bug.cgi?id=2086254
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
Changes since v1:
 - Acked-by from Mauro.

--
 Documentation/sphinx/kerneldoc-preamble.sty | 22 +++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/sphinx/kerneldoc-preamble.sty b/Documentation/sphinx/kerneldoc-preamble.sty
index 2a29cbe51396..9707e033c8c4 100644
--- a/Documentation/sphinx/kerneldoc-preamble.sty
+++ b/Documentation/sphinx/kerneldoc-preamble.sty
@@ -70,8 +70,16 @@
 
 % Translations have Asian (CJK) characters which are only displayed if
 % xeCJK is used
+\usepackage{ifthen}
+\newboolean{enablecjk}
+\setboolean{enablecjk}{false}
 \IfFontExistsTF{Noto Sans CJK SC}{
-    % Load xeCJK when CJK font is available
+    \IfFileExists{xeCJK.sty}{
+	\setboolean{enablecjk}{true}
+    }{}
+}{}
+\ifthenelse{\boolean{enablecjk}}{
+    % Load xeCJK when both the Noto Sans CJK font and xeCJK.sty are available.
     \usepackage{xeCJK}
     % Noto CJK fonts don't provide slant shape. [AutoFakeSlant] permits
     % its emulation.
@@ -196,7 +204,7 @@
     % Inactivate CJK after tableofcontents
     \apptocmd{\sphinxtableofcontents}{\kerneldocCJKoff}{}{}
     \xeCJKsetup{CJKspace = true}% For inter-phrase space of Korean TOC
-}{ % No CJK font found
+}{ % Don't enable CJK
     % Custom macros to on/off CJK and switch CJK fonts (Dummy)
     \newcommand{\kerneldocCJKon}{}
     \newcommand{\kerneldocCJKoff}{}
@@ -204,14 +212,16 @@
     %% and ignore the argument (#1) in their definitions, whole contents of
     %% CJK chapters can be ignored.
     \newcommand{\kerneldocBeginSC}[1]{%
-	%% Put a note on missing CJK fonts in place of zh_CN translation.
-	\begin{sphinxadmonition}{note}{Note on missing fonts:}
+	%% Put a note on missing CJK fonts or the xecjk package in place of
+	%% zh_CN translation.
+	\begin{sphinxadmonition}{note}{Note on missing fonts and a package:}
 	    Translations of Simplified Chinese (zh\_CN), Traditional Chinese
 	    (zh\_TW), Korean (ko\_KR), and Japanese (ja\_JP) were skipped
-	    due to the lack of suitable font families.
+	    due to the lack of suitable font families and/or the texlive-xecjk
+	    package.
 
 	    If you want them, please install ``Noto Sans CJK'' font families
-	    by following instructions from
+	    along with the texlive-xecjk package by following instructions from
 	    \sphinxcode{./scripts/sphinx-pre-install}.
 	    Having optional ``Noto Serif CJK'' font families will improve
 	    the looks of those translations.
-- 
2.25.1


