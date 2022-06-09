Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD354537A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbiFIRxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbiFIRw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:52:56 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE1E44A0A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:52:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3F18C32009B4;
        Thu,  9 Jun 2022 13:52:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 09 Jun 2022 13:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1654797172; x=1654883572; bh=NP
        lvGbpWe3tdccHpDPunMo3g/eJ+mFewyfL3DA2+pmg=; b=jeDvndkXiscmTy0nS3
        PgFDpL/m84xWB9iDdKJc+m8BzNG0dzYLnOUECadviLsTnp3shfBoMIIXUZtYMllm
        yrKargcVAzo8NEmbju6ZNsNZwDjysGs+uCZnR6t2Mg7X9p2GrJZRFh5KolgDhZse
        xKb52z5oSqq5BKK0WwWsVWyK1qznvUWSIlYDlvZXwHTzS6NxPzl6sTHMmLFb/Gv5
        X2JqWcTzx+IuzUkeU5/MeeUgvi0YoDyo86TigV13bNap3tUL5qBG1B+whqcucoO7
        AePsQgOvlphEUkKEZ9ufygExJ9wc+Pf9Hf3/yab+VN/IW7npEzDwRF+2eY5CqJnL
        ycgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1654797172; x=1654883572; bh=NPlvGbpWe3tdc
        cHpDPunMo3g/eJ+mFewyfL3DA2+pmg=; b=Mi9CifMxcLMG2mIO3lTLFdvboXwTk
        kg1JSmurIACiEmxd0f3QbCV+Ldy+7vUDPPfIAqf4+STzJeh5PSP+SA7YPaU6UyUF
        OtoXnXL9FT570X6Ur50TZ3uf6xsSO5czWQYnGG+Y2oHGCkTwsw9IHCrqx6VZUgCT
        ttOTmZTCO2kOwda9ogmm6Ynnsisp2ejMFH8jiCK60gJ7wFMazHKzt3jAMdxaT8Em
        S0Ni4KdiyehPErlME6woTOW50vpeBgMWWi/9+BKW20ZlDGOKy0yjoxjUiwu+tJL5
        Xais3LlJvD9lqYVdXSfTR70WQzhhXAcFVH4lgkudI70TRRPBVUzXWF+qQ==
X-ME-Sender: <xms:dDOiYnjiH_knMF-Ski6Z9D1cnFzE8FrCerEV6XicX82_G1beSGOojw>
    <xme:dDOiYkBZodby_Y3dI-iV_AkWMy50KVgmdr88bWhwkTdpTQbQl9WbowOPZKJc_Gp0h
    gPuORNRWflPCzd9ElA>
X-ME-Received: <xmr:dDOiYnHYQhe5jvW6CQvlrquHCb8yi70lm_NPImeux002IcsQ1LLU-3zZJaPwvtR1Fs1rvuYypTQb1YhD8aiKVQhDjdxuc0hr3ZF8nUXpRBAhzmTVJkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigr
    nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvue
    dvvdegkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
    ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:dDOiYkQa-8D4IwrE353cpFC8snJecXxl4m0HUa1_2DLdaoWsT4XfgQ>
    <xmx:dDOiYkwLdy_dt3-ZSiy-AqYnVR9VFzQ5lm3eWMKGzIRqkvpO0UaQFA>
    <xmx:dDOiYq6zzPxY_W0h5EX7Xd_bH5fS1HMevvhIVO5U9pIwf8JbcnWwcg>
    <xmx:dDOiYg-hyqkKzp0v4oF5A9x8HOOSa_wvWHjOLf3InYNYScPT97Px2A>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jun 2022 13:52:51 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, maz@kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH for-5.19 v2 2/2] loongarch: Mask out higher bits for cpuid and rename the function
Date:   Thu,  9 Jun 2022 18:52:42 +0100
Message-Id: <20220609175242.977-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609175242.977-1-jiaxun.yang@flygoat.com>
References: <20220609175242.977-1-jiaxun.yang@flygoat.com>
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

Only low 9 bits of CPUID CSR represents coreid, higher bits
are marked as reserved. In case Loongson may define higher
bits in future, just mask them out for get_csr_cpuid.

Also, as we already have read_csr_cpuid, rename get_csr_cpuid
to get_csr_coreid to reflect the actual bit domain name.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/loongarch/include/asm/loongarch.h | 4 ++--
 drivers/irqchip/irq-loongson-liointc.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 3ba4f7e87cd2..fe2408144fa3 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -1198,9 +1198,9 @@ static inline u64 drdtime(void)
 	return val;
 }
 
-static inline unsigned int get_csr_cpuid(void)
+static inline unsigned int get_csr_coreid(void)
 {
-	return csr_read32(LOONGARCH_CSR_CPUID);
+	return csr_read32(LOONGARCH_CSR_CPUID) & CSR_CPUID_COREID;
 }
 
 static inline void csr_any_send(unsigned int addr, unsigned int data,
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 8d05d8bcf56f..2ee636b2d827 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -42,7 +42,7 @@
 #if defined(CONFIG_MIPS)
 #define liointc_core_id get_ebase_cpunum()
 #else
-#define liointc_core_id get_csr_cpuid()
+#define liointc_core_id read_csr_cpuid()
 #endif
 
 struct liointc_handler_data {
-- 
2.25.1

