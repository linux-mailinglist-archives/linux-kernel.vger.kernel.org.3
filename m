Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD394B411B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbiBNFNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:13:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbiBNFN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:13:27 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B644DF50;
        Sun, 13 Feb 2022 21:13:20 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DB97C32009DF;
        Mon, 14 Feb 2022 00:13:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 14 Feb 2022 00:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=QHjHOgjzLKjnI1LxHZ8XMgQzd2FOXo4wEHGTg6T+51c=; b=vh9bc
        te+qDU1Vlqxjj56YLbCRsSrKER2BZ38AZuZ+LuUpLzRFLe63Qz7qZzpy1TzK2/SQ
        AMjuAS2t0UwAGsHzUTYSr4pxFz4kjQukxJE79JjZCr/YO05wWhfPnALr8M0d9sfV
        l+/KbArG/vwPswH8mh9+TxX3mtOmtNrSenu9inCFMYUVydK6sLGCfU+TFkUMCUai
        cwFITeYhxBaA1qybLlmul0n9r9x8ZpLASrMNw4f9/4mwxyyK3rJTBbpuCCadtEzT
        NQ+TWpz6bEoNAgXQ/g6bkhYZOEJyp2Xu8ZSo0HsP76Va5ddGiIpDXHpZMgrKiEct
        3aDbcTIESmWSGtJ8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=QHjHOgjzLKjnI1LxHZ8XMgQzd2FOX
        o4wEHGTg6T+51c=; b=oueYm+2sWSep0KqXnHrwtEOG11VKJ54SNHGbv+97XqTPB
        rHuSoK7IDg1xqJv5BMLl6R5zH8JBfXAcf3QlOMUOQ0KDjEU0TLJ20/AE/rsAuwCd
        xZkjEBD48wCMjzDBvhT/mY77ysCgorKyqb+gYATZCxX6bjZ2xt9xah3COy0qmNQ0
        jyqrmi6SBAMM3sMfizJcOrCqxr+4BE6fxMHpNdd8hJyvKYYXeetlN2VcZhMFnB+V
        lCZ937YEKbP1izjGv8THhsvBea7bHuODPYkASweREuUZ4QxrWi0yBke0i8NBc5Lf
        BOI8eCTEI/tv8nig2FeGsYxLAD2eHXTwB/J8X95tA==
X-ME-Sender: <xms:7-QJYmjjkkzgUCDRRx_aqLqzRFiqfH9Al_Zcb7fLppnYTEgpt5DuTA>
    <xme:7-QJYnBfsK4ubjjmgKaU1Ah9wM4DbuYm4tYAB-b0F-vuUEe6WRbLIqi0xC6AjEXcU
    BKjDO8xB7BteIJPTA>
X-ME-Received: <xmr:7-QJYuGad-mNURlxJNqJQKXUsZjPPnXN_B8833hAr14CDxe--gZF6bG7NP6Ij94t2RWs4WPIv7ta3NOUm07Ld8gjixDNveEcydLbAzARYS2Xc8Rp280CZBIctirIByKd6Q_QPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjedugdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrfgrth
    htvghrnhepieetkefhheduudfgledtudefjeejfeegveehkeeufffhhfejkeehiefftdev
    tdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    grmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:7-QJYvSDYgdTe2zPZtzi5njB49oqZIgTLwLilvDGUNq8OfgYF7D_AA>
    <xmx:7-QJYjwrsyCM1Vl7uf0wXNt-qsfMQpCQHmfjAOkxcaS1SgwT5mNnkA>
    <xmx:7-QJYt7sV0mlVNNR1itJWWavL-MhX9HRpdwvi_xM4kZuU8Ftmcb5Yg>
    <xmx:7-QJYuryCKzjfHajsz_3PA7LfK8pSA3tz0PIj-gVt3ke3VAmQWfUfw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Feb 2022 00:13:18 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] of/irq: Use interrupts-extended to find parent
Date:   Sun, 13 Feb 2022 23:13:17 -0600
Message-Id: <20220214051318.2273-1-samuel@sholland.org>
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

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/of/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 2b07677a386b..0c20e22b91f5 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -60,7 +60,8 @@ struct device_node *of_irq_find_parent(struct device_node *child)
 		return NULL;
 
 	do {
-		if (of_property_read_u32(child, "interrupt-parent", &parent)) {
+		if (of_property_read_u32(child, "interrupt-parent", &parent) &&
+		    of_property_read_u32(child, "interrupts-extended", &parent)) {
 			p = of_get_parent(child);
 		} else	{
 			if (of_irq_workarounds & OF_IMAP_NO_PHANDLE)
-- 
2.33.1

