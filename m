Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2624D994D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347460AbiCOKqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347333AbiCOKpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF02437020;
        Tue, 15 Mar 2022 03:44:01 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BArpg0luzrNqYekEmkMHjjGR+Qr0GLlZhXr+w9OnlbQ=;
        b=F6vu84bqIYR45E2G6iXuv4GSK2rTlrRf6qRa5jWOI/Fz0S0KcmXoyo++liXTsDIA7YeZe0
        T9wSqTL3VDBe6bNxSX+XzFo9DtihYisGuMJfWoWQbsg7cVgMznoBJ5ajVgNW8FgmQg/JCS
        WWx0cue8FwlfU29f5ptQfkGeAPZAe0eAHHzPC++Ce5GYNQ1iUVvhHavrujiiVYlfi3GCC1
        4aYEBktM1jOS6YwKvkk62ERWanpF4FSYdzXBZDvT6j6SXFUPHC9p7i2VrGSArJ70SWirSe
        Ycf0vcuRI0QcuSTFUD8k3CduxV73ZVSEXyLPPnvH7QWeP9DqNS6EMWZqThiR1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BArpg0luzrNqYekEmkMHjjGR+Qr0GLlZhXr+w9OnlbQ=;
        b=lZnW2SOsjjbGoLM3vIXid8uFP4DZdRNgI8oH/NVjoR51CaFLKmgZMnzlKTIwAoAjsX233c
        eNWavtRDHVfBbFDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,ftrace: Add ENDBR to samples/ftrace
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.523421433@infradead.org>
References: <20220308154318.523421433@infradead.org>
MIME-Version: 1.0
Message-ID: <164734103928.16921.15454561124281816294.tip-bot2@tip-bot2>
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

Commit-ID:     0aec21cfb51bc1856206f312d8c13bf1f368d78e
Gitweb:        https://git.kernel.org/tip/0aec21cfb51bc1856206f312d8c13bf1f368d78e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:38 +01:00

x86/ibt,ftrace: Add ENDBR to samples/ftrace

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.523421433@infradead.org
---
 samples/ftrace/ftrace-direct-modify.c       |  5 +++++
 samples/ftrace/ftrace-direct-multi-modify.c | 10 +++++++---
 samples/ftrace/ftrace-direct-multi.c        |  5 ++++-
 samples/ftrace/ftrace-direct-too.c          |  3 +++
 samples/ftrace/ftrace-direct.c              |  3 +++
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index 2c7c318..39146fa 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -24,20 +24,25 @@ static unsigned long my_ip = (unsigned long)schedule;
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	call my_direct_func1\n"
 "	leave\n"
 "	.size		my_tramp1, .-my_tramp1\n"
 	ASM_RET
+
 "	.type		my_tramp2, @function\n"
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	call my_direct_func2\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 6f43a39..65aa94d 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -22,11 +22,14 @@ extern void my_tramp2(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
 "   my_tramp1:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
@@ -34,12 +37,13 @@ asm (
 "	call my_direct_func1\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp1, .-my_tramp1\n"
+
 "	.type		my_tramp2, @function\n"
-"\n"
 "	.globl		my_tramp2\n"
 "   my_tramp2:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
@@ -47,7 +51,7 @@ asm (
 "	call my_direct_func2\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp2, .-my_tramp2\n"
 "	.popsection\n"
 );
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 2fafc9a..41ded7c 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -17,11 +17,14 @@ extern void my_tramp(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
@@ -29,7 +32,7 @@ asm (
 "	call my_direct_func\n"
 "	popq %rdi\n"
 "	leave\n"
-"	ret\n"
+	ASM_RET
 "	.size		my_tramp, .-my_tramp\n"
 "	.popsection\n"
 );
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index c93fb0e..6690468 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -19,11 +19,14 @@ extern void my_tramp(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 8b551e5..e8f1e44 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -16,11 +16,14 @@ extern void my_tramp(void *);
 
 #ifdef CONFIG_X86_64
 
+#include <asm/ibt.h>
+
 asm (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
 "   my_tramp:"
+	ASM_ENDBR
 "	pushq %rbp\n"
 "	movq %rsp, %rbp\n"
 "	pushq %rdi\n"
