Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2234E78C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357499AbiCYQQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbiCYQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:16:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661701C93D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:14:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c23so8569025plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=/J3ZSura8UYnQkEtUNyN05EeOp8uC8XsehkUYYVu7hc=;
        b=Yz7UZWgyzK8BJWrcAbbloqTm4nqij/XFViIuJS1a4mJAyy6FP3vMCoe2NQZK1xF2mO
         VBSicpqlNAvmOC9pPhqCxGyF0po774m8vrM2xESN3lOSTlPHtl+B0fJCpg8U9Q7vbRQ3
         AHxQ7x235808lNeJ65hlfEGmLLEKxz+P6f1JFXCGCiXth9n6TlUd0F1WdJ7th9cQ8LWN
         dHW88zuQaDq9vPsKHa6DU/exLfeUb0TMlPcx0aL3KS5GhIlwau0cSMVoiAp0WyH88bU6
         G1wi54fILVxiNJkN5xLbXkm8dt6AeLb69rgxMrSQS1arYtLacuIcsjoTtz1KLhwmKrSo
         aS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=/J3ZSura8UYnQkEtUNyN05EeOp8uC8XsehkUYYVu7hc=;
        b=Cwh3v9W0m/hZ4F3eAq4pacscv1gOoyQX6jA3C7k857S0n43T4bEIl1hUsF5BpmD75v
         ceWZFsBEMzsXx7uy8/btuD8vJPGGPcj+zoWKS4qpCbV+2eCwV02JTmNXRE8Gb2hBDXMF
         zx5XLj9j25jHjFReQyYqhl9QWk+lrgljocdVV9J1b2wf18viTbz3Audng5FDwRzNb6sy
         bVYFLj9JMWvhgE1ZB5ufV5symJldAZ4bP0H1mdFpyd36KGfJA8rLN7ykYwzAHgr0TW0e
         MmMSSti7ulBysJsrWk3DrA6d7nQyxAPK2Pz4S6mm4/QqPfj5vagG675XdK4dPlVHlcqe
         Q6dQ==
X-Gm-Message-State: AOAM531gpgxtd75ALejMnvgEW0p1OjwGX66frwrpCM85KQxjHBFtCuUn
        lQt2hk0C/NVpkVLLqc/zUv5HYbyLltHUPQ==
X-Google-Smtp-Source: ABdhPJxnPyi0T+WZ4F2PU9/Xn+sjZ9aQ1D80QCL90ndV0kfW9N8KGj/ii1yUnaqk2DcIjp5kwxBt6Q==
X-Received: by 2002:a17:902:d48d:b0:153:a517:6ff2 with SMTP id c13-20020a170902d48d00b00153a5176ff2mr12515140plg.141.1648224880795;
        Fri, 25 Mar 2022 09:14:40 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id f4-20020aa782c4000000b004f6f0334a51sm6863378pfn.126.2022.03.25.09.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 09:14:40 -0700 (PDT)
Date:   Fri, 25 Mar 2022 09:14:40 -0700 (PDT)
X-Google-Original-Date: Fri, 25 Mar 2022 09:14:32 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.18 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-d6e408db-0c83-4358-9cef-831a694d582e@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-mw0

for you to fetch changes up to bbde015227e89f1da21bd3b84523d62c4a445c06:

  RISC-V: add support for restartable sequences (2022-03-22 16:20:37 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.18 Merge Window, Part 1

* Support for Sv57-based virtual memory.
* Various improvements for the MicroChip PolarFire SOC and the
  associated Icicle dev board, which should allow upstream kernels to
  boot without any additional modifications.
* An improved memmove() implementation.
* Support for the new Ssconfpmf and SBI PMU extensions, which allows for
  a much more useful perf implementation on RISC-V systems.
* Support for restartable sequences.

----------------------------------------------------------------
There will almost certainly be a part 2: there are at least a handful of
fixes/cleanups that have already started to show up, and there's still some
larger patch sets that minor issues I hope can be resolved.

There are a handful of merge conflicts, once again between this and my fixes
tree.  Here's how I resolved them, for reference:

diff --cc arch/riscv/kernel/Makefile
index ffc87e76b1dd,fb63b462ff85..e0133d113216
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@@ -51,9 -51,6 +51,8 @@@ obj-$(CONFIG_MODULE_SECTIONS) += module
  obj-$(CONFIG_FUNCTION_TRACER) += mcount.o ftrace.o
  obj-$(CONFIG_DYNAMIC_FTRACE)  += mcount-dyn.o

 +obj-$(CONFIG_TRACE_IRQFLAGS)  += trace_irq.o
 +
- obj-$(CONFIG_RISCV_BASE_PMU)  += perf_event.o
  obj-$(CONFIG_PERF_EVENTS)     += perf_callchain.o
  obj-$(CONFIG_HAVE_PERF_REGS)  += perf_regs.o
  obj-$(CONFIG_RISCV_SBI)               += sbi.o
diff --cc arch/riscv/mm/kasan_init.c
index cd1a145257b7,3c99b24c9adf..a22e418dbd82
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@@ -111,13 -111,12 +111,15 @@@ static void __init kasan_populate_pud(p
                 * pt_ops facility.
                 */
                base_pud = pt_ops.get_pud_virt(pfn_to_phys(_pgd_pfn(*pgd)));
+       } else if (pgd_none(*pgd)) {
+               base_pud = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
        } else {
                base_pud = (pud_t *)pgd_page_vaddr(*pgd);
 -              if (base_pud == lm_alias(kasan_early_shadow_pud))
 +              if (base_pud == lm_alias(kasan_early_shadow_pud)) {
                        base_pud = memblock_alloc(PTRS_PER_PUD * sizeof(pud_t), PAGE_SIZE);
 +                      memcpy(base_pud, (void *)kasan_early_shadow_pud,
 +                             sizeof(pud_t) * PTRS_PER_PUD);
 +              }
        }

        pudp = base_pud + pud_index(vaddr);

----------------------------------------------------------------
Atish Patra (12):
      RISC-V: Implement multi-letter ISA extension probing framework
      RISC-V: Do no continue isa string parsing without correct XLEN
      RISC-V: Improve /proc/cpuinfo output for ISA extensions
      RISC-V: Remove the current perf implementation
      RISC-V: Add CSR encodings for all HPMCOUNTERS
      RISC-V: Add a perf core library for pmu drivers
      RISC-V: Add a simple platform driver for RISC-V legacy perf
      RISC-V: Add RISC-V SBI PMU extension definitions
      RISC-V: Add perf platform driver based on SBI PMU extension
      RISC-V: Add sscofpmf extension support
      Documentation: riscv: Remove the old documentation
      MAINTAINERS: Add entry for RISC-V PMU drivers

Conor Dooley (11):
      dt-bindings: soc/microchip: update syscontroller compatibles
      dt-bindings: soc/microchip: add info about services to mpfs sysctrl
      dt-bindings: rtc: add bindings for microchip mpfs rtc
      dt-bindings: gpio: add bindings for microchip mpfs gpio
      dt-bindings: pwm: add microchip corepwm binding
      riscv: dts: microchip: use clk defines for icicle kit
      riscv: dts: microchip: add fpga fabric section to icicle kit
      riscv: dts: microchip: refactor icicle kit device tree
      riscv: dts: microchip: update peripherals in icicle kit device tree
      riscv: dts: microchip: add new peripherals to icicle kit device tree
      MAINTAINERS: update riscv/microchip entry

Daire McNamara (1):
      dt-bindings: clk: microchip: Add Microchip PolarFire host binding

Jisheng Zhang (1):
      riscv: mm: init: mark satp_mode __ro_after_init

Mayuresh Chitale (1):
      riscv: defconfig: enable hugetlbfs option

Michael T. Kloos (1):
      riscv: Fixed misaligned memory access. Fixed pointer comparison.

Palmer Dabbelt (5):
      RISC-V: Add Sv57 page table support
      Update the Icicle Kit device tree
      RISC-V: Provide a fraemework for RISC-V ISA extensions
      perf: RISC-V: Add support for SBI PMU and Sscofpmf
      RISC-V: add support for restartable sequences

Qinglin Pan (4):
      riscv: mm: Control p4d's folding by pgtable_l5_enabled
      riscv: mm: Prepare pt_ops helper functions for sv57
      riscv: mm: Set sv57 on defaultly
      riscv: mm: Support kasan for sv57

Tsukasa OI (3):
      RISC-V: Correctly print supported extensions
      RISC-V: Minimal parser for "riscv, isa" strings
      RISC-V: Extract multi-letter extension names from "riscv, isa"

Vincent Chen (2):
      RISC-V: Add support for restartable sequence
      rseq/selftests: Add support for RISC-V

 .../devicetree/bindings/clock/microchip,mpfs.yaml  |  58 ++
 .../bindings/gpio/microchip,mpfs-gpio.yaml         |  79 +++
 ...oc-mailbox.yaml => microchip,mpfs-mailbox.yaml} |   6 +-
 .../devicetree/bindings/pwm/microchip,corepwm.yaml |  81 +++
 .../bindings/rtc/microchip,mfps-rtc.yaml           |  58 ++
 .../microchip/microchip,mpfs-sys-controller.yaml   |  40 ++
 .../microchip,polarfire-soc-sys-controller.yaml    |  35 -
 Documentation/riscv/pmu.rst                        | 255 -------
 MAINTAINERS                                        |  11 +
 arch/riscv/Kconfig                                 |  18 +-
 .../boot/dts/microchip/microchip-mpfs-fabric.dtsi  |  25 +
 .../dts/microchip/microchip-mpfs-icicle-kit.dts    | 115 ++-
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi  | 254 +++++--
 arch/riscv/configs/defconfig                       |   1 +
 arch/riscv/configs/rv32_defconfig                  |   1 +
 arch/riscv/include/asm/csr.h                       |  67 +-
 arch/riscv/include/asm/fixmap.h                    |   1 +
 arch/riscv/include/asm/hwcap.h                     |  26 +
 arch/riscv/include/asm/page.h                      |   1 +
 arch/riscv/include/asm/perf_event.h                |  72 --
 arch/riscv/include/asm/pgalloc.h                   |  49 ++
 arch/riscv/include/asm/pgtable-64.h                | 106 ++-
 arch/riscv/include/asm/pgtable.h                   |   6 +-
 arch/riscv/include/asm/sbi.h                       |  95 +++
 arch/riscv/kernel/Makefile                         |   1 -
 arch/riscv/kernel/cpu.c                            |  70 +-
 arch/riscv/kernel/cpufeature.c                     | 130 +++-
 arch/riscv/kernel/entry.S                          |   4 +
 arch/riscv/kernel/perf_event.c                     | 485 -------------
 arch/riscv/kernel/signal.c                         |   2 +
 arch/riscv/lib/memmove.S                           | 368 ++++++++--
 arch/riscv/mm/init.c                               | 168 ++++-
 arch/riscv/mm/kasan_init.c                         | 155 +++-
 drivers/perf/Kconfig                               |  30 +
 drivers/perf/Makefile                              |   3 +
 drivers/perf/riscv_pmu.c                           | 324 +++++++++
 drivers/perf/riscv_pmu_legacy.c                    | 142 ++++
 drivers/perf/riscv_pmu_sbi.c                       | 790 +++++++++++++++++++++
 include/dt-bindings/clock/microchip,mpfs-clock.h   |  45 ++
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/perf/riscv_pmu.h                     |  75 ++
 tools/testing/selftests/rseq/param_test.c          |  23 +
 tools/testing/selftests/rseq/rseq-riscv.h          | 677 ++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h                |   2 +
 44 files changed, 3900 insertions(+), 1055 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
 rename Documentation/devicetree/bindings/mailbox/{microchip,polarfire-soc-mailbox.yaml => microchip,mpfs-mailbox.yaml} (82%)
 create mode 100644 Documentation/devicetree/bindings/pwm/microchip,corepwm.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/microchip,mfps-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml
 delete mode 100644 Documentation/riscv/pmu.rst
 create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-fabric.dtsi
 delete mode 100644 arch/riscv/kernel/perf_event.c
 create mode 100644 drivers/perf/riscv_pmu.c
 create mode 100644 drivers/perf/riscv_pmu_legacy.c
 create mode 100644 drivers/perf/riscv_pmu_sbi.c
 create mode 100644 include/dt-bindings/clock/microchip,mpfs-clock.h
 create mode 100644 include/linux/perf/riscv_pmu.h
 create mode 100644 tools/testing/selftests/rseq/rseq-riscv.h
