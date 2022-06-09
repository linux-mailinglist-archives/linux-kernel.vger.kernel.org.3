Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF56545378
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345194AbiFIRw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343517AbiFIRw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:52:56 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2DDC03B5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:52:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 08B2132009D3;
        Thu,  9 Jun 2022 13:52:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 09 Jun 2022 13:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1654797170; x=1654883570; bh=ilLW3c3uTv/4cm728Uz1pZhDr
        9fWyLngYo0f/x6NrMQ=; b=sNh7NklmkmZLS+XNPEVU+yIxXRo7BqtoEkjPS1eaW
        4pnDDaMxIlfMD3N1NSes+W7D5tRTBINh2GrAitckZKEF3ZShUSJ9N6LM53E/Sj0K
        mtZ+3Stv7fujT2H2+SJBmg8nXCadpwu0Hij0E0y7N+yJ9JjqW0HfV7dmQPX2tFVT
        yKwUzeWZtrtetWyjaMVU3RDOWGWkwnX6Hi8Mqi115qoF02xIkgYsOBW5qtgBOnk6
        nZLipPLwoBgBfCk4B3u3bmgxROqgf3mJQ/LyXtUpQ7rbzqp+Oak8tGs7OrZtNTDc
        fgS6BjJMAodfVlsm4dRTth5eqwmURTdXiEoiS1szLDGCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1654797170; x=1654883570; bh=ilLW3c3uTv/4cm728Uz1pZhDr9fWyLngYo0
        f/x6NrMQ=; b=Iolx1x94Plcu+WYT0NQolM8oiSplddWr+8v6p2aaf/S75DZ7hpW
        DQxRRYHLi7bVGVDmZfYeEyUjalaYQOIFVusnaHcqL1Djx+6CJ9TCjNP9JyVKBYuM
        Ldeerk3sxyEQuOyRMFfemVu5HA/1ycvnP8n7McB6j8G4rMBoqHPBtyt8YbRT4b9h
        ACLCBAmttryWzZeK3KSHOSr1qSCuNHGliCo/pc0Yfzt/VV/aKpOHePsziDeAt5rj
        7ctj3ybiEIjWcYzfl1WpSrRnXMyhRSosAOjxH5ezJazC5yFUoJ3yni5/d6dSCy45
        5OgZ/5xcelp6EhcBwmWY3cMHoc60SfAZvMA==
X-ME-Sender: <xms:cTOiYg08hfCT68p9BY9JfLz0dsTxnleLnCiy3LyH1ZNUzsS0345AVg>
    <xme:cTOiYrFboAYKgWGun3t-o1MSme7DZn_WuT4g55lgQE0zv0gEC6bF2XoGdlRAsCTFH
    EHst3QixXjNxFI1rgs>
X-ME-Received: <xmr:cTOiYo5oNOHCmNZIf5igXEFd_JdlfsYhGsW_ps_Ti8xfqm_wgVeP38_sLYUTX32GIIRNpQVTHDaorPWkjz_eHHr9ISr9tucWo5ESmNMqZDQjk3CUksk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedutdduveeileejje
    etffehueejudehgfffjeduhfeuleeludfffefgffevkeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:cjOiYp2EC8W9LHh5WqJu5pOZH5R3pxQ2KzyXK-ABsGzZg0nE1XHRpw>
    <xmx:cjOiYjFJDOJEuWNFn66M5w2htXVH1C2wYMXqzqma1p04SsJ7YcSA-g>
    <xmx:cjOiYi_MD8E93X7clc7cAfaEcRBjilqwzlLP3ekSftcFmoSdft8Dow>
    <xmx:cjOiYrDoTUwzHr_0GkoNivWAm5W2eGigwr7WYNK1JjxVFI26Hu60aw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 13:52:49 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, maz@kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH for-5.19 v2 1/2] irqchip/loongson-liointc: Use architecture register to get coreid
Date:   Thu,  9 Jun 2022 18:52:41 +0100
Message-Id: <20220609175242.977-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/irqchip/irq-loongson-liointc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index aed88857d90f..8d05d8bcf56f 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -39,6 +39,12 @@
 
 #define LIOINTC_ERRATA_IRQ	10
 
+#if defined(CONFIG_MIPS)
+#define liointc_core_id get_ebase_cpunum()
+#else
+#define liointc_core_id get_csr_cpuid()
+#endif
+
 struct liointc_handler_data {
 	struct liointc_priv	*priv;
 	u32			parent_int_map;
@@ -57,7 +63,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = handler->priv->gc;
-	int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
+	int core = liointc_core_id % LIOINTC_NUM_CORES;
 	u32 pending;
 
 	chained_irq_enter(chip, desc);
-- 
2.25.1

