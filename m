Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE9F576E77
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiGPOKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:10:03 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C2B210;
        Sat, 16 Jul 2022 07:09:58 -0700 (PDT)
X-QQ-mid: bizesmtp68t1657980565tfvkvdxh
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 22:09:22 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: XBN7tc9DADL4XQXd1k7qY80VeEy7MEkFhvJ4hBUIfEpR3bbV7BIaTL9QaRTYS
        YlbcyuTzXrXIzsElEMPpZfa36pRQ+pj+lYWgLN3OE/gV4g9gO095MIiPtxl1EI5Gx9fSE2n
        5ggIVVdmlgdEVh2hxZGrqyOZ16g8U3eo3D6vL32gCs3+M3IpWeQGwx3YrZTRJGugZWeQrO0
        lDtJfjvZeXKoeJIFVw0VGpGgom9kMtG1wXe+3YqAwf5uwnTw37ZRHDw8f0y13dKliTaA+30
        P4FSzIlw8d19D5bLrbSoTYnJCrrwiSGEEE2JWhSEgXDDt4wW/I3ywlRTURxPZgyebLPxkvX
        LJtzyvqOU0983GUkfOG2nXsWYp8QUJ6hSlKnglLgoGTXsVD7GatN974vFlikgri8iqdea0t
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     kishon@ti.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] mmc/host: fix repeated words in comments
Date:   Sat, 16 Jul 2022 22:09:05 +0800
Message-Id: <20220716140905.57835-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'a'.
 Delete the redundant word 'any'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/mmc/host/sdhci-omap.c | 2 +-
 drivers/mmc/host/sdhci.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 86e867ffbb10..8c1c47c80c71 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -370,7 +370,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	/*
 	 * Stage 1: Search for a maximum pass window ignoring any
-	 * any single point failures. If the tuning value ends up
+	 * single point failures. If the tuning value ends up
 	 * near it, move away from it in stage 2 below
 	 */
 	while (phase_delay <= MAX_PHASE_DELAY) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d7929d725730..624960052228 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -345,7 +345,7 @@ struct sdhci_adma2_64_desc {
  */
 #define SDHCI_MAX_SEGS		128
 
-/* Allow for a a command request and a data request at the same time */
+/* Allow for a command request and a data request at the same time */
 #define SDHCI_MAX_MRQS		2
 
 /*
-- 
2.36.1

