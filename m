Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B54A8691
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351583AbiBCOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:34:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53536 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351352AbiBCOdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:46 -0500
Date:   Thu, 03 Feb 2022 14:33:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jo1jLGLeRCAT+1O+cVU+7LtkQe06iJA2Kf8/JYgMi+4=;
        b=v2ZWOND8cCHb8mGSSIeHCo/TRno3AXLfflpAcuVPlV5Z6geL6yju55dssIiIYwTRNYlU8s
        dv/lRsbNQphBBR04EUVtQ+iezu4HbQeIagk8fgS13ndB99JjwuhHWsrNHUFpx2FqbjwQie
        n/qn/DO8CoHb4clv4Ad8DofZOJ9GADDI0x1fQatbgzLC5nJdXfAhVADZZT6mhkZY5IA3CU
        KuOHE12DLregOc4IBfw6fZAQPsCDWVBMw2XbYp3a6RZOrmQ4EVXKCMbOWQQn+yd0YrkbYz
        B2mOLv1rw+CmP4dzizcC7eCvKzBW+oi8m55SKvugDt0PB1lw8bu/liFeXlV4dQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898825;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jo1jLGLeRCAT+1O+cVU+7LtkQe06iJA2Kf8/JYgMi+4=;
        b=GKPssxlJ+YKM2mKugddSz4D/vYLMDKgNvaw3NoupnFvU2rp8yuOf0bYCUtyLoNWzLHYH/q
        uBEBXxt9ifpOSUDg==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Fix warnings about #if checks of
 undefined tokens
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-12-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-12-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389882476.16921.9784500566910984223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d7ed99ade3e62b755584eea07b4e499e79240527
Gitweb:        https://git.kernel.org/tip/d7ed99ade3e62b755584eea07b4e499e79240527
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:49 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:36 +01:00

selftests/rseq: Fix warnings about #if checks of undefined tokens

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-12-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/param_test.c | 2 +-
 tools/testing/selftests/rseq/rseq-x86.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 335c290..da23c22 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -161,7 +161,7 @@ unsigned int yield_mod_cnt, nr_abort;
 	"	cbnz	" INJECT_ASM_REG ", 222b\n"			\
 	"333:\n"
 
-#elif __PPC__
+#elif defined(__PPC__)
 
 #define RSEQ_INJECT_INPUT \
 	, [loop_cnt_1]"m"(loop_cnt[1]) \
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index 0ee6c04..e444563 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -600,7 +600,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 #endif /* !RSEQ_SKIP_FASTPATH */
 
-#elif __i386__
+#elif defined(__i386__)
 
 #define rseq_smp_mb()	\
 	__asm__ __volatile__ ("lock; addl $0,-128(%%esp)" ::: "memory", "cc")
