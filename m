Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19125535E19
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350516AbiE0KXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiE0KXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:23:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7118661295;
        Fri, 27 May 2022 03:23:20 -0700 (PDT)
Date:   Fri, 27 May 2022 10:23:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653646999;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQUsMhyGGlP7z06Ym/dPYqkVKG4aOCPSjHxMgq7+g0o=;
        b=SM16mHJbAyoQa/uKXCxKkPHZpUOUiqnIj3y46Db7K13XBffoQYGvl/ZY4ws/3OqltmoGCd
        NKPEgBq6MjktPvTRuJVNhfHYXh9bEltUIB/A618S5W3cHeNW+nlrZBNzBQ3XUZ4B14b/vh
        RlLM0owTnTuuZH5ZUni/5WSGKnab0864RI1wFFGJhILAfIDuR0iudX6/Q99M0wpqeohzO3
        OCEolYy9TSvueclK5QfOGMJsUE2pAm2WMKl2YooPGY+Ax1mazISoWoTGTyuEkWwdGw23+G
        y6gulvdUaEbfs8M0lvCMT2KWzNT7XhHm5whlgSIoAA/WZPHchCXpFEwHf9QOvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653646999;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQUsMhyGGlP7z06Ym/dPYqkVKG4aOCPSjHxMgq7+g0o=;
        b=gjXQ+ESiOfWaBSOqmKdT9EIstDGTIlWHPlRm4o/5igkY1a3WrsrMawwGm0Rm+SlhEjFv3a
        mfRQGpeL2BfFspCQ==
From:   "tip-bot2 for Bo Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Fix all occurences of the "the the" typo
Cc:     Bo Liu <liubo03@inspur.com>, Ingo Molnar <mingo@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220527061400.5694-1-liubo03@inspur.com>
References: <20220527061400.5694-1-liubo03@inspur.com>
MIME-Version: 1.0
Message-ID: <165364699773.4207.16914012230909223764.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f7081834b2d5bbc77d67073d8ab490bfeaf3c13b
Gitweb:        https://git.kernel.org/tip/f7081834b2d5bbc77d67073d8ab490bfeaf3c13b
Author:        Bo Liu <liubo03@inspur.com>
AuthorDate:    Fri, 27 May 2022 02:14:00 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 27 May 2022 12:15:39 +02:00

x86: Fix all occurences of the "the the" typo

Rather than waiting for the bots to fix these one-by-one,
fix all occurences of "the the" throughout arch/x86.

Signed-off-by: Bo Liu <liubo03@inspur.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20220527061400.5694-1-liubo03@inspur.com
---
 arch/x86/kvm/vmx/vmx.c               | 2 +-
 arch/x86/kvm/x86.c                   | 2 +-
 arch/x86/platform/efi/efi_thunk_64.S | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 610355b..2a67350 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6221,7 +6221,7 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
 
 	/*
-	 * This code is only executed when the the flush mode is 'cond' or
+	 * This code is only executed when the flush mode is 'cond' or
 	 * 'always'
 	 */
 	if (static_branch_likely(&vmx_l1d_flush_cond)) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4790f0d..5f11d7b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11855,7 +11855,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	if (current->mm == kvm->mm) {
 		/*
 		 * Free memory regions allocated on behalf of userspace,
-		 * unless the the memory map has changed due to process exit
+		 * unless the memory map has changed due to process exit
 		 * or fd copying.
 		 */
 		mutex_lock(&kvm->slots_lock);
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 854dd81..9ffe2ba 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -8,7 +8,7 @@
  * The below thunking functions are only used after ExitBootServices()
  * has been called. This simplifies things considerably as compared with
  * the early EFI thunking because we can leave all the kernel state
- * intact (GDT, IDT, etc) and simply invoke the the 32-bit EFI runtime
+ * intact (GDT, IDT, etc) and simply invoke the 32-bit EFI runtime
  * services from __KERNEL32_CS. This means we can continue to service
  * interrupts across an EFI mixed mode call.
  *
