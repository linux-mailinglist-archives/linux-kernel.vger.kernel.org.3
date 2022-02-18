Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2609B4BBF58
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiBRSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbiBRSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:17:06 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BB7B32;
        Fri, 18 Feb 2022 10:16:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d27so15932334wrc.6;
        Fri, 18 Feb 2022 10:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1rWH/BsccXg4cqTVnl88SeuUMSVFDqYiKoq6y7EUDcA=;
        b=pIq7/7L5LAbPU+GGcDbqzcRpe2RdjLEYz/ApzoAOpU6QIibs0WAHiCmv41nmjZhL5S
         mQZ2HCEIG6SvhLLB7IfJpsWIjDAe40svARasskZnxMpTkkDGUauSyy+tcSLD7AESPTW4
         JjBVCXoHf/9qi/6P8rXvY3NdCg/EBgI/NMJWl8H7/Ti0XRFbW8Cfqs+eyLCh86r4JEEo
         2TIhpF1BjWoysZVgH2ziKkcu1mY8Wpn+Mv3ohBooipI96vcyggHlqDjLZ+a/J7taMgif
         5RzlamyetYosnHCVhK1wgprKAlr2Vv3Jtez8vEZhSBFKN0gRIBMyTkGq6/agcpGUO2lU
         hFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rWH/BsccXg4cqTVnl88SeuUMSVFDqYiKoq6y7EUDcA=;
        b=R3YBam8QwIuY88jD50Vx5n7/NvAihqCogCYSnoZ78jVCB+XubMVeCOotn3Pf3sBhDb
         vl3INhEHVldHSm1CCUdJZwaEZJCtWFGLRnMnLRHX+IIjJ/R6Eh1eYeAyvIgX/4cYShmX
         k1ab1dmrJJUmj59gz3vBWkhjgEms4BjQyca7iBzwnatqD/zavqDk8u7ctBJbfDmY0/jK
         aiv+2ZT6iGCzqNTK0TvtTlY01qGhn6FfvkiU1s/3boRCJzTNjlQ0WFpH6UXFTUR3tRVH
         btLGOGx7goak0+FwA7ON+I9J+rx48fIaqXD8FBTmybLUHGS/V3lbiW6BPTjTyOJ4ZMDX
         QmXA==
X-Gm-Message-State: AOAM533HdCEtVfnKhxXZGX/xJiRJsOaJ5qZ+yXZY/StMmL5KYkH1EIJN
        3q3MbD6lp3tWzlbXwFwcFHA=
X-Google-Smtp-Source: ABdhPJy4XiLWgnAAaFNYDRnx8H+L9AOS8cpRcg3UDdflougEBjxkv7xtTrSwDa92rYFTkBwfZowVIg==
X-Received: by 2002:a5d:44c4:0:b0:1e6:8878:8cb2 with SMTP id z4-20020a5d44c4000000b001e688788cb2mr7021889wrr.434.1645208206841;
        Fri, 18 Feb 2022 10:16:46 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:46 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] scripts: kernel-doc: Translate the "Output selection modifiers" subsection of OPTIONS
Date:   Fri, 18 Feb 2022 19:16:24 +0100
Message-Id: <20220218181628.1411551-8-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aim: unified POD, user more satisfied, script better structured

A subsection "reStructuredText only" is added for -enable-lineno.

Other notes:
- paragraphing correction

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index e49cdb307a35..210e7e3b501b 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,14 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output selection modifiers:
-  -no-doc-sections	Do not output DOC: sections.
-  -enable-lineno        Enable output of #define LINENO lines. Only works with
-                        reStructuredText format.
-  -export-file FILE     Specify an additional FILE in which to look for
-                        EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(). To be used with
-                        -export or -internal. May be specified multiple times.
-
 Other parameters:
   -v			Verbose output, more warnings and other information.
   -h			Print this help.
@@ -2607,4 +2599,33 @@ May be specified multiple times.
 
 =back
 
+=head2 Output selection modifiers:
+
+=over 8
+
+=item -no-doc-sections
+
+Do not output DOC: sections.
+
+=item -export-file FILE
+
+Specify an additional FILE in which to look for EXPORT_SYMBOL() and
+EXPORT_SYMBOL_GPL().
+
+To be used with -export or -internal.
+
+May be specified multiple times.
+
+=back
+
+=head3 reStructuredText only
+
+=over 8
+
+=item -enable-lineno
+
+Enable output of #define LINENO lines.
+
+=back
+
 =cut
-- 
2.30.2

