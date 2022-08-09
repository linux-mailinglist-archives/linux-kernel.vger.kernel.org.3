Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0751B58D20F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiHICnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiHICm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:42:59 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 393361BEA4
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:42:58 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 419C61E80D95;
        Tue,  9 Aug 2022 10:41:15 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qBf77Qdk2HDE; Tue,  9 Aug 2022 10:41:12 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 974601E80D77;
        Tue,  9 Aug 2022 10:41:12 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] clocksource/timer-mediatek: Remove unnecessary (void*) conversions
Date:   Tue,  9 Aug 2022 10:42:53 +0800
Message-Id: <20220809024253.3727-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary void* type castings.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/clocksource/timer-mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
index d5b29fd03ca2..35e08c329d8e 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -264,7 +264,7 @@ static int mtk_gpt_clkevt_next_event(unsigned long event,
 
 static irqreturn_t mtk_gpt_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *clkevt = (struct clock_event_device *)dev_id;
+	struct clock_event_device *clkevt = dev_id;
 	struct timer_of *to = to_timer_of(clkevt);
 
 	/* Acknowledge timer0 irq */
-- 
2.18.2

