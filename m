Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73F5595C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiHPMr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiHPMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:47:25 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ED4B07DE;
        Tue, 16 Aug 2022 05:46:06 -0700 (PDT)
X-QQ-mid: bizesmtp84t1660653961tmmppklh
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 20:46:00 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: LE7C6P2vL8R/Zo2ENKZ0zlbt+dkX4D8P+kCdlSz0cerNSWvn9msUgRptDim/K
        aH6wFKMnVMPD9yPaifaz/1ga7Kw4iXK5KiwuJlHiRWv00OmWFZOhO8HAuebEappyztTUs7l
        Df+zsUJtESt/x4qOwm1Bq0nlHd0IuIPuK0WtZ3FPlRxUqwGVS0ixwojhcx4qzA69Qs8tIHF
        KHHzTNGK9toVxZ/v+upAjWm/u2EmOu5pEX+JiyHDIjFBb0jL2OS38dBl2FI1CDXGLkZn1UF
        rYMH3WtXuGyFnA75QtmfPMzciDwCn59fIZZ96X8gPHB+g7YL7TQ0cV57DGBMCEa/NR2yV2x
        YmFD0ahl1OQgMJ0LoN3ySK0KPxkdu4snKkHz1RwH/iNkJUe/HTKFRtj19btirDVe1bAm8v8
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/watchdog: fix repeated words in comments
Date:   Tue, 16 Aug 2022 20:45:53 +0800
Message-Id: <20220816124553.17561-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'and'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/watchdog/booke_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 5e4dc1a0f2c6..75da5cd02615 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -74,7 +74,7 @@ static unsigned long long period_to_sec(unsigned int period)
 /*
  * This procedure will find the highest period which will give a timeout
  * greater than the one required. e.g. for a bus speed of 66666666 and
- * and a parameter of 2 secs, then this procedure will return a value of 38.
+ * a parameter of 2 secs, then this procedure will return a value of 38.
  */
 static unsigned int sec_to_period(unsigned int secs)
 {
-- 
2.36.1

