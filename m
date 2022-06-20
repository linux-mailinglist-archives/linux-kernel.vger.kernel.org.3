Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5A25517E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241231AbiFTL5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241436AbiFTL5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:57:30 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C8B17E1D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:57:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r66so4150832pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9C+hw/LDK0fNwXiLPN2w98TPlBfCZarzlx/DbOVjVR4=;
        b=kynoLGne7zsBPZJecBRrJPiyLchBLvmtNMel3lqaLJ13AK4Ko0E25y341pPgT+IcMc
         7RRMUMgoFr5ipH5k1btOHMgvMdRZfzZerPlUy5svd8/xgUxJoP2mElEwnhrLSzI7bMPA
         OylnVImfJ9YVaaM4BgVEswf6ktREpWRHBooCgmaUTUOySb9uvO2cXF5MtGAZbgMcEfNz
         Xzc84ZGcOpAJtH9hWmRCo4vB63jETIRcKyXdNxPzkDjwGIdExTQ3Pie9B5Xtg3z3H9fz
         n9WPeyddmKQqSIkjm3+EG4jAleiH1oAumH8+oiuvl68wn4ixeCJYmx06lC83ywu9zyns
         Hjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9C+hw/LDK0fNwXiLPN2w98TPlBfCZarzlx/DbOVjVR4=;
        b=YFnXPSO84BNCiRbsn6edN7Q5h25rmRWOGZhctZ6dxV8QH6/32louEII1B5RdLIUwv/
         AP75OSDxYYuNyYYuQnr4J81iAIJTl1NOzXbkm96iypCeQt+5n9pKeNF3jepiU9eiqadw
         9kPeyK7fSdCnUS9I4gZQVFBc96TSf3RUbiDSQ90j6zEu7JO+/yzcTRaoGcDnw34zwiv4
         Qe+al3nAOxXazcLUpPsgEGz3orl8EaG7QRwmJdTff5EtzxM16OMBNkf69rxcaPLq3Tbk
         Ys8VGElqj6GbvQABip5mzQKRjG0Bj5a/bLIcBfAlgsi4FVMxGlVA8CX3yrvsB5vV4kpV
         hYDA==
X-Gm-Message-State: AJIora9H+awqtxvIczzK4e2tGqvfLTp/qYhvlACR9RgO1XriCBi0PA+G
        KZeNNs/lT4KVnRcdfVMCsag=
X-Google-Smtp-Source: AGRyM1uzKXry+gURZQst1vKjzwX7SOs+3xu91J4k8AyY31VrvU7Tzr8QKFS0h2NZ/vGmblST1v1Y5Q==
X-Received: by 2002:a65:6e96:0:b0:3fd:c8b7:5fa6 with SMTP id bm22-20020a656e96000000b003fdc8b75fa6mr21049752pgb.569.1655726249529;
        Mon, 20 Jun 2022 04:57:29 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.250])
        by smtp.gmail.com with ESMTPSA id mm21-20020a17090b359500b001ec86a0490csm4539154pjb.32.2022.06.20.04.57.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2022 04:57:29 -0700 (PDT)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, liuchao12@xiaomi.com,
        qxy65535@gmail.com, qixiaoyu1 <qixiaoyu1@xiaomi.com>
Subject: [PATCH v3 2/2] resize.f2fs: update man page for options -i, -s and -V
Date:   Mon, 20 Jun 2022 19:56:29 +0800
Message-Id: <20220620115629.9169-2-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620115629.9169-1-qixiaoyu1@xiaomi.com>
References: <5627a654-d605-6840-a133-e583c804aadd@kernel.org>
 <20220620115629.9169-1-qixiaoyu1@xiaomi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---
 man/resize.f2fs.8 | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/man/resize.f2fs.8 b/man/resize.f2fs.8
index a4b6cd7..3288760 100644
--- a/man/resize.f2fs.8
+++ b/man/resize.f2fs.8
@@ -17,6 +17,15 @@ resize.f2fs \- resize filesystem size
 .B \-o
 .I overprovision-ratio-percentage
 ]
+[
+.B \-i
+]
+[
+.B \-s
+]
+[
+.B \-V
+]
 .I device
 .SH DESCRIPTION
 .B resize.f2fs
@@ -44,6 +53,15 @@ Specify the percentage of the volume that will be used as overprovision area.
 This area is hidden to users, and utilized by F2FS cleaner. If not specified, the
 best number will be assigned automatically according to the partition size.
 .TP
+.BI \-i
+Enable extended node bitmap.
+.TP
+.BI \-s
+Enable safe resize.
+.TP
+.BI \-V
+Print the version number and exit.
+.TP
 .SH AUTHOR
 This version of
 .B resize.f2fs
-- 
2.36.1

