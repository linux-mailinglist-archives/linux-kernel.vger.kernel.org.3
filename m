Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9A4D9934
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347454AbiCOKqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347310AbiCOKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FD936160;
        Tue, 15 Mar 2022 03:43:56 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVU+lrvapvn0znejHRZAg557m9aZeIjX/fmZ/bSUEbc=;
        b=wP1xitNZYpJBRZYhBhaKo4Ih9XhK4NYHCgxolEMu5bqIpYulh4NaHVQDM9g7B8qkKf0wu2
        trNBaBpZJaJssHxB/pb5FTBvLgIuevnlSYf7d3iLvUj9KCEkDFawhMqFoTQULvL8XmC42i
        A9Fpsm2Z9BjMFbQ/e24/16R5bhHornjli/QgSPO6gJ7Gi5oFsLlowfrzSv/A0g9mbIY4dw
        0NtBNUbT3N7f+Y7MyL9IoKIlLXIZOTRB24WpH2DjUgw45hoMebWVN3d4CHSTxHUPzgdWoL
        EmePVfmQ3RIyIKgzpk7FN9s7zypFADiMXRIzX9k3S0/k2aft63H0BJmfML8okw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVU+lrvapvn0znejHRZAg557m9aZeIjX/fmZ/bSUEbc=;
        b=7ryQvtryx0Feqv/EEtyC0ZMee7t0cosuOKh3/ymiPIMUmLAwgLDHwLqpOAwGNhVuO+loNG
        aZe1nmRXP6z/yqDg==
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
Message-ID: <164734103356.16921.7240074614046517982.tip-bot2@tip-bot2>
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

Commit-ID:     e8d61bdf0fdfaeaf35fb5a63d6e67e60038b88e0
Gitweb:        https://git.kernel.org/tip/e8d61bdf0fdfaeaf35fb5a63d6e67e60038b88e0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:41 +01:00

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
index d76f14f..6e53991 100644
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
