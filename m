Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2324D7EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbiCNJaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbiCNJ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAE5434B4;
        Mon, 14 Mar 2022 02:28:28 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250106;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+u2et7hoZgP7Z8ClW3Uh9gbhmjodfwBHypwg6xx4txQ=;
        b=g/LNDwGFOOZdLpHOituAxHUmK4zLFt2BWMNcHTTL6a46nhsuP7/oScJynUyrk608FT1taj
        2jalSViczdOuFIUd3NDL/fTlgFWnhBz0doT3Sw/RScPFBZN0bT1iq9e2nKU55Y67VD84UM
        hdGE/yWZtqCuvxEb/NrONtFR+5ghu2gwfhezwwC2oAQuC4vO4cHkEMAjv2AqYs93tqqscY
        tHAiobuvZdV3aLOZTI8QH/Hffo3s1DnT1QQhKh/enY8f+V6eiaE+qLLnStLgbvd7d8J8oL
        tE0f/6EYENXDZGF4pvHbfxTH8ev9EZzdQL0HR9ayb8S6NHDPgXggG0lhhIZr/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250106;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+u2et7hoZgP7Z8ClW3Uh9gbhmjodfwBHypwg6xx4txQ=;
        b=Ti39oftJ3WrIm5F7KN3hCXGLysdEqcZuqZG8CtKeky+5qiBmIMTAmocF1wpWOnA0ey5GP3
        JtI0m6lOIIzK0xCg==
From:   "tip-bot2 for Alim Akhtar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Increase the size
 of name array
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220221174547.26176-3-alim.akhtar@samsung.com>
References: <20220221174547.26176-3-alim.akhtar@samsung.com>
MIME-Version: 1.0
Message-ID: <164725010547.16921.8057421664894415746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0a3a4b9d2bb7928f54579421bbadd4aa9c4a94f0
Gitweb:        https://git.kernel.org/tip/0a3a4b9d2bb7928f54579421bbadd4aa9c4a94f0
Author:        Alim Akhtar <alim.akhtar@samsung.com>
AuthorDate:    Mon, 21 Feb 2022 23:15:47 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:22 +01:00

clocksource/drivers/exynos_mct: Increase the size of name array

Variable _name_ hold mct_tick number per cpu and it is currently
limited to 10. Which restrict the scalability of the MCT driver for
the SoC which has more local timers interrupts (>= 12).
Increase the length of it to make mct_tick printed correctly for
each local timer interrupts per CPU.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20220221174547.26176-3-alim.akhtar@samsung.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index bcf2100..f29c812 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -80,7 +80,11 @@ static int mct_irqs[MCT_NR_IRQS];
 struct mct_clock_event_device {
 	struct clock_event_device evt;
 	unsigned long base;
-	char name[10];
+	/**
+	 *  The length of the name must be adjusted if number of
+	 *  local timer interrupts grow over two digits
+	 */
+	char name[11];
 };
 
 static void exynos4_mct_write(unsigned int value, unsigned long offset)
