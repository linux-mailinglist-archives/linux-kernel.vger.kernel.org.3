Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2024DD84A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiCRKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiCRKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:39:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB292DB59D;
        Fri, 18 Mar 2022 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ozx1tw3XxjRE3xzrnLv53rTzYlVWrfmUPszMI7i3uqc=;
  b=BHnOWWlNS04xk2vAs0ptVaMHqTKt8oumakhflciMGxMBIBmQ4NMqIT7R
   gsUHNam/QMYoRD9z3CJBrohWuuIiwxZekvv65Vtb7qv3wTX8IN8DigwiC
   OEleiM4yJ+9EADlAZyey4hP8/UCOF09kSY0qSSx6iz6bBpKVQxh9LDqvu
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,192,1643670000"; 
   d="scan'208";a="8935658"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 11:37:38 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: davinci: fix typos in comments
Date:   Fri, 18 Mar 2022 11:37:17 +0100
Message-Id: <20220318103729.157574-22-Julia.Lawall@inria.fr>
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
 arch/arm/mach-davinci/board-dm355-evm.c  |    4 ++--
 arch/arm/mach-davinci/board-dm365-evm.c  |    2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c |    2 +-
 arch/arm/mach-davinci/devices.c          |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 3c5a9e3c128a..36983dd73904 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -222,7 +222,7 @@ static struct v4l2_input tvp5146_inputs[] = {
 
 /*
  * this is the route info for connecting each input to decoder
- * ouput that goes to vpfe. There is a one to one correspondence
+ * output that goes to vpfe. There is a one to one correspondence
  * with tvp5146_inputs
  */
 static struct vpfe_route tvp5146_routes[] = {
@@ -295,7 +295,7 @@ static struct vpbe_enc_mode_info dm355evm_enc_preset_timing[] = {
 #define VENC_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
 
 /*
- * The outputs available from VPBE + ecnoders. Keep the
+ * The outputs available from VPBE + encoders. Keep the
  * the order same as that of encoders. First those from venc followed by that
  * from encoders. Index in the output refers to index on a particular encoder.
  * Driver uses this index to pass it to encoder when it supports more than
diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index b3bef74c982a..21cf356fcd01 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -535,7 +535,7 @@ static struct vpbe_enc_mode_info dm365evm_enc_preset_timing[] = {
 #define VENC_STD_ALL	(V4L2_STD_NTSC | V4L2_STD_PAL)
 
 /*
- * The outputs available from VPBE + ecnoders. Keep the
+ * The outputs available from VPBE + encoders. Keep the
  * the order same as that of encoders. First those from venc followed by that
  * from encoders. Index in the output refers to index on a particular
  * encoder.Driver uses this index to pass it to encoder when it supports more
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index cce3a621eb20..1493f4a77e29 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -260,7 +260,7 @@ static struct v4l2_input dm644xevm_tvp5146_inputs[] = {
 
 /*
  * this is the route info for connecting each input to decoder
- * ouput that goes to vpfe. There is a one to one correspondence
+ * output that goes to vpfe. There is a one to one correspondence
  * with tvp5146_inputs
  */
 static struct vpfe_route dm644xevm_tvp5146_routes[] = {
diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
index 849e811fade7..781a619af1e1 100644
--- a/arch/arm/mach-davinci/devices.c
+++ b/arch/arm/mach-davinci/devices.c
@@ -245,7 +245,7 @@ void __init davinci_setup_mmc(int module, struct davinci_mmc_config *config)
 			/* Power-on 3.3V IO cells */
 			__raw_writel(0,
 				DAVINCI_SYSMOD_VIRT(SYSMOD_VDD3P3VPWDN));
-			/*Set up the pull regiter for MMC */
+			/*Set up the pull register for MMC */
 			davinci_cfg_reg(DM644X_MSTK);
 		}
 

