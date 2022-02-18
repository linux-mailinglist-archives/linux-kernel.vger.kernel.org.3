Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3624BBF56
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiBRSRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbiBRSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:17:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F3FBA5;
        Fri, 18 Feb 2022 10:16:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e3so16005223wra.0;
        Fri, 18 Feb 2022 10:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2lb5EpDrjZ7Ucka1D9DCg1WHob0SHwbW9oEXk90RPrs=;
        b=WS3QZY6M3UB9909PRkjQxHh3MFAbnv5w63hkV438NIYYd84kFghIWSJErVXRGpgY0e
         VA9gO3pQHfB3JAgF4hwCGe+jI3x8Cg5SFDmg2hxcw1AkWq+C7+g0rovX3YNrqw7Pb39Y
         fAhcCLHtVPZNe+G8/v2s82g/qP48s6gIz76tD3ouu4DBh1qTDVMqQ7AZ3LH745yG8lzq
         +N2P0x7dE4eTabpuiBSICqwZ+Ppzm7keyoBtfgcKt6q3nhRCRD+ntfQB3EWD/uWWpqA6
         fng7F/+TtGEivESLN0mw35wwju7YqME3CeNDV+Bn+JE2b6MYu6SDYXmo+fFRYw850W2U
         MVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2lb5EpDrjZ7Ucka1D9DCg1WHob0SHwbW9oEXk90RPrs=;
        b=vN2P1SQPDZCr/ctIY8xl8kxdr+z7HGQxUSudFg6P2ZEWsOMLKma2AI3cyhIfDperHp
         OQR2M/7+v/Lw19uhcci6EXS3YDlPc3a5uKfwxrEsuMAte3er/jJG8PrOPH0MPJMYEe04
         f67wYWszp28BAdi/4tCRzRMmchbmckP6kPva+x8xhzBuZaRV95+Oiie38wByeI1Os9qA
         wA/Lz54ZTRhxLbDNRDTNO8BJkaY1FHWGtFSOB/6Rkqn/yH94TCXypK7pFKrOFi+9iijl
         MMVl6Qhgi1lRTyA8xTL29FOtyLiW2ypCt3eanGBCnxo0WW+4y7LXQvIxhuuUPjRn7oWH
         zXRA==
X-Gm-Message-State: AOAM5321gwA+P7FdeKr55H9Z7AwoVOhvsDdr4BdmLZJwIueQ32ibgLtN
        po7c2oBQpx4pk23fRINC6sY=
X-Google-Smtp-Source: ABdhPJwlQXbzR3MwBSz9x39dlEhRav6nu/HafcNw9vr9feXS38Bl6Inn00TaH4YdXR9hbOsIhWbFgA==
X-Received: by 2002:a5d:6244:0:b0:1e7:686d:41e7 with SMTP id m4-20020a5d6244000000b001e7686d41e7mr6785305wrv.491.1645208207924;
        Fri, 18 Feb 2022 10:16:47 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:47 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/11] scripts: kernel-doc: Translate the "Other parameters" subsection of OPTIONS
Date:   Fri, 18 Feb 2022 19:16:25 +0100
Message-Id: <20220218181628.1411551-9-tomasz.warniello@gmail.com>
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

Notes:
- The -help token is added.
- The entries are sorted alphbetically.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 210e7e3b501b..4a26a74318e6 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,11 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Other parameters:
-  -v			Verbose output, more warnings and other information.
-  -h			Print this help.
-  -Werror		Treat warnings as errors.
-
 EOF
     print $message;
     exit 1;
@@ -2628,4 +2623,22 @@ Enable output of #define LINENO lines.
 
 =back
 
+=head2 Other parameters:
+
+=over 8
+
+=item -h, -help
+
+Print this help.
+
+=item -v
+
+Verbose output, more warnings and other information.
+
+=item -Werror
+
+Treat warnings as errors.
+
+=back
+
 =cut
-- 
2.30.2

