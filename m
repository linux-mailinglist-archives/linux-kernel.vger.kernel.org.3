Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1657AD98
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbiGTCHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbiGTCHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:07:45 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D1E857256
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:07:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 75C8A1E80D46;
        Wed, 20 Jul 2022 10:03:28 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6nnFMm1IVyhs; Wed, 20 Jul 2022 10:03:25 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id AEB0F1E80C80;
        Wed, 20 Jul 2022 10:03:25 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] clocksource/drivers/sun4i: remove unnecessary (void*) conversions
Date:   Wed, 20 Jul 2022 10:07:35 +0800
Message-Id: <20220720020735.3771-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type casting.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 drivers/clocksource/timer-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-sun4i.c
index bb6ea6c19829..94dc6e42e983 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -128,7 +128,7 @@ static void sun4i_timer_clear_interrupt(void __iomem *base)
 
 static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	struct clock_event_device *evt = dev_id;
 	struct timer_of *to = to_timer_of(evt);
 
 	sun4i_timer_clear_interrupt(timer_of_base(to));
-- 
2.18.2

