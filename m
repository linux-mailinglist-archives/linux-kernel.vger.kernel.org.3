Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8774AF65E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiBIQRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiBIQRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:17:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB5C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:17:51 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423469;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1KQm9EMSzkWWhOOn+ExIpeFWSKFUcNJFZ4OVf2jrno8=;
        b=o5rKqW0iFe71WUp4HADFjcjFmKccjxluXgHnHxq1RixY3oi/fd0FNeVrk2/EtR3RTGrUF9
        8dowRkpK1j6jHx6uSLEutLptMhYuLxLH84Hl1I8UA2VLkIczx0y7MfIeSaJUBRsZju5Mku
        2uxK3EC6nBDxAXxM/mIC6azh8uAHYlkShrFnfsRN1xRjBR44oJVIXChq7SS6ETdx76rZYG
        +mpzpI6NmTokPjn1itKqny7F2geRkdZnE+YmDqaR9OyCj5luBoMlKZuUGPZskZvcz1HIJU
        Nq18SPxbXj/V1Jl9kOxoYJ5fqwgrHOrLVCPAEpdxp/DXoGqygkOX8x3t1gVNEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423469;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1KQm9EMSzkWWhOOn+ExIpeFWSKFUcNJFZ4OVf2jrno8=;
        b=rB0PEqfjuOUdM3v2B8bswspP8fS8v5Q1wKeT18hvgAuLRiMQaF/CFdfvsqXEcDcGND/adp
        M9Wn18BhnXkO/MAA==
From:   "irqchip-bot for Alexandre Torgue" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] ARM: dts: stm32: Enable EXTI on stm32mp13
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220202140005.860-4-alexandre.torgue@foss.st.com>
References: <20220202140005.860-4-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Message-ID: <164442346834.16921.4768307930127665697.tip-bot2@tip-bot2>
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

Commit-ID:     56a85388115b8513917ea269e116d7962dd6fab4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/56a85388115b8513917ea269e116d7962dd6fab4
Author:        Alexandre Torgue <alexandre.torgue@foss.st.com>
AuthorDate:    Wed, 02 Feb 2022 15:00:05 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:43:13 

ARM: dts: stm32: Enable EXTI on stm32mp13

As EXTI/GIC mapping has changed between STM32MP15 and STM32MP13, a new
compatible is needed to choose mp13 mapping table in stm32-exti driver.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220202140005.860-4-alexandre.torgue@foss.st.com
---
 arch/arm/boot/dts/stm32mp131.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 86126dc..c249dbe 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -115,6 +115,13 @@
 			status = "disabled";
 		};
 
+		exti: interrupt-controller@5000d000 {
+			compatible = "st,stm32mp13-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x5000d000 0x400>;
+		};
+
 		syscfg: syscon@50020000 {
 			compatible = "st,stm32mp157-syscfg", "syscon";
 			reg = <0x50020000 0x400>;
