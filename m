Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3D354524E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbiFIQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243444AbiFIQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:50:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC11839C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:50:24 -0700 (PDT)
Date:   Thu, 09 Jun 2022 16:50:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654793423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHOmdrsdIbYPVGwhcAboU9RJvv1TVanddfROKS0b62A=;
        b=OlGIsCc+r5qCFTVWVYM4WHgA0UfeUdiEUPV368QGMTP3ubLQuVw9SqeeA77BcJc1uveuP/
        7DOXPhXoSpbQy83HUCjce/rjx4o3wfZvEczuDdhRvwe6nQctuC796etUxdW/qO4SonPrx2
        cPB68jt2Sv8C6M/YVKOQ8tr3ecUD9tkiucX9W1gi9oS3TerMAqNaPRbgNXY9OVnRyt/59E
        uyKm1iAsnnJyCjiOmvjLbEI8iCB7gHrnsaHonmrm4Y7bec4cbuAmYspdFeVwwx0xUJ7Vrr
        J4x/o0d9E6xPwlSWD7Ah6i2uwe4/5ckci6ooyFgyTshkmQq2OsG1BW54uYrhJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654793423;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHOmdrsdIbYPVGwhcAboU9RJvv1TVanddfROKS0b62A=;
        b=hFYN45QFi6UhevtlPnNvEn0pUC3JHE+KooH+Nk4jg+nHKDSrZEPziViGEj+JZp/BnDWSV9
        OKmYMQmDEHNi8NCw==
From:   "irqchip-bot for Kunihiko Hayashi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/uniphier-aidet: Add compatible
 string for NX1 SoC
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <1653023822-19229-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1653023822-19229-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Message-ID: <165479342190.4207.7774447284523859230.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     e3f056a7aafabe4ac3ad4b7465ba821b44a7e639
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e3f056a7aafabe4ac3ad4b7465ba821b44a7e639
Author:        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
AuthorDate:    Fri, 20 May 2022 14:17:02 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 09 Jun 2022 17:41:57 +01:00

irqchip/uniphier-aidet: Add compatible string for NX1 SoC

Add the compatible string to support UniPhier NX1 SoC, which has the same
kinds of controls as the other UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1653023822-19229-3-git-send-email-hayashi.kunihiko@socionext.com
---
 drivers/irqchip/irq-uniphier-aidet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniphier-aidet.c
index 89121b3..716b1bb 100644
--- a/drivers/irqchip/irq-uniphier-aidet.c
+++ b/drivers/irqchip/irq-uniphier-aidet.c
@@ -237,6 +237,7 @@ static const struct of_device_id uniphier_aidet_match[] = {
 	{ .compatible = "socionext,uniphier-ld11-aidet" },
 	{ .compatible = "socionext,uniphier-ld20-aidet" },
 	{ .compatible = "socionext,uniphier-pxs3-aidet" },
+	{ .compatible = "socionext,uniphier-nx1-aidet" },
 	{ /* sentinel */ }
 };
 
