Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B6C533E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244493AbiEYNna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiEYNn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:43:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987476D3B4;
        Wed, 25 May 2022 06:43:24 -0700 (PDT)
Date:   Wed, 25 May 2022 13:43:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653486202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KO7GIteGbsZ0Cl7wHs8oAZxalnBb2CUpv6+0HO13LOE=;
        b=EYkkT8MQoUsyg/NrWF0Loktdte/wjHiNevbFlUchdhQuTC5AiKyacGOZ9nPt8JGG/ewePm
        BiDmnBNRCsfjwaCBahCJv/j4/PNMu5N56TjMkJBYTf0juH9GxuUDVhRsw2/H3qJTt+4ooZ
        UcSitccdPbzbp5E4LxXk8faydleDVegrFCtyfDHe/8iQjjT+cKGS9KRBJZ9zoJ088bmPzl
        9lzuSfk4G8bWDiCGcEvCTtZQsdWkEARECcfGoajP1NqyR8jUR5jeO3t9DTiTqUisW+81OP
        vnciVXIzI5Su9A8TU6mrcJuFfvt09IC1Vmdv5L+M/Jnh+CJnNBIVkQY8c0W+aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653486202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KO7GIteGbsZ0Cl7wHs8oAZxalnBb2CUpv6+0HO13LOE=;
        b=1y4LpAARi4Jb+3YPYyJssFtZxfSNij7018rxj05ds8+tpavTHl/0PvIOatLhoQB8U50m18
        eHIOoeYNsQvKidCQ==
From:   "tip-bot2 for Juerg Haefliger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/Kconfig: Fix indentation and add endif
 comments to arch/x86/Kconfig
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220525133203.52463-2-juerg.haefliger@canonical.com>
References: <20220525133203.52463-2-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Message-ID: <165348620137.4207.5059731990365095043.tip-bot2@tip-bot2>
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

Commit-ID:     758cd94a0e16ddbc5607428f28170897f67c2964
Gitweb:        https://git.kernel.org/tip/758cd94a0e16ddbc5607428f28170897f67c2964
Author:        Juerg Haefliger <juerg.haefliger@canonical.com>
AuthorDate:    Wed, 25 May 2022 15:32:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 May 2022 15:39:08 +02:00

x86/Kconfig: Fix indentation and add endif comments to arch/x86/Kconfig

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, add missing trailing endif comments and squeeze multiple
empty lines.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220525133203.52463-2-juerg.haefliger@canonical.com
---
 arch/x86/Kconfig | 101 ++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 52 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 762a0b6..4d610ae 100644
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
-	 for x86_32. For x86_32, force DYNAMIC_FTRACE. 
+	  We keep the static function tracing (!DYNAMIC_FTRACE) around
+	  in order to test the non static function tracing in the
+	  generic code, as other architectures still use it. But we
+	  only need to keep it around for x86_64. No need to keep it
+	  for x86_32. For x86_32, force DYNAMIC_FTRACE.
 #
 # Arch settings
 #
@@ -392,9 +392,9 @@ config CC_HAS_SANE_STACKPROTECTOR
 	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
 	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
 	help
-	   We have to make sure stack protector is unconditionally disabled if
-	   the compiler produces broken code or if it does not let us control
-	   the segment on 32-bit kernels.
+	  We have to make sure stack protector is unconditionally disabled if
+	  the compiler produces broken code or if it does not let us control
+	  the segment on 32-bit kernels.
 
 menu "Processor type and features"
 
@@ -530,7 +530,7 @@ config X86_EXTENDED_PLATFORM
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
-endif
+endif # X86_32
 
 if X86_64
 config X86_EXTENDED_PLATFORM
@@ -549,7 +549,7 @@ config X86_EXTENDED_PLATFORM
 
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
 
 config X86_INTEL_CE
 	bool "CE4100 TV platform"
@@ -898,7 +898,7 @@ config INTEL_TDX_GUEST
 	  memory contents and CPU state. TDX guests are protected from
 	  some attacks from the VMM.
 
-endif #HYPERVISOR_GUEST
+endif # HYPERVISOR_GUEST
 
 source "arch/x86/Kconfig.cpu"
 
@@ -1159,16 +1159,16 @@ config X86_MCE_INTEL
 	prompt "Intel MCE features"
 	depends on X86_MCE && X86_LOCAL_APIC
 	help
-	   Additional support for intel specific MCE features such as
-	   the thermal monitor.
+	  Additional support for intel specific MCE features such as
+	  the thermal monitor.
 
 config X86_MCE_AMD
 	def_bool y
 	prompt "AMD MCE features"
 	depends on X86_MCE && X86_LOCAL_APIC && AMD_NB
 	help
-	   Additional support for AMD specific MCE features such as
-	   the DRAM Error Threshold.
+	  Additional support for AMD specific MCE features such as
+	  the DRAM Error Threshold.
 
 config X86_ANCIENT_MCE
 	bool "Support for old Pentium 5 / WinChip machine checks"
@@ -1246,18 +1246,18 @@ config X86_VSYSCALL_EMULATION
 	default y
 	depends on X86_64
 	help
-	 This enables emulation of the legacy vsyscall page.  Disabling
-	 it is roughly equivalent to booting with vsyscall=none, except
-	 that it will also disable the helpful warning if a program
-	 tries to use a vsyscall.  With this option set to N, offending
-	 programs will just segfault, citing addresses of the form
-	 0xffffffffff600?00.
+	  This enables emulation of the legacy vsyscall page.  Disabling
+	  it is roughly equivalent to booting with vsyscall=none, except
+	  that it will also disable the helpful warning if a program
+	  tries to use a vsyscall.  With this option set to N, offending
+	  programs will just segfault, citing addresses of the form
+	  0xffffffffff600?00.
 
-	 This option is required by many programs built before 2013, and
-	 care should be used even with newer programs if set to N.
+	  This option is required by many programs built before 2013, and
+	  care should be used even with newer programs if set to N.
 
-	 Disabling this option saves about 7K of kernel size and
-	 possibly 4K of additional runtime pagetable memory.
+	  Disabling this option saves about 7K of kernel size and
+	  possibly 4K of additional runtime pagetable memory.
 
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
 
-	   Note that it is not possible to boot a mixed-mode enabled
-	   kernel via the EFI boot stub - a bootloader that supports
-	   the EFI handover protocol must be used.
+	  Note that it is not possible to boot a mixed-mode enabled
+	  kernel via the EFI boot stub - a bootloader that supports
+	  the EFI handover protocol must be used.
 
-	   If unsure, say N.
+	  If unsure, say N.
 
 source "kernel/Kconfig.hz"
 
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
 
-	   The order of allocations remains unchanged. Entropy is generated in
-	   the same way as RANDOMIZE_BASE. Current implementation in the optimal
-	   configuration have in average 30,000 different possible virtual
-	   addresses for each memory section.
+	  The order of allocations remains unchanged. Entropy is generated in
+	  the same way as RANDOMIZE_BASE. Current implementation in the optimal
+	  configuration have in average 30,000 different possible virtual
+	  addresses for each memory section.
 
-	   If unsure, say Y.
+	  If unsure, say Y.
 
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
 
-	   If unsure, leave at the default value.
+	  If unsure, leave at the default value.
 
 config HOTPLUG_CPU
 	def_bool y
@@ -2598,7 +2598,6 @@ source "drivers/idle/Kconfig"
 
 endmenu
 
-
 menu "Bus options (PCI etc.)"
 
 choice
@@ -2822,7 +2821,6 @@ config AMD_NB
 
 endmenu
 
-
 menu "Binary Emulations"
 
 config IA32_EMULATION
@@ -2867,11 +2865,10 @@ config COMPAT_FOR_U64_ALIGNMENT
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on SYSVIPC
-endif
+endif # COMPAT
 
 endmenu
 
-
 config HAVE_ATOMIC_IOMAP
 	def_bool y
 	depends on X86_32
