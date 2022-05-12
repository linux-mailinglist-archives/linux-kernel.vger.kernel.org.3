Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E955242E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244098AbiELCyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244033AbiELCyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:54:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E4F1F92A8;
        Wed, 11 May 2022 19:54:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s14so3624000plk.8;
        Wed, 11 May 2022 19:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=0ncjSUxU9ysAJVNjYh3SEKLhVjJ2NUMWUwnaCNe9M+4=;
        b=eqhv82/YtmgTASuDpV78q7NFNrgsaQkdY6OcKvUGe4H4gveR8+OuyqYb7pJArOAyS0
         y7AjyXTClc1mCZYP+LPN9ix/8PZTSjx2h5L7jnhz0ACJ/V/d47rUtf+exrPuP1FRL6Wf
         rqxo80lrMJgRh/mG3+5KKpkZyA5YiH3/rRIHEvtOakBl/cSY2DukjI4sxMs9zl22lTQN
         QH8C9SpxpBTYtQ1vkEav2VMpmMZmJGK1PgjlfzhTCZf/R3KW2wLX6p5TU78t10m86lpv
         DEFPmLz0mgiQehyO+7h13hhoDtt8ZFvTJvosExDah2Pd9QOJjY0NA5NcPBBPpR8F9lbR
         x83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=0ncjSUxU9ysAJVNjYh3SEKLhVjJ2NUMWUwnaCNe9M+4=;
        b=t/6TAgiCP1WcJL4+1f3TPj1m7/F5T5yMdpGPcPiDlLIobbS3tm9j0D/z+1HMUEGCHm
         SPjm53KJ+gx5eoKy1rtZ/kZ9GTiM1Xb4WBIFAp52Z8ECIOOF0aTKLFN/isboeW58OROH
         uBiZ7JZJV4bfzK6OEnobFl5rl2zV+O/+YSbBlh5P9rTffxSZv0fPnLoMTNSvOOkm5IBG
         bT+4DtXTbbahI/0MBKGs0nM6INzzzCQ07lOcvlFfgQy6aLjTu4JSqapuOwOMh7FSwpF0
         krjNJGG6hCIG/DGtdjSFMm/P+ryRTmojRvZKSOOcZxO+OnLvso2QQw68S+QytiKV0aVj
         bqIA==
X-Gm-Message-State: AOAM530a3IaON+eQJrBGCDjfZGLCrJqajPrp05lbJG8ywvtZhk2vgGKH
        Pw/bTpLbiFO5xbwSvweS/+8=
X-Google-Smtp-Source: ABdhPJwMI/BS05nSm+q+R3pIxryrQGUxMNCYmzDsdtMimal9fRRdt8eLWR7v9mLY91T4i3TvSwmOeA==
X-Received: by 2002:a17:902:ef50:b0:156:486f:b593 with SMTP id e16-20020a170902ef5000b00156486fb593mr28378992plx.104.1652324058050;
        Wed, 11 May 2022 19:54:18 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902b70f00b0015e8d4eb21dsm2618567pls.103.2022.05.11.19.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 19:54:17 -0700 (PDT)
Message-ID: <bdb60ba3-7813-47d0-74f9-7c31dd912d95@gmail.com>
Date:   Thu, 12 May 2022 11:54:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: pdfdocs: Add space for chapter counts >= 100 in TOC
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

It turns out that networking.pdf has exceeded 100 chapters and
titles of chapters >= 100 collide with their counts in its table
of contents (TOC).

Increase relevant params by 0.6em in the preamble to avoid such
ugly collisions.

While at it, fix a typo in comment (subsection).

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/sphinx/kerneldoc-preamble.sty | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/sphinx/kerneldoc-preamble.sty b/Documentation/sphinx/kerneldoc-preamble.sty
index 9d0204dc38be..2a29cbe51396 100644
--- a/Documentation/sphinx/kerneldoc-preamble.sty
+++ b/Documentation/sphinx/kerneldoc-preamble.sty
@@ -20,13 +20,13 @@
 %  - Indent of 2 chars is preserved for ease of comparison.
 % Summary of changes from default params:
 %   Width of page number (\@pnumwidth): 1.55em -> 2.7em
-%   Width of chapter number:            1.5em  -> 1.8em
-%   Indent of section number:           1.5em  -> 1.8em
+%   Width of chapter number:            1.5em  -> 2.4em
+%   Indent of section number:           1.5em  -> 2.4em
 %   Width of section number:            2.6em  -> 3.2em
-%   Indent of sebsection number:        4.1em  -> 5em
+%   Indent of subsection number:        4.1em  -> 5.6em
 %   Width of subsection number:         3.5em  -> 4.3em
 %
-% These params can have 4 digit page counts, 2 digit chapter counts,
+% These params can have 4 digit page counts, 3 digit chapter counts,
 % section counts of 4 digits + 1 period (e.g., 18.10), and subsection counts
 % of 5 digits + 2 periods (e.g., 18.7.13).
 \makeatletter
@@ -37,7 +37,7 @@
   \ifnum \c@tocdepth >\m@ne
     \addpenalty{-\@highpenalty}%
     \vskip 1.0em \@plus\p@
-    \setlength\@tempdima{1.8em}%
+    \setlength\@tempdima{2.4em}%
     \begingroup
       \parindent \z@ \rightskip \@pnumwidth
       \parfillskip -\@pnumwidth
@@ -51,8 +51,8 @@
     \endgroup
   \fi}
 %% Redefine \l@section and \l@subsection
-\renewcommand*\l@section{\@dottedtocline{1}{1.8em}{3.2em}}
-\renewcommand*\l@subsection{\@dottedtocline{2}{5em}{4.3em}}
+\renewcommand*\l@section{\@dottedtocline{1}{2.4em}{3.2em}}
+\renewcommand*\l@subsection{\@dottedtocline{2}{5.6em}{4.3em}}
 \makeatother
 %% Sphinx < 1.8 doesn't have \sphinxtableofcontentshook
 \providecommand{\sphinxtableofcontentshook}{}

base-commit: 4a840d5fdcfcfff55b8b22896c1193a9b26405aa
-- 
2.25.1

