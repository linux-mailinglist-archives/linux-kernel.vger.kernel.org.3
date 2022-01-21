Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A55E496392
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbiAURLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiAURLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:11:16 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D40C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:11:15 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id e28so5001101pfj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=EkBKAb+fz4ftZ/Li4vejfF8DFA5HVNha2levh2DSsDE=;
        b=E1B3yU2XhsTV6T3+2v/yBaqbIOP/h99KnFXDbNiZn6f6tAjHj+mlUK203rl81TCNtB
         9ESbgnl0nsvJ9+JZvgjeTosy/oCAnu42nip2nzjcn5MuayggY1BEvXy8e3TBW60ZBWlW
         Uk89fFDNDPzyXtVMqbL7funftDCghihHlBeA2nuL/hNmp27ulGYEDAScHZGzq5FqI5/X
         9/bZl7vaQU9bf+kKxd9OLfbPksdtcYx2TB48qRHh5/NvtgQI9HP5XtL5CESgmn+J1rdp
         lhuBfxcxSD3ifAn381JyY9nv69Oq8GjgZc9ez9xyQjQdUMrvpHSCegd3/gKFBN89Bdil
         fVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=EkBKAb+fz4ftZ/Li4vejfF8DFA5HVNha2levh2DSsDE=;
        b=lwKmZuGIUCQW4RqEK/ms5IIjUyOcq+QXTwSoTQXDxR/9dQ9etwCa1KG4araksnC0mL
         NDMbjiL74b21EiaGb0lPFlsC3daaMUh4jyvcp6XRxiq9e/vOs2/xjoSvqcASeHP4eydo
         tTwJ6hhugNIPPh14cTxVXt1LWeN7MIphChMKDfd5uGk0IopNoLOFLdTMGbvkRRlW8Api
         u0O/4+UzmnW5PDewWJg73smck/NMPa33YRZVn7ZE8qsiTuZHbzTTlHiYK712DnPWyIi3
         W9DHD3NOfbj+oBe45y2IbWdDYgV0uzDbtggrYmE8f5qYSxEdDGPmk3qp2GSEDMCfQgAn
         3mWQ==
X-Gm-Message-State: AOAM530luw3P7t1hfhQ21fubtSVyldpgTqcm6FEBVKo8faLY8X1xS7VC
        KltcbilTPPLDN+xF+UYdKa0bqA==
X-Google-Smtp-Source: ABdhPJwpZ89rbtvTV6MDhqBZj7XeB4HRo7yT0fbPqjK4J91buwa3Ffy5Ygz5lM3HQGuKSK8+8qLAYg==
X-Received: by 2002:a05:6a00:2487:b0:4bc:315d:21f4 with SMTP id c7-20020a056a00248700b004bc315d21f4mr4360065pfv.55.1642785075000;
        Fri, 21 Jan 2022 09:11:15 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id v36sm5330804pgk.81.2022.01.21.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 09:11:14 -0800 (PST)
Date:   Fri, 21 Jan 2022 09:11:14 -0800 (PST)
X-Google-Original-Date: Fri, 21 Jan 2022 09:10:29 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for the 5.17 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-c8a6625a-625b-420a-9399-f69d027a43ea@palmer-ri-x1c9>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f1b744f65e2f9682347c5faf6377e61e2ab19a67:

  Merge tag 'riscv-for-linus-5.17-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2022-01-19 11:38:21 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-mw1

for you to fetch changes up to c59cd507fb640c2acc6b07cb60d7f765839e18c7:

  RISC-V: nommu_virt: Drop unused SLAB_MERGE_DEFAULT (2022-01-20 12:48:14 -0800)

----------------------------------------------------------------
RISC-V Patches for the 5.17 Merge Window, Part 2

* Support for sv48 paging.
* Hart ID mappings are now sparse, which enables more CPUs to come up on
  systems with sparse hart IDs.
* A handful of cleanups and fixes.

---
The sv48 patch set is a bit intrusive for something this late, but given that
it's being shown to fix some hangs it's seems better to take it now rather than
waiting.

I had no merge conflicts.

I'm not planning on submitting another PR for the merge window.

----------------------------------------------------------------
Alexandre Ghiti (9):
      riscv: Get rid of MAXPHYSMEM configs
      riscv: Move KASAN mapping next to the kernel mapping
      riscv: Split early kasan mapping to prepare sv48 introduction
      riscv: Introduce functions to switch pt_ops
      riscv: Allow to dynamically define VA_BITS
      asm-generic: Prepare for riscv use of pud_alloc_one and pud_free
      riscv: Implement sv48 support
      riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
      riscv: Explicit comment about user virtual address space size

Atish Patra (6):
      RISC-V: Avoid using per cpu array for ordered booting
      RISC-V: Do not print the SBI version during HSM extension boot print
      RISC-V: Use __cpu_up_stack/task_pointer only for spinwait method
      RISC-V: Move the entire hart selection via lottery to SMP
      RISC-V: Move spinwait booting method to its own config
      RISC-V: Do not use cpumask data structure for hartid bitmap

Heinrich Schuchardt (1):
      riscv: default to CONFIG_RISCV_SBI_V01=n

Jisheng Zhang (6):
      riscv: mm: init: remove unnecessary "#ifdef CONFIG_CRASH_DUMP"
      riscv: mm: init: try best to use IS_ENABLED(CONFIG_64BIT) instead of #ifdef
      riscv: mm: init: remove _pt_ops and use pt_ops directly
      riscv: mm: init: try IS_ENABLED(CONFIG_XIP_KERNEL) instead of #ifdef
      riscv: mm: init: try best to remove #ifdef CONFIG_XIP_KERNEL usage
      riscv: bpf: Fix eBPF's exception tables

Lukas Bulwahn (1):
      riscv: canaan: remove useless select of non-existing config SYSCON

Minghao Chi (1):
      RISC-V: Remove redundant err variable

Palmer Dabbelt (2):
      RISC-V: Introduce sv48 support without relocatable kernel
      RISC-V: nommu_virt: Drop unused SLAB_MERGE_DEFAULT

Ron Economos (1):
      riscv: dts: sifive unmatched: Add gpio poweroff

kernel test robot (1):
      riscv: fix boolconv.cocci warnings

 Documentation/riscv/vm-layout.rst                  |  12 +-
 arch/riscv/Kconfig                                 |  52 +--
 .../riscv/boot/dts/sifive/hifive-unmatched-a00.dts |   5 +
 arch/riscv/configs/nommu_k210_defconfig            |   1 -
 arch/riscv/configs/nommu_k210_sdcard_defconfig     |   1 -
 arch/riscv/configs/nommu_virt_defconfig            |   2 -
 arch/riscv/include/asm/cpu_ops.h                   |   2 -
 arch/riscv/include/asm/cpu_ops_sbi.h               |  25 ++
 arch/riscv/include/asm/csr.h                       |   3 +-
 arch/riscv/include/asm/fixmap.h                    |   1 +
 arch/riscv/include/asm/kasan.h                     |  11 +-
 arch/riscv/include/asm/page.h                      |  16 +-
 arch/riscv/include/asm/pgalloc.h                   |  40 +++
 arch/riscv/include/asm/pgtable-64.h                | 108 +++++-
 arch/riscv/include/asm/pgtable.h                   |  65 +++-
 arch/riscv/include/asm/sbi.h                       |  19 +-
 arch/riscv/include/asm/smp.h                       |   2 -
 arch/riscv/include/asm/sparsemem.h                 |   6 +-
 arch/riscv/kernel/Makefile                         |   3 +-
 arch/riscv/kernel/asm-offsets.c                    |   3 +
 arch/riscv/kernel/cpu.c                            |  23 +-
 arch/riscv/kernel/cpu_ops.c                        |  26 +-
 arch/riscv/kernel/cpu_ops_sbi.c                    |  26 +-
 arch/riscv/kernel/cpu_ops_spinwait.c               |  27 +-
 arch/riscv/kernel/head.S                           |  38 ++-
 arch/riscv/kernel/head.h                           |   6 +-
 arch/riscv/kernel/ptrace.c                         |   4 +-
 arch/riscv/kernel/sbi.c                            | 189 ++++++-----
 arch/riscv/kernel/setup.c                          |  10 -
 arch/riscv/kernel/smpboot.c                        |   2 +-
 arch/riscv/kvm/mmu.c                               |   4 +-
 arch/riscv/kvm/vcpu_sbi_replace.c                  |  11 +-
 arch/riscv/kvm/vcpu_sbi_v01.c                      |  11 +-
 arch/riscv/kvm/vmid.c                              |   4 +-
 arch/riscv/mm/cacheflush.c                         |   5 +-
 arch/riscv/mm/context.c                            |   4 +-
 arch/riscv/mm/init.c                               | 378 +++++++++++++++------
 arch/riscv/mm/kasan_init.c                         | 248 ++++++++++----
 arch/riscv/mm/tlbflush.c                           |   9 +-
 arch/riscv/net/bpf_jit_comp64.c                    |   2 +-
 drivers/firmware/efi/libstub/efi-stub.c            |   2 +
 drivers/soc/canaan/Kconfig                         |   1 -
 include/asm-generic/pgalloc.h                      |  24 +-
 43 files changed, 1006 insertions(+), 425 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpu_ops_sbi.h
