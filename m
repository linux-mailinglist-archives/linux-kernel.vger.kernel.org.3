Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D154C29C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiBXKnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiBXKnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:43:49 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8251A39E8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:43:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V5Nr-oV_1645699346;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V5Nr-oV_1645699346)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Feb 2022 18:43:17 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tangmeng@uniontech.com
Cc:     matti.vaittinen@fi.rohmeurope.com, josef@toxicpanda.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] kernel/reboot.c: Fix hw_failure_emergency_poweroff() kernel-doc comment
Date:   Thu, 24 Feb 2022 18:42:25 +0800
Message-Id: <20220224104225.67677-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following clang-w1 warning:

kernel/reboot.c:587: warning: Function parameter or member
'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index ed4e6dfb7d44..c18d9515a27f 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -579,6 +579,7 @@ static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
 
 /**
  * hw_failure_emergency_poweroff - Trigger an emergency system poweroff
+ * @poweroff_delay_ms: Shutdown delay time value.
  *
  * This may be called from any critical situation to trigger a system shutdown
  * after a given period of time. If time is negative this is not scheduled.
-- 
2.20.1.7.g153144c

