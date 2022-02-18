Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A254BBF50
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiBRSRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239075AbiBRSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:17:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF2612A85;
        Fri, 18 Feb 2022 10:16:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d27so15932267wrc.6;
        Fri, 18 Feb 2022 10:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wo5NvcwHFFtStXDoiS+t0v8LcaxRXSvFfszKiww2PfQ=;
        b=GfWkT0p66agfM59hEUjlXkfOQ9Whc+0BMoWQBJHgcPyWAzecHSbFDTEedwgPtZulln
         n3tQyPqiTJL7jZBrR5e+QjRyP5v1txZ9H7ZYeI7C9k0CFzrZK0vyR7Ke5AAMUydQBmBm
         d+v3PuHISGVVzWfI8dd4KAbZu660+WQ+M9MocgWUchazcf2C+a47A9XFNKVn7FDNnRra
         buctkZkCDHeBIsva7fyXRD+vSeOzBkbB12yaDfzFeHDICuWD48LTXUuvQwipNTQNyjkR
         8MUR5DNXXeFDLFZvaO5CmFhs8mK+DO0x5cX+T96M4Q94qW3CpgTzGZ8x6/Gax1wL35JU
         JyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wo5NvcwHFFtStXDoiS+t0v8LcaxRXSvFfszKiww2PfQ=;
        b=r7N5j9x4BA/WwUCWucNOvPqeuGfGXpmKr3mhbOy2lxyCtV6wmFhQYSJEfiMnDFbape
         R84iSMU9xtSwlo5wiWq74Qqfn5uFKw5RHkHwZRSvRK2/RBR/OlLB0KEoWAVvav3dq1uh
         Yw8Tlu9Qho21CGuNOljmWG5e81SjB2OLBl4n1+YhOsLBDt1+d4znmi/xUeDy0OE6bdwJ
         U1K89G4LXOXfopjJGW7bQZKZYOdspwJrYexWzTHY1PWDmUdIilfJGkclDu5/odL0a1Fc
         WJKWfS2EaJf39N6TmMS0BG9tQwGBMPygus8K9vPZzgTxBRapVn8TWKpixSoEuxsrMLvN
         xITw==
X-Gm-Message-State: AOAM533fDSPeXWjAGz/kiigsgM90uwzORZakYPVBkYd/QfQbD332PO1z
        OIaN48PTIc1m5qrUdk/399SRgErOyL7Efg==
X-Google-Smtp-Source: ABdhPJyvtVQCat2Gzd6TH1LkB71Yv/+tQBWH7sJ6gcZtJJ/rLkoMyyvOTZPTpogGcmYApiITz7VlXA==
X-Received: by 2002:a05:6000:c5:b0:1e3:2a0d:fe6 with SMTP id q5-20020a05600000c500b001e32a0d0fe6mr7009551wrx.421.1645208205886;
        Fri, 18 Feb 2022 10:16:45 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:45 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] scripts: kernel-doc: Translate the "Output selection" subsection of OPTIONS
Date:   Fri, 18 Feb 2022 19:16:23 +0100
Message-Id: <20220218181628.1411551-7-tomasz.warniello@gmail.com>
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

The plurals in -function and -nosymbol are corrected to singulars.
That's how the script works now. I think this describes the syntax better.
The plurar suggests multiple FILE arguments might be possible. So this
seems more coherent.

Other notes:
- paragraphing correction
- article correction

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index b926faa16b00..e49cdb307a35 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,19 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output selection (mutually exclusive):
-  -export		Only output documentation for symbols that have been
-			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
-                        in any input FILE or -export-file FILE.
-  -internal		Only output documentation for symbols that have NOT been
-			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
-                        in any input FILE or -export-file FILE.
-  -function NAME	Only output documentation for the given function(s)
-			or DOC: section title(s). All other functions and DOC:
-			sections are ignored. May be specified multiple times.
-  -nosymbol NAME	Exclude the specified symbols from the output
-		        documentation. May be specified multiple times.
-
 Output selection modifiers:
   -no-doc-sections	Do not output DOC: sections.
   -enable-lineno        Enable output of #define LINENO lines. Only works with
@@ -2591,4 +2578,33 @@ found on PATH.
 
 =back
 
+=head2 Output selection (mutually exclusive):
+
+=over 8
+
+=item -export
+
+Only output documentation for the symbols that have been exported using
+EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+
+=item -internal
+
+Only output documentation for the symbols that have NOT been exported using
+EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+
+=item -function NAME
+
+Only output documentation for the given function or DOC: section title.
+All other functions and DOC: sections are ignored.
+
+May be specified multiple times.
+
+=item -nosymbol NAME
+
+Exclude the specified symbol from the output documentation.
+
+May be specified multiple times.
+
+=back
+
 =cut
-- 
2.30.2

