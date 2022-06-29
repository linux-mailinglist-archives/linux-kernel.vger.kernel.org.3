Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43955F661
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiF2GMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiF2GMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:12:34 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2867D101C1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:12:34 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5F3C71E80D11;
        Wed, 29 Jun 2022 14:11:23 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TO_unnP3jnrg; Wed, 29 Jun 2022 14:11:20 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: chuanjian@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id AF4A61E80CDC;
        Wed, 29 Jun 2022 14:11:20 +0800 (CST)
From:   Dong Chuanjian <chuanjian@nfschina.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel@nfschina.com,
        Dong Chuanjian <chuanjian@nfschina.com>
Subject: [PATCH] driver: remove unnecessary void* conversions..
Date:   Wed, 29 Jun 2022 14:12:27 +0800
Message-Id: <20220629061227.3960-1-chuanjian@nfschina.com>
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

Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>
---
 drivers/clocksource/timer-ti-dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 3e52c5226c4d..5d89629507b7 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -299,7 +299,7 @@ static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
 		cap = *(u32 *)data;
 		break;
 	case REQUEST_BY_NODE:
-		np = (struct device_node *)data;
+		np = data;
 		break;
 	default:
 		/* REQUEST_ANY */
-- 
2.18.2

