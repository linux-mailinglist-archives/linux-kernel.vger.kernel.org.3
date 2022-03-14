Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660FD4D7E97
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiCNJaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiCNJ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC943EF0;
        Mon, 14 Mar 2022 02:28:29 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250108;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TMzalIRHv2xmi+kniv+zWAvVC30QB2FiFE/xTXAcOA=;
        b=q0QImK5ljTEz4oogxLhbEB+6SeBo4LQTMLos66oKnQko0klOZXAmwmqLRdfom0ksEh7Djt
        hOzFQXOHvOmEy7KRXvaPIc4ou4ZVSwi4rP9xm+b0MqC8boZiv6gMHCcZQGGCcUsx5bQ0Rt
        nusYJkH+hDSNs1QD+GgswR6YLo3KWpN7HMmxcZU44haRrjFBjYRQfMlTBikVs3yIc3d8AR
        +RIGs388hmdfDZG8Icll3tbPF8TZcPb6FAyO3WrggeqfAxjlr0mFmXu+lxqt4Gban8qL0y
        MtDnrpfeps3HFosUrspMeSpPRqSbvdGDZN6nJtzmVkZj5hbimrmdhLl+vb9ZDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250108;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TMzalIRHv2xmi+kniv+zWAvVC30QB2FiFE/xTXAcOA=;
        b=ukzsmkNN51vC51ZxfRGNFBLUnvvPWbLW2+pUzM/Xet1ASB7jq3NRDhA0Zm2r7W8JKKBOqK
        U0cM1InWGLaxlEBA==
From:   "tip-bot2 for Alim Akhtar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Remove mct
 interrupt index enum
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220221174547.26176-1-alim.akhtar@samsung.com>
References: <20220221174547.26176-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Message-ID: <164725010743.16921.13475123967852849541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dfc597c9bca9b4447820a59fe86526f016be1458
Gitweb:        https://git.kernel.org/tip/dfc597c9bca9b4447820a59fe86526f016be1458
Author:        Alim Akhtar <alim.akhtar@samsung.com>
AuthorDate:    Mon, 21 Feb 2022 23:15:45 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:22 +01:00

clocksource/drivers/exynos_mct: Remove mct interrupt index enum

MCT driver define an enum which list global and local timer's
irq index. Most of them are not used but MCT_G0_IRQ and
MCT_L0_IRQ and these two are at a fixed offset/index.
Get rid of this enum and use a #define for the used irq index.

No functional changes expected.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Link: https://lore.kernel.org/r/20220221174547.26176-1-alim.akhtar@samsung.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 03782b3..341ee47 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -60,27 +60,17 @@
 #define MCT_CLKEVENTS_RATING		350
 #endif
 
+/* There are four Global timers starting with 0 offset */
+#define MCT_G0_IRQ	0
+/* Local timers count starts after global timer count */
+#define MCT_L0_IRQ	4
+#define MCT_NR_IRQS	12
+
 enum {
 	MCT_INT_SPI,
 	MCT_INT_PPI
 };
 
-enum {
-	MCT_G0_IRQ,
-	MCT_G1_IRQ,
-	MCT_G2_IRQ,
-	MCT_G3_IRQ,
-	MCT_L0_IRQ,
-	MCT_L1_IRQ,
-	MCT_L2_IRQ,
-	MCT_L3_IRQ,
-	MCT_L4_IRQ,
-	MCT_L5_IRQ,
-	MCT_L6_IRQ,
-	MCT_L7_IRQ,
-	MCT_NR_IRQS,
-};
-
 static void __iomem *reg_base;
 static unsigned long clk_rate;
 static unsigned int mct_int_type;
