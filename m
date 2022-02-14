Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01D4B4F98
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351558AbiBNMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:04:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352448AbiBNME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:04:29 -0500
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FF0B2BDE;
        Mon, 14 Feb 2022 04:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=U+JDY
        cv4Sgjbhmy74T8cF1JfikTdJpu6pHvaldP6AWY=; b=j+3OgVHiT/HQT4Ly8J28I
        y8zfPY9WRl22n2RdMJ/oBNd80oywFYic3YwDSbL9Qab8Xb2n0i3iWneEniUf26LF
        dFaAISezUDlG2tSyjIwixqXJkZXbPAwPSaglTGCRBRyKQjgTD6AEGhAzP52w2y/V
        20+1ojt1gvf8Akb8HzUV0k=
Received: from localhost.localdomain (unknown [49.76.218.253])
        by smtp3 (Coremail) with SMTP id DcmowAAn1Pz3RApiYcDMAQ--.15568S2;
        Mon, 14 Feb 2022 20:03:05 +0800 (CST)
From:   wonder_rock@126.com
To:     rdunlap@infradead.org
Cc:     axboe@kernel.dk, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, wonder_rock@126.com
Subject: [PATCH 1/1] csky: Fix versioncheck warnings
Date:   Mon, 14 Feb 2022 20:02:50 +0800
Message-Id: <20220214120250.10256-1-wonder_rock@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <98208fa3-4b28-cdeb-7699-dbd9d66bfa60@infradead.org>
References: <98208fa3-4b28-cdeb-7699-dbd9d66bfa60@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowAAn1Pz3RApiYcDMAQ--.15568S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw47Xr1rZF4Dur17Ar1kZrb_yoW8Ww15pF
        1DZrZ5KrW5Cw18tr9rAr1qyas0q3WDGw1xX347KFWUZF47tFWqqrs5Crn0yr1DXFWv9w4r
        WF43Gr45GrWDXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcSdkUUUUU=
X-Originating-IP: [49.76.218.253]
X-CM-SenderInfo: xzrqvv5ubu0ubn6rjloofrz/1tbiuRmngVpD7wfTewAAsf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Deyan Wang <wonder_rock@126.com>

arch/csky/include/asm/io.h: 8 linux/version.h not needed.
arch/csky/kernel/process.c: 5 linux/version.h not needed.
arch/csky/mm/dma-mapping.c: 12 linux/version.h not needed.

Signed-off-by: Deyan Wang <wonder_rock@126.com>
---
 arch/csky/include/asm/io.h | 1 -
 arch/csky/kernel/process.c | 1 -
 arch/csky/mm/dma-mapping.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index f82654053dc0..ed53f0b47388 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -5,7 +5,6 @@
 
 #include <linux/pgtable.h>
 #include <linux/types.h>
-#include <linux/version.h>
 
 /*
  * I/O memory access primitives. Reads are ordered relative to any
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22cd0e2..5de04707aa07 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -2,7 +2,6 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/debug.h>
diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index c3a775a7e8f9..82447029feb4 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -9,7 +9,6 @@
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <asm/cache.h>
 
 static inline void cache_op(phys_addr_t paddr, size_t size,
-- 
2.25.1

