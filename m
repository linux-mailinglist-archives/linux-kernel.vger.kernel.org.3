Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47824D1C91
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348778AbiCHP6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348076AbiCHP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA54F9E6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BHmZTqiysMj1QLQhBSo7BFGPn1UiIgnYUvV4LA4FjGE=; b=IlFgmnwQs3DVffHF01got5hlBN
        VBNEOdYP+DqW+jn0OVSJ4XLeReQau0XEr2qsKlEtUPPR6aDo0KfHu881A+KCfcoFRexqT6o6i0tBG
        hELKdcU6ovB/b2K21/+EmasAvLJHTvK89uYI8lXri1CngJs6P4ouZsiEqcsZh94KZhx2qs1Lrz0aS
        1l9Hr0rM+kYmh3nvuHIQNinbxm7FluG9xzWi1OQOZKuOHeNmzep32a34fgoTr2v3OW5OgxBEWtM0x
        X0PyANsgqkWSmyo1nMJajk7ce5A1zZj8+nGBlh8CATKdolKkOSq3UM4JfC6gxBLw9g/wg1gaP/mvX
        Xn7+3z0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAc-00GUif-UB; Tue, 08 Mar 2022 15:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4ACBC302DCE;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 988BB2B5649C1; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154318.995109889@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 31/45] x86/ibt,sev: Annotations
References: <20220308153011.021123062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No IBT on AMD so far.. probably correct, who knows.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S        |    1 +
 arch/x86/entry/entry_64_compat.S |    1 +
 arch/x86/kernel/head_64.S        |    2 ++
 3 files changed, 4 insertions(+)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -95,6 +95,7 @@ SYM_CODE_START(entry_SYSCALL_64)
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER_DS				/* pt_regs->ss */
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -214,6 +214,7 @@ SYM_CODE_START(entry_SYSCALL_compat)
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER32_DS		/* pt_regs->ss */
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


