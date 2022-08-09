Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6697E58D201
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiHICV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHICVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:21:55 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35CE71B782
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:21:55 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5099B1E80D70;
        Tue,  9 Aug 2022 10:20:12 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0mHvrptkFAJs; Tue,  9 Aug 2022 10:20:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 8A5FA1E80D0A;
        Tue,  9 Aug 2022 10:20:09 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] clocksource/drivers/ingenic: remove unnecessary (void*) conversions
Date:   Tue,  9 Aug 2022 10:21:49 +0800
Message-Id: <20220809022149.8415-1-xupengfei@nfschina.com>
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
 drivers/clocksource/ingenic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
index 24ed0f1f089b..1ee4a8ced8d4 100644
--- a/drivers/clocksource/ingenic-timer.c
+++ b/drivers/clocksource/ingenic-timer.c
@@ -104,7 +104,7 @@ static int ingenic_tcu_cevt_set_next(unsigned long next,
 
 static void ingenic_per_cpu_event_handler(void *info)
 {
-	struct clock_event_device *cevt = (struct clock_event_device *) info;
+	struct clock_event_device *cevt = info;
 
 	cevt->event_handler(cevt);
 }
-- 
2.18.2

