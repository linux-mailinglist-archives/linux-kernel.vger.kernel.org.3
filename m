Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252D051A52D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353294AbiEDQUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353215AbiEDQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FAD46B1A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:15:09 -0700 (PDT)
Date:   Wed, 04 May 2022 16:15:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651680908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=979E4Xu7QN4ovM5JgHIMaZepiBPTzE8DUHniwh1uTxs=;
        b=xoGRDO3fmEmiomWki/+p3r34+DpImkWM4AyGAttbgbVH9f9EXGFQxWlXE4oqsPDpTRBY4j
        ZEbUg46Iz+OHEmt4bgh2+Y7FbSbgjh2GaLwfKqsL0UQZSBAGEA/A0ZG6MUQP2SJvXsTkyX
        ld2allyxqCQ8Mc9AagpbAQLTPCUi6+um5Sd6HpQU8CKC0Y0AXeQlZ1R/oKKSa4NPEVLC/j
        BBVWk+gzj6JBGOXVy66pnJ1f0M+AxVcxc6z7Uy+q3z4TexrGR6PvOe2LlYLegv2AIRhXSY
        +R5aD48MBLvrCM2DZ0QpPozeyDHnxSddqrFmOSPjq7XbO3ziJX3nox6bnxy4qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651680908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=979E4Xu7QN4ovM5JgHIMaZepiBPTzE8DUHniwh1uTxs=;
        b=exjWIUKiV3D83j8iMTs013bcm8+zLtVXIZy7y99ctbsfwCweyecx0UE9hD9IRvTgYewPqV
        z9/mmydujjUZyEAw==
From:   "irqchip-bot for Haowen Bai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/csky: Return true/false (not 1/0)
 from bool functions
Cc:     Haowen Bai <baihaowen@meizu.com>, Guo Ren <guoren@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <1647487284-30088-1-git-send-email-baihaowen@meizu.com>
References: <1647487284-30088-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Message-ID: <165168090696.4207.17138569704564180194.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     0c16e931a735500f15db74916db56c698d8ff735
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0c16e931a735500f15db74916db56c698d8ff735
Author:        Haowen Bai <baihaowen@meizu.com>
AuthorDate:    Thu, 17 Mar 2022 11:21:24 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 16:49:47 +01:00

irqchip/csky: Return true/false (not 1/0) from bool functions

Return boolean values ("true" or "false") instead of 1 or 0 from bool
functions.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1647487284-30088-1-git-send-email-baihaowen@meizu.com
---
 drivers/irqchip/irq-csky-apb-intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index d36f536..42d8a24 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -136,11 +136,11 @@ static inline bool handle_irq_perbit(struct pt_regs *regs, u32 hwirq,
 				     u32 irq_base)
 {
 	if (hwirq == 0)
-		return 0;
+		return false;
 
 	generic_handle_domain_irq(root_domain, irq_base + __fls(hwirq));
 
-	return 1;
+	return true;
 }
 
 /* gx6605s 64 irqs interrupt controller */
