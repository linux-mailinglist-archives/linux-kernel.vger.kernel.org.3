Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961714D964B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346053AbiCOIdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345995AbiCOIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944E34C7BD;
        Tue, 15 Mar 2022 01:31:07 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:31:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PAIfHzuLRTya4FtPeZFGwa7r26FL64VKw4IcqyzpqZ8=;
        b=f5zRCkxeIzLqsCRBSJcuttc8dFdhhIw2iTW+OQPH7BzLQd7UH05xj85P1E0S4BBjbjpISB
        LenlNt9VDOVznP50bTywBh9kQfQCsDcSjHqGK4jl/DuQrSeHY30rLRC4UmbM34sSEa3zGM
        SsEiLW5+20gIEuqlIY6lC0xplCfWTKA42cqBxuDbt5BZzhCQex074kKIFP8qCA8wzcKwtF
        8yP47NDj5RzkPn1BKUXmALHtSdGyOe3oOgdirDQhJWfL9zzg5QodUXeNeim2On0gsFWTQA
        20soWe1BdcfVdkZ8JKQQBSWm2FEQjzJJAa2n/JtM7DLUijKg4iol14ryPjt62w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PAIfHzuLRTya4FtPeZFGwa7r26FL64VKw4IcqyzpqZ8=;
        b=iTmzHV54KqmegI9+7xKYI1nr/g5BmLLjqFdLmjwFX7eCVMr2t79HBABkLYwIgzUQFPuktR
        LX3KzkGIMG5nRRDg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Add header guard to kernel/sched/sched.h
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733306511.16921.3387492917730056941.tip-bot2@tip-bot2>
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

Commit-ID:     95458477f5b2dc436e3aa6aa25c0f84bb83e6195
Gitweb:        https://git.kernel.org/tip/95458477f5b2dc436e3aa6aa25c0f84bb83e6195
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 22 Feb 2022 14:50:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 08:21:56 +01:00

sched/headers: Add header guard to kernel/sched/sched.h

Use the canonical header guard naming of the full path to the header.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3da5718..eab4a18 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2,6 +2,9 @@
 /*
  * Scheduler internal types and methods:
  */
+#ifndef _KERNEL_SCHED_SCHED_H
+#define _KERNEL_SCHED_SCHED_H
+
 #include <linux/sched.h>
 
 #include <linux/sched/autogroup.h>
@@ -3137,3 +3140,4 @@ extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
 #endif
 
+#endif /* _KERNEL_SCHED_SCHED_H */
