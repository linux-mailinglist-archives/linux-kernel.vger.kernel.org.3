Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8334DD854
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiCRKlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiCRKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996612DB598;
        Fri, 18 Mar 2022 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LYiItQFFi/MXAk4t3Ibiix6hi+OGC0+kYKcBgk0Rleg=;
  b=KLY5jrKXS08FFNloxFLI+7XyopFyir1SGqJwu+wlLMJFDWsXrd485eIx
   Ahng7NA7SvQtY+K/V0n46gVmPtDfp6vB7AnqJWkG8/7Yn21MNjptnegpB
   WYCOSNcErpF12ra0QLo+24usZkmEwc3UxCppsVpSsb0i8jJnK/SmjdFLd
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935652"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:38 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Richard Henderson <rth@twiddle.net>
Cc:     kernel-janitors@vger.kernel.org,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:14 +0100
Message-Id: <20220318103729.157574-19-Julia.Lawall@inria.fr>
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
 arch/alpha/boot/bootpz.c       |    2 +-
 arch/alpha/kernel/osf_sys.c    |    2 +-
 arch/alpha/kernel/sys_eiger.c  |    4 ++--
 arch/alpha/kernel/sys_takara.c |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/boot/bootpz.c b/arch/alpha/boot/bootpz.c
index 90a2b341e9c0..f7657507d2a5 100644
--- a/arch/alpha/boot/bootpz.c
+++ b/arch/alpha/boot/bootpz.c
@@ -456,7 +456,7 @@ start_kernel(void)
 #ifdef DEBUG_LAST_STEPS
 	srm_printk("Preparing INITRD info...\n");
 #endif
-	/* Finally, set the INITRD paramenters for the kernel. */
+	/* Finally, set the INITRD parameters for the kernel. */
 	((long *)(ZERO_PGE+256))[0] = initrd_image_start;
 	((long *)(ZERO_PGE+256))[1] = INITRD_IMAGE_SIZE;
 
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 8bbeebb73cf0..e46f76b79826 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -825,7 +825,7 @@ SYSCALL_DEFINE5(osf_setsysinfo, unsigned long, op, void __user *, buffer,
 
 		/* 
 		 * Alpha Architecture Handbook 4.7.7.3:
-		 * To be fully IEEE compiant, we must track the current IEEE
+		 * To be fully IEEE compliant, we must track the current IEEE
 		 * exception state in software, because spurious bits can be
 		 * set in the trap shadow of a software-complete insn.
 		 */
diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
index aea8a54da4bc..fbe264a30a66 100644
--- a/arch/alpha/kernel/sys_eiger.c
+++ b/arch/alpha/kernel/sys_eiger.c
@@ -98,7 +98,7 @@ eiger_device_interrupt(unsigned long vector)
 	if (intstatus) {
 		/*
 		 * This is a PCI interrupt. Check each bit and
-		 * despatch an interrupt if it's set.
+		 * dispatch an interrupt if it's set.
 		 */
 
 		if (intstatus & 8) handle_irq(16+3);
@@ -148,7 +148,7 @@ eiger_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 
 	/* The SRM console has already calculated out the IRQ value's for
 	   option cards. As this works lets just read in the value already
-	   set and change it to a useable value by Linux.
+	   set and change it to a usable value by Linux.
 
 	   All the IRQ values generated by the console are greater than 90,
 	   so we subtract 80 because it is (90 - allocated ISA IRQ's).  */
diff --git a/arch/alpha/kernel/sys_takara.c b/arch/alpha/kernel/sys_takara.c
index 9e2adb69bc74..aa65a7fb8fc6 100644
--- a/arch/alpha/kernel/sys_takara.c
+++ b/arch/alpha/kernel/sys_takara.c
@@ -93,7 +93,7 @@ takara_device_interrupt(unsigned long vector)
 	if (intstatus) {
 		/*
 		 * This is a PCI interrupt. Check each bit and
-		 * despatch an interrupt if it's set.
+		 * dispatch an interrupt if it's set.
 		 */
 
 		if (intstatus & 8) handle_irq(16+3);

