Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613175A070A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiHYB7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiHYB7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:59:05 -0400
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 18:54:04 PDT
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58949AF98;
        Wed, 24 Aug 2022 18:54:04 -0700 (PDT)
X-QQ-mid: bizesmtp77t1661392164tspq557z
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 09:49:21 +0800 (CST)
X-QQ-SSF: 01000000000000B0B000000A0000000
X-QQ-FEAT: wF64VgvUy+UPmdenfmPgcpMnG/bIuQR5LxITUxHsRnPRidiX7aAe4ASUhtDZI
        M6DTRXNv4D9uXWp8gBj0o/jR7OSoaCbHI+eSpmh6AalhtNleztq1dxuz/5y1jgW9b0uF2YL
        RyJ8+9oJaG1wwWGQhhvSD89CwlqqRmg2n586OIWYdG+xJUg6MFW+bp5CltWAtUILppkM3QS
        9IWTYtmKQij7KoEHTPwla8OjTinML9D9t2LDRsMB9UOUkuqhe5dsrBuEeQEPl0aCQo+b3QJ
        oAax4IdicnOxwwa8hxBVScBRuN8Ji3QlXF6m5jtoAJcPmLBB2EEDbNE7chgTJ3z+wVuNTze
        l37oHm/IxFfz+60hCde6UbQJr7imORqaNktAJ/wd/WsWGQFwC8=
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] pinctrl: at91: Fix double word in comments
Date:   Wed, 24 Aug 2022 21:49:21 -0400
Message-Id: <20220825014921.6135-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the rebundant word "the" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/pinctrl/pinctrl-at91.c        | 2 +-
 drivers/xen/xen-pciback/pciback_ops.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index d91a010e65f5..f1234e719e58 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1748,7 +1748,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	writel_relaxed(~0, at91_gpio->regbase + PIO_IDR);
 
 	/*
-	 * Let the generic code handle this edge IRQ, the the chained
+	 * Let the generic code handle this edge IRQ, the chained
 	 * handler will perform the actual work of handling the parent
 	 * interrupt.
 	 */
diff --git a/drivers/xen/xen-pciback/pciback_ops.c b/drivers/xen/xen-pciback/pciback_ops.c
index e38b43b5065e..52da75bf8485 100644
--- a/drivers/xen/xen-pciback/pciback_ops.c
+++ b/drivers/xen/xen-pciback/pciback_ops.c
@@ -160,7 +160,8 @@ int xen_pcibk_enable_msi(struct xen_pcibk_device *pdev,
 	}
 
 	/* The value the guest needs is actually the IDT vector, not the
-	 * local domain's IRQ number. */
+	 * local domain's IRQ number.
+	 */
 
 	op->value = dev->irq ? xen_pirq_from_irq(dev->irq) : 0;
 
-- 
2.35.1

