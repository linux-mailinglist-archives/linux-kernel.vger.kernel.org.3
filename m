Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B0357984D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiGSLVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGSLVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:21:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88AF1EC66
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:21:16 -0700 (PDT)
Date:   Tue, 19 Jul 2022 11:21:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658229675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pk1fyLIsHfoRQmsXJ2jTqaeievyMkNJS1qcck37CGn0=;
        b=34bIPmpUaFStzlySqwCz7cQidmwiUVlvnc2ot5rkrohq1EuUdmnggkLoozCeBLVkqMU0Ce
        08Uum1OTN65kMVpgwUlqUCcyl8EQqusSCCR9BX4LzfNkkG7iy1TFMEpOfyhQH2EsYMOOXO
        wl7EACsk/tHYstZ37URKygqsS2GgrGTYjTZSmU0o3Le31932FQkrvor/SvWpV7xecH9hOp
        Fgo8XmIeGMLZ+UJ57yAbcz5sqhsYAWZK9EhTlf9Mca7DNaiXfbbKKyEMEZ1OVsGAWP2Gsv
        sHB6m9FrSwmxOWl8XcGHLw/DknUSh8CelCVWCoRwKJn8x/iL5nr+1YnAoULNEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658229675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pk1fyLIsHfoRQmsXJ2jTqaeievyMkNJS1qcck37CGn0=;
        b=um/+e1JChdmO+Soavows5bDlszEty+Q7u/hpwFJp6uS3SJXn6/CJRlESZzd8ZDVPbCgVy5
        YoCll0602uDMQACQ==
From:   "irqchip-bot for Jason Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Fix comment typo
Cc:     Jason Wang <wangborong@cdjrlc.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220715051258.28889-1-wangborong@cdjrlc.com>
References: <20220715051258.28889-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Message-ID: <165822967317.15455.7810652368125768179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     295171705c9ac98f4626609033f6bab0c2e37ed0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/295171705c9ac98f4626609033f6bab0c2e37ed0
Author:        Jason Wang <wangborong@cdjrlc.com>
AuthorDate:    Fri, 15 Jul 2022 13:12:58 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Jul 2022 12:13:31 +01:00

irqchip/gic-v3: Fix comment typo

The double `the' is duplicated in line 1786, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220715051258.28889-1-wangborong@cdjrlc.com
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5c1cf90..d28b45f 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1783,7 +1783,7 @@ static void gic_enable_nmi_support(void)
 	 * the security state of the GIC (controlled by the GICD_CTRL.DS bit)
 	 * and if Group 0 interrupts can be delivered to Linux in the non-secure
 	 * world as FIQs (controlled by the SCR_EL3.FIQ bit). These affect the
-	 * the ICC_PMR_EL1 register and the priority that software assigns to
+	 * ICC_PMR_EL1 register and the priority that software assigns to
 	 * interrupts:
 	 *
 	 * GICD_CTRL.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Group 1 priority
