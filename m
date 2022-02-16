Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE944B7D41
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbiBPCU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:20:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbiBPCUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:20:54 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B29EBF97D;
        Tue, 15 Feb 2022 18:20:43 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C1B45C02A2;
        Tue, 15 Feb 2022 21:20:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 15 Feb 2022 21:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=J5AXj40E9HqNRYqC6qIeTjIFyzcv3BtezY5WnWbvfpw=; b=dSnhO
        hAcBaMdsg196yB6uJSkxx3i/iqh8MVN9FeKqijDbzSf54bYb0t0elDQiYMU9XY8I
        abJbTc7NSqVKGYO29yse+KeF6rfesq64z70Lciw1W0FTycsLjX1CHTT83T6az+Yf
        0EM4RNOrret58YAb3MOcsj8RFatEIrPEWj8y+bw3PzBAU9Ib8TR2v41RKE20+bCJ
        aQS1BBSnh/KyZVO4FYubCsrqFyvrHjbVoPPcKVFsHn0oMtwwUY63PzEV1AKdHM4M
        5BnlA3yyGC9Mqngo20HG7/8BDE2YGgh81gLdq9VettGJ9X1nnUCtlfHKSE/ck+OX
        H99tfWW5Qvb2fPamg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=J5AXj40E9HqNRYqC6qIeTjIFyzcv3
        BtezY5WnWbvfpw=; b=a+SAvR9DBP7Yl0cPtoXJLFYiDQTiDpOOGhn4we3e0epTm
        3Fv8L7wam0//iditANPmyKV08rcwHKx+ZtHtSI5of/VV+sO/NUVyKAmj1fJZDlVZ
        ZVTQvDYuWARpmKM43oNl/aCpzAZLjmnRhwGFQ7YL3GZdOWEkjSb0+JoAISpSEL62
        jfw0YcsIYwn4EoQtvhtp8sYGLfm4XGSYyH2A/uWLPbDl06MQOufOiT2PoFZ2wkrf
        OPLwrZOZ1dVY9d/0hnfmRbXUXMDUPnNFXi+crb2GFGY1lGXSG6elnV5FmK2gHa1+
        z8u+jsiE/+xZJVc0CJ4+FNE6NxagkChxMDdDvrLIQ==
X-ME-Sender: <xms:el8MYl0hjAeAjS6M8WG82e3etGsrV3Q9dQhie4e2JKDRFwb5yhTBDg>
    <xme:el8MYsHeVcyZ4-71Q58nKsCHQN_bPGNakMLtEPidcxYuAkl82-SdnUh5i6Cq30raC
    oNLScdHQz3SDxr6UQ>
X-ME-Received: <xmr:el8MYl6W_dWrPAI9fuVJVicjKLPSkv_ZI621UM2NFmi-NrZSbne6NV_hDN7ezRz-TGYpF4jAK3cs9n1kas_S_0d7JLOceMhgsZebChvbxHB2ifjqPagKrXeFaOrMsIRWqAH67Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeehgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:el8MYi3mnFnEa5-loOj-fsfg_9wJtPyOJYC6vSdTAGswbVTWug-ktg>
    <xmx:el8MYoEzWpLcUompitbfHuadznVzu85ty8qYAmvY1czBhRXxSibFcw>
    <xmx:el8MYj9wgDT80sUB4wbzs_GYU4s-BBcMjIsDhRVH0qo-GTdIntDWTg>
    <xmx:el8MYtMPfM1mB9ETFnU3SEx4kUSNHqpv89HpFnuw-FjpSJyJMEBmVg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Feb 2022 21:20:41 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2] of/irq: Use interrupts-extended to find parent
Date:   Tue, 15 Feb 2022 20:20:39 -0600
Message-Id: <20220216022040.61532-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
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

Some OF irqchips, such as the RISC-V PLIC, use interrupts-extended to
specify their parent domain(s). That binding does not allow using the
interrupt-parent property in the irqchip node, which prevents
of_irq_init from properly detecting the irqchip hierarchy.

If no interrupt-parent property is present in the enclosing bus or root
node, then desc->interrupt_parent will be NULL for both the per-CPU
RISC-V INTCs (the actual root domains) and the RISC-V PLIC. Similarly,
if the bus or root node specifies `interrupt-parent = <&plic>`, then
of_irq_init will hit the `desc->interrupt_parent == np` check, and again
all parents will be NULL. So things happen to work today for some boards
due to Makefile ordering.

However, things break when another irqchip ("foo") is stacked on top of
the PLIC. The bus/root node will have `interrupt-parent = <&foo>`,
since that is what all of the other peripherals need. When of_irq_init
runs, it will try to find the PLIC's parent domain. But because
of_irq_find_parent ignores interrupts-extended, it will fall back to
using the interrupt-parent property of the PLIC's parent node (i.e. the
bus or root node), and see "foo" as the PLIC's parent domain. But this
is wrong, because "foo" is actually the PLIC's child domain!

So of_irq_init wrongly attempts to init the stacked irqchip before the
PLIC. This fails and breaks boot.

Fix this by having of_irq_find_parent return the first node referenced
by interrupts-extended when that property is present. Even if the
property references multiple different IRQ domains, this will still work
reliably in of_irq_init as long as all referenced domains are the same
distance away from some root domain (e.g. the RISC-V INTCs referenced by
the PLIC's interrupts-extended are always all root domains).

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Add comments noting the assumptions made here

 drivers/of/irq.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 2b07677a386b..c7d14f5c4660 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -60,7 +60,12 @@ struct device_node *of_irq_find_parent(struct device_node *child)
 		return NULL;
 
 	do {
-		if (of_property_read_u32(child, "interrupt-parent", &parent)) {
+		/*
+		 * interrupts-extended can reference multiple parent domains.
+		 * This only returns the first one.
+		 */
+		if (of_property_read_u32(child, "interrupt-parent", &parent) &&
+		    of_property_read_u32(child, "interrupts-extended", &parent)) {
 			p = of_get_parent(child);
 		} else	{
 			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
@@ -560,6 +565,11 @@ void __init of_irq_init(const struct of_device_id *matches)
 	 * The root irq controller is the one without an interrupt-parent.
 	 * That one goes first, followed by the controllers that reference it,
 	 * followed by the ones that reference the 2nd level controllers, etc.
+	 *
+	 * Controllers using the interrupts-extended property may have multiple
+	 * parents; interrupt_parent always references the first one. The order
+	 * used here assumes that other parents are no farther away from a root
+	 * irq controller than the first parent.
 	 */
 	while (!list_empty(&intc_desc_list)) {
 		/*
-- 
2.33.1

