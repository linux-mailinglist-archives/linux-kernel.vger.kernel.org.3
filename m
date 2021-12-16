Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0BE4775D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbhLPPYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:24:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55052 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbhLPPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:24:48 -0500
Date:   Thu, 16 Dec 2021 15:24:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639668287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBCpCAq96OL5PYH3i8pPiaRjf7agvjj7PjYDyEf2KQg=;
        b=TwDMgMw+uzHUcmRIl3GLWW9zLvwFZVphbSCqorKVrN7GA9yrXtYcgBdPzyDL9MQuHL9PhS
        snj28NF4DM0w9aOFuCMOtCizV3ep6VhmLRCKSxy4vCiOcwvtLQamWMxHDf0uIZvaf+TXaN
        1hrRm7xIU9as5Ecwuvgy+niG35V6GMWrDnsZU6hBzBz/wyqfA9SggyCYL3XrKVBRdLhbqZ
        zdjD5r0yj8mDK/FgdBGBL+fik6FN3NEJMHyuRtD37VvTVKGmbotJZWD+mePZpeXNdilsFF
        vzivjrdfNnlpNPC3ks719ZSqHsU0+Hd2PbaPhjmEa3almIg+UyWDq8cdNNNzxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639668287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBCpCAq96OL5PYH3i8pPiaRjf7agvjj7PjYDyEf2KQg=;
        b=R3wBsVuAcs/a/uEE2lfEMwcKbXregyHMOjRvUiX505rwUa1Aej8Uj9L5bWou3LqEw3uSKd
        8pX9YUITLbQcBtBg==
From:   "irqchip-bot for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/imx-gpcv2: Mark
 imx_gpcv2_instance with __ro_after_init
Cc:     Peng Fan <peng.fan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211214084711.1357325-1-peng.fan@oss.nxp.com>
References: <20211214084711.1357325-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <163966828605.23020.10155713322275168793.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     29e525cc825e33ea0da2ac0fbf951e418fc28c69
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/29e525cc825e33ea0da2ac0fbf951e418fc28c69
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Tue, 14 Dec 2021 16:47:11 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Dec 2021 15:19:43 

irqchip/imx-gpcv2: Mark imx_gpcv2_instance with __ro_after_init

imx_gpcv2_instance will not be updated after init, so mark it with
__ro_after_init.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211214084711.1357325-1-peng.fan@oss.nxp.com
---
 drivers/irqchip/irq-imx-gpcv2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 5b5a365..b9c22f7 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -26,7 +26,7 @@ struct gpcv2_irqchip_data {
 	u32			cpu2wakeup;
 };
 
-static struct gpcv2_irqchip_data *imx_gpcv2_instance;
+static struct gpcv2_irqchip_data *imx_gpcv2_instance __ro_after_init;
 
 static void __iomem *gpcv2_idx_to_reg(struct gpcv2_irqchip_data *cd, int i)
 {
