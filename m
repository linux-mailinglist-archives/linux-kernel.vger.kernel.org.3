Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D943051F280
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiEIBeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiEIBba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 21:31:30 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513982616
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 18:21:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B92D15C0037;
        Sun,  8 May 2022 21:21:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 08 May 2022 21:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1652059283; x=1652145683; bh=ocfO726Kgd2oGw0Tv8/aji7U+
        imgHZnPcKK9GAi4KlI=; b=d+9NBS2sBLLKEL2qcU/34D6uosjdcq9dBliOwCGFW
        TEU+O+EMDSKf7zz+BN8GSleUoPs2F+tUKhTUngLrZbSBMJN+doFn4svxQ3O2WPF5
        VpI2BKMOH+vEwYAnfB9vlP7F1SkQonpebKjjhCbPt48EWZQhZfDNhYqUwIeHG8Yv
        JfBiGp4kLgHHZa0F1j+UpclI7+uL6MpqMC+pV8ewBwWZwMvp3lGG6SG+lirIovrN
        l+rfoEo32ulilyStCA431Ey2z1Qb42pN7ptrLO6itrGcphAR9ydnetg+O8MGuagX
        SKjCZ5hf3R6aBCPOVwEbC2V/wTnAQ9V7iCNJEFbaHOAOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1652059283; x=1652145683; bh=o
        cfO726Kgd2oGw0Tv8/aji7U+imgHZnPcKK9GAi4KlI=; b=dO3GHKZMgU11UaHc1
        QEpGIP2jbuj/Tq8wFi4xsnDNa/1nCTFn7oBzY/qczvca4MVqMccEkLE067BjE7fk
        iscbjIOTlYo/sgzMh7Pn5vpORWNOzr4DAt3Iu6iHER0/j1UwO07Qn0zEat/sENne
        dnr8fzFzkCIEmpFwwcnZUrfplcMx/HG4LZhqROIcIFyvnQniLeL4fqw14oM48w9l
        NJ1WOxP40lCeeUCmjxXu2+8YfnZC3ZSIIooqkoGeZpuQSDaO4Pb0QGJkTkstlmgn
        PVchO3fBF83UKDSlQ3pjW1JzHz/fdGcRF6F+n+8ojHddjutJsA58zmOj/mSjQnOf
        k68iA==
X-ME-Sender: <xms:k2x4Ysn70GTH1JovlHEbcp26RUS1-4ZuduHQlb2IKnisUuHDj7rj8A>
    <xme:k2x4Yr3mc2KBBIEce88Sw7l7n2y12T5jxJQJ9tamdYP-6NTsVyoAT2BTdnMrJw9PA
    u9yjELy5aorvBUJ5g>
X-ME-Received: <xmr:k2x4YqpkQ6Cvb54l9UqgmOOsZfG7JORdkYtb9_OEMeqD1o5L46reCQk7eYZoyhr8J5hqcdErmYCJwgaUt9ukKOOULCMjxBhXY1KQefOanDG8TXqtLc3mBny9FLvl0S-nV1cGMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:k2x4YokEvkaTQfzTENfDRfAmV0SrrrP3NlUPcmEYuNhCXv3aOPLKWA>
    <xmx:k2x4Yq3Iig-cH0MnLWMZkppJEkW_sBIjCxSFwFVp8yGts_KOcwKi6w>
    <xmx:k2x4Yvt7xdRQidW0bA-lxRUTHmouqU4BMQPF0aCRilhuaefTCkpqTg>
    <xmx:k2x4YrLLnMwTQsUGyAtn9XgI8PMkvW_CrbF0SzkJm1I1RYKl5ZQD4A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 May 2022 21:21:22 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] clocksource/drivers/riscv: Events are stopped during CPU suspend
Date:   Sun,  8 May 2022 20:21:21 -0500
Message-Id: <20220509012121.40031-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

Some implementations of the SBI time extension depend on hart-local
state (for example, CSRs) that are lost or hardware that is powered
down when a CPU is suspended. To be safe, the clockevents driver
cannot assume that timer IRQs will be received during CPU suspend.

Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 1767f8bf2013..593d5a957b69 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long delta,
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
 	.rating			= 100,
 	.set_next_event		= riscv_clock_next_event,
 };
-- 
2.35.1

