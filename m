Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2279D530CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiEWJq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiEWJot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:44:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D86B496
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 02:44:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F24461F8D1;
        Mon, 23 May 2022 09:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653299086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tKYMwStdifgfa2zV60wvEIGbRxutqsKNVDQ7Odvgtj0=;
        b=0NzggIkSZZAWGTR/2BGFvtfo+CNM24mZBiE07JnfjDm47YxYsY7er3iEDl6wEjXH5fqvN0
        pHe/ETpfogV0aAAdIwi/PT+gPiqsRfN3+vcXxT5cX40XYLLU4OH2O1QWV0cMHgEf3J9VTD
        5NhJyLlUY++l7sqOu5RTwwDS6c63ZaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653299086;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tKYMwStdifgfa2zV60wvEIGbRxutqsKNVDQ7Odvgtj0=;
        b=pdzUqQODStJfuvWQJ+5u7NFB96HXRL4rqtYswg4klOPozTOydBtEIIHc2jBFnSATNLHB+Z
        nsQg03aD04nAMdDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAC9D139F5;
        Mon, 23 May 2022 09:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3jBkNY1Xi2LzaQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 09:44:45 +0000
Date:   Mon, 23 May 2022 11:44:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for 5.19
Message-ID: <YotXilVhT2BZHZ5R@zn.tnic>
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

please pull the third AMD confidential computing feature called Secure
Nested Paging.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.19_rc1

for you to fetch changes up to ce6565282b3b16fd850c6a676f78c6bc76d0c235:

  x86/entry: Fixup objtool/ibt validation (2022-05-20 12:04:56 +0200)

----------------------------------------------------------------
AMD SEV-SNP support

Add to confidential guests the necessary memory integrity protection
against malicious hypervisor-based attacks like data replay, memory
remapping and others, thus achieving a stronger isolation from the
hypervisor.

At the core of the functionality is a new structure called a reverse
map table (RMP) with which the guest has a say in which pages get
assigned to it and gets notified when a page which it owns, gets
accessed/modified under the covers so that the guest can take an
appropriate action.

In addition, add support for the whole machinery needed to launch a SNP
guest, details of which is properly explained in each patch.

And last but not least, the series refactors and improves parts of the
previous SEV support so that the new code is accomodated properly and
not just bolted on.

----------------------------------------------------------------
Borislav Petkov (2):
      x86/boot: Add an efi.h header for the decompressor
      x86/sev: Fix address space sparse warning

Brijesh Singh (21):
      KVM: SVM: Define sev_features and VMPL field in the VMSA
      x86/mm: Extend cc_attr to include AMD SEV-SNP
      x86/sev: Define the Linux-specific guest termination reasons
      x86/sev: Save the negotiated GHCB version
      x86/sev: Check SEV-SNP features support
      x86/sev: Add a helper for the PVALIDATE instruction
      x86/sev: Check the VMPL level
      x86/compressed: Add helper for validating pages in the decompression stage
      x86/compressed: Register GHCB memory when SEV-SNP is active
      x86/sev: Register GHCB memory when SEV-SNP is active
      x86/sev: Add helper for validating pages in early enc attribute changes
      x86/kernel: Mark the .bss..decrypted section as shared in the RMP table
      x86/kernel: Validate ROM memory before accessing when SEV-SNP is active
      x86/mm: Validate memory when changing the C-bit
      x86/boot: Add Confidential Computing type to setup_data
      x86/sev: Provide support for SNP guest request NAEs
      x86/sev: Register SEV-SNP guest request platform device
      virt: Add SEV-SNP guest driver
      virt: sevguest: Add support to derive key
      virt: sevguest: Add support to get extended report
      x86/sev: Get the AP jump table address from secrets page

Colin Ian King (1):
      x86/sev: Remove duplicated assignment to variable info

Haowen Bai (1):
      virt: sevguest: Fix bool function returning negative value

Lai Jiangshan (2):
      x86/sev: Annotate stack change in the #VC handler
      x86/sev: Mark the code returning to user space as syscall gap

Michael Roth (24):
      x86/boot: Introduce helpers for MSR reads/writes
      x86/boot: Use MSR read/write helpers instead of inline assembly
      x86/compressed/64: Detect/setup SEV/SME features earlier during boot
      x86/sev: Detect/setup SEV/SME features earlier in boot
      x86/head/64: Re-enable stack protection
      x86/compressed/acpi: Move EFI detection to helper
      x86/compressed/acpi: Move EFI system table lookup to helper
      x86/compressed/acpi: Move EFI config table lookup to helper
      x86/compressed/acpi: Move EFI vendor table lookup to helper
      x86/compressed/acpi: Move EFI kexec handling into common code
      KVM: x86: Move lookup of indexed CPUID leafs to helper
      x86/sev: Move MSR-based VMGEXITs for CPUID to helper
      x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers
      x86/boot: Add a pointer to Confidential Computing blob in bootparams
      x86/compressed: Add SEV-SNP feature detection/setup
      x86/compressed: Use firmware-validated CPUID leaves for SEV-SNP guests
      x86/compressed: Export and rename add_identity_map()
      x86/compressed/64: Add identity mapping for Confidential Computing blob
      x86/sev: Add SEV-SNP feature detection/setup
      x86/sev: Use firmware-validated CPUID for SEV-SNP guests
      x86/sev: Add a sev= cmdline option
      virt: sevguest: Add documentation for SEV-SNP CPUID Enforcement
      x86/boot: Put globals that are accessed early into the .data section
      x86/sev: Add missing __init annotations to SEV init routines

Peter Gonda (1):
      x86/sev-es: Replace open-coded hlt-loop with sev_es_terminate()

Peter Zijlstra (1):
      x86/entry: Fixup objtool/ibt validation

Tom Lendacky (6):
      KVM: SVM: Create a separate mapping for the SEV-ES save area
      KVM: SVM: Create a separate mapping for the GHCB save area
      KVM: SVM: Update the SEV-ES save area mapping
      x86/sev: Use SEV-SNP AP creation to start secondary CPUs
      virt: sevguest: Change driver name to reflect generic SEV support
      virt: sevguest: Rename the sevguest dir and files to sev-guest

Yang Yingliang (1):
      virt: sevguest: Fix return value check in alloc_shared_pages()

 Documentation/admin-guide/kernel-parameters.txt |   2 +
 Documentation/virt/coco/sev-guest.rst           | 155 +++++
 Documentation/virt/index.rst                    |   1 +
 Documentation/x86/x86_64/boot-options.rst       |  14 +
 Documentation/x86/zero-page.rst                 |   2 +
 arch/x86/boot/compressed/Makefile               |   1 +
 arch/x86/boot/compressed/acpi.c                 | 176 +----
 arch/x86/boot/compressed/early_serial_console.c |   3 +-
 arch/x86/boot/compressed/efi.c                  | 234 +++++++
 arch/x86/boot/compressed/efi.h                  | 126 ++++
 arch/x86/boot/compressed/head_64.S              |  37 +-
 arch/x86/boot/compressed/ident_map_64.c         |  39 +-
 arch/x86/boot/compressed/idt_64.c               |  18 +-
 arch/x86/boot/compressed/kaslr.c                |   3 +-
 arch/x86/boot/compressed/mem_encrypt.S          |  36 -
 arch/x86/boot/compressed/misc.c                 |   5 +-
 arch/x86/boot/compressed/misc.h                 |  56 +-
 arch/x86/boot/compressed/pgtable_64.c           |   3 +-
 arch/x86/boot/compressed/sev.c                  | 263 +++++++-
 arch/x86/boot/cpucheck.c                        |  30 +-
 arch/x86/boot/msr.h                             |  26 +
 arch/x86/coco/core.c                            |   3 +
 arch/x86/entry/entry_64.S                       |   6 +
 arch/x86/entry/entry_64_compat.S                |   5 +
 arch/x86/include/asm/bootparam_utils.h          |   1 +
 arch/x86/include/asm/cpuid.h                    |  34 +
 arch/x86/include/asm/msr-index.h                |   2 +
 arch/x86/include/asm/msr.h                      |  11 +-
 arch/x86/include/asm/proto.h                    |   4 +
 arch/x86/include/asm/ptrace.h                   |   4 +
 arch/x86/include/asm/setup.h                    |   1 -
 arch/x86/include/asm/sev-common.h               |  82 +++
 arch/x86/include/asm/sev.h                      | 137 +++-
 arch/x86/include/asm/shared/msr.h               |  15 +
 arch/x86/include/asm/svm.h                      | 171 ++++-
 arch/x86/include/uapi/asm/bootparam.h           |   4 +-
 arch/x86/include/uapi/asm/svm.h                 |  13 +
 arch/x86/kernel/Makefile                        |   2 -
 arch/x86/kernel/cpu/common.c                    |   4 +
 arch/x86/kernel/head64.c                        |  29 +-
 arch/x86/kernel/head_64.S                       |  37 +-
 arch/x86/kernel/probe_roms.c                    |  13 +-
 arch/x86/kernel/sev-shared.c                    | 534 ++++++++++++++-
 arch/x86/kernel/sev.c                           | 855 +++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c                       |   3 +
 arch/x86/kvm/cpuid.c                            |  19 +-
 arch/x86/kvm/svm/sev.c                          |  22 +-
 arch/x86/kvm/svm/svm.c                          |   8 +-
 arch/x86/kvm/svm/svm.h                          |   4 +-
 arch/x86/mm/mem_encrypt.c                       |   4 +
 arch/x86/mm/mem_encrypt_amd.c                   |  71 +-
 arch/x86/mm/mem_encrypt_identity.c              |   8 +
 arch/x86/realmode/init.c                        |   2 +-
 drivers/virt/Kconfig                            |   3 +
 drivers/virt/Makefile                           |   1 +
 drivers/virt/coco/sev-guest/Kconfig             |  14 +
 drivers/virt/coco/sev-guest/Makefile            |   2 +
 drivers/virt/coco/sev-guest/sev-guest.c         | 743 ++++++++++++++++++++
 drivers/virt/coco/sev-guest/sev-guest.h         |  63 ++
 include/linux/cc_platform.h                     |   8 +
 include/linux/efi.h                             |   1 +
 include/uapi/linux/sev-guest.h                  |  80 +++
 62 files changed, 3861 insertions(+), 392 deletions(-)
 create mode 100644 Documentation/virt/coco/sev-guest.rst
 create mode 100644 arch/x86/boot/compressed/efi.c
 create mode 100644 arch/x86/boot/compressed/efi.h
 create mode 100644 arch/x86/boot/msr.h
 create mode 100644 arch/x86/include/asm/cpuid.h
 create mode 100644 arch/x86/include/asm/shared/msr.h
 create mode 100644 drivers/virt/coco/sev-guest/Kconfig
 create mode 100644 drivers/virt/coco/sev-guest/Makefile
 create mode 100644 drivers/virt/coco/sev-guest/sev-guest.c
 create mode 100644 drivers/virt/coco/sev-guest/sev-guest.h
 create mode 100644 include/uapi/linux/sev-guest.h

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
