Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FA551F30B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiEIDwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiEIDrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:47:32 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A80480738
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:43:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 791A35C008E;
        Sun,  8 May 2022 23:43:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 08 May 2022 23:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1652067819; x=1652154219; bh=ms
        qaI6htjko0o6Rwzc8TtNjGSkoayAQlCj6N0SQz54I=; b=lRTlGsZ9kxDxUh0qCb
        EjjgtT9tAhe08Ty5rMNqmz0PJQdBvU+irvbX7bSxciyGGNjk1hmVJFEd9xWI2aCz
        Gpq3Pj1O1KNnuw/nb945TN83GP9L6XGngDUzHDfQk6m9gLWIneK3EM6XPeT+ESbP
        ieAY5ehvtUJ8dmOCbnOHSOkj5rapT7s/drrrw0yjQNlrB2IWR+HfjX9S8cQoEMUN
        ctAMfIEvozkjk4v2RQqOrYMV11FvJxfqI5qkl05CgMPDqIIsBlZoXcwLj8NXoy7P
        Bz+8DZqKvvuXkfyP4OC6aFMrwpo6wmPAtRYJVXjZZyHnkZy/uRGk4+VQSppQbXr5
        z7Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1652067819; x=1652154219; bh=msqaI6htjko0o6Rwzc8TtNjGSkoayAQlCj6
        N0SQz54I=; b=hoKbVwFI3G/m5K1WVbeWY1q4VPgRTN1HRYgkS5EdHixn/yiHriF
        FBvaTsmU8I6rStGtmQIkEudQYu/No1b+ZqHDFPq8pnNLYUb93wSqIQ4HZRn/Lvsg
        kOvPrxaV4fXReWjRoOzBi2PdpYPSiPJFVtq1tW5vCA7hNdUT5HihiTN2FrbYseGk
        vHlv11W5RHS0IYzQTeYWPGBBhOVBddd4057X5iyr0Os/15W0IUWn4dUBwHkhXFS8
        WrW+Kv0jGtGOrb2nnJwH4/47eEo9XVilr7+KlLjh5tcSdohSTKPArS+i9W1HmzTr
        J6jeH13qrkSQamxVk0XUxugVwdWe/nuGcHw==
X-ME-Sender: <xms:6414YksMW7cpWEIYuM-zvUPARGoIu79gT36Tkj9zdTcKYqDZEpqt_A>
    <xme:6414Yhe66YWntqsrVjGIIso8BU2IJL6e9MJ-9RXeKxFNXeQdtiXbrk415D7uIxihk
    a15GIw9rEYtiI4RwQ>
X-ME-Received: <xmr:6414Yvw9SXimNlxMb0ddnhGce4Eir7V13si8gO-wGgDnn-WwgWsMR3TbssiCazOYwyTXXAmblDvHtVeH2Ec0a_gyvHsR_ZIUw3ZMSVyC1IrkXBBEA0sJdZWi5NgiyMJ3ozpy9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6414YnM4E_axMnt9oYwuymYZpwmrANSIYLY_m6mJBgThxbIHcK-jkg>
    <xmx:6414Yk8fLgvQtrQXokzTxUJD5iZaqN204LZWucdOQljTCRONosBsdQ>
    <xmx:6414YvXqfhL-C-gAXUjt6XRdrz3ipCVbhIBOKNRttJkw7g7XQGrDdw>
    <xmx:6414Yuca92C7IsGa6t_7ocOER7C9SWIGX7h172dh9aYTZ25Hqb5fQQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 May 2022 23:43:38 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Samuel Holland <samuel@sholland.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 3/5] genirq: Provide an IRQ affinity mask in non-SMP configs
Date:   Sun,  8 May 2022 22:43:31 -0500
Message-Id: <20220509034333.60017-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509034333.60017-1-samuel@sholland.org>
References: <20220509034333.60017-1-samuel@sholland.org>
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

 include/linux/irq.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 48ac33ca3703..d716e882c020 100644
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
@@ -879,7 +881,11 @@ static inline int irq_data_get_node(struct irq_data *d)
 
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

