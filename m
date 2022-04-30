Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845E3516000
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244603AbiD3TPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244433AbiD3TPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:15:00 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1714EF69;
        Sat, 30 Apr 2022 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FfCsmwJtzggHEHrba1vUQFe2mSjPcmuODMc6JOC2TtA=;
  b=G8TSGLGLfyjV3aQiYDtQ7xRUMIGvTYL34Q0R+g1ByKpdiOtSfEitTBKn
   1xoHHjbU6am85w2A+/xSP9Al5UGRzH3A0mOOYDRARqcV13fFEsu65/06u
   vUDiiriVSQddMQK0pxGgZDYyFbBc6qxxTGOfu3vK5dQcnbno5Nr2msCq9
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,188,1647298800"; 
   d="scan'208";a="34084617"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 21:11:32 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     kernel-janitors@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: fix typos in comments
Date:   Sat, 30 Apr 2022 21:11:18 +0200
Message-Id: <20220430191122.8667-4-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/m68k/coldfire/intc.c  |    2 +-
 arch/m68k/coldfire/m53xx.c |    2 +-
 arch/m68k/coldfire/pci.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/coldfire/intc.c b/arch/m68k/coldfire/intc.c
index cce257420388..adb3cbf7e97a 100644
--- a/arch/m68k/coldfire/intc.c
+++ b/arch/m68k/coldfire/intc.c
@@ -28,7 +28,7 @@
 unsigned char mcf_irq2imr[NR_IRQS];
 
 /*
- * Define the miniumun and maximum external interrupt numbers.
+ * Define the minimum and maximum external interrupt numbers.
  * This is also used as the "level" interrupt numbers.
  */
 #define	EIRQ1	25
diff --git a/arch/m68k/coldfire/m53xx.c b/arch/m68k/coldfire/m53xx.c
index bd033e1975bf..17af5f673796 100644
--- a/arch/m68k/coldfire/m53xx.c
+++ b/arch/m68k/coldfire/m53xx.c
@@ -532,7 +532,7 @@ int clock_pll(int fsys, int flags)
 		writel(readl(MCF_SDRAMC_SDCR) | MCF_SDRAMC_SDCR_CKE,
 			MCF_SDRAMC_SDCR);
 
-	/* Errata - workaround for SDRAM opeartion after exiting LIMP mode */
+	/* Errata - workaround for SDRAM operation after exiting LIMP mode */
 	writel(MCF_SDRAMC_REFRESH, MCF_SDRAMC_LIMP_FIX);
 
 	/* wait for DQS logic to relock */
diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
index 84eab0f5e00a..ceb5775b8d23 100644
--- a/arch/m68k/coldfire/pci.c
+++ b/arch/m68k/coldfire/pci.c
@@ -31,7 +31,7 @@ static struct pci_bus *rootbus;
 static unsigned long iospace;
 
 /*
- * We need to be carefull probing on bus 0 (directly connected to host
+ * We need to be careful probing on bus 0 (directly connected to host
  * bridge). We should only access the well defined possible devices in
  * use, ignore aliases and the like.
  */

