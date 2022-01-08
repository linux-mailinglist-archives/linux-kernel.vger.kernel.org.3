Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65944883E4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 15:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiAHOBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 09:01:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35874 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAHOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 09:01:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC20BB8090B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 14:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E52AC36AE9;
        Sat,  8 Jan 2022 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641650482;
        bh=SHxW8BUtoUOufGlYNFbmsT4r4xQb1806XYZ0UU+v4GA=;
        h=From:To:Cc:Subject:Date:From;
        b=Xsjxg2IciND1jX9JhkaZ/FOEnVcGSFf52DS55EGrLm/3Df4pAHPdy++0BzRcUtkiY
         SPdoGg9eDQz+d1iHl0JQCZJ1CBkxNVCyZyTsl9mqYBWsqDPsPhR+e94RU5sH4q2+Y0
         mnJHe+uztkkV/bzZrntgzJai6SYk9aBz4d0/dhzUi980wZ3fHkqnRG9i5cLgSbll9Z
         IFMNLp2ScAF0+nWHGAl2xVwdpMD7iLzUZby2MNqCxqCMIL1FII/srQ9/QhHETvkqsw
         vmWE9IdDaLzQdjdNgZ5YKv2LvnWvj+Re9oGsXARl7VQ+lkapn1FF24b2PnrXEmtJfB
         us/lK4C77c1yw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1n6CHY-00GlSZ-I2; Sat, 08 Jan 2022 14:01:20 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     marcan@marcan.st, Thomas Gleixner <tglx@linutronix.de>,
        kernel-team@android.com
Subject: [PATCH] irqchip/apple-aic: Drop unused ipi_hwirq field
Date:   Sat,  8 Jan 2022 14:01:18 +0000
Message-Id: <20220108140118.3378937-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, marcan@marcan.st, tglx@linutronix.de, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This field was never used, remove it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index a5927382172a..3683c71a4d27 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -172,7 +172,6 @@ struct aic_irq_chip {
 		cpumask_t aff;
 	} *fiq_aff[AIC_NR_FIQ];
 	int nr_hw;
-	int ipi_hwirq;
 };
 
 static DEFINE_PER_CPU(uint32_t, aic_fiq_unmasked);
-- 
2.30.2

