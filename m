Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73357579D85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiGSMwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbiGSMuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:50:55 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4025926C;
        Tue, 19 Jul 2022 05:20:01 -0700 (PDT)
X-QQ-mid: bizesmtp84t1658233113tf3r0e4k
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:18:32 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: bQsUcYFpAAZCL2K0fSWXqSFtpi8ZcffXy0TgbFPYGm0V4LCUMvUBbQin92pm6
        nrtiZHhtFFcJLhNG8O4Sn+pV4ThKUbAdyoYuX06CE6OtxxYUpQ2mpcq0Ig9Fs4/ltV5+5QX
        IE5wHbNJysFeDsdqcWtUVPQMOb6YBddIe8HyWRn7UIrC9Zo1siUUutohpux3cEviUVrl/4Y
        RPJRk3aMVxgYN0jabtH9bo+5IEJ3N/EfI166UkOp28zSKXzmPnwkELIfFhwKDEJRaPGzyLO
        qi55iIaOViJabhfPzFP08Ht0ut1WqHIzMdERy55bEg5uu3kH00WYEYr0qjcPadvZUlqELdm
        R1nI/hGYeSX1hvtuKs0KWpeC4Pqc4NI3o+Qd6PxPCA8N1pS37zAJcRqR/QsBcxpHUB7X4gy
        mQJI3hrZcE0=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     maz@kernel.org
Cc:     tsbogend@alpha.franken.de, fancer.lancer@gmail.com,
        tglx@linutronix.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] irqchip/mips-gic: Fix comment typo
Date:   Sat, 16 Jul 2022 12:16:19 +0800
Message-Id: <20220716041619.33629-1-wangborong@cdjrlc.com>
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
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 8a9efb6ae587..9464af4b53e7 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -494,7 +494,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
 
 	/*
-	 * If adding support for more per-cpu interrupts, keep the the
+	 * If adding support for more per-cpu interrupts, keep the
 	 * array in gic_all_vpes_irq_cpu_online() in sync.
 	 */
 	switch (intr) {
-- 
2.35.1

