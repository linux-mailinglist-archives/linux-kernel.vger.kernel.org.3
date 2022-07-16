Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D513576E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbiGPON4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiGPONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:13:53 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DD465D1;
        Sat, 16 Jul 2022 07:13:48 -0700 (PDT)
X-QQ-mid: bizesmtp81t1657980777tgna77j1
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 22:12:46 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: cJxW8JU4sGvPIlZNDCmnbgzt4QyZwIhAdodf7TNoPb92SJXsyA2hH4joWV4Lj
        wQofsHXIvul71D9hj30qVQDCB3PM+XcODpRxdPeqru96ZlNsJRnX8GrXBvtPk8QvIIaqQqG
        HUZdotmXn+efYmct4yGj3vBt8czF4jRJbUsIHQvs8QBlnbtKcxX1SUZK1Lc8eVv1WCFD8MZ
        SBxcG1pNqS1g4nmkDbwH6CD2QAmc+VVWRx1KWQ3yyUoKgvWZI4uXmS+LLA63EuUeenWi8GL
        7D3cxrRhtsaqbFvkYs/eEY4EPwRaiP976cg4L5Rd3e1S5FDfh8FyAzFHsWI+ryPBNo29U8e
        IVuTLSjVnQnGQ8bq9/ns79NptpUm26w8O9fxgPqIJ0adu1bZeC3V0x5t8gccET2nNa0qF2s
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, haibo.chen@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mmc/host: fix repeated words in comments
Date:   Sat, 16 Jul 2022 22:12:40 +0800
Message-Id: <20220716141240.58814-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.
 Delete the redundant word 'that'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mmc/host/sdhci-bcm-kona.c  | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 4d4aac85cc7a..175f2038f9b6 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -178,7 +178,7 @@ static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
 	/*
 	 *  JEDEC and SD spec specify supplying 74 continuous clocks to
 	 * device after power up. With minimum bus (100KHz) that
-	 * that translates to 740us
+	 * translates to 740us
 	 */
 	if (power_mode != MMC_POWER_OFF)
 		udelay(740);
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 55981b0f0b10..e1ada9487a8f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1454,7 +1454,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 		/*
 		 * On i.MX8MM, we are running Dual Linux OS, with 1st Linux using SD Card
 		 * as rootfs storage, 2nd Linux using eMMC as rootfs storage. We let the
-		 * the 1st linux configure power/clock for the 2nd Linux.
+		 * 1st linux configure power/clock for the 2nd Linux.
 		 *
 		 * When the 2nd Linux is booting into rootfs stage, we let the 1st Linux
 		 * to destroy the 2nd linux, then restart the 2nd linux, we met SDHCI dump.
-- 
2.36.1

