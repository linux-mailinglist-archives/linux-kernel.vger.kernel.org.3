Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9FD52E441
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 07:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345542AbiETFRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 01:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244485AbiETFRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 01:17:13 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 934F2B41E0;
        Thu, 19 May 2022 22:17:12 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 20 May 2022 14:17:12 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id EEBED2058B50;
        Fri, 20 May 2022 14:17:11 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 20 May 2022 14:17:11 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 4BA06B62B7;
        Fri, 20 May 2022 14:17:11 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/2] irqchip/uniphier-aidet: Add compatible string for NX1 SoC
Date:   Fri, 20 May 2022 14:17:02 +0900
Message-Id: <1653023822-19229-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653023822-19229-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1653023822-19229-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string to support UniPhier NX1 SoC, which has the same
kinds of controls as the other UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/irqchip/irq-uniphier-aidet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniphier-aidet.c
index 89121b39be26..716b1bb88bf2 100644
--- a/drivers/irqchip/irq-uniphier-aidet.c
+++ b/drivers/irqchip/irq-uniphier-aidet.c
@@ -237,6 +237,7 @@ static const struct of_device_id uniphier_aidet_match[] = {
 	{ .compatible = "socionext,uniphier-ld11-aidet" },
 	{ .compatible = "socionext,uniphier-ld20-aidet" },
 	{ .compatible = "socionext,uniphier-pxs3-aidet" },
+	{ .compatible = "socionext,uniphier-nx1-aidet" },
 	{ /* sentinel */ }
 };
 
-- 
2.25.1

