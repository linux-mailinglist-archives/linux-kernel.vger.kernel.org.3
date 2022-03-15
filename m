Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC994D9FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350037AbiCOQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiCOQWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:22:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FDB237C9;
        Tue, 15 Mar 2022 09:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 808AFB81770;
        Tue, 15 Mar 2022 16:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E0BC340E8;
        Tue, 15 Mar 2022 16:21:19 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 5.15.28-rt36
Date:   Tue, 15 Mar 2022 16:20:39 -0000
Message-ID: <164736123954.3997068.7163237580661006943@puck.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.15.28-rt36 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.15-rt
  Head SHA1: 42ea71f324239aff9351a401974c9781ebacda4c

Or to build 5.15.28-rt36 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.15.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.15.28.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/patch-5.15.28-rt36.patch.xz


You can also build from 5.15.27-rt35 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.15/incr/patch-5.15.27-rt35-rt36.patch.xz

Enjoy!
Clark

Changes from v5.15.27-rt35:
---

Anshuman Khandual (1):
      arm64: Add Cortex-X2 CPU part definition

Clark Williams (2):
      Merge tag 'v5.15.28' into v5.15-rt
      Linux 5.15.28-rt36

Emmanuel Gil Peyrot (1):
      ARM: fix build error when BPF_SYSCALL is disabled

Greg Kroah-Hartman (2):
      Revert "ACPI: PM: s2idle: Cancel wakeup before dispatching EC GPE"
      Linux 5.15.28

Huang Pei (1):
      slip: fix macro redefine warning

James Morse (20):
      arm64: entry.S: Add ventry overflow sanity checks
      arm64: spectre: Rename spectre_v4_patch_fw_mitigation_conduit
      KVM: arm64: Allow indirect vectors to be used without SPECTRE_V3A
      arm64: entry: Make the trampoline cleanup optional
      arm64: entry: Free up another register on kpti's tramp_exit path
      arm64: entry: Move the trampoline data page before the text page
      arm64: entry: Allow tramp_alias to access symbols after the 4K boundary
      arm64: entry: Don't assume tramp_vectors is the start of the vectors
      arm64: entry: Move trampoline macros out of ifdef'd section
      arm64: entry: Make the kpti trampoline's kpti sequence optional
      arm64: entry: Allow the trampoline text to occupy multiple pages
      arm64: entry: Add non-kpti __bp_harden_el1_vectors for mitigations
      arm64: entry: Add vectors that have the bhb mitigation sequences
      arm64: entry: Add macro for reading symbol addresses from the trampoline
      arm64: Add percpu vectors for EL1
      arm64: proton-pack: Report Spectre-BHB vulnerabilities as part of Spectre-v2
      arm64: Mitigate spectre style branch history side channels
      KVM: arm64: Allow SMCCC_ARCH_WORKAROUND_3 to be discovered and migrated
      arm64: Use the clearbhb instruction in mitigations
      arm64: proton-pack: Include unprivileged eBPF status in Spectre v2 mitigation reporting

Joey Gouly (3):
      arm64: add ID_AA64ISAR2_EL1 sys register
      arm64: cpufeature: add HWCAP for FEAT_AFP
      arm64: cpufeature: add HWCAP for FEAT_RPRES

Josh Poimboeuf (3):
      x86/speculation: Include unprivileged eBPF status in Spectre v2 mitigation reporting
      x86/speculation: Warn about Spectre v2 LFENCE mitigation
      x86/speculation: Warn about eIBRS + LFENCE + Unprivileged eBPF + SMT

Juergen Gross (11):
      xen/xenbus: don't let xenbus_grant_ring() remove grants in error case
      xen/grant-table: add gnttab_try_end_foreign_access()
      xen/blkfront: don't use gnttab_query_foreign_access() for mapped status
      xen/netfront: don't use gnttab_query_foreign_access() for mapped status
      xen/scsifront: don't use gnttab_query_foreign_access() for mapped status
      xen/gntalloc: don't use gnttab_query_foreign_access()
      xen: remove gnttab_query_foreign_access()
      xen/9p: use alloc/free_pages_exact()
      xen/pvcalls: use alloc/free_pages_exact()
      xen/gnttab: fix gnttab_end_foreign_access() without page specified
      xen/netfront: react properly to failing gnttab_end_foreign_access_ref()

Kim Phillips (2):
      x86/speculation: Use generic retpoline by default on AMD
      x86/speculation: Update link to AMD speculation whitepaper

Marc Zyngier (1):
      arm64: Add HWCAP for self-synchronising virtual counter

Nathan Chancellor (2):
      ARM: Do not use NOCROSSREFS directive with ld.lld
      arm64: Do not include __READ_ONCE() block in assembly files

Peter Zijlstra (3):
      x86,bugs: Unconditionally allow spectre_v2=retpoline,amd
      x86/speculation: Add eIBRS + Retpoline options
      Documentation/hw-vuln: Update spectre doc

Peter Zijlstra (Intel) (1):
      x86/speculation: Rename RETPOLINE_AMD to RETPOLINE_LFENCE

Russell King (Oracle) (7):
      ARM: report Spectre v2 status through sysfs
      ARM: early traps initialisation
      ARM: use LOADADDR() to get load address of sections
      ARM: Spectre-BHB workaround
      ARM: include unprivileged BPF status in Spectre V2 reporting
      ARM: fix co-processor register typo
      ARM: fix build warning in proc-v7-bugs.c

Suzuki K Poulose (1):
      arm64: Add Neoverse-N2, Cortex-A710 CPU part definition
---
Documentation/admin-guide/hw-vuln/spectre.rst   |  48 ++-
 Documentation/admin-guide/kernel-parameters.txt |   8 +-
 Documentation/arm64/cpu-feature-registers.rst   |  29 +-
 Documentation/arm64/elf_hwcaps.rst              |  12 +
 Makefile                                        |   2 +-
 arch/arm/include/asm/assembler.h                |  10 +
 arch/arm/include/asm/spectre.h                  |  32 ++
 arch/arm/include/asm/vmlinux.lds.h              |  43 ++-
 arch/arm/kernel/Makefile                        |   2 +
 arch/arm/kernel/entry-armv.S                    |  79 ++++-
 arch/arm/kernel/entry-common.S                  |  24 ++
 arch/arm/kernel/spectre.c                       |  71 +++++
 arch/arm/kernel/traps.c                         |  65 +++-
 arch/arm/mm/Kconfig                             |  11 +
 arch/arm/mm/proc-v7-bugs.c                      | 208 ++++++++++---
 arch/arm64/Kconfig                              |   9 +
 arch/arm64/include/asm/assembler.h              |  53 ++++
 arch/arm64/include/asm/cpu.h                    |   1 +
 arch/arm64/include/asm/cpufeature.h             |  29 ++
 arch/arm64/include/asm/cputype.h                |  14 +
 arch/arm64/include/asm/fixmap.h                 |   6 +-
 arch/arm64/include/asm/hwcap.h                  |   3 +
 arch/arm64/include/asm/insn.h                   |   1 +
 arch/arm64/include/asm/kvm_host.h               |   5 +
 arch/arm64/include/asm/rwonce.h                 |   4 +-
 arch/arm64/include/asm/sections.h               |   5 +
 arch/arm64/include/asm/spectre.h                |   4 +
 arch/arm64/include/asm/sysreg.h                 |  18 ++
 arch/arm64/include/asm/vectors.h                |  73 +++++
 arch/arm64/include/uapi/asm/hwcap.h             |   3 +
 arch/arm64/include/uapi/asm/kvm.h               |   5 +
 arch/arm64/kernel/cpu_errata.c                  |   7 +
 arch/arm64/kernel/cpufeature.c                  |  28 +-
 arch/arm64/kernel/cpuinfo.c                     |   4 +
 arch/arm64/kernel/entry.S                       | 214 +++++++++----
 arch/arm64/kernel/image-vars.h                  |   4 +
 arch/arm64/kernel/proton-pack.c                 | 391 +++++++++++++++++++++++-
 arch/arm64/kernel/vmlinux.lds.S                 |   2 +-
 arch/arm64/kvm/arm.c                            |   5 +-
 arch/arm64/kvm/hyp/hyp-entry.S                  |   9 +
 arch/arm64/kvm/hyp/nvhe/mm.c                    |   4 +-
 arch/arm64/kvm/hyp/vhe/switch.c                 |   9 +-
 arch/arm64/kvm/hypercalls.c                     |  12 +
 arch/arm64/kvm/psci.c                           |  18 +-
 arch/arm64/kvm/sys_regs.c                       |   2 +-
 arch/arm64/mm/mmu.c                             |  12 +-
 arch/arm64/tools/cpucaps                        |   1 +
 arch/x86/include/asm/cpufeatures.h              |   2 +-
 arch/x86/include/asm/nospec-branch.h            |  16 +-
 arch/x86/kernel/cpu/bugs.c                      | 205 +++++++++----
 arch/x86/lib/retpoline.S                        |   2 +-
 drivers/acpi/ec.c                               |  10 -
 drivers/acpi/sleep.c                            |  14 +-
 drivers/block/xen-blkfront.c                    |  63 ++--
 drivers/net/slip/slip.h                         |   2 +
 drivers/net/xen-netfront.c                      |  54 ++--
 drivers/scsi/xen-scsifront.c                    |   3 +-
 drivers/xen/gntalloc.c                          |  25 +-
 drivers/xen/grant-table.c                       |  71 +++--
 drivers/xen/pvcalls-front.c                     |   8 +-
 drivers/xen/xenbus/xenbus_client.c              |  24 +-
 include/linux/arm-smccc.h                       |   5 +
 include/linux/bpf.h                             |  12 +
 include/xen/grant_table.h                       |  19 +-
 kernel/sysctl.c                                 |   7 +
 localversion-rt                                 |   2 +-
 net/9p/trans_xen.c                              |  14 +-
 tools/arch/x86/include/asm/cpufeatures.h        |   2 +-
 68 files changed, 1800 insertions(+), 359 deletions(-)
---
