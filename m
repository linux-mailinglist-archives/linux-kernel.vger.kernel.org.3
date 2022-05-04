Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E0051A52B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353273AbiEDQTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353247AbiEDQSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311AFD94
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:15:15 -0700 (PDT)
Date:   Wed, 04 May 2022 16:15:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651680913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4to5n7sOJdQwEe8TV7DhguB3iQQ4hTVBK/b43Hwks5g=;
        b=NlE76ENgA8f6RIifz5J+d2/SfviePDlHNQOKPlBbAq4E6qm/o2Huuqw5dUgaBlz2C2I5OO
        4Nbq210L+UQ/jeh5smdOKCc3xNR2i2MbjH86akN6dadSlX0pUFawM387dUgiT2waWqlTwU
        qP7dP13mLtJR8eQUIKqOxqVe3D3/PAb7hq/qqAUP20FpaSwmfQvJB3NRm6VAOBsGB1kLff
        cj4ZrA1KF5VqFnR1k7PZUImIo7XE1isGqhnC0DheESBCSfVc942QYR4zrzdfymBOlKP962
        Uh00AgVhG244unScGANqlApZA73c5DZodA2Gr78kn2w8vxmRPneshdqI+nT2Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651680913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4to5n7sOJdQwEe8TV7DhguB3iQQ4hTVBK/b43Hwks5g=;
        b=A9xxra6XzuMb5pVzXTRChtbahpwgQeIthFWRmJD0uvwvgfq0qM/K7ax+HAaEXMRGxBD+u0
        yhauRmAqboyFq/Bw==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/sun6i-r: Use NULL for chip_data
Cc:     kernel test robot <lkp@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220424173952.36591-1-samuel@sholland.org>
References: <20220424173952.36591-1-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165168091269.4207.6786695383349559922.tip-bot2@tip-bot2>
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

Commit-ID:     1b2eb89ccf4ffff2ea83c41451b3fed709cd3fc8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1b2eb89ccf4ffff2ea83c41451b3fed709cd3fc8
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Sun, 24 Apr 2022 12:39:51 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 16:36:59 +01:00

irqchip/sun6i-r: Use NULL for chip_data

sparse complains about using an integer as a NULL pointer.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220424173952.36591-1-samuel@sholland.org
---
 drivers/irqchip/irq-sun6i-r.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
index 4cd3e53..a01e440 100644
--- a/drivers/irqchip/irq-sun6i-r.c
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -249,11 +249,13 @@ static int sun6i_r_intc_domain_alloc(struct irq_domain *domain,
 	for (i = 0; i < nr_irqs; ++i, ++hwirq, ++virq) {
 		if (hwirq == nmi_hwirq) {
 			irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-						      &sun6i_r_intc_nmi_chip, 0);
+						      &sun6i_r_intc_nmi_chip,
+						      NULL);
 			irq_set_handler(virq, handle_fasteoi_ack_irq);
 		} else {
 			irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-						      &sun6i_r_intc_wakeup_chip, 0);
+						      &sun6i_r_intc_wakeup_chip,
+						      NULL);
 		}
 	}
 
