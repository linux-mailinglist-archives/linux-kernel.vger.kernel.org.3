Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71994D1DFE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348342AbiCHQ5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiCHQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:57:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC74EF56
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:56:43 -0800 (PST)
Date:   Tue, 08 Mar 2022 16:56:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646758601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=knDFfYSc1r+BLFuqKbf2kfPJLbvVQIs2X47DbiQu5lQ=;
        b=LIxMbR7Qa4/j+SzaLXLk3ZIQqqj653oelG/jpb3pDpLnR7uxCtPSOMzSKCzhdcef0EPWKv
        m8tlYlYyxZ1/m9ohoqhAbl3tjuGW/Elo0LthlFdEXugb9gX7V9VQRXAGd/5aZ7/qycO6JD
        TCsucdL8w3tUEI308d86E1QP0BxBPWBEg142lR80t51fTPbion3FLr5+t23rMcTWki7CqP
        FhPZZ4u/RRa0k4PmjGWmD+aO7CsD9i8I5fb0L+aZ33dZIau1YIfCJHCql/xhrTPD0ocuft
        ylnmDkkY0+Kr8j6vOHwLAic4h8MjXAPBWZWc9h6deFYVUI9PqIe61/MrZ1ONVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646758601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=knDFfYSc1r+BLFuqKbf2kfPJLbvVQIs2X47DbiQu5lQ=;
        b=CpO9ApAe8pf81dO1rMcl89otAySbwsQB91PxtaCSSLnN7ZhjnQhOjc+YOimBz+WVa1TPUa
        PpSY8SU3N6CgWxAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Move PMU-specific
 registers to their own include file
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <164675859974.16921.1432367425483508379.tip-bot2@tip-bot2>
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

Commit-ID:     11db7410cfcba2e5ffed7b8bb2a57d4dd5e22063
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/11db7410cfcba2e5ffed7b8bb2a57d4dd5e22063
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 03 Nov 2021 13:55:19 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 07 Feb 2022 16:00:42 

irqchip/apple-aic: Move PMU-specific registers to their own include file

As we are about to have a PMU driver, move the PMU bits from the AIC
driver into a common include file.

Reviewed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/apple_m1_pmu.h | 19 +++++++++++++++++++
 drivers/irqchip/irq-apple-aic.c       | 11 +----------
 2 files changed, 20 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/include/asm/apple_m1_pmu.h

diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
new file mode 100644
index 0000000..b848af7
--- /dev/null
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __ASM_APPLE_M1_PMU_h
+#define __ASM_APPLE_M1_PMU_h
+
+#include <linux/bits.h>
+#include <asm/sysreg.h>
+
+/* Core PMC control register */
+#define SYS_IMP_APL_PMCR0_EL1	sys_reg(3, 1, 15, 0, 0)
+#define PMCR0_IMODE		GENMASK(10, 8)
+#define PMCR0_IMODE_OFF		0
+#define PMCR0_IMODE_PMI		1
+#define PMCR0_IMODE_AIC		2
+#define PMCR0_IMODE_HALT	3
+#define PMCR0_IMODE_FIQ		4
+#define PMCR0_IACT		BIT(11)
+
+#endif /* __ASM_APPLE_M1_PMU_h */
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 873544e..b40199c 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -55,6 +55,7 @@
 #include <linux/limits.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+#include <asm/apple_m1_pmu.h>
 #include <asm/exception.h>
 #include <asm/sysreg.h>
 #include <asm/virt.h>
@@ -109,16 +110,6 @@
  * Note: sysreg-based IPIs are not supported yet.
  */
 
-/* Core PMC control register */
-#define SYS_IMP_APL_PMCR0_EL1		sys_reg(3, 1, 15, 0, 0)
-#define PMCR0_IMODE			GENMASK(10, 8)
-#define PMCR0_IMODE_OFF			0
-#define PMCR0_IMODE_PMI			1
-#define PMCR0_IMODE_AIC			2
-#define PMCR0_IMODE_HALT		3
-#define PMCR0_IMODE_FIQ			4
-#define PMCR0_IACT			BIT(11)
-
 /* IPI request registers */
 #define SYS_IMP_APL_IPI_RR_LOCAL_EL1	sys_reg(3, 5, 15, 0, 0)
 #define SYS_IMP_APL_IPI_RR_GLOBAL_EL1	sys_reg(3, 5, 15, 0, 1)
