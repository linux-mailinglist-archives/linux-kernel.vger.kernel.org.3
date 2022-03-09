Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972654D29FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiCIH4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiCIHzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2103616202C;
        Tue,  8 Mar 2022 23:54:55 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812493;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BxBl4E13hlJ3jb+0pzeJeAg2/338hjXMrMRWFQfQxwk=;
        b=WzEE2qtw3w8S5BFSBx96qfQXs5NYNzKhQB2v2WnZJe3N+mwQjvfCnXU81e4hpph0mo0LhX
        kCRjgjDkJtmNYznbf0otwU5YcVHbVoX3Zv7O6WPW+hBXWBU9pYGTy+8unxIUuPtiMmoSR7
        ebwmmKewru5W0EprdKKhyAo4hi9eQ5vKJOhY1EVY3qMHzgaQNLPxE9hwnioRodDp2Av/nD
        WP+X0KeZt38XrfqwnPXxoZhSQ6nZfTKjx3mpP2fUW3eBBSqKjP/3oZYHwBJh9KiV9f79Gk
        M57WLopnXHYlxqwN04M7Md/RruXztwijyCWLnLbtixJ3kevwTj1eB2chxGyFmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812493;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BxBl4E13hlJ3jb+0pzeJeAg2/338hjXMrMRWFQfQxwk=;
        b=QxyGwvPH+3LTUj70hKVHnrNzCMWOrdWRBZ5RI1w9pweOAVMWzi7ytDvlJbJt8fq/ybJg18
        mzEcG9ySsztQu+Bw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,sev: Annotations
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.995109889@infradead.org>
References: <20220308154318.995109889@infradead.org>
MIME-Version: 1.0
Message-ID: <164681249279.16921.12727429345823782869.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     e58b0dfcd8634a758ec0fc14b200c20c70013635
Gitweb:        https://git.kernel.org/tip/e58b0dfcd8634a758ec0fc14b200c20c70013635
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:35 +01:00

x86/ibt,sev: Annotations

No IBT on AMD so far.. probably correct, who knows.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.995109889@infradead.org
---
 arch/x86/entry/entry_64.S        | 1 +
 arch/x86/entry/entry_64_compat.S | 1 +
 arch/x86/kernel/head_64.S        | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 899bc86..cb5b734 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -95,6 +95,7 @@ SYM_CODE_START(entry_SYSCALL_64)
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER_DS				/* pt_regs->ss */
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 74208a1..4fdb007 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -214,6 +214,7 @@ SYM_CODE_START(entry_SYSCALL_compat)
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 462cc1e..b8e3019 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -332,6 +332,7 @@ SYM_CODE_END(start_cpu0)
  */
 SYM_CODE_START_NOALIGN(vc_boot_ghcb)
 	UNWIND_HINT_IRET_REGS offset=8
+	ENDBR
 
 	/* Build pt_regs */
 	PUSH_AND_CLEAR_REGS
@@ -439,6 +440,7 @@ SYM_CODE_END(early_idt_handler_common)
  */
 SYM_CODE_START_NOALIGN(vc_no_ghcb)
 	UNWIND_HINT_IRET_REGS offset=8
+	ENDBR
 
 	/* Build pt_regs */
 	PUSH_AND_CLEAR_REGS
