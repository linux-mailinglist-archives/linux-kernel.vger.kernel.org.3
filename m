Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664885875D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiHBDIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiHBDIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:08:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19264136;
        Mon,  1 Aug 2022 20:07:56 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lxfvt4B0WzWfS0;
        Tue,  2 Aug 2022 11:03:54 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 11:07:53 +0800
Received: from huawei.com (10.174.176.191) by dggpemm500018.china.huawei.com
 (7.185.36.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 2 Aug
 2022 11:07:52 +0800
From:   Tie Liu <liutie4@huawei.com>
To:     <jstultz@google.com>, <tglx@linutronix.de>, <sboyd@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hewenliang4@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH] clocksource: Resolve some coding specification issues about spaces
Date:   Tue, 2 Aug 2022 11:07:49 +0800
Message-ID: <20220802030749.1044-1-liutie4@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.191]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some spaces were not used in accordance with current 
encoding specifications, so I tried to modify them.

Signed-off-by: Liu Tie <liutie4@huawei.com>
---
 kernel/time/clocksource.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cee5da1e5..46b738696 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -47,7 +47,7 @@ void
 clocks_calc_mult_shift(u32 *mult, u32 *shift, u32 from, u32 to, u32 maxsec)
 {
 	u64 tmp;
-	u32 sft, sftacc= 32;
+	u32 sft, sftacc = 32;
 
 	/*
 	 * Calculate the shift factor which is limiting the conversion
@@ -55,7 +55,7 @@ clocks_calc_mult_shift(u32 *mult, u32 *shift, u32 from, u32 to, u32 maxsec)
 	 */
 	tmp = ((u64)maxsec * from) >> 32;
 	while (tmp) {
-		tmp >>=1;
+		tmp >>= 1;
 		sftacc--;
 	}
 
@@ -863,7 +863,7 @@ static u32 clocksource_max_adjustment(struct clocksource *cs)
 	 * We won't try to correct for more than 11% adjustments (110,000 ppm),
 	 */
 	ret = (u64)cs->mult * 11;
-	do_div(ret,100);
+	do_div(ret, 100);
 	return (u32)ret;
 }
 
@@ -1446,7 +1446,7 @@ device_initcall(init_clocksource_sysfs);
  * Takes a clocksource= boot argument and uses it
  * as the clocksource override name.
  */
-static int __init boot_override_clocksource(char* str)
+static int __init boot_override_clocksource(char *str)
 {
 	mutex_lock(&clocksource_mutex);
 	if (str)
@@ -1464,7 +1464,7 @@ __setup("clocksource=", boot_override_clocksource);
  * DEPRECATED! Takes a clock= boot argument and uses it
  * as the clocksource override name
  */
-static int __init boot_override_clock(char* str)
+static int __init boot_override_clock(char *str)
 {
 	if (!strcmp(str, "pmtmr")) {
 		pr_warn("clock=pmtmr is deprecated - use clocksource=acpi_pm\n");
-- 
2.27.0

