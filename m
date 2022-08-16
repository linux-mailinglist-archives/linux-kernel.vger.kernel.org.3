Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20A2595C35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiHPMrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiHPMqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:46:40 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91CE77E92;
        Tue, 16 Aug 2022 05:45:11 -0700 (PDT)
X-QQ-mid: bizesmtp90t1660653907t6nq4iup
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 20:45:06 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: ILHsT53NKPiZ5/pcX6hNp/tyyZ8jwvYvGq6P+ZkOmWNdzn1RgNxQxdovUMg5v
        OKNihxqMtehl5/vXWuZuSkYUJEVgL4tSZ4excTvgppmy0Br41j7nYI0RAt0SbW8e8rQ08xa
        1xlN6EuYqblb2zjzOnsy9E9uvX/4MIYvOYtRG3C6Y0C8vzwjSusHHbsGnZLNo1F7s84nF5n
        akUWLe9ljgW7p2aTpHzCA8cSVaPGV0muXMxpucpOydZryQcavHnEAHffE8t3gvQY+HuH/OZ
        ymJHSaslxS/DI3f0To1eg90jMJs5C0A6GOrD6SeFkaKoVFVORE1RwgveFFMgw3Rd/SBKs0W
        eG1V6WvfKhhbS/aT+p0Z/iozeuVmNW69ciFe0HjNN8Cpb3cUESLA5MScVYNpM/nB5Yf3VGv
        vu1FryvZVPE=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/watchdog: fix repeated words in comments
Date:   Tue, 16 Aug 2022 20:44:58 +0800
Message-Id: <20220816124458.16843-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'we'.
 Delete the redundant word 'have'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/watchdog/dw_wdt.c      | 2 +-
 drivers/watchdog/eurotechwdt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index cd578843277e..3208ce305335 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -218,7 +218,7 @@ static int dw_wdt_set_timeout(struct watchdog_device *wdd, unsigned int top_s)
 
 	/*
 	 * Set the new value in the watchdog.  Some versions of dw_wdt
-	 * have have TOPINIT in the TIMEOUT_RANGE register (as per
+	 * have TOPINIT in the TIMEOUT_RANGE register (as per
 	 * CP_WDT_DUAL_TOP in WDT_COMP_PARAMS_1).  On those we
 	 * effectively get a pat of the watchdog right here.
 	 */
diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
index ce682942662c..e26609ad4c17 100644
--- a/drivers/watchdog/eurotechwdt.c
+++ b/drivers/watchdog/eurotechwdt.c
@@ -192,7 +192,7 @@ static void eurwdt_ping(void)
  * @ppos: pointer to the position to write. No seeks allowed
  *
  * A write to a watchdog device is defined as a keepalive signal. Any
- * write of data will do, as we we don't define content meaning.
+ * write of data will do, as we don't define content meaning.
  */
 
 static ssize_t eurwdt_write(struct file *file, const char __user *buf,
-- 
2.36.1

