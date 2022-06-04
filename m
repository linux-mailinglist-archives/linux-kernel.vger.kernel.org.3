Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1749B53D6D1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 14:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240036AbiFDMlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiFDMlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 08:41:04 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1311531536;
        Sat,  4 Jun 2022 05:41:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 354F53200344;
        Sat,  4 Jun 2022 08:41:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 04 Jun 2022 08:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1654346459; x=1654432859; bh=lVC02QK4SHsr+00py+U1MSnZZ
        Egh3HHWEX2YPoM+RBo=; b=4hiQqR26na7FmbxhQbKOst12IMMuhyNU9p9p5LDCc
        gfwoi2N72pxgcVOoOB4G0174YDXLpZZ03hx9KYUxTuBk6DB67KU6BBq5ZzQjB8eg
        gZ61ae9f8u/JghYAXe4XaLB7clcWpSdab8MDmgl2SBLD1EGT4Kew6flvher+Pl0q
        bGzSvqV9cVlHktd4wIFf6a9gxoLR4wdDpbi44Q6v1pvr1A9kZ/l2S9RjYLpN4Fl1
        W5BnCQapr6D+vniBN4RuseIZnKCt2TuvLXLF0jtBoCTENxAC6rPScx1bkmhjj9vc
        C71AM6OQEh0uiWbp+FfXntZUJteaAcp9+bPXSNp2fbBYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1654346459; x=1654432859; bh=lVC02QK4SHsr+00py+U1MSnZZEgh3HHWEX2
        YPoM+RBo=; b=FrbJDl6fBu/000qV/LpbkIRjm9EonOFBHRAzIvRFPf2/NjH410F
        akKPp9xHyX8qLugC4CkJlIvVOkcHmjg+f/Q5G6Z2UM3W2sgeN0lYXYDaMHGgFMqc
        5GMQXwA9bEpSOqMs3UntXuLKsZ5SeOpZaEpAJGtFSRElCriWJkOH5UFiiWZiAc/Q
        JpA9vKHxJkpetlREqO9yjjpfB+Q/vta2/k2+Yj5//Oh+UsUXm1KLRS8Bit4EBE2n
        UUlGUf8d/DX7TwRiMe1BA8arkJz5Iyo5sFE3BXihSrvNBC4jCjnSJQLhVsi5juqB
        NHtYLTGbZph1xYaoOw4CmK2Jv405wWilkRA==
X-ME-Sender: <xms:21KbYvPWgLfBLTf1GF3O6NfksTBFqB7kkhXEbZAB_Xlsv9P-ej18qg>
    <xme:21KbYp_z8wzO415KJnTQ_xNZIvqlCZUozj8CeBP-p5c_NO-2FrRKamqa5cps5GD98
    WA34rJgOKooZpxFCuo>
X-ME-Received: <xmr:21KbYuTssyDfHboQjeR8TCo2TKpsjnqMGcNYPh0_0CX7gTX5eZRvXMCd_MHhjCxf-SNp7eSFMXKlQFa1Sf6BgHEXDrsIkpyxcoLYUnq701zUIQW7ogc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleekgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedutdduveeileejjeetff
    ehueejudehgfffjeduhfeuleeludfffefgffevkeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorg
    htrdgtohhm
X-ME-Proxy: <xmx:21KbYjshhPIPM8vji13fTVEGoKAjFXMb3deaI__bjM6vlPkYt1lp0w>
    <xmx:21KbYnfsxADlr27Zt3YpW3_Hp2cfFBgFvGgYwojeT1bNXkUQ2Qg7Jg>
    <xmx:21KbYv005vDYJhlGfw7P9HdcO-UGc4dtZiOW2a8c8A9WK_OvqKm8BQ>
    <xmx:21KbYu4GzPz-OIWMaxUnCpTR9TcjrcD5hapo1DBn1BKONFAb0kPQsw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jun 2022 08:40:57 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, maz@kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH for-5.19 1/2] irqchip/loongson-liointc: Use architecture register to get coreid
Date:   Sat,  4 Jun 2022 13:40:51 +0100
Message-Id: <20220604124052.1550-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.25.1
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

fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for
LoongArch") replaced get_ebase_cpunum with physical processor
id from SMP facilities. However that breaks MIPS non-SMP build
and makes booting from other cores inpossible on non-SMP kernel.

Thus we revert get_ebase_cpunum back and use get_csr_cpuid for
LoongArch.

Fixes: fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for LoongArch")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/irqchip/irq-loongson-liointc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index aed88857d90f..c11cf97bcd1a 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -39,6 +39,14 @@
 
 #define LIOINTC_ERRATA_IRQ	10
 
+#if defined(CONFIG_MIPS)
+#define liointc_core_id get_ebase_cpunum()
+#elif defined(CONFIG_LOONGARCH)
+#define liointc_core_id get_csr_cpuid()
+#else
+#define liointc_core_id 0
+#endif
+
 struct liointc_handler_data {
 	struct liointc_priv	*priv;
 	u32			parent_int_map;
@@ -57,7 +65,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = handler->priv->gc;
-	int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
+	int core = liointc_core_id % LIOINTC_NUM_CORES;
 	u32 pending;
 
 	chained_irq_enter(chip, desc);
-- 
2.25.1

