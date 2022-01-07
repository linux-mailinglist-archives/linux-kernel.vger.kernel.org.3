Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5026E487F9F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiAGXwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:52:33 -0500
Received: from ip59.38.31.103.in-addr.arpa.unknwn.cloudhost.asia ([103.31.38.59]:44740
        "EHLO gnuweeb.org" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231812AbiAGXw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:52:27 -0500
Received: from integral2.. (unknown [36.68.70.227])
        by gnuweeb.org (Postfix) with ESMTPSA id 8A478C17CA;
        Fri,  7 Jan 2022 23:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuweeb.org;
        s=default; t=1641599544;
        bh=NWy+Wlzi8SPi1Do3lakRbwYr/LHTBJck7Fu+hasZIqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPNB6A1ZFG3sr0EuPpXiS2lu/8yTJlFZKz9MjVYjhI5+PyvS58j3ICsQMFuE70DY+
         xPoWLk4EhhU6Xw3q66AHozIcFWPKlMD6SKhsnnj/gHvEK3TuTeE9q2xzpQk7yt+8Xm
         Bwzo7QUvY8Wy8+4TeVZEZM/A5eYG36D6WH3+ynPJtwCieYVdtKASpslABkCO+V604p
         XMRSDaRNOueVz+qcpgRDVWEG4TICwJ5hktVnNlME0YfuGwwBwj1hWn5uhSJOpIZbIo
         2SimraBJQ0i7PuCGsjaLUtOEKC8gY0MzZw+juqy6oaF+Yk9ba4dskp95uLN4hMXYxo
         tNCmho3cyKxkQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>
Subject: [PATCH v1 1/3] x86/entry/64: Clean up spaces after the instruction
Date:   Sat,  8 Jan 2022 06:52:08 +0700
Message-Id: <20220107235210.1339168-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220107235210.1339168-1-ammarfaizi2@gnuweeb.org>
References: <20220107235210.1339168-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of lines here use a tab as a separator between the instruction
and its operand(s). But there are several parts that use spaces.

Replace these spaces with a tab for consistency.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86-ml <x86@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Cc: GNU/Weeb Mailing List <gwml@gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 arch/x86/entry/entry_64.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 97b1f84bb53f..e432dd075291 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -305,13 +305,13 @@ SYM_CODE_END(ret_from_fork)
 
 .macro DEBUG_ENTRY_ASSERT_IRQS_OFF
 #ifdef CONFIG_DEBUG_ENTRY
-	pushq %rax
+	pushq	%rax
 	SAVE_FLAGS
-	testl $X86_EFLAGS_IF, %eax
-	jz .Lokay_\@
+	testl	$X86_EFLAGS_IF, %eax
+	jz	.Lokay_\@
 	ud2
 .Lokay_\@:
-	popq %rax
+	popq	%rax
 #endif
 .endm
 
@@ -749,8 +749,8 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
 	swapgs					/* switch back to user gs */
 .macro ZAP_GS
 	/* This can't be a string because the preprocessor needs to see it. */
-	movl $__USER_DS, %eax
-	movl %eax, %gs
+	movl	$__USER_DS, %eax
+	movl	%eax, %gs
 .endm
 	ALTERNATIVE "", "ZAP_GS", X86_BUG_NULL_SEG
 	xorl	%eax, %eax
@@ -1135,7 +1135,7 @@ SYM_CODE_START(asm_exc_nmi)
 	pushq	2*8(%rdx)	/* pt_regs->cs */
 	pushq	1*8(%rdx)	/* pt_regs->rip */
 	UNWIND_HINT_IRET_REGS
-	pushq   $-1		/* pt_regs->orig_ax */
+	pushq	$-1		/* pt_regs->orig_ax */
 	PUSH_AND_CLEAR_REGS rdx=(%rdx)
 	ENCODE_FRAME_POINTER
 
-- 
2.32.0

