Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4B57D183
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiGUQah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiGUQab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:30:31 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8B19C3B;
        Thu, 21 Jul 2022 09:30:25 -0700 (PDT)
X-QQ-mid: bizesmtp82t1658420974t9n9vk9y
Received: from localhost.localdomain ( [171.223.97.251])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 00:29:22 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: iKELhlls3Fzi4U23FvR0b8Q1kzjm5J4x3sNvc0t3cb00eYaxfMDwEnbLOnsHY
        ARzzBdHUJjxcMntmy371ZHfTdCL5uNnAb3gqXorttZ4iwMY3/TVn2yxyY/4c9z2hcDC6H9T
        00XGrUlkImg6xjqnwvSOHAVZkCEYK8ww/+IWI/5RyNYC6ze9T6iurdXYv97I++5/jHqde8f
        cpl3qySa7X1MDzqOqzHGCJ8eAy9nTTM4D/C9CttvUCuGSK05My1Cz3YCd4bnxkqBQbKi3wL
        mbMKuwuVG4adQvablXn0QFOcoN132y/xk8qyfZSP4WTyxQ3QE85WZUbo33rAbOQsW0WworI
        +z9i7Tf7RQtDb3iTgj/IFVendYzDfrZPRueX77yf6p/Uq7D0pA=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, kishon@ti.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH 2/3] mmc: sdhci-esdhc-imx: Fix comment typo
Date:   Mon, 18 Jul 2022 16:26:49 +0800
Message-Id: <20220718082650.9784-2-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718082650.9784-1-wangborong@cdjrlc.com>
References: <20220718082650.9784-1-wangborong@cdjrlc.com>
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
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
2.35.1

