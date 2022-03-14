Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAFF4D7E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiCNJah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbiCNJ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:29:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E470C43ED7;
        Mon, 14 Mar 2022 02:28:28 -0700 (PDT)
Date:   Mon, 14 Mar 2022 09:28:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647250107;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjjJNZm2xM8/hV5Wy/QhDpFZFya1mjP/FO38qkzE/kI=;
        b=c2CuoOyoXGOAIJ+Nc1Phjts7Ys+CtCheQcONLu46SEgjwRCKoZ4MRNUkcdWRX7Nw5CDUhE
        w0ecaNOq7eJ/sGjd5vNRlG+LWO/6sX46UbxUunDd9kNuvSRSpMzjZJ7Mm46fgtCG29M8dd
        B4WR3Wv9Yub6GDh45dEDv8BPwR+ag5DtU3LPiQ2rh0/eE0pLCAsAWrdFZpEqYODoQftAt6
        UhDrtspCie8+C4kqfTuivE+F+o77vQJsdxZIRVNErKoWlaaUl8tD/PkHC2lR8WV1Xca+2+
        V6yk6Oqn8OU49HIob4H098ZYSOryYK+Xkd4QdvTQ5OcThNZcTmfHjxroNq1U4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647250107;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PjjJNZm2xM8/hV5Wy/QhDpFZFya1mjP/FO38qkzE/kI=;
        b=T/r0tmGHetqs18dQjA9x6gqU8LAFB4F1WL6mvM0MHucptuS+YiuhZEH7HrScTu25tAPxPQ
        w9IVweDvYvnu81Bg==
From:   "tip-bot2 for Alim Akhtar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Bump up mct max irq number
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220221174547.26176-2-alim.akhtar@samsung.com>
References: <20220221174547.26176-2-alim.akhtar@samsung.com>
MIME-Version: 1.0
Message-ID: <164725010645.16921.12185056725638897002.tip-bot2@tip-bot2>
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

Commit-ID:     f49b82a0a54fa85451ed96c35f24679522d59c7a
Gitweb:        https://git.kernel.org/tip/f49b82a0a54fa85451ed96c35f24679522d59c7a
Author:        Alim Akhtar <alim.akhtar@samsung.com>
AuthorDate:    Mon, 21 Feb 2022 23:15:46 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 07 Mar 2022 18:27:22 +01:00

clocksource/drivers/exynos_mct: Bump up mct max irq number

Bump-up maximum number of MCT IRQ to match the binding
documentation. This make driver scalable for SoC which
has more than 12 timer irqs, like recently added FSD SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Link: https://lore.kernel.org/r/20220221174547.26176-2-alim.akhtar@samsung.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 341ee47..bcf2100 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -64,7 +64,8 @@
 #define MCT_G0_IRQ	0
 /* Local timers count starts after global timer count */
 #define MCT_L0_IRQ	4
-#define MCT_NR_IRQS	12
+/* Max number of IRQ as per DT binding document */
+#define MCT_NR_IRQS	20
 
 enum {
 	MCT_INT_SPI,
