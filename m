Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0B59E7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245352AbiHWQon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244078AbiHWQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:44:21 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD199924D;
        Tue, 23 Aug 2022 07:35:31 -0700 (PDT)
X-QQ-mid: bizesmtp63t1661265306tcjl87k1
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:35:05 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: CR3LFp2JE4lsMi4y5SOOx7rBpqqJUbpxns7R41MYtoWzw4TkT6PbPgcsIBUjE
        O8TFio6RF7CKukJ84ap9pCXYJY5T8cG4gl7EK2h2E8eCXnSy/qwHuqTNfGXxXoF68etUjIJ
        eQLCETxxepsdSTYVMHKgc3RL7PFpXGVtTy4xCENlLdXNkG1G3k4jJ4CEyGq7xEvFYprp1NI
        Ex9/SJrJGyhsVv8VUSUyi5jFhUOPMvAYVJaNb/a2m7BExWZvFId7SlBH+q7FG8uli+vGCE0
        ozgy0Nyxswm0sD/mGYfodwQvGnomdcmDttJ3YPorprWx7pU2pS45mTC/IR2JtEYnbCFaET3
        iX8Lihr7CIHZSs5lEgj84gAul56251ozxOUoxzv7+r+Tkwv1cSt6buVFUmW4g==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] mmc/host: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:34:59 +0800
Message-Id: <20220823143459.27942-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/mmc/host/sdhci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index c0350e9c03f3..93fe6e5a5f9f 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -648,7 +648,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
 	 *       in reading a garbage value and using the wrong presets.
 	 *
 	 *       Since HS400 and HS200 presets must be identical, we could
-	 *       instead use the the SDR104 preset register.
+	 *       instead use the SDR104 preset register.
 	 *
 	 *    If the above issues are resolved we could remove this quirk for
 	 *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
-- 
2.36.1

