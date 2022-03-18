Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B464DD831
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiCRKje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiCRKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:06 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83D2D9D50;
        Fri, 18 Mar 2022 03:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HNsH48t+EV6ivnkxLpBDiWmjr5FnEaaFgC7nRyfhpuc=;
  b=IpJzgAuUN9uVfx1RR8bvWG2Mrx70QeITan9PZ+aDr6QfemGs3XM4JjIl
   n8cQ9IzeyFF0+yc2WAxsZlYPpREq/8gKsivb0Ks4WmlTidT5ykkko5qUK
   10vHi38rX8UJeQvXbhhWBzDThuUA3t7//luDOJkhkRXWrYWos+a4fgTrn
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935642"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:36 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-janitors@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:05 +0100
Message-Id: <20220318103729.157574-10-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/arm64/kernel/module-plts.c |    2 +-
 arch/arm64/kernel/suspend.c     |    2 +-
 arch/arm64/mm/init.c            |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index e53493d8b208..a3d0494f25a9 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -220,7 +220,7 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
 			 * increasing the section's alignment so that the
 			 * resulting address of this instruction is guaranteed
 			 * to equal the offset in that particular bit (as well
-			 * as all less signficant bits). This ensures that the
+			 * as all less significant bits). This ensures that the
 			 * address modulo 4 KB != 0xfff8 or 0xfffc (which would
 			 * have all ones in bits [11:3])
 			 */
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index 19ee7c33769d..2b0887e58a7c 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -140,7 +140,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	/*
 	 * Restore pstate flags. OS lock and mdscr have been already
 	 * restored, so from this point onwards, debugging is fully
-	 * renabled if it was enabled when core started shutdown.
+	 * reenabled if it was enabled when core started shutdown.
 	 */
 	local_daif_restore(flags);
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8ac25f19084e..1e7b1550e2fc 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(memstart_addr);
  * In this scheme a comparatively quicker boot is observed.
  *
  * If ZONE_DMA configs are defined, crash kernel memory reservation
- * is delayed until DMA zone memory range size initilazation performed in
+ * is delayed until DMA zone memory range size initialization performed in
  * zone_sizes_init().  The defer is necessary to steer clear of DMA zone
  * memory range to avoid overlap allocation.  So crash kernel memory boundaries
  * are not known when mapping all bank memory ranges, which otherwise means
@@ -81,7 +81,7 @@ EXPORT_SYMBOL(memstart_addr);
  * so page-granularity mappings are created for the entire memory range.
  * Hence a slightly slower boot is observed.
  *
- * Note: Page-granularity mapppings are necessary for crash kernel memory
+ * Note: Page-granularity mappings are necessary for crash kernel memory
  * range for shrinking its size via /sys/kernel/kexec_crash_size interface.
  */
 #if IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)

