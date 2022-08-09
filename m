Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E71958D20C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiHICg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiHICf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:35:57 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51540FD7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:35:56 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 53A231E80D70;
        Tue,  9 Aug 2022 10:34:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RZ1XjhXY0toH; Tue,  9 Aug 2022 10:34:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7FBED1E80D0A;
        Tue,  9 Aug 2022 10:34:10 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     verdun@hpe.com, nick.hawkins@hpe.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] clocksource/drivers/timer-gxp: remove unnecessary (void*) conversions
Date:   Tue,  9 Aug 2022 10:35:50 +0800
Message-Id: <20220809023550.8624-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type casting.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 drivers/clocksource/timer-gxp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-gxp.c b/drivers/clocksource/timer-gxp.c
index 8b38b3212388..c33c71c4425b 100644
--- a/drivers/clocksource/timer-gxp.c
+++ b/drivers/clocksource/timer-gxp.c
@@ -56,7 +56,7 @@ static int gxp_time_set_next_event(unsigned long event, struct clock_event_devic
 
 static irqreturn_t gxp_timer_interrupt(int irq, void *dev_id)
 {
-	struct gxp_timer *timer = (struct gxp_timer *)dev_id;
+	struct gxp_timer *timer = dev_id;
 
 	if (!(readb_relaxed(timer->control) & MASK_TCS_TC))
 		return IRQ_NONE;
-- 
2.18.2

