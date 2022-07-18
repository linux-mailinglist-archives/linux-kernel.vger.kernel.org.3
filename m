Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1166C57D182
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiGUQaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGUQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:30:28 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6BE1929D;
        Thu, 21 Jul 2022 09:30:20 -0700 (PDT)
X-QQ-mid: bizesmtp82t1658420979t2qk79c7
Received: from localhost.localdomain ( [171.223.97.251])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 00:29:36 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000000
X-QQ-FEAT: 9E3Ddn8eo0KhR0G4R2hlVZSMQQFWPkUDXyw8LJYpaLCpeVQ+YWs7fxvtUZQxv
        b9loq/ZFy7C9sVqPaMFh8tm7fq9ByAJiCzF31LBlqgAPn84zNL3Ee5IO54qr96X3vt4eb6m
        wtJv9znTD/I1Azjto4R2HWKckFrPBJNAtHtLCzKhIadDTN0HbFj6Uiy+1HtSyGLLTUkSQML
        nX0+aRl0xdthOlhDmJ2YxhweAHrx4ZuZpvxlTOrmuqtf4RCnyrXFI2KaWf7SzQ/lEHZUVKr
        Napap63FLAh82670T1J/g1JKHlkstZckqcdkoI2MnvEEz0DWv6LxW7RlfncIunDQKJGU4vK
        2natlCpSKe/v1aHXcBDyp4ZLhkKaRjZRlsArZIjPmmSbRx3cT0=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, kishon@ti.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH 3/3] mmc: sdhci-omap: Fix comment typo
Date:   Mon, 18 Jul 2022 16:26:50 +0800
Message-Id: <20220718082650.9784-3-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718082650.9784-1-wangborong@cdjrlc.com>
References: <20220718082650.9784-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `any' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/mmc/host/sdhci-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 033be559a730..8ed9256b83da 100644
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
-- 
2.35.1

