Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D959E8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343854AbiHWRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344853AbiHWRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:11:20 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C51AF49B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:59:05 -0700 (PDT)
X-QQ-mid: bizesmtp65t1661263139t8xkl00a
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 21:58:58 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: ILHsT53NKPjHCKbWdw2Ev+HCg+vtubMSNDB/HPDggiCua6mrLbeUNr8v4XjlD
        oem9LYvH8Jd4Lx9A//IVc4PlLmS/c8yxJlFbYMXP5/MvLw2pGiNhBKLLgQLiXA2b0JGCcHj
        ONWfs/aZExtbUFyjQzyHfnDPkaXaIXNK18h/2Akd6vVfojWzPm8o84bFbHHeGiqOM7stfwW
        yLBVuuUDQiPJNgISJDJlq3GyTKxJF+D5fb4cKu3EJ16sMmtNh4jWkUmj19pGnAcvselem0T
        7J3QFYQrp4eyhshPziKr0c3j6hVEhhZJK+Wzm0H52o3dHOPrss3XgdQnAssF4A+EFqwvQjP
        V3ildHuaY8zkC5dheZp+MuMP0XUZEVdKB9DfYSct05D03SQiXQGTwGKpS5YsZdjXJVedV5x
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/cpuidle: fix repeated words in comments
Date:   Tue, 23 Aug 2022 21:58:52 +0800
Message-Id: <20220823135852.1625-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'are'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/cpuidle/coupled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 74068742cef3..9acde71558d5 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -54,7 +54,7 @@
  * variable is not locked.  It is only written from the cpu that
  * it stores (or by the on/offlining cpu if that cpu is offline),
  * and only read after all the cpus are ready for the coupled idle
- * state are are no longer updating it.
+ * state are no longer updating it.
  *
  * Three atomic counters are used.  alive_count tracks the number
  * of cpus in the coupled set that are currently or soon will be
-- 
2.36.1

