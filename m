Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95CC53DB08
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351021AbiFEJbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350951AbiFEJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:31:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B938B4D9C6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:31:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654421460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bLMt0Z3mozn69YUyEEwHHpPCZnBs1iTJtrnfvk1DGXw=;
        b=WofOs0/R61RLeGSC4/qMbH+30ejgaiNZ463EzuiaPX6ihvoI0Pcp+LZje78ykrzUlo8+dk
        qOlxZ8JnywrSq32zR23tURlmMGFCuaQUs2K7J1t5JXitqksM94A08GYe+IG2b/J2I6Md5L
        z/v79O3TP5zR8bsa//RS4Z3Cc/9gH/953yVBmt6wF93hbjOkXd5dtwr7u1mpxzUCm1FR81
        KFcX6TCAw7hAhX0RJD0J3qIC0DwT/7o3nRiGl1KlIypfGbONbr+Ypf+ghCxfbtDfh3HW2D
        BPdmo6/4D+ur36JSyuKVFvlLtaEzOcITPSZLAe8rYiR/oLXWlz6sGW5R6PTsxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654421460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bLMt0Z3mozn69YUyEEwHHpPCZnBs1iTJtrnfvk1DGXw=;
        b=THi5GXtrfNVjFiU+eX+0KDuKm5PpjNicPBbuRpxhwPV+c0ZXTPnabQ95Kt9VBLvAdlhKBE
        ucEcPsAsmMPQ9RDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/cleanups for v5.19-rc1
References: <165442136963.152751.14259048792272164569.tglx@xen13>
Message-ID: <165442137838.152751.6839806816555222572.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Jun 2022 11:30:59 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/cleanups branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-202=
2-06-05

up to:  f7081834b2d5: x86: Fix all occurences of the "the the" typo


A set of small x86 cleanups:

  - Remove unused headers in the IDT code
 =20
  - Kconfig indendation and comment fixes

  - Fix all 'the the' typos in one go instead of waiting for bots to fix
    one at a time.

Thanks,

	tglx

------------------>
Bo Liu (1):
      x86: Fix all occurences of the "the the" typo

Juerg Haefliger (2):
      x86/Kconfig: Fix indentation and add endif comments to arch/x86/Kconfig
      x86/Kconfig: Fix indentation of arch/x86/Kconfig.debug

sunliming (1):
      x86/idt: Remove unused headers


 arch/x86/Kconfig                     | 101 +++++++++++++++++----------------=
--
 arch/x86/Kconfig.debug               |  29 +++++-----
 arch/x86/kernel/tracepoint.c         |   3 --
 arch/x86/kvm/vmx/vmx.c               |   2 +-
 arch/x86/kvm/x86.c                   |   2 +-
 arch/x86/platform/efi/efi_thunk_64.S |   2 +-
 6 files changed, 66 insertions(+), 73 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 762a0b6ab8b6..4d610ae216ce 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -41,11 +41,11 @@ config FORCE_DYNAMIC_FTRACE
 	depends on FUNCTION_TRACER
 	select DYNAMIC_FTRACE
 	help
-	 We keep the static function tracing (!DYNAMIC_FTRACE) around
-	 in order to test the non static function tracing in the
-	 generic code, as other architectures still use it. But we
-	 only need to keep it around for x86_64. No need to keep it
-	 for x86_32. For x86_32, force DYNAMIC_FTRACE.=20
+	  We keep the static function tracing (!DYNAMIC_FTRACE) around
+	  in order to test the non static function tracing in the
+	  generic code, as other architectures still use it. But we
+	  only need to keep it around for x86_64. No need to keep it
+	  for x86_32. For x86_32, force DYNAMIC_FTRACE.
 #
 # Arch settings
 #
@@ -392,9 +392,9 @@ config CC_HAS_SANE_STACKPROTECTOR
 	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC=
)) if 64BIT
 	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC=
))
 	help
-	   We have to make sure stack protector is unconditionally disabled if
-	   the compiler produces broken code or if it does not let us control
-	   the segment on 32-bit kernels.
+	  We have to make sure stack protector is unconditionally disabled if
+	  the compiler produces broken code or if it does not let us control
+	  the segment on 32-bit kernels.
=20
 menu "Processor type and features"
=20
@@ -530,7 +530,7 @@ config X86_EXTENDED_PLATFORM
=20
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
-endif
+endif # X86_32
=20
 if X86_64
 config X86_EXTENDED_PLATFORM
@@ -549,7 +549,7 @@ config X86_EXTENDED_PLATFORM
=20
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
-endif
+endif # X86_64
 # This is an alphabetically sorted list of 64 bit extended platforms
 # Please maintain the alphabetic order if and when there are additions
 config X86_NUMACHIP
@@ -597,9 +597,9 @@ config X86_GOLDFISH
 	bool "Goldfish (Virtual Platform)"
 	depends on X86_EXTENDED_PLATFORM
 	help
-	 Enable support for the Goldfish virtual platform used primarily
-	 for Android development. Unless you are building for the Android
-	 Goldfish emulator say N here.
+	  Enable support for the Goldfish virtual platform used primarily
+	  for Android development. Unless you are building for the Android
+	  Goldfish emulator say N here.
=20
 config X86_INTEL_CE
 	bool "CE4100 TV platform"
@@ -898,7 +898,7 @@ config INTEL_TDX_GUEST
 	  memory contents and CPU state. TDX guests are protected from
 	  some attacks from the VMM.
=20
-endif #HYPERVISOR_GUEST
+endif # HYPERVISOR_GUEST
=20
 source "arch/x86/Kconfig.cpu"
=20
@@ -1159,16 +1159,16 @@ config X86_MCE_INTEL
 	prompt "Intel MCE features"
 	depends on X86_MCE && X86_LOCAL_APIC
 	help
-	   Additional support for intel specific MCE features such as
-	   the thermal monitor.
+	  Additional support for intel specific MCE features such as
+	  the thermal monitor.
=20
 config X86_MCE_AMD
 	def_bool y
 	prompt "AMD MCE features"
 	depends on X86_MCE && X86_LOCAL_APIC && AMD_NB
 	help
-	   Additional support for AMD specific MCE features such as
-	   the DRAM Error Threshold.
+	  Additional support for AMD specific MCE features such as
+	  the DRAM Error Threshold.
=20
 config X86_ANCIENT_MCE
 	bool "Support for old Pentium 5 / WinChip machine checks"
@@ -1246,18 +1246,18 @@ config X86_VSYSCALL_EMULATION
 	default y
 	depends on X86_64
 	help
-	 This enables emulation of the legacy vsyscall page.  Disabling
-	 it is roughly equivalent to booting with vsyscall=3Dnone, except
-	 that it will also disable the helpful warning if a program
-	 tries to use a vsyscall.  With this option set to N, offending
-	 programs will just segfault, citing addresses of the form
-	 0xffffffffff600?00.
+	  This enables emulation of the legacy vsyscall page.  Disabling
+	  it is roughly equivalent to booting with vsyscall=3Dnone, except
+	  that it will also disable the helpful warning if a program
+	  tries to use a vsyscall.  With this option set to N, offending
+	  programs will just segfault, citing addresses of the form
+	  0xffffffffff600?00.
=20
-	 This option is required by many programs built before 2013, and
-	 care should be used even with newer programs if set to N.
+	  This option is required by many programs built before 2013, and
+	  care should be used even with newer programs if set to N.
=20
-	 Disabling this option saves about 7K of kernel size and
-	 possibly 4K of additional runtime pagetable memory.
+	  Disabling this option saves about 7K of kernel size and
+	  possibly 4K of additional runtime pagetable memory.
=20
 config X86_IOPL_IOPERM
 	bool "IOPERM and IOPL Emulation"
@@ -1994,15 +1994,15 @@ config EFI_MIXED
 	bool "EFI mixed-mode support"
 	depends on EFI_STUB && X86_64
 	help
-	   Enabling this feature allows a 64-bit kernel to be booted
-	   on a 32-bit firmware, provided that your CPU supports 64-bit
-	   mode.
+	  Enabling this feature allows a 64-bit kernel to be booted
+	  on a 32-bit firmware, provided that your CPU supports 64-bit
+	  mode.
=20
-	   Note that it is not possible to boot a mixed-mode enabled
-	   kernel via the EFI boot stub - a bootloader that supports
-	   the EFI handover protocol must be used.
+	  Note that it is not possible to boot a mixed-mode enabled
+	  kernel via the EFI boot stub - a bootloader that supports
+	  the EFI handover protocol must be used.
=20
-	   If unsure, say N.
+	  If unsure, say N.
=20
 source "kernel/Kconfig.hz"
=20
@@ -2227,16 +2227,16 @@ config RANDOMIZE_MEMORY
 	select DYNAMIC_MEMORY_LAYOUT
 	default RANDOMIZE_BASE
 	help
-	   Randomizes the base virtual address of kernel memory sections
-	   (physical memory mapping, vmalloc & vmemmap). This security feature
-	   makes exploits relying on predictable memory locations less reliable.
+	  Randomizes the base virtual address of kernel memory sections
+	  (physical memory mapping, vmalloc & vmemmap). This security feature
+	  makes exploits relying on predictable memory locations less reliable.
=20
-	   The order of allocations remains unchanged. Entropy is generated in
-	   the same way as RANDOMIZE_BASE. Current implementation in the optimal
-	   configuration have in average 30,000 different possible virtual
-	   addresses for each memory section.
+	  The order of allocations remains unchanged. Entropy is generated in
+	  the same way as RANDOMIZE_BASE. Current implementation in the optimal
+	  configuration have in average 30,000 different possible virtual
+	  addresses for each memory section.
=20
-	   If unsure, say Y.
+	  If unsure, say Y.
=20
 config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 	hex "Physical memory mapping padding" if EXPERT
@@ -2246,12 +2246,12 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 	range 0x1 0x40 if MEMORY_HOTPLUG
 	range 0x0 0x40
 	help
-	   Define the padding in terabytes added to the existing physical
-	   memory size during kernel memory randomization. It is useful
-	   for memory hotplug support but reduces the entropy available for
-	   address randomization.
+	  Define the padding in terabytes added to the existing physical
+	  memory size during kernel memory randomization. It is useful
+	  for memory hotplug support but reduces the entropy available for
+	  address randomization.
=20
-	   If unsure, leave at the default value.
+	  If unsure, leave at the default value.
=20
 config HOTPLUG_CPU
 	def_bool y
@@ -2598,7 +2598,6 @@ source "drivers/idle/Kconfig"
=20
 endmenu
=20
-
 menu "Bus options (PCI etc.)"
=20
 choice
@@ -2822,7 +2821,6 @@ config AMD_NB
=20
 endmenu
=20
-
 menu "Binary Emulations"
=20
 config IA32_EMULATION
@@ -2867,11 +2865,10 @@ config COMPAT_FOR_U64_ALIGNMENT
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on SYSVIPC
-endif
+endif # COMPAT
=20
 endmenu
=20
-
 config HAVE_ATOMIC_IOMAP
 	def_bool y
 	depends on X86_32
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d872a7522e55..340399f69954 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -73,20 +73,19 @@ config DEBUG_TLBFLUSH
 	bool "Set upper limit of TLB entries to flush one-by-one"
 	depends on DEBUG_KERNEL
 	help
+	  X86-only for now.
=20
-	X86-only for now.
+	  This option allows the user to tune the amount of TLB entries the
+	  kernel flushes one-by-one instead of doing a full TLB flush. In
+	  certain situations, the former is cheaper. This is controlled by the
+	  tlb_flushall_shift knob under /sys/kernel/debug/x86. If you set it
+	  to -1, the code flushes the whole TLB unconditionally. Otherwise,
+	  for positive values of it, the kernel will use single TLB entry
+	  invalidating instructions according to the following formula:
=20
-	This option allows the user to tune the amount of TLB entries the
-	kernel flushes one-by-one instead of doing a full TLB flush. In
-	certain situations, the former is cheaper. This is controlled by the
-	tlb_flushall_shift knob under /sys/kernel/debug/x86. If you set it
-	to -1, the code flushes the whole TLB unconditionally. Otherwise,
-	for positive values of it, the kernel will use single TLB entry
-	invalidating instructions according to the following formula:
+	  flush_entries <=3D active_tlb_entries / 2^tlb_flushall_shift
=20
-	flush_entries <=3D active_tlb_entries / 2^tlb_flushall_shift
-
-	If in doubt, say "N".
+	  If in doubt, say "N".
=20
 config IOMMU_DEBUG
 	bool "Enable IOMMU debugging"
@@ -119,10 +118,10 @@ config X86_DECODER_SELFTEST
 	depends on DEBUG_KERNEL && INSTRUCTION_DECODER
 	depends on !COMPILE_TEST
 	help
-	 Perform x86 instruction decoder selftests at build time.
-	 This option is useful for checking the sanity of x86 instruction
-	 decoder code.
-	 If unsure, say "N".
+	  Perform x86 instruction decoder selftests at build time.
+	  This option is useful for checking the sanity of x86 instruction
+	  decoder code.
+	  If unsure, say "N".
=20
 choice
 	prompt "IO delay type"
diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index fcfc077afe2d..f39aad69fb64 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -8,10 +8,7 @@
 #include <linux/jump_label.h>
 #include <linux/atomic.h>
=20
-#include <asm/hw_irq.h>
-#include <asm/desc.h>
 #include <asm/trace/exceptions.h>
-#include <asm/trace/irq_vectors.h>
=20
 DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
=20
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 610355b9ccce..2a67350d93d2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6221,7 +6221,7 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 	int size =3D PAGE_SIZE << L1D_CACHE_ORDER;
=20
 	/*
-	 * This code is only executed when the the flush mode is 'cond' or
+	 * This code is only executed when the flush mode is 'cond' or
 	 * 'always'
 	 */
 	if (static_branch_likely(&vmx_l1d_flush_cond)) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4790f0d7d40b..5f11d7bc6ef4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11855,7 +11855,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	if (current->mm =3D=3D kvm->mm) {
 		/*
 		 * Free memory regions allocated on behalf of userspace,
-		 * unless the the memory map has changed due to process exit
+		 * unless the memory map has changed due to process exit
 		 * or fd copying.
 		 */
 		mutex_lock(&kvm->slots_lock);
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi=
_thunk_64.S
index 854dd81804b7..9ffe2bad27d5 100644
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

