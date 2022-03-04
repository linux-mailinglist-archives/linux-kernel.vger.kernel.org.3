Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44964CD9AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiCDRFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240894AbiCDRFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:05:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0B1CD7E4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:04:39 -0800 (PST)
Date:   Fri, 04 Mar 2022 17:04:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646413478;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfF1KiANxs95jhlS6zk60mk4lWKI3jc7M9TTM9ZVnEM=;
        b=QDlunVq5yO3BDH1oGXAomLgNcjmEmw8SPBuNup47a1g7RzmsJydyxgVAkvt1cpIoETcxBJ
        8wzbU8vdlMItIy2Bgf7jxuB8h9GnRQIMCESL7a6uIRYgICugo0whQSXzXldMGllNZtiunB
        PDrD0zvmhB8RS0v0lMAX9QSkMKX/kGxmRV8LEMLOFftekGAGXqlcqu3Nx612K5D6KWqcGF
        /oG1Lf9R1aIudERC47yKq7dNzXQNvEKDJQbq6+2K1vhjZo+wrh3tE3OUMdrQxoXVuO+rlM
        YZA9SfuezPHXYtx6sC/dN1BQ2YK2YMDWXypDogStsXjZevFPk0k07wCKtXkvWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646413478;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfF1KiANxs95jhlS6zk60mk4lWKI3jc7M9TTM9ZVnEM=;
        b=fyJLbkq1+B6twx9XsnaWoLw25NQcLN+OOHUV4EIOsVFt7HPNTEcevgFXv6+LW0FO/GHC9f
        G7kb76qt7LFEX0DA==
From:   "irqchip-bot for Qianggui Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: New
 binding for Meson-S4 SoCs
Cc:     Rob Herring <robh@kernel.org>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220225055207.1048-2-qianggui.song@amlogic.com>
References: <20220225055207.1048-2-qianggui.song@amlogic.com>
MIME-Version: 1.0
Message-ID: <164641347714.16921.1109139686936125429.tip-bot2@tip-bot2>
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

Commit-ID:     d6a3be863dcf8c51ba2d18d8fd47a1fadb1336aa
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d6a3be863dcf8c51ba2d18d8fd47a1fadb1336aa
Author:        Qianggui Song <qianggui.song@amlogic.com>
AuthorDate:    Fri, 25 Feb 2022 13:52:03 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 04 Mar 2022 17:01:03 

dt-bindings: interrupt-controller: New binding for Meson-S4 SoCs

Update dt-binding document for GPIO interrupt controller of Meson-S4 SoCs

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220225055207.1048-2-qianggui.song@amlogic.com
---
 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index 23b18b9..bde63f8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -18,6 +18,7 @@ Required properties:
     "amlogic,meson-g12a-gpio-intc" for G12A SoCs (S905D2, S905X2, S905Y2)
     "amlogic,meson-sm1-gpio-intc" for SM1 SoCs (S905D3, S905X3, S905Y3)
     "amlogic,meson-a1-gpio-intc" for A1 SoCs (A113L)
+    "amlogic,meson-s4-gpio-intc" for S4 SoCs (S802X2, S905Y4, S805X2G, S905W2)
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
