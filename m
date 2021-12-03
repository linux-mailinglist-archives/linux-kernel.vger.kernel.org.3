Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859ED466E89
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377761AbhLCAk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:40:26 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35505 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349864AbhLCAkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:40:19 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C7345C039D;
        Thu,  2 Dec 2021 19:36:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 19:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=EUCXCeL+MGLva
        lzSbGQmtROqa77WL595Cktf8udoN5k=; b=wTNT0lWPbinRkw/ppcf2Bs1//a0BL
        2bJMXJjltJLaa81peYpBHgkQfYbQx/pDEfK+Xf207wsPyDcUHuv3ii/xWF6sSYae
        tCzMESa9wB6QVzknrwhO5lGiNaFyaLUAFi6oX7VExu1jq4iaTk9MYb+vHelJGrA9
        OuxKMdCfvVuhHWvNy9Gfz8oLtfdXqm7fpeUliPlRURTrv9MoZ9+NDhTqi5sfUGjl
        gml9TT9aaIDq9/gvuPDol9qzLpc0LZeC/Et8Rt5cg6mD3817rOvEpiKfTgvQNMNS
        aiZm5cwb+GzQoottwEHSSUG81ICj6RiyDXYQP5kUhaoDIZiavTj2ZCN0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=EUCXCeL+MGLvalzSbGQmtROqa77WL595Cktf8udoN5k=; b=Q1w5y+kZ
        7GT2f2uzVwbzP0rEAqz2UKHi7FoI71M7/Br9Kn83zrsp5RyMm39Y/RwtJ69V0Hrw
        DmhhRDK8/548cNbFG3w9uZcUqjEd2bVwH+c+yzSuCSxI2h23p5CFjHWkw6DX23gM
        6weP7krtFAi5i6sT15suCJ8y26swdP9vrGXIRYa6dJ1FidSMwSNnbhGpsKHipgY+
        kj6APv5xteO91DyAZasEiuoH9qKbeh7qaYkmWgFgQphGvvWMH8SUI6jijlP3vyCZ
        TsBAONVyZvYz4o7+P04KXYnDpQxrrdQa3ykA/XK7nG8nAzsvy1WKAqwZu8B3dKey
        VITJXn25ElHaUQ==
X-ME-Sender: <xms:qGapYfH6Zin73PsNj18rKUrCgNwK9fF1TxuHSgxF_wbIxousRCJpmg>
    <xme:qGapYcV6b8I8QXPPPvj70lpl7Zae0eBbb5Sguw0SnQWcExlrEhDBNPimUlNIRBWMm
    HMU0bB3DC9bUS9YlPM>
X-ME-Received: <xmr:qGapYRKcwOx2-g0nf97iI-l9bi_HKxIsIGRNQ0wq4UdNirorUyb0DD4z9rUv2wQRDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeeihffgteelkeelffduke
    dtheevudejvdegkeekjeefhffhhfetudetgfdtffeunecuvehluhhsthgvrhfuihiivgep
    vdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:qGapYdELtpu7iKDf0rqTQqgNo1nIecAzXCycSnShPLQBNOc2785acg>
    <xmx:qGapYVWSEDp1hTyshY-P6HyOG2-jb8d1cwVrgsWjgK_7x6AgMmpNKQ>
    <xmx:qGapYYNIybm3QoARz2-cx242t1bHOgv5kWp_9Vh3Xy6XpZ6CYCX2Rw>
    <xmx:qGapYRqt9k0OFp37cbzgb4q63-S3WNIiU4AFwieJIaI2yoHz-45tdQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 19:36:54 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        chang.seok.bae@intel.com, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
Subject: [RFC PATCH 07/10] x86/fpu: Rellocate fpstate on save_fpregs_to_fpstate
Date:   Fri,  3 Dec 2021 00:36:33 +0000
Message-Id: <20211203003636.11417-8-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
References: <20211203003636.11417-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The general idea is to compare XINUSE with xfeatures of fpstate
buffer on every saving. If there are new in use states that not
existing in buffer's xfeatures then just reallocate to enlarge it.

fpstate_realloc is reworked to including calculation of kernel
buffer size and use in interrupt.

Signed-off-by: Jiaxun Yang <j.yang-87@sms.ed.ac.uk>
---
 arch/x86/kernel/fpu/core.c   |  17 ++++
 arch/x86/kernel/fpu/xstate.c | 176 ++++++++++++++++++-----------------
 arch/x86/kernel/fpu/xstate.h |   1 +
 3 files changed, 109 insertions(+), 85 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 88dbbbde7a3a..861cbfc51c17 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -112,6 +112,22 @@ static void update_avx_timestamp(struct fpu *fpu)
 		fpu->avx512_timestamp = jiffies;
 }
 
+/* Update xstate size if it more dynamic features are opted-in. */
+static inline void xstate_update_size(struct fpu *fpu)
+{
+	int err;
+	struct fpstate *fpstate = fpu->fpstate;
+	u64 fpsmask = fpstate->xfeatures;
+	u64 curmask = fpsmask | xfeatures_in_use();
+
+	if (fpu_state_size_dynamic()) {
+		if (fpsmask != curmask) {
+			err = fpstate_realloc(fpu, curmask);
+			WARN_ON_FPU(err);
+		}
+	}
+}
+
 /*
  * Save the FPU register state in fpu->fpstate->regs. The register state is
  * preserved.
@@ -129,6 +145,7 @@ static void update_avx_timestamp(struct fpu *fpu)
 void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
+		xstate_update_size(fpu);
 		os_xsave(fpu->fpstate);
 		update_avx_timestamp(fpu);
 		return;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index df8a70a055a9..8519a6286d0d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,10 +7,12 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/nospec.h>
 #include <linux/pkeys.h>
 #include <linux/seq_file.h>
+#include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
 
@@ -1414,71 +1416,10 @@ static int __init xstate_update_static_branch(void)
 }
 arch_initcall(xstate_update_static_branch)
 
-#ifdef CONFIG_X86_64
-
-#ifdef CONFIG_X86_DEBUG_FPU
-/*
- * Ensure that a subsequent XSAVE* or XRSTOR* instruction with RFBM=@mask
- * can safely operate on the @fpstate buffer.
- */
-static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
-{
-	u64 xfd = __this_cpu_read(xfd_state);
-
-	if (fpstate->xfd == xfd)
-		return true;
-
-	 /*
-	  * The XFD MSR does not match fpstate->xfd. That's invalid when
-	  * the passed in fpstate is current's fpstate.
-	  */
-	if (fpstate->xfd == current->thread.fpu.fpstate->xfd)
-		return false;
-
-	/*
-	 * XRSTOR(S) from init_fpstate are always correct as it will just
-	 * bring all components into init state and not read from the
-	 * buffer. XSAVE(S) raises #PF after init.
-	 */
-	if (fpstate == &init_fpstate)
-		return rstor;
-
-	/*
-	 * XSAVE(S): clone(), fpu_swap_kvm_fpu()
-	 * XRSTORS(S): fpu_swap_kvm_fpu()
-	 */
-
-	/*
-	 * No XSAVE/XRSTOR instructions (except XSAVE itself) touch
-	 * the buffer area for XFD-disabled state components.
-	 */
-	mask &= ~xfd;
-
-	/*
-	 * Remove features which are valid in fpstate. They
-	 * have space allocated in fpstate.
-	 */
-	mask &= ~fpstate->xfeatures;
-
-	/*
-	 * Any remaining state components in 'mask' might be written
-	 * by XSAVE/XRSTOR. Fail validation it found.
-	 */
-	return !mask;
-}
-
-void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor)
-{
-	WARN_ON_ONCE(!xstate_op_valid(fpstate, mask, rstor));
-}
-#endif /* CONFIG_X86_DEBUG_FPU */
-
-
-
 void fpstate_free(struct fpu *fpu)
 {
 	if (fpu->fpstate && fpu->fpstate != &fpu->__fpstate)
-		vfree(fpu->fpstate);
+		kvfree(fpu->fpstate);
 }
 
 /**
@@ -1507,10 +1448,9 @@ static struct fpstate *fpu_install_fpstate(struct fpu *fpu,
 /**
  * fpstate_realloc - Reallocate struct fpstate for the requested new features
  *
- * @xfeatures:	A bitmap of xstate features which extend the enabled features
- *		of that task
- * @ksize:	The required size for the kernel buffer
- * @usize:	The required size for user space buffers
+ * @fpu:	point to the struct fpu to be modified.
+ * @xfeature: A bitmap of xstate features which should be enabled in the new
+ *		buffer.
  *
  * Note vs. vmalloc(): If the task with a vzalloc()-allocated buffer
  * terminates quickly, vfree()-induced IPIs may be a concern, but tasks
@@ -1518,22 +1458,35 @@ static struct fpstate *fpu_install_fpstate(struct fpu *fpu,
  *
  * Returns: 0 on success, -ENOMEM on allocation error.
  */
-static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
-			   unsigned int usize)
+int fpstate_realloc(struct fpu *fpu, u64 xfeatures)
 {
-	struct fpu *fpu = &current->thread.fpu;
 	struct fpstate *curfps, *newfps = NULL;
-	unsigned int fpsize;
+	unsigned int ksize, fpsize;
 
 	curfps = fpu->fpstate;
+	xfeatures |= curfps->xfeatures;
+	ksize = xstate_calculate_size(xfeatures, true);
 	fpsize = ksize + ALIGN(offsetof(struct fpstate, regs), 64);
 
-	newfps = vzalloc(fpsize);
+	/* vzalloc is not allowed in interrupt */
+	if (in_interrupt())
+		newfps = kzalloc(fpsize, GFP_KERNEL | GFP_ATOMIC);
+	else
+		newfps = vzalloc(fpsize);
+
 	if (!newfps)
 		return -ENOMEM;
 	newfps->size = ksize;
-	newfps->user_size = usize;
 	newfps->is_valloc = true;
+	newfps->xfeatures = xfeatures;
+
+	/*
+	 * Just leave user and XFD stuff untouched, they will be modified
+	 * on perm request syscall.
+	 */
+	newfps->user_xfeatures = curfps->user_xfeatures;
+	newfps->user_size = curfps->user_size;
+	newfps->xfd = curfps->xfd;
 
 	fpregs_lock();
 	/*
@@ -1541,12 +1494,6 @@ static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 	 * swapping fpstate as that might invalidate it due to layout
 	 * changes.
 	 */
-	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		fpregs_restore_userregs();
-
-	newfps->xfeatures = curfps->xfeatures | xfeatures;
-	newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
-	newfps->xfd = curfps->xfd & ~xfeatures;
 
 	curfps = fpu_install_fpstate(fpu, newfps);
 
@@ -1556,9 +1503,67 @@ static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 
 	fpregs_unlock();
 
-	vfree(curfps);
+	kvfree(curfps);
 	return 0;
 }
+#ifdef CONFIG_X86_64
+
+#ifdef CONFIG_X86_DEBUG_FPU
+/*
+ * Ensure that a subsequent XSAVE* or XRSTOR* instruction with RFBM=@mask
+ * can safely operate on the @fpstate buffer.
+ */
+static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
+{
+	u64 xfd = __this_cpu_read(xfd_state);
+
+	if (fpstate->xfd == xfd)
+		return true;
+
+	 /*
+	  * The XFD MSR does not match fpstate->xfd. That's invalid when
+	  * the passed in fpstate is current's fpstate.
+	  */
+	if (fpstate->xfd == current->thread.fpu.fpstate->xfd)
+		return false;
+
+	/*
+	 * XRSTOR(S) from init_fpstate are always correct as it will just
+	 * bring all components into init state and not read from the
+	 * buffer. XSAVE(S) raises #PF after init.
+	 */
+	if (fpstate == &init_fpstate)
+		return rstor;
+
+	/*
+	 * XSAVE(S): clone(), fpu_swap_kvm_fpu()
+	 * XRSTORS(S): fpu_swap_kvm_fpu()
+	 */
+
+	/*
+	 * No XSAVE/XRSTOR instructions (except XSAVE itself) touch
+	 * the buffer area for XFD-disabled state components.
+	 */
+	mask &= ~xfd;
+
+	/*
+	 * Remove features which are valid in fpstate. They
+	 * have space allocated in fpstate.
+	 */
+	mask &= ~fpstate->xfeatures;
+
+	/*
+	 * Any remaining state components in 'mask' might be written
+	 * by XSAVE/XRSTOR. Fail validation it found.
+	 */
+	return !mask;
+}
+
+void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor)
+{
+	WARN_ON_ONCE(!xstate_op_valid(fpstate, mask, rstor));
+}
+#endif /* CONFIG_X86_DEBUG_FPU */
 
 static int validate_sigaltstack(unsigned int usize)
 {
@@ -1686,12 +1691,13 @@ int xfd_enable_feature(u64 xfd_err)
 	 */
 	spin_unlock_irq(&current->sighand->siglock);
 
-	/*
-	 * Try to allocate a new fpstate. If that fails there is no way
-	 * out.
-	 */
-	if (fpstate_realloc(xfd_event, ksize, usize))
-		return -EFAULT;
+	/* Update user state size */
+	fpu->fpstate->user_size = usize;
+	/* Enable feature for user */
+	fpu->fpstate->user_xfeatures |= xfd_event;
+	/* Opt-out XFD */
+	fpu->fpstate->xfd &= ~xfd_event;
+
 	return 0;
 }
 #else /* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index f6bebaeea4ad..473af864b5d1 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -40,6 +40,7 @@ extern void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 extern int copy_uabi_from_kernel_to_xstate(struct fpstate *fpstate, const void *kbuf);
 extern int copy_sigframe_from_user_to_xstate(struct fpstate *fpstate, const void __user *ubuf);
 
+extern int fpstate_realloc(struct fpu *fpu, u64 xfeatures);
 
 extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system_xstate(unsigned int legacy_size);
-- 
2.30.2

