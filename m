Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878A358AC62
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiHEO0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbiHEO0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:26:32 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4F922515;
        Fri,  5 Aug 2022 07:26:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bf13so2788204pgb.11;
        Fri, 05 Aug 2022 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/J9uJtMk8fswjqJJI+2F/RdYBU5Fl+RhmlsOaGGHJAA=;
        b=RTLqnBc8q9hqj4XC8sQaCRGNX5qoT53WlKdoXF7hYyE1/ohzrefiGYOlfYtasjIDCy
         QD/sXUXknXXcSKBFkczM6ka+ZlZ/emuMYFliwBhD6PrC+hVblOJMefVM6kEJF+MID7Xs
         Tp+LeG73iAllx7f32H6cuMwZwFc10CzA/5mMitSeLlsB/LxaDelOwE/Z4cAeLDkcxnMY
         UjeegazX/9NyT1CYj+GWsakl9djWXBYiuwQMQMBVmdhTN1AEmmjYYP1qSpkeWAivMPDM
         4EtJ8OtWdiKFxrSd9HqtNIgZifBLy1aml4DlSizoINwsQmR//yBAdjtMaUmff043CEFS
         qjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/J9uJtMk8fswjqJJI+2F/RdYBU5Fl+RhmlsOaGGHJAA=;
        b=4/YyaQVbU8l8+RwxMGXONgkMBh5Vm54lgCaUF/Y7jHM7bvJGXPK6UnqmZgyCzIiEc0
         TrN+Td8PEPbuttD3u/inbjFs/M9zPWifFqo7MkfZGRH+2jrYgj1PoFbdCOVPf7RBvqlY
         chetoxio7TIRzsjmnmX/0dGJ6QSjCTQiNaoRkamh1piPiuWJd/qR2uEptNejaXLrqqCW
         MtkA/39ErQsM5SACltoTgjT9W8RH8acrVYgBJF8ivXEXQzm6n1GzreBsQDnOtwaGvrhG
         Tp1yaSJyIM0LAXZKxy9eWLzGK2F5V+Hnx/Rtyqwip1CZy483YL4K0Wid16YtMzeGd7m1
         92iw==
X-Gm-Message-State: ACgBeo2+HkyajKuKKIc3FiNdmY5F/5XGJEGI2oYsDZxB5TPtgQjpozSY
        3wqjBWdmDVbIURZkaSmmHVo=
X-Google-Smtp-Source: AA6agR7hReDusRnc9VbiqCn7hUq/+mjqT/W104BgtoJ05QnwcI7cvIGwu3P3gNkqwUBCAndMfyXE1w==
X-Received: by 2002:a65:5381:0:b0:415:f0ec:ac70 with SMTP id x1-20020a655381000000b00415f0ecac70mr6159294pgq.473.1659709591379;
        Fri, 05 Aug 2022 07:26:31 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b0016dd667d511sm2998311plk.252.2022.08.05.07.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 07:26:30 -0700 (PDT)
Message-ID: <484ac87f-565b-d445-0384-e6522a27fe2e@gmail.com>
Date:   Fri, 5 Aug 2022 23:26:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 3/3] docs: kerneldoc-preamble: Test xeCJK.sty before loading
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <12d078f5-6995-b039-7076-bdb1f372a799@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <12d078f5-6995-b039-7076-bdb1f372a799@gmail.com>
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
Conditionally loading xeCJK.sty depending only on the existence of
the "Noto Sans CJK SC" font might end up in xelatex error of
"xeCJK.sty not found!".

Improve the situation by testing existence of xeCJK.sty before
loading it.

This is useful on RHEL 9 and its clone distros where texlive-xecjk
doesn't work at the moment due to the missing dependency [1].
"make pdfdocs" for non-CJK contents should work after removing
texlive-xecjk.

Link: [1] https://bugzilla.redhat.com/show_bug.cgi?id=2086254
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
---
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


