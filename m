Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2DE4908A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbiAQMYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbiAQMYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:24:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59E3C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:24:24 -0800 (PST)
Date:   Mon, 17 Jan 2022 12:24:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642422263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZVEXXyfBUrpTTBZNXwJvWy0L0Qx06oa77j1XLIg4ek=;
        b=gF92KpQjLc/9+PCFXqwArY8boArWbqqOJg+kIqmB76psY41iG31SMSII/CM578fo8C6mEE
        pg6EPw8xt/M/qGBp4XFqScq6qwrxydb4atqJBrGclo/TsXMHBwvzZ5yUG1CIKR7q5MBoVV
        pK0QUei1cGZhg1uVPehut/K9Pcl3WWPMaot5q2g+6L2jejVBm0hXI4hzacmuT6Fc5GYdWC
        VdH0VtS9HX8aXn8BZg5WlRVj3nR6GxWLKSMWjGagCEHIiqrMMZR+BUcO6BlRR/TIKxwgT/
        ziuvxRpSHi6XMwLq8eABzZ+8iHqdtJC5MHoWSx9EkM5NHP3KvMDoaUYDp5myLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642422263;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZVEXXyfBUrpTTBZNXwJvWy0L0Qx06oa77j1XLIg4ek=;
        b=2jqo5NmK3ZpuwKalZzFUHN4+h9ySf2hyAa6/mRwsW7F2gg4+YkrH8U61E1VFWK4JKuLgV6
        sKJgvMMNtGuQxLAg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/apple-aic: Drop unused ipi_hwirq field
Cc:     Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
        tglx@linutronix.de
In-Reply-To: <20220108140118.3378937-1-maz@kernel.org>
References: <20220108140118.3378937-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164242226258.16921.4490894235029862313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     45378cd33905966baf16d12ab0adbd56794ee075
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/45378cd33905966baf16d12ab0adbd56794ee075
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 08 Jan 2022 14:01:18 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 17 Jan 2022 12:12:26 

irqchip/apple-aic: Drop unused ipi_hwirq field

This field was never used, remove it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Hector Martin <marcan@marcan.st>
Link: https://lore.kernel.org/r/20220108140118.3378937-1-maz@kernel.org
---
 drivers/irqchip/irq-apple-aic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 3759dc3..53c4783 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -178,7 +178,6 @@ struct aic_irq_chip {
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
 	int nr_hw;
-	int ipi_hwirq;
 };
 
 static DEFINE_PER_CPU(uint32_t, aic_fiq_unmasked);
