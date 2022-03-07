Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD54CEEFF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 01:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiCGAoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 19:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiCGAoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 19:44:03 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB2513E39
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 16:43:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V6NTmX2_1646613785;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V6NTmX2_1646613785)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 08:43:08 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ftrace: Fix some W=1 warnings
Date:   Mon,  7 Mar 2022 08:43:03 +0800
Message-Id: <20220307004303.26399-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following clang-w1 warning:

kernel/trace/ftrace.c:7827: warning: Function parameter or member 'ops'
not described in 'unregister_ftrace_function'.

kernel/trace/ftrace.c:7805: warning: Function parameter or member 'ops'
not described in 'register_ftrace_function'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index acb50fb7ed2d..8b568f57cc24 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7792,7 +7792,7 @@ int ftrace_is_dead(void)
 
 /**
  * register_ftrace_function - register a function for profiling
- * @ops - ops structure that holds the function for profiling.
+ * @ops:	ops structure that holds the function for profiling.
  *
  * Register a function to be called by all functions in the
  * kernel.
@@ -7819,7 +7819,7 @@ EXPORT_SYMBOL_GPL(register_ftrace_function);
 
 /**
  * unregister_ftrace_function - unregister a function for profiling.
- * @ops - ops structure that holds the function to unregister
+ * @ops:	ops structure that holds the function to unregister
  *
  * Unregister a function that was added to be called by ftrace profiling.
  */
-- 
2.20.1.7.g153144c

