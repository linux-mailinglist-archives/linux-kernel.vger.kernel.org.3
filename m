Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06174B7854
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbiBOSc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:32:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243115AbiBOScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:32:21 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756391FA43
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:32:11 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JyqSF21Byz9sSB;
        Tue, 15 Feb 2022 19:31:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7bxRVn6K1kRp; Tue, 15 Feb 2022 19:31:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JyqSB1X5xz9sSC;
        Tue, 15 Feb 2022 19:31:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 185FA8B77E;
        Tue, 15 Feb 2022 19:31:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SWjpc880R7eV; Tue, 15 Feb 2022 19:31:53 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA43C8B778;
        Tue, 15 Feb 2022 19:31:53 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21FIVi88146781
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 19:31:44 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21FIViKF146780;
        Tue, 15 Feb 2022 19:31:44 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH v1 4/4] powerpc/ftrace: Style cleanup in ftrace_mprofile.S
Date:   Tue, 15 Feb 2022 19:31:25 +0100
Message-Id: <973506292d0c7b05c06530c8e11803ce38e5eda2.1644949750.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ff535e86d3a69376a6d89168511d4e403835f18b.1644949750.git.christophe.leroy@csgroup.eu>
References: <ff535e86d3a69376a6d89168511d4e403835f18b.1644949750.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644949837; l=2299; s=20211009; h=from:subject:message-id; bh=4PYJ3eQ4qDx2xs4GBPOySTEAxOgCS4edutAoCKQ514U=; b=xTTeJJAH255uBnTnyUVTUY/1567dAiLSJZBXCiLIznuOcpy9DyAXA1tN+quSyQtTYHhAm0Y1uBmt ysBbwYi+DAMe8n9m4xUDHPM/UjrrtJmb3hGjn9eQuIr0ciewZ1f/
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some line breaks to better match the file's style, add
some space after comma and fix a couple of misplaced blanks.

Suggested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/trace/ftrace_mprofile.S | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_mprofile.S b/arch/powerpc/kernel/trace/ftrace_mprofile.S
index eb077270ec2f..89639e64acd1 100644
--- a/arch/powerpc/kernel/trace/ftrace_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_mprofile.S
@@ -87,8 +87,9 @@ _GLOBAL(ftrace_regs_caller)
 #endif
 
 #ifdef CONFIG_LIVEPATCH_64
-	mr	r14,r7		/* remember old NIP */
+	mr	r14, r7		/* remember old NIP */
 #endif
+
 	/* Calculate ip from nip-4 into r3 for call below */
 	subi    r3, r7, MCOUNT_INSN_SIZE
 
@@ -102,7 +103,7 @@ _GLOBAL(ftrace_regs_caller)
 	PPC_STL	r11, _CCR(r1)
 
 	/* Load &pt_regs in r6 for call below */
-	addi    r6, r1 ,STACK_FRAME_OVERHEAD
+	addi    r6, r1, STACK_FRAME_OVERHEAD
 
 	/* ftrace_call(r3, r4, r5, r6) */
 .globl ftrace_regs_call
@@ -113,6 +114,7 @@ ftrace_regs_call:
 	/* Load ctr with the possibly modified NIP */
 	PPC_LL	r3, _NIP(r1)
 	mtctr	r3
+
 #ifdef CONFIG_LIVEPATCH_64
 	cmpd	r14, r3		/* has NIP been altered? */
 #endif
@@ -196,7 +198,7 @@ _GLOBAL(ftrace_caller)
 
 #ifdef CONFIG_LIVEPATCH_64
 	SAVE_GPR(14, r1)
-	mr	r14,r7		/* remember old NIP */
+	mr	r14, r7		/* remember old NIP */
 #endif
 	/* Calculate ip from nip-4 into r3 for call below */
 	subi    r3, r7, MCOUNT_INSN_SIZE
@@ -210,7 +212,7 @@ _GLOBAL(ftrace_caller)
 	PPC_STL	r8, _MSR(r1)
 
 	/* Load &pt_regs in r6 for call below */
-	addi    r6, r1 ,STACK_FRAME_OVERHEAD
+	addi    r6, r1, STACK_FRAME_OVERHEAD
 
 	/* ftrace_call(r3, r4, r5, r6) */
 .globl ftrace_call
@@ -220,6 +222,7 @@ ftrace_call:
 
 	PPC_LL	r3, _NIP(r1)
 	mtctr	r3
+
 #ifdef CONFIG_LIVEPATCH_64
 	cmpd	r14, r3		/* has NIP been altered? */
 	REST_GPR(14, r1)
@@ -244,6 +247,7 @@ ftrace_call:
         /* Based on the cmpd above, if the NIP was altered handle livepatch */
 	bne-	livepatch_handler
 #endif
+
 	bctr			/* jump after _mcount site */
 
 #ifdef CONFIG_LIVEPATCH_64
-- 
2.34.1

