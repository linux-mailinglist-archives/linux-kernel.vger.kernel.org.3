Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF079563460
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiGAN35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiGAN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:29:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F613CC6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:29:52 -0700 (PDT)
Date:   Fri, 01 Jul 2022 13:29:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656682190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qVkSU71kgOF9AcEODAydwM12WIppspmpwRDu9TbhFc=;
        b=xrX0RsKD4D+v36JJbu0eSCFe8mPCMYsRf++qJQHrwIXf9AcVf0w/auWe0SutOBLknt5TWW
        OTTMb9YvQXkmEHEhDzJkcaoe3B7yZ2bfVEJ0EPkGkzqHevZ3EIXhg27W2bfK3ovoEc/lC8
        2u2apkCgFmats/9o9ucioqw4Qpp+tvYFgXQRsYgQlk5gGZkHNPuit73z1wiEwQ2HHBiGGj
        DTRdQ2/2hiyfHCEvbWa8dPbYhW8MmcEJS4BHQbwtSal9RVxF2HyNhgkyxeKKnXoah5JCIS
        Fn33PHgCCaJKepJHgIBoNra7uX0riTi8w5Ix/AavHcHGZBS+DPjEGXZQMj7F6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656682190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qVkSU71kgOF9AcEODAydwM12WIppspmpwRDu9TbhFc=;
        b=tvyKppGazyWXwOYyxMZMfiA3fmdjuhGUpabiYlxOaYI7kjYW1Ot96Km5XSxQ1RroyAIHqM
        8CGa+vrTkk2gHhAQ==
From:   "irqchip-bot for Jamie Iles" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/xilinx: Add explicit dependency
 on OF_ADDRESS
Cc:     kernel test robot <lkp@intel.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Michal Simek <michal.simek@amd.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220630111008.3838307-1-jamie@jamieiles.com>
References: <20220630111008.3838307-1-jamie@jamieiles.com>
MIME-Version: 1.0
Message-ID: <165668218959.15455.8802811514977821768.tip-bot2@tip-bot2>
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

Commit-ID:     fd31000d58f41588fa10128278efdab8474f5ce8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fd31000d58f41588fa10128278efdab8474f5ce8
Author:        Jamie Iles <jamie@jamieiles.com>
AuthorDate:    Thu, 30 Jun 2022 12:10:08 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 01 Jul 2022 14:25:46 +01:00

irqchip/xilinx: Add explicit dependency on OF_ADDRESS

Commit b84dc7f0e364 ("irqchip/xilinx: Remove microblaze+zynq
dependency") relaxed the dependencies on the Xilinx interrupt controller
to be OF only, but some OF architectures (s390 for example) do not
support OF_ADDRESS and so a build of the driver will result in undefined
references to of_iomap/iounmap and friends.

Fixes: b84dc7f0e364 ("irqchip/xilinx: Remove microblaze+zynq dependency")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220630111008.3838307-1-jamie@jamieiles.com
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1f23a6b..bbb11cb 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -298,7 +298,7 @@ config XTENSA_MX
 
 config XILINX_INTC
 	bool "Xilinx Interrupt Controller IP"
-	depends on OF
+	depends on OF_ADDRESS
 	select IRQ_DOMAIN
 	help
 	  Support for the Xilinx Interrupt Controller IP core.
