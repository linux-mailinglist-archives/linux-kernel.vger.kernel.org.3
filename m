Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31E958D200
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiHICVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHICV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:21:29 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 437A6193D0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:21:28 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6F5D21E80CD2;
        Tue,  9 Aug 2022 10:19:45 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qVxw8NlsAiae; Tue,  9 Aug 2022 10:19:42 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B4D7D1E80CC5;
        Tue,  9 Aug 2022 10:19:42 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] clocksource: Remove unnecessary (void*) conversions
Date:   Tue,  9 Aug 2022 10:21:22 +0800
Message-Id: <20220809022122.3419-1-zeming@nfschina.com>
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
 drivers/clocksource/timer-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
index 430cb99d8d79..9b97fd87fbe9 100644
--- a/drivers/clocksource/timer-sprd.c
+++ b/drivers/clocksource/timer-sprd.c
@@ -109,7 +109,7 @@ static int sprd_timer_shutdown(struct clock_event_device *ce)
 
 static irqreturn_t sprd_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *ce = (struct clock_event_device *)dev_id;
+	struct clock_event_device *ce = dev_id;
 	struct timer_of *to = to_timer_of(ce);
 
 	sprd_timer_clear_interrupt(timer_of_base(to));
-- 
2.18.2

