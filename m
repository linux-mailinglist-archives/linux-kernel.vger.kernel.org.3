Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2EE54DAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359069AbiFPGk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359228AbiFPGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:40:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E6F580E9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:40:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AFA5C3200B29;
        Thu, 16 Jun 2022 02:40:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 16 Jun 2022 02:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655361637; x=1655448037; bh=zm
        ZeppPZ05wI/evFnRfJ039u6Qr5P+abvVXy/2awP+c=; b=GFay1IcafnQ4DMeWxc
        MzZ9RRX+pVxfMUiKQxg4Z0FcxFSJcbMjzG0tQKde4XlKB3bLxtW9Sw/4htLDu7TC
        o3lrdvDqC/9ZF/lxom7+wnxpLvUR3eMB9zmZlFpqSbvi1byuxZX2nHZTri3ZYKHT
        JF7FY90LAgBx4fV5G2r7XlrG54wpbU/NWl8u/Ejy9WCKNk11m6KCjyhusxqBbeyI
        nnOn0LoJSPTaaU9Ubp/F3iHO4ug2gm3Fed/T10PoEOI01h798mE6rHegTiXhatve
        9z9Orbg77qagT1UbL57I1rfjU5NacDqsTgyvIP1d5kFqNjSsu+3dyjagJzR4RsLp
        F09Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655361637; x=1655448037; bh=zmZeppPZ05wI/
        evFnRfJ039u6Qr5P+abvVXy/2awP+c=; b=n1m1QpN+hpl1bdOl4OUaYK/103A7P
        Twup2+9q8fRn5Ye8KgKlGuTcFHU2rw83jveJC0+WviqoMkQB3wO12zHOKE6SQiUJ
        4Xfj/M/NC6w/thVE/1b0i5Hc+95B7dUozvVROm2yIFk+NoLJjGPCy1ScGwmdCqBJ
        0MSpJ+qV7Kj4MjH/IvYarVWNpA9wGL1UujPhuintHZbkm1eJOifooHMCNNKzasMP
        hxWICQLeYaWcxiANa3bZfCOHaOZAvKV67+tiZIeRUt8GjQhkddzTjRow7VXBMKfE
        7yr2ZNBFwLWuVBCQFnyfbCzCjmmt26UcLN1i3VnAqAHdU+683F3RGd5mA==
X-ME-Sender: <xms:ZNCqYgAChbAsQNhN6o2xke4d0Pix18PaxLNiPboAHW7H6FEzv_Nq6Q>
    <xme:ZNCqYij2Y8gySxJ6c9YnvC3dAChvvr905vTxAnoHUEhEfgOdvhJCsu4GlQmOTqNy7
    Yh4DlTynNQtpV0rGw>
X-ME-Received: <xmr:ZNCqYjkX-LUXELfIGO5KxYX4AUaCFjFBTCJxFPOReL-J6TwiF8vFZ11aQtW7NMV3opmrietIjUdYmvMZvcTWf_nnXSDcM9yPa4sjSTB2yAiFw-4EYTz1tZBG7VF27vP3CjlnXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ZNCqYmyF7nr-ZxSp4n58cp3zs9egIPQJFr-3ykxAmgO7kjs064lEPQ>
    <xmx:ZNCqYlSbQYeYVs6kJG6Yt_SHwlSTbV1tlQWeLqbgdx30Ky9vET-vfw>
    <xmx:ZNCqYhY30xKOJTTKF3uD2vax0OyN6gILUdENz1OmNSfQPr0uAJwoOA>
    <xmx:ZdCqYkILVPB3zhy6IBPtY3cBpW2Xxzxi2QniRFIJoYWoo2azRuMgfg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:40:36 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Guo Ren <guoren@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/6] genirq: GENERIC_IRQ_IPI depends on SMP
Date:   Thu, 16 Jun 2022 01:40:24 -0500
Message-Id: <20220616064028.57933-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616064028.57933-1-samuel@sholland.org>
References: <20220616064028.57933-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic IPI code depends on the affinity mask being set for IPI
IRQs. The affinity mask will not be allocated if SMP is disabled.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - New patch to prevent GENERIC_IRQ_IPI from being selected on !SMP

 drivers/irqchip/Kconfig | 4 ++--
 kernel/irq/Kconfig      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6f74c144a7cc..68be9eccc897 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -177,7 +177,7 @@ config MADERA_IRQ
 config IRQ_MIPS_CPU
 	bool
 	select GENERIC_IRQ_CHIP
-	select GENERIC_IRQ_IPI if SYS_SUPPORTS_MULTITHREADING
+	select GENERIC_IRQ_IPI if SMP && SYS_SUPPORTS_MULTITHREADING
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
@@ -322,7 +322,7 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
-	select GENERIC_IRQ_IPI
+	select GENERIC_IRQ_IPI if SMP
 	select MIPS_CM
 
 config INGENIC_IRQ
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index a2a8df39c2bc..db3d174c53d4 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -83,6 +83,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
 # Generic IRQ IPI support
 config GENERIC_IRQ_IPI
 	bool
+	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
 
 # Generic MSI interrupt support
-- 
2.35.1

