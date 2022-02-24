Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7CC4C29DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiBXKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbiBXKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:52:06 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60422AD8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:51:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V5NrOEA_1645699886;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V5NrOEA_1645699886)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Feb 2022 18:51:32 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     chris.hyser@oracle.com
Cc:     ran.xiaokai@zte.com.cn, ccross@google.com, pcc@google.com,
        dave@stgolabs.net, david@redhat.com, caoxiaofeng@yulong.com,
        linux-kernel@vger.kernel.org,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] kernel/sys.c: clean up some inconsistent indenting
Date:   Thu, 24 Feb 2022 18:51:24 +0800
Message-Id: <20220224105124.73645-1-jiapeng.chong@linux.alibaba.com>
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

From: chongjiapeng <jiapeng.chong@linux.alibaba.com>

Eliminate the follow smatch warning:

kernel/sys.c:1617 do_prlimit() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
---
 kernel/sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 97dc9e5d6bf9..330de8b2d8f4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1614,9 +1614,9 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 	 * infinite. In case of RLIM_INFINITY the posix CPU timer code
 	 * ignores the rlimit.
 	 */
-	 if (!retval && new_rlim && resource == RLIMIT_CPU &&
-	     new_rlim->rlim_cur != RLIM_INFINITY &&
-	     IS_ENABLED(CONFIG_POSIX_TIMERS))
+	if (!retval && new_rlim && resource == RLIMIT_CPU &&
+	    new_rlim->rlim_cur != RLIM_INFINITY &&
+	    IS_ENABLED(CONFIG_POSIX_TIMERS))
 		update_rlimit_cpu(tsk, new_rlim->rlim_cur);
 out:
 	read_unlock(&tasklist_lock);
-- 
2.19.1.6.gb485710b

