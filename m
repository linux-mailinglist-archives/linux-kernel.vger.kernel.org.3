Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A05F4D1DFF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiCHQ5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiCHQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:57:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D4351E46
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:56:43 -0800 (PST)
Date:   Tue, 08 Mar 2022 16:56:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646758602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GQNkFCZfZyk8icRD65OAQJctmut6o4vtWqiLmJig9zs=;
        b=FRzJrVdyap/2A1AMExZe94UrYfTeYwM9Z5PGJ+uaWHZu2NZxLNJnWCvomC7KIJcBJGGdUg
        HJ6Hac65SjFVKKPYrxL46+7k7x/aNvRwEezU2NxPxC8fzXZ2tOpGytFNOuj4iEmsEEWVmm
        4nLOgHXryGWxmVaVkz8xA8NunFstQ8GEoZN3/jhTBAFMvTVYNOXx+yeyu5ZH9Yl2nQ+h6+
        xS67mhG40/1AMMIJ6Hb7VqSJw0aNYB50Ljvh3jhzTYfMfFZq9+DLanaDxXMMMh3ns8Gp8S
        cI7Quk/dD/uA9H9G+mwuMYsdo26j16gXJ+kcGmrFaqZHZUc+Yx1VNgk37pzlWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646758602;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GQNkFCZfZyk8icRD65OAQJctmut6o4vtWqiLmJig9zs=;
        b=tyjp1bfkrtnwF+7CglUT9eVMejH6F9M31WS5rS9uXbRfoy2JX8KMAao4UWXZVdOjHcy4RN
        F/Glwca7iHqMHPCQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64: dts: apple: Add t8303 PMU nodes
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <164675860092.16921.4576631338044011697.tip-bot2@tip-bot2>
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

Commit-ID:     0f522efcd79634a6113195842ee763dc6ebacfbb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/0f522efcd79634a6113195842ee763dc6ebacfbb
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 02 Nov 2021 17:09:49 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 07 Feb 2022 16:00:42 

arm64: dts: apple: Add t8303 PMU nodes

Advertise the two PMU nodes for the t8103 SoC.

Reviewed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index a2e0065..9f8f414 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -97,6 +97,18 @@
 			     <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	pmu-e {
+		compatible = "apple,icestorm-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,firestorm-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	clkref: clock-ref {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
