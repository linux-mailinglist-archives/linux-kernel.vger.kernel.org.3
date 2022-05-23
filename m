Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83E530FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiEWLvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiEWLvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:51:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F219FD10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:51:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BAE2A1F8D1;
        Mon, 23 May 2022 11:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653306660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k3FxMEGz9P/tohodFkPU7lH2Sd7D9iV3kGlcJbG7Ac8=;
        b=vIuXOC79KG672qQNXyrmhAFnLFPv6TOw9jVOJuJwBdzgTYPMVVBUd2NzyxVuIqJh+IGJIZ
        Sd7HOiWj20wOSfwp+pNuSZ/YbxH88OrxOpx/AAhJPnjWPB801VFA5ME0Dfo+8L5sGI/C6d
        cxIqS1nPtjTYA0NEinmzYlLaZVPbc3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653306660;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k3FxMEGz9P/tohodFkPU7lH2Sd7D9iV3kGlcJbG7Ac8=;
        b=V4kyod5X83ypkp0t13GgRSDPthI6tisD+5ml1Q6MpHiFH+eOkc5fCgis8f/XtmrV5zlUMW
        LmqP1+hzn/tWeyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEB85139F5;
        Mon, 23 May 2022 11:51:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zzCfKiR1i2IUKgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 11:51:00 +0000
Date:   Mon, 23 May 2022 13:50:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/tdx for 5.19
Message-ID: <Yot1IAqHoRBlwe0w@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the Intel confidential computing solution called TDX.

Depending on the order you merge the branches, this conflicts with the
x86/sev stuff but the merge conflict resolve is simple, I'm adding it at
the end of this message.

Thx.

---
The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_v5.19_rc1

for you to fetch changes up to c796f02162e428b595ff70196dca161ee46b163b:

  x86/tdx: Fix RETs in TDX asm (2022-05-20 12:53:22 +0200)

----------------------------------------------------------------
Intel Trust Domain Extensions

This is the Intel version of a confidential computing solution called
Trust Domain Extensions (TDX). This series adds support to run the
kernel as part of a TDX guest. It provides similar guest protections to
AMD's SEV-SNP like guest memory and register state encryption, memory
integrity protection and a lot more.

Design-wise, it differs from AMD's solution considerably: it uses
a software module which runs in a special CPU mode called (Secure
Arbitration Mode) SEAM. As the name suggests, this module serves as sort
of an arbiter which the confidential guest calls for services it needs
during its lifetime.

Just like AMD's SNP set, this series reworks and streamlines certain
parts of x86 arch code so that this feature can be properly accomodated.

----------------------------------------------------------------
Andi Kleen (1):
      x86/tdx: Port I/O: Add early boot support

Borislav Petkov (1):
      x86/tdx: Annotate a noreturn function

Isaku Yamahata (1):
      x86/tdx/ioapic: Add shared bit for IOAPIC base address

Kirill A. Shutemov (19):
      x86/tdx: Provide common base for SEAMCALL and TDCALL C wrappers
      x86/tdx: Extend the confidential computing API to support TDX guests
      x86/tdx: Exclude shared bit from __PHYSICAL_MASK
      x86/traps: Refactor exc_general_protection()
      x86/traps: Add #VE support for TDX guest
      x86/tdx: Add HLT support for TDX guests
      x86/tdx: Add MSR support for TDX guests
      x86/tdx: Handle CPUID via #VE
      x86/tdx: Handle in-kernel MMIO
      x86: Adjust types used in port I/O helpers
      x86: Consolidate port I/O helpers
      x86/boot: Port I/O: Allow to hook up alternative helpers
      x86/boot: Port I/O: Add decompression-time support for TDX
      x86/boot: Set CR0.NE early and keep it set during the boot
      x86/tdx: Make pages shared in ioremap()
      x86/mm/cpa: Add support for TDX shared memory
      x86/mm: Make DMA memory shared for TD guest
      ACPICA: Avoid cache flush inside virtual machines
      x86/kaslr: Fix build warning in KASLR code in boot stub

Kuppuswamy Sathyanarayanan (8):
      x86/tdx: Detect running as a TDX guest in early boot
      x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions
      x86/tdx: Detect TDX at early kernel decompression time
      x86/tdx: Port I/O: Add runtime hypercalls
      x86/tdx: Wire up KVM hypercalls
      x86/acpi/x86/boot: Add multiprocessor wake-up support
      x86/topology: Disable CPU online/offline control for TDX guests
      Documentation/x86: Document TDX kernel architecture

Peter Zijlstra (1):
      x86/tdx: Fix RETs in TDX asm

Sean Christopherson (2):
      x86/boot: Add a trampoline for booting APs via firmware handoff
      x86/boot: Avoid #VE during boot for TDX platforms

Tom Lendacky (1):
      x86/mm: Fix spacing within memory encryption features message

 Documentation/x86/index.rst              |   1 +
 Documentation/x86/tdx.rst                | 218 ++++++++++
 arch/x86/Kconfig                         |  15 +
 arch/x86/boot/boot.h                     |  37 +-
 arch/x86/boot/compressed/Makefile        |   1 +
 arch/x86/boot/compressed/head_64.S       |  27 +-
 arch/x86/boot/compressed/misc.c          |  12 +
 arch/x86/boot/compressed/misc.h          |   4 +-
 arch/x86/boot/compressed/pgtable.h       |   2 +-
 arch/x86/boot/compressed/tdcall.S        |   3 +
 arch/x86/boot/compressed/tdx.c           |  77 ++++
 arch/x86/boot/compressed/tdx.h           |  13 +
 arch/x86/boot/cpuflags.c                 |   3 +-
 arch/x86/boot/cpuflags.h                 |   1 +
 arch/x86/boot/io.h                       |  41 ++
 arch/x86/boot/main.c                     |   4 +
 arch/x86/coco/Makefile                   |   2 +
 arch/x86/coco/core.c                     |  22 +-
 arch/x86/coco/tdx/Makefile               |   3 +
 arch/x86/coco/tdx/tdcall.S               | 205 +++++++++
 arch/x86/coco/tdx/tdx.c                  | 692 +++++++++++++++++++++++++++++++
 arch/x86/include/asm/acenv.h             |  14 +-
 arch/x86/include/asm/apic.h              |   7 +
 arch/x86/include/asm/cpufeatures.h       |   1 +
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/idtentry.h          |   4 +
 arch/x86/include/asm/io.h                |  42 +-
 arch/x86/include/asm/kvm_para.h          |  22 +
 arch/x86/include/asm/mem_encrypt.h       |   6 +-
 arch/x86/include/asm/realmode.h          |   1 +
 arch/x86/include/asm/shared/io.h         |  34 ++
 arch/x86/include/asm/shared/tdx.h        |  40 ++
 arch/x86/include/asm/tdx.h               |  91 ++++
 arch/x86/kernel/acpi/boot.c              |  93 ++++-
 arch/x86/kernel/apic/apic.c              |  10 +
 arch/x86/kernel/apic/io_apic.c           |  18 +-
 arch/x86/kernel/asm-offsets.c            |  17 +
 arch/x86/kernel/head64.c                 |   7 +
 arch/x86/kernel/head_64.S                |  28 +-
 arch/x86/kernel/idt.c                    |   3 +
 arch/x86/kernel/process.c                |   4 +
 arch/x86/kernel/smpboot.c                |  12 +-
 arch/x86/kernel/traps.c                  | 143 +++++--
 arch/x86/lib/kaslr.c                     |   2 +-
 arch/x86/mm/ioremap.c                    |   5 +
 arch/x86/mm/mem_encrypt.c                |   9 +-
 arch/x86/realmode/rm/header.S            |   1 +
 arch/x86/realmode/rm/trampoline_64.S     |  57 ++-
 arch/x86/realmode/rm/trampoline_common.S |  12 +-
 arch/x86/realmode/rm/wakemain.c          |   4 +
 arch/x86/virt/vmx/tdx/tdxcall.S          |  96 +++++
 include/linux/cc_platform.h              |  10 +
 kernel/cpu.c                             |   7 +
 53 files changed, 2071 insertions(+), 120 deletions(-)
 create mode 100644 Documentation/x86/tdx.rst
 create mode 100644 arch/x86/boot/compressed/tdcall.S
 create mode 100644 arch/x86/boot/compressed/tdx.c
 create mode 100644 arch/x86/boot/compressed/tdx.h
 create mode 100644 arch/x86/boot/io.h
 create mode 100644 arch/x86/coco/tdx/Makefile
 create mode 100644 arch/x86/coco/tdx/tdcall.S
 create mode 100644 arch/x86/coco/tdx/tdx.c
 create mode 100644 arch/x86/include/asm/shared/io.h
 create mode 100644 arch/x86/include/asm/shared/tdx.h
 create mode 100644 arch/x86/include/asm/tdx.h
 create mode 100644 arch/x86/virt/vmx/tdx/tdxcall.S

---

Merge conflict resolution:


diff --cc arch/x86/boot/compressed/Makefile
index e69c3d2e0628,8fd0e6ae2e1f..19e1905dcbf6
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@@ -101,9 -101,9 +101,10 @@@ ifdef CONFIG_X86_6
  endif
  
  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
+ vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
  
  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 +vmlinux-objs-$(CONFIG_EFI) += $(obj)/efi.o
  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
  
  $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
diff --cc arch/x86/boot/compressed/misc.h
index 4ca2857ea041,ea71cf3d64e1..4910bf230d7b
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@@ -33,9 -34,8 +34,10 @@@
  
  #define BOOT_BOOT_H
  #include "../ctype.h"
+ #include "../io.h"
  
 +#include "efi.h"
 +
  #ifdef CONFIG_X86_64
  #define memptr long
  #else
diff --cc include/linux/cc_platform.h
index d08dd65b5c43,691494bbaf5a..cb0d6cd1c12f
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@@ -73,13 -73,15 +73,23 @@@ enum cc_attr 
  	 */
  	CC_ATTR_GUEST_UNROLL_STRING_IO,
  
 +	/**
 +	 * @CC_ATTR_SEV_SNP: Guest SNP is active.
 +	 *
 +	 * The platform/OS is running as a guest/virtual machine and actively
 +	 * using AMD SEV-SNP features.
 +	 */
 +	CC_ATTR_GUEST_SEV_SNP,
++
+ 	/**
+ 	 * @CC_ATTR_HOTPLUG_DISABLED: Hotplug is not supported or disabled.
+ 	 *
+ 	 * The platform/OS is running as a guest/virtual machine does not
+ 	 * support CPU hotplug feature.
+ 	 *
+ 	 * Examples include TDX Guest.
+ 	 */
+ 	CC_ATTR_HOTPLUG_DISABLED,
  };
  
  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
