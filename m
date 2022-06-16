Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A76754DAE5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359057AbiFPGlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359267AbiFPGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:40:46 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAF057159
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:40:45 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7F21A3200B51;
        Thu, 16 Jun 2022 02:40:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 16 Jun 2022 02:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655361643; x=1655448043; bh=gj
        1T9kOuDzjoImIENJ7o3y478sayKqN7VNgA40v4t4g=; b=ZY0Bkqv9Jl8jT1rhOj
        I0Ugo7w7e/5w3pVe+JYO+29DsD7PrKLEzIVs4ggHApAvRQRrsha+2p03y2zs9ncn
        lmEcff8nMGucoPe5HPT9FvWTE6bks+AwTBVPy42hCtiRgPuW+IwyRnOIHQKDnggi
        qeWCGUqEb+T053Teg0bG1fVeknqorKeiNjtq6ydNN+VEU/n094V8vLj+64TdvLki
        mcufMDvgYLdrh/7maeHz5vmoVGH+lVki9Nw018LZg5iBMOsdaLZJJvIDedqbcM5t
        WWqz4NRgatdtxn8i9VUITSSFugC4Iq+yOV6RFcqAPd5aLsB9rJQIGQAjRMeNnfbT
        x6Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655361643; x=1655448043; bh=gj1T9kOuDzjoI
        mIENJ7o3y478sayKqN7VNgA40v4t4g=; b=R9lniPasK4ZzfWouh4JgWT5JIf+Js
        A68RoIg1OTtxZVHmuw2mCixiQ+RHue2VqzGy2bihKXYmXwuFsaf4WyFX7+Nn/AJq
        HgM22hTf9ONxha5vkqwpAnnp2WVSy9+iHOd6zjj4hrnTIDPCvithDpAu3hCuucJG
        FIm/JQCfwSigdy5xdKT18ePNeQnPIK3qGL5mI0uoahx0CSFwLp1+OeWah58iLpSP
        73d/Ea0zCBpmolHPOWh6jANDffFE2KSs3g02sJeTPJPafuTbHAJmK9+HlI/iPsHv
        +h+EcZSdTVaCVOwYWhZPJqevNtSAhNgVlWDmaRFeccma0qbLueGYvhhhw==
X-ME-Sender: <xms:atCqYuUtCs3VHnZS5MFOiJVxjyPwth4d5lOQYGavL9OncrIRtFT4bg>
    <xme:atCqYqlko5_axUa1aAP80qjgPq72LOdLs6962kAl7P-9ikJqvYmHhGODGAn_AyyAR
    6zCIgc6wdhuMc7nOQ>
X-ME-Received: <xmr:atCqYiYKLhbKqfbZiLOqmHIwmEC6vpzoNrKXVGqYO9M2W2D8yy2LVQPf_fe0JifN85WXaXBzAg3xXyY5PpBVBdWqrvd4iRM7CqfmTPR069shznEkRmvFdZQKCOrlmXA7WwcVrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:atCqYlXio2KsAw3QZ7QXmnl0qNCf3Z42EPQsLLzzwvgHXedksBXamQ>
    <xmx:atCqYomAv9WIlI5gWpKkzVjT1PZxj7rrEn2zLssbNQYHlyhJHVFEGw>
    <xmx:atCqYqdsN92KQ8YGA0XkBLRTuZ5qbzPaWJsfPQicNg4NfKYP3KRMHQ>
    <xmx:a9CqYj_JXZYvmoz9w5Ia_TJxgJg1p6D0OsUmqP4uKxIr4cTKdnApOw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:40:42 -0400 (EDT)
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
Subject: [PATCH v2 4/6] genirq: Provide an IRQ affinity mask in non-SMP configs
Date:   Thu, 16 Jun 2022 01:40:26 -0500
Message-Id: <20220616064028.57933-5-samuel@sholland.org>
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

IRQ affinity masks are not allocated in uniprocessor configurations.
This requires special case non-SMP code in drivers for irqchips which
have per-CPU enable or mask registers.

Since IRQ affinity is always the same in a uniprocessor configuration,
we can still provide the correct affinity mask without allocating one
per IRQ. We can reuse the system-wide cpu_possible_mask.

By returning a real cpumask from irq_data_get_affinity_mask even when
SMP is disabled, irqchip drivers which iterate over that mask will
automatically do the right thing.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 include/linux/irq.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 69ee4e2f36ce..d5e958b026aa 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -151,7 +151,9 @@ struct irq_common_data {
 #endif
 	void			*handler_data;
 	struct msi_desc		*msi_desc;
+#ifdef CONFIG_SMP
 	cpumask_var_t		affinity;
+#endif
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	cpumask_var_t		effective_affinity;
 #endif
@@ -881,7 +883,11 @@ static inline int irq_data_get_node(struct irq_data *d)
 
 static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 {
+#ifdef CONFIG_SMP
 	return d->common->affinity;
+#else
+	return &__cpu_possible_mask;
+#endif
 }
 
 static inline struct cpumask *irq_get_affinity_mask(int irq)
-- 
2.35.1

