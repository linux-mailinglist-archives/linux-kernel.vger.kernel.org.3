Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2457D185
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiGUQae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiGUQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:30:28 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611AE1E3E4;
        Thu, 21 Jul 2022 09:30:21 -0700 (PDT)
X-QQ-mid: bizesmtp82t1658420959t58l6g1s
Received: from localhost.localdomain ( [171.223.97.251])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 00:29:17 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: OJMdz4nl17by3agcAaDS3RzNQMrhDfQfIb0sAE4r2HepIJRpmvFBOHSDjQx1M
        tIwEUB4WagwpXaGh0ISUmplMtwL/G1hnmoru60DUWgiY5vkzcRc8r+l/BDVjl6dwLNnm4c8
        qt01sfcBLRmJ/YEAqx3IVf2q9H2MxgIuIfjzLUasAsyVKZ1wFUjtNSR51dwF6BVYDkUIbII
        +g+hX13ZUmws1j5RM2zVXZpKxctnS7+sKP+hG41X4aYJ49+ZVWAHPF1beo1dNSOb9/RCT6I
        APPY3umv/TmUbK6zvaH3TMP30OVSqfVeWz2fmypXEXLcvcc9ERmINKKL3VyvGLKbEttCssc
        PDu2O7/L+SEm58bHTck4VqF6ZVaiw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, kishon@ti.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH 1/3] mmc: sdhci-acpi: Fix comment typo
Date:   Mon, 18 Jul 2022 16:26:48 +0800
Message-Id: <20220718082650.9784-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/mmc/host/sdhci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 4cca4c90769b..bddfaba091a9 100644
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
2.35.1

