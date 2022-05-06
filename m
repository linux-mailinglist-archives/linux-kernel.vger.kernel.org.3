Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1251D699
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391305AbiEFL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbiEFL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:28:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C505469C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:25:16 -0700 (PDT)
Date:   Fri, 06 May 2022 11:25:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651836315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEEiGomcOYhMnteRAbtxxaEBfAek9bdMMc4yXKiUfs4=;
        b=NLTyj2t/tpMdbbWHvhlX5Eo/nRj4d3GxMkZBs9poDhRWRhPb3yqvZYpVe9+R+EdcxwxaGv
        WuLCD9Uzjur8vguxhF0Xk2EcnLR0MJx6bPnflteiE68jQeVUTALXDu2ZInQzqzXvtD+Sck
        1r48g8aju3q/Air3XHu2K5ul2BzzYKpciipeMgClFGXayJ1kaEXsDYzThO3Hb37GCUagon
        yCUDH+V2APYL1DjYdiuEl0uhokfsyB/rjR8cK444qfmAullqe+hQSLL+IrgZKOxkZSEWIH
        PB0pscdHUtP8sTyoWnMnWZ1VUZNGmu55U1lJGYSGynW6eytApc0Q+esnK/PT1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651836315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yEEiGomcOYhMnteRAbtxxaEBfAek9bdMMc4yXKiUfs4=;
        b=jRqUjnmE9C8PV8vpYxKccRHUvoUMYw5ZjhqJa5/N1O9geX6fyMkcTtXFhOe7YmRtCixEHr
        KFvF6kosKR7yo/CQ==
From:   irqchip-bot for Pali =?utf-8?q?Roh=C3=A1r?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/armada-370-xp: Do not allow
 mapping IRQ 0 and 1
Cc:     pali@kernel.org, Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220425113706.29310-2-pali@kernel.org>
References: <20220425113706.29310-2-pali@kernel.org>
MIME-Version: 1.0
Message-ID: <165183631358.4207.11410029183803941850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     baf78c1078b474aed18864796a8161784dd81fc2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/baf78c1078b474aed18864796a8161784dd81fc2
Author:        Pali Roh=C3=A1r <pali@kernel.org>
AuthorDate:    Mon, 25 Apr 2022 13:37:06 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 06 May 2022 12:20:27 +01:00

irqchip/armada-370-xp: Do not allow mapping IRQ 0 and 1

IRQs 0 and 1 cannot be mapped, they are handled internally by this driver
and this driver does not call generic_handle_domain_irq() for these IRQs.
So do not allow mapping these IRQs and correctly propagate error from the
.irq_map callback.

Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220425113706.29310-2-pali@kernel.org
---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index ee18eb3..ab02b44 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -567,6 +567,10 @@ static struct irq_chip armada_370_xp_irq_chip =3D {
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
+	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
+	if (hw <=3D 1)
+		return -EINVAL;
+
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	if (!is_percpu_irq(hw))
 		writel(hw, per_cpu_int_base +
