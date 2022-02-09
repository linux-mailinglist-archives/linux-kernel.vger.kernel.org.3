Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD94AF657
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiBIQR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbiBIQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:17:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC10C0612BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:17:52 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsfnIUi4R9TmarB5E8A4dVOi+a1yrugp/7QKyk/l3fc=;
        b=Lx4smNWjABPk1sNXJdZay7XSpAvKMqT7NeeWTQ+kNLZy595kuHeDKcjN5WWf2iQdsy2dSu
        saeGTgV/RN3NbRfOHPGkKv4KSGqb6Jq2VD6zYGzEEcuQ4QlUfStuKlJvmkXN/wmttNwjQG
        uWz1CmeCt+Ka6a5H7vwPOuQkFB3u9ilILapuO+LG+sBOop+rSAOYfOXwHKdJxRNs2D++JO
        uiN5+hzA6oCwd6DvIdQOlo2UsK4OovbbGKCtlNOStzSLT+gjUleDDRxJDY/jyUtZk9O6Ff
        NFPFWXeWAY/Zg8SYhVQZsNIcWopqm1inyKQKV1JwRoxs5epjGtvaP0trMiGVpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsfnIUi4R9TmarB5E8A4dVOi+a1yrugp/7QKyk/l3fc=;
        b=lsy7Mp7mBlQHyQsjmIRB/vserRhPFwnq9Wqqv0ur14QxTSlTca3X5hlq+161UmiDauG7Eb
        xiX8CdQn5fNtBpBA==
From:   "irqchip-bot for Alexandre Torgue" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 stm32-exti: document st,stm32mp13-exti
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220202140005.860-2-alexandre.torgue@foss.st.com>
References: <20220202140005.860-2-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Message-ID: <164442347028.16921.11122272581930963953.tip-bot2@tip-bot2>
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

Commit-ID:     d335092933079e0a48c61ea5791906d040105a4d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d335092933079e0a48c61ea5791906d040105a4d
Author:        Alexandre Torgue <alexandre.torgue@foss.st.com>
AuthorDate:    Wed, 02 Feb 2022 15:00:03 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:42:51 

dt-bindings: interrupt-controller: stm32-exti: document st,stm32mp13-exti

Support of STM32MP13 SoC implies to create a new compatible in order to
manage EXTI/GIC mapping changes.

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220202140005.860-2-alexandre.torgue@foss.st.com
---
 Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
index d19c881..e44daa0 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
@@ -20,6 +20,7 @@ properties:
       - items:
           - enum:
               - st,stm32mp1-exti
+              - st,stm32mp13-exti
           - const: syscon
 
   "#interrupt-cells":
