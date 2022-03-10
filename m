Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE604D4D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbiCJPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344066AbiCJPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:10:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9D195304
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:04:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83000616F7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F69C340FA;
        Thu, 10 Mar 2022 15:04:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nSKLS-001DaM-0L;
        Thu, 10 Mar 2022 10:04:50 -0500
Message-ID: <20220310150449.848734097@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Mar 2022 10:04:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [for-linus][PATCH 3/3] ftrace: Fix some W=1 warnings in kernel doc comments
References: <20220310150431.248810778@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Clean up the following clang-w1 warning:

kernel/trace/ftrace.c:7827: warning: Function parameter or member 'ops'
not described in 'unregister_ftrace_function'.

kernel/trace/ftrace.c:7805: warning: Function parameter or member 'ops'
not described in 'register_ftrace_function'.

Link: https://lkml.kernel.org/r/20220307004303.26399-1-jiapeng.chong@linux.alibaba.com

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a4b462b6f944..6105b7036482 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7790,7 +7790,7 @@ int ftrace_is_dead(void)
 
 /**
  * register_ftrace_function - register a function for profiling
- * @ops - ops structure that holds the function for profiling.
+ * @ops:	ops structure that holds the function for profiling.
  *
  * Register a function to be called by all functions in the
  * kernel.
@@ -7817,7 +7817,7 @@ EXPORT_SYMBOL_GPL(register_ftrace_function);
 
 /**
  * unregister_ftrace_function - unregister a function for profiling.
- * @ops - ops structure that holds the function to unregister
+ * @ops:	ops structure that holds the function to unregister
  *
  * Unregister a function that was added to be called by ftrace profiling.
  */
-- 
2.34.1
