Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF23E4D9649
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbiCOIdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345991AbiCOIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9104C7B5;
        Tue, 15 Mar 2022 01:31:06 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:31:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=G1ArYyEHOd1xXfjFotnqm8kTqfvGJHVvjPOLnY3Aa0M=;
        b=ekPgttry6AysXwInT5J3c9owHW081QsJI2x3g6UgrQJSBkOIwTkN7lR82sJF5jVSU8pJMw
        DJ4pfp0Eme9yx6kNHXNQfg6j1V+UxeLw4FUBz3Aq0NBkZRSBRMqHiEV5G5DoO1k7W+bDJU
        qJj4CrAJFjSe/hJaVcj8LsRU6YWgj4mivmwsR7UDbGn6xzlPd5WDNHeNs//ehg7MUdvpkV
        uJyJUNuwMUq+LxHMACfHSF8YC4mOIB91VJZ6hX9ZYGfwnS/W98KSkXDeGssnYq+FZlXAKl
        uX97hDeaVOS7WcZJ2cyq1Hzt2ui/jzCtAhqQO6pc3eBN4FJKtVtzkUN6t/hFpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=G1ArYyEHOd1xXfjFotnqm8kTqfvGJHVvjPOLnY3Aa0M=;
        b=cG04VWnBDlfSioCABrbVSzte20GMbe0EcXJQ4YDh+N9nPV6Lpwc2IBvcw9Ws7mks+KLHlY
        vPyrgsdYVbtBQZCg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Add header guard to
 kernel/sched/stats.h and kernel/sched/autogroup.h
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733306423.16921.13170771691611393113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d90a2f160a1cd9a1745896c381afdf8d2812fd6b
Gitweb:        https://git.kernel.org/tip/d90a2f160a1cd9a1745896c381afdf8d2812fd6b
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 20 Nov 2021 10:39:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 08:22:00 +01:00

sched/headers: Add header guard to kernel/sched/stats.h and kernel/sched/autogroup.h

Protect against multiple inclusion.

Also include "sched.h" in "stat.h", as it relies on it.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/autogroup.h | 5 +++++
 kernel/sched/stats.h     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/sched/autogroup.h b/kernel/sched/autogroup.h
index 90fcbfd..90d69f2 100644
--- a/kernel/sched/autogroup.h
+++ b/kernel/sched/autogroup.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KERNEL_SCHED_AUTOGROUP_H
+#define _KERNEL_SCHED_AUTOGROUP_H
+
 #ifdef CONFIG_SCHED_AUTOGROUP
 
 struct autogroup {
@@ -59,3 +62,5 @@ static inline int autogroup_path(struct task_group *tg, char *buf, int buflen)
 }
 
 #endif /* CONFIG_SCHED_AUTOGROUP */
+
+#endif /* _KERNEL_SCHED_AUTOGROUP_H */
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 3a3c826..edc0d13 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -1,7 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KERNEL_STATS_H
+#define _KERNEL_STATS_H
 
 #ifdef CONFIG_SCHEDSTATS
 
+#include "sched.h"
+
 extern struct static_key_false sched_schedstats;
 
 /*
@@ -298,3 +302,5 @@ sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct *n
 # define sched_info_dequeue(rq, t)	do { } while (0)
 # define sched_info_switch(rq, t, next)	do { } while (0)
 #endif /* CONFIG_SCHED_INFO */
+
+#endif /* _KERNEL_STATS_H */
