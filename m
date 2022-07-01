Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12777563461
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiGAN34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGAN3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:29:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCAF12AEA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:29:52 -0700 (PDT)
Date:   Fri, 01 Jul 2022 13:29:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656682190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xgqgsw3iiFBa56MxrKpPVQNNBJ7OnwzHYMkaiEQ/t/8=;
        b=QCSDDYGsAx6PZ6qstuaMtxSEQUxSWdx2SHXeeUunbyxrAtTjUWhAZp5ZdSAIVfwrDcqrw/
        rVTtxcKOVra1DliY/wCLhRh1Zs4zIJIiwpLyJg6P8UFBNZU8O947GnMQuhB4E3nUy+yG9I
        4s3SUOyf/vR4Ej0yCbzrO1uvihrz58Rneug+05sCRThsQ9hqF9ZHv5uPt6x0Z6dPm3X8hY
        RAwH0+MPDWzPvVr9tYTrB3JkEuQ2hU/Ujqrp7JfHknZOTVF9WC7RBJRdC1fjz8lQDSjgyQ
        HlazSRAeuVSIZxSME95CO+pK2hs0yH+Om4PujudF8V7hkHxRReXsMZHHo940lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656682190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xgqgsw3iiFBa56MxrKpPVQNNBJ7OnwzHYMkaiEQ/t/8=;
        b=PVizgzZCAVN/jfRxOgjC9OJEwmpryWtpirdQy+keer9SDVQ3ian3c3V62sNE6IUgALzcMn
        0BogRX9/CQxhcHBA==
From:   "irqchip-bot for Wei Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/apple-aic: Make symbol
 'use_fast_ipi' static
Cc:     Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220618072824.562350-1-weiyongjun1@huawei.com>
References: <20220618072824.562350-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Message-ID: <165668218855.15455.14423377159998750578.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     1357d2a65601bc0afb221672d5a8f1649063a141
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1357d2a65601bc0afb221672d5a8f1649063a141
Author:        Wei Yongjun <weiyongjun1@huawei.com>
AuthorDate:    Sat, 18 Jun 2022 07:28:24 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 01 Jul 2022 14:26:13 +01:00

irqchip/apple-aic: Make symbol 'use_fast_ipi' static

The sparse tool complains as follows:

drivers/irqchip/irq-apple-aic.c:231:1: warning:
 symbol 'use_fast_ipi' was not declared. Should it be static?

This symbol is not used outside of irq-apple-aic.c, so marks it static.

Fixes: 2cf68211664a ("irqchip/apple-aic: Add Fast IPI support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220618072824.562350-1-weiyongjun1@huawei.com
---
 drivers/irqchip/irq-apple-aic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 5ac8318..1c2813a 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -228,7 +228,7 @@
 #define AIC_TMR_EL02_PHYS	AIC_TMR_GUEST_PHYS
 #define AIC_TMR_EL02_VIRT	AIC_TMR_GUEST_VIRT
 
-DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
+static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
 
 struct aic_info {
 	int version;
