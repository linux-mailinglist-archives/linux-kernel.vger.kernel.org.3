Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BA746B7D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhLGJs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbhLGJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:46:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C64EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 01:43:24 -0800 (PST)
Date:   Tue, 07 Dec 2021 09:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638870201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xDSl5lpAaj5XQRMP9ub5QuQg52pIT8/mT2/BF9AZEiQ=;
        b=cO3q20mJ7xSZnP9osVGQyzIHI6aNzX1QTO5fAP6/f4P7stPdrm7eAQO5/ssYCpUuK2wung
        AZ7Jastt8RXFR1mK+vjxxVhBio+F9psbVZGS6pEJYuvteslXb10S+omncbBhfwSv3szMP9
        pPWrVwpgnEslQzbJCAzXBNX0bq+19UOuWAZl3wI7/yAkovv6ZtqpKRB6XFxLHrFBOCpoI6
        AZaGmDj3zAVS5VrkEPQQjmwvrzNwUGZHnhyFpaqlSwm1DBHnRmVeCx+NaRknnOe8vztNLy
        MSQ1O6bbezsBQuV5YsskfBQYqHF8ri4PJcDSZ2OznhjIK4eJdGM+mna0nEGYsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638870201;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xDSl5lpAaj5XQRMP9ub5QuQg52pIT8/mT2/BF9AZEiQ=;
        b=wpuu/QHGIoCkavmFVLPlyAKUixIhlVK4NltzcEBT8BTIsnonfPpX5W2Wb1xFfOve6S4qUB
        ePU/fwu9qL7O+RDw==
From:   "irqchip-bot for Donghyeok Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/apple-aic: Mark aic_init_smp() as __init
Cc:     Donghyeok Kim <dthex5d@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211204164228.5920-1-dthex5d@gmail.com>
References: <20211204164228.5920-1-dthex5d@gmail.com>
MIME-Version: 1.0
Message-ID: <163887020065.11128.15613324164044814104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     3d9e575f2acef57528ed6950b5f8ba99f5e52f3f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3d9e575f2acef57528ed6950b5f8ba99f5e52f3f
Author:        Donghyeok Kim <dthex5d@gmail.com>
AuthorDate:    Sun, 05 Dec 2021 01:42:28 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 07 Dec 2021 09:33:11 

irqchip/apple-aic: Mark aic_init_smp() as __init

This function is only called from the driver init code.

Signed-off-by: Donghyeok Kim <dthex5d@gmail.com>
Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211204164228.5920-1-dthex5d@gmail.com
---
 drivers/irqchip/irq-apple-aic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 3759dc3..2543ef6 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -707,7 +707,7 @@ static const struct irq_domain_ops aic_ipi_domain_ops = {
 	.free = aic_ipi_free,
 };
 
-static int aic_init_smp(struct aic_irq_chip *irqc, struct device_node *node)
+static int __init aic_init_smp(struct aic_irq_chip *irqc, struct device_node *node)
 {
 	struct irq_domain *ipi_domain;
 	int base_ipi;
