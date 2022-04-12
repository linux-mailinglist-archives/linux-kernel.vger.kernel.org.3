Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E3A4FCEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347724AbiDLFSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347996AbiDLFRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:17:48 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B933E29834;
        Mon, 11 Apr 2022 22:15:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E0B663201FAA;
        Tue, 12 Apr 2022 01:15:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 12 Apr 2022 01:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1649740530; x=1649826930; bh=x32ANA/Em4ExBsg2nqemM4kd0
        +5fMFBD4QX/jgrUNik=; b=kTVnT7sOfN7OCuvtCmiyEpbQOboJUAFkMdaUkGNU2
        7P4H6Y1H6pMebdjxZP1QnxX8A77NAA1x5ThlZiNyeZbcxrEHrnUIw1KDyQfC5Vm1
        85yUiRgC8B/7i/l37mwIjLxZ/rpTGcVzRlR9KdaesdD2bFoIoZV+YAkb7GIfEA3x
        Ssul/Lyuh34nFTURnc4+ll6lcto75q/yXGrU1Vltc42mpES8+YO+Go+tmw/jt7CV
        Aq3vaBp4Wxa4NdYHgRENncPYXir+vKDLartejyf70DI7LtApOroR1ko4LTqrwAK8
        SviRsTtiWT5YcktNhISKKSPY9rsMRQ+95IBCcCDmOg9jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1649740530; x=1649826930; bh=x
        32ANA/Em4ExBsg2nqemM4kd0+5fMFBD4QX/jgrUNik=; b=GlCWEKjFxVLfULWsi
        BGyCVruiO5wZGE/BQU5rHnmcOSvv4WkrgvkhmMcV88AdGXqd52p2SJsuPZf6wd68
        9+7R/tgFluFCn3W2sUceCNLEC06Mb6RFkE8FKpJxFXwq9IfrEtkGNuFOIDCPy6CT
        pw5321G/zHM7qUs+a8MI+yKrwcHqEM8rfeDGxAW59HgsROalOMxH1cQZBFzhEo7U
        1Ohr+KZoFzLOvCz5J69UEydbho4m0/Bh/e5cgHiJ5VlnUHQl1grgm1VpxK1PvOYv
        k1CZmO4pzXmRTXA9bYMtnavChH+7TaRC1I03t47iCp7gJ6anD/viQganaSyUcHLS
        H4M7g==
X-ME-Sender: <xms:8gpVYjQrvVLRb5GtB_aTKza0l0epfNi07jSaz4pk1Vew-E5FrWCCdA>
    <xme:8gpVYkw5QmPruDOUloU0SSdVobvmEdOkc_d-YRTPV5t1WlQs440q9J2jmglmUA_Na
    _Q_RGUtFM3wppfdFw>
X-ME-Received: <xmr:8gpVYo0FHXQ8wbuip8KysclQK5BK-cT48mFpro2fhiXmwWSYnhcllMySbBFwu78DQtM7Y_9A61WZXWw3PeLiyjIT2mfKOnHKFtVumIRXE4PldQnssY4RmT750SXcsBz4F4uixA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekjedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:8gpVYjB3Nyyq8c9c70cEMycS9C6AkAtxu1f8fTX4TZvCvaqrTimANA>
    <xmx:8gpVYsijNmWVKpcWrJ6u7t8p9rS5RTOuofJIUdQWCnVrCuy3mSWrvQ>
    <xmx:8gpVYnoIsBxOAMj6l-49UPJqpdWymIOvPtCMXA-zencoXH9FKkj3Hg>
    <xmx:8gpVYmZBjBMLqi0tTvzaBn_v6CHRmBXtr5GuDR3YZyCqUcSsN5bBJQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 01:15:29 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3] of/irq: Use interrupts-extended to find parent
Date:   Tue, 12 Apr 2022 00:15:28 -0500
Message-Id: <20220412051529.6293-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V PLIC binding uses interrupts-extended to specify its parent
domain(s). That binding does not allow the interrupt-parent property to
appear in the irqchip node. This prevents of_irq_init from properly
detecting the irqchip hierarchy.

If no interrupt-parent property is present in the enclosing bus or root
node, then desc->interrupt_parent will be NULL for both the per-CPU
RISC-V INTC (the actual root domain) and the RISC-V PLIC. Similarly, if
the bus or root node specifies `interrupt-parent = <&plic>`, then
of_irq_init will hit the `desc->interrupt_parent == np` check, and again
all parents will be NULL. So things happen to work today for some boards
due to Makefile ordering.

However, things break when another irqchip ("foo") is stacked on top of
the PLIC. The bus or root node will have `interrupt-parent = <&foo>`,
since that is what all of the other peripherals need. When of_irq_init
runs, it will try to find the PLIC's parent domain. of_irq_find_parent
will fall back to using the interrupt-parent property of the PLIC's
parent node (i.e. the bus or root node), and of_irq_init will see "foo"
as the PLIC's parent domain. But this is wrong, because "foo" is
actually the PLIC's child domain!

So of_irq_init wrongly attempts to init the stacked irqchip before the
PLIC. This fails and breaks booting.

Fix this by using the first node referenced by interrupts-extended as
the parent when that property is present. This allows of_irq_init to see
the relationship between the PLIC and the per-CPU RISC-V INTC, and thus
only the RISC-V INTC is (correctly) considered a root domain.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Move the check into of_irq_init. Do not touch of_irq_find_parent.

Changes in v2:
 - Add comments noting the assumptions made here

 drivers/of/irq.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 2b07677a386b..aa485eb312ac 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -550,9 +550,18 @@ void __init of_irq_init(const struct of_device_id *matches)
 
 		desc->irq_init_cb = match->data;
 		desc->dev = of_node_get(np);
-		desc->interrupt_parent = of_irq_find_parent(np);
-		if (desc->interrupt_parent == np)
+		/*
+		 * interrupts-extended can reference multiple parent domains.
+		 * Arbitrarily pick the first one; assume any other parents
+		 * are the same distance away from the root irq controller.
+		 */
+		desc->interrupt_parent = of_parse_phandle(np, "interrupts-extended", 0);
+		if (!desc->interrupt_parent)
+			desc->interrupt_parent = of_irq_find_parent(np);
+		if (desc->interrupt_parent == np) {
+			of_node_put(desc->interrupt_parent);
 			desc->interrupt_parent = NULL;
+		}
 		list_add_tail(&desc->list, &intc_desc_list);
 	}
 
-- 
2.35.1

