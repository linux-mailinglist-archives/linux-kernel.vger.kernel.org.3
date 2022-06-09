Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB754525C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244149AbiFIQvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344634AbiFIQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:50:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8756C55F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:50:32 -0700 (PDT)
Date:   Thu, 09 Jun 2022 16:50:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654793431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/TtGqeIHyDmLKv3CPijYNsnKTzn1gj6kvI09Ktoi9Ps=;
        b=cPC7ir7sVUYlsYdk10jHznVwnQcgrOMhDvtd1qvSAYUJ6ZM4n/buT9hXwnY8BhM9FZLJyf
        0sSaezt8flMBQ0KO2hn8uZj4g3TgyV596ksG1/wg+i+RVnE9qYL9EHdW5vvj9XCa5pWqfF
        e78anW1qNZJmiU4oZRHfStdPeh4+6joeDoo4VisMU5+14oQLmzfr66BMW2cG4xWcTqpQlu
        5MUhjctjmI/kZCRsEZHDNHhVcJFNhHexOXcBfvgUH7D2HA7Jg1qc0nh6na6gDpZ03I3hRC
        y5tCuL5LmsD507yvbrjLjvgcTKS9upxNPSjnUVcNmnsdhWalC5vyCP3FPjktPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654793431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/TtGqeIHyDmLKv3CPijYNsnKTzn1gj6kvI09Ktoi9Ps=;
        b=ZdxoL5+AiRaoYrAbs8j6NhtjJryGAmoGVmjJwBqn78tcNTfyh6ocxVwvlVzNyEqroTYJ3j
        i8ZNyod08xzNaXAw==
From:   "irqchip-bot for Jamie Iles" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/xilinx: Remove microblaze+zynq
 dependency
Cc:     Jamie Iles <jamie@jamieiles.com>,
        Michal Simek <michal.simek@amd.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220606213952.298686-1-jamie@jamieiles.com>
References: <20220606213952.298686-1-jamie@jamieiles.com>
MIME-Version: 1.0
Message-ID: <165479343022.4207.13397822799404943777.tip-bot2@tip-bot2>
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

Commit-ID:     b84dc7f0e3646d480b6972c5f25586215c5f33e2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b84dc7f0e3646d480b6972c5f25586215c5f33e2
Author:        Jamie Iles <jamie@jamieiles.com>
AuthorDate:    Mon, 06 Jun 2022 22:39:52 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 09 Jun 2022 17:34:56 +01:00

irqchip/xilinx: Remove microblaze+zynq dependency

The Xilinx IRQ controller doesn't really have any architecture
dependencies - it's a generic AXI component that can be used for any
FPGA core from Zynq hard processor systems to microblaze+riscv soft
cores and more.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220606213952.298686-1-jamie@jamieiles.com
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4ab1038..1f23a6b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -298,7 +298,7 @@ config XTENSA_MX
 
 config XILINX_INTC
 	bool "Xilinx Interrupt Controller IP"
-	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP
+	depends on OF
 	select IRQ_DOMAIN
 	help
 	  Support for the Xilinx Interrupt Controller IP core.
