Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EC8492E18
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 20:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbiARTEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 14:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiARTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:04:11 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:04:10 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so460771pjj.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 11:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=biey1FXuSLp9uMBbNSRcmdkFvKVYavrrZd8/2A1pbn8=;
        b=DXZ0LebVjSdYseM6kIv4sfk4jVgqlhaax0/RLb6tlUcxHMaArRZPMTsRg+UPxtgFGN
         vWHo/HDdAl8t+x/PcIIZaiE3lrpoSyRCdX/fvlNtn8dbTVbejPeJuqbyOq8/CkAX3RVp
         psncXlsH8d7UE1VCH+1UIp6GuymWqOqyx5dFjkqRTO60G+2aEPN25ugIGZKQsjjG/KR6
         pQ7MBUWxEBP0zCpUagB0I8C6N0DRsuXcU4CX4aTmL71EXDl8nLPfbAfACGPufKh0kXO7
         7h0gpe+sQnlPkT0broTg5biJut0DHUvLsOGTDIL/FkO1FD0l2n7YJYg5wkwn9zgQG25+
         9oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=biey1FXuSLp9uMBbNSRcmdkFvKVYavrrZd8/2A1pbn8=;
        b=piwLlARNiojp2QZDBd714+L/JT5hls18y/j5BF+MaNSo7lamA9R/uF15r2tuCUyCxm
         Nqy7izPTysOExvQUXd24HlyRUJywZcy92xf4Rjs6/bPHZrnMESFB/1O6ElO3/j4sA0Tk
         Jp4ygmvKYHrcCa9CnWDzQVfWJIiu27Jca1fiKSZX49oPda1y53+5SrMPY0AW2EjmuWrN
         SGxCAJym857mz64RELcn3jMk2CRmp/QBlQpI4Pt5esBxc5RS8hEi+a8uLydUVETAHtHK
         uv3ILJWXjYnLflyfPp/PX7sy0C6bH/OuFvYxapD7uHcHk4xSGfjChXaECqWtoAsPoB2e
         Opxg==
X-Gm-Message-State: AOAM532l3gKa9MCn0ia0UsZ/MazbgERNC0G3vXYRZzVVSrtoFm7dxvlE
        sWNNGSl10PyMFB4JAYA+Gh3JqTxtj1CYfA==
X-Google-Smtp-Source: ABdhPJxwgZp+Zn/HYJt5qkQv4jJyaKwIEjE1mQa3AtSN1fo5wMdMX8GzBZm5mamuGqbiEQai+xBSlg==
X-Received: by 2002:a17:90a:b018:: with SMTP id x24mr21584898pjq.150.1642532650094;
        Tue, 18 Jan 2022 11:04:10 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k9sm15738796pgr.47.2022.01.18.11.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:04:09 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:04:09 -0800 (PST)
X-Google-Original-Date: Tue, 18 Jan 2022 11:03:29 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for the 5.17 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-d9275aee-84cd-428e-8732-adfa59900a9d@palmer-ri-x1c9>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-mw0

for you to fetch changes up to b579dfe71a6a5c3967ca9ad648673b6ca10ab0d5:

  RISC-V: Use SBI SRST extension when available (2022-01-11 10:25:43 -0800)

----------------------------------------------------------------
RISC-V Patches for the 5.17 Merge Window, Part 1

* Support for the DA9063 as used on the HiFive Unmatched.
* Support for relative extables, which puts us in line with other
  architectures and save some space in vmlinux.
* A handful of kexec fixes/improvements, including the ability to run
  crash kernels from PCI-addressable memory on the HiFive Unmatched.
* Support for the SBI SRST extension, which allows systems that do not
  have an explicit driver in Linux to reboot.
* A handful of fixes and cleanups, including to the defconfigs and
  device trees.

---
This time I do expect to have a part 2, as there's still some smaller
patches on the list.  I was hoping to get through more of that over the
weekend, but I got distracted with the ABI issues.  Figured it's better
to send this sooner rather than waiting.

Included are my merge resolutions against a master from this morning, if
that helps any:

diff --cc arch/riscv/include/asm/sbi.h
index 289621da4a2a,9c46dd3ff4a2..000000000000
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@@ -27,7 -27,14 +27,15 @@@ enum sbi_ext_id
        SBI_EXT_IPI = 0x735049,
        SBI_EXT_RFENCE = 0x52464E43,
        SBI_EXT_HSM = 0x48534D,
 +      SBI_EXT_SRST = 0x53525354,
+
+       /* Experimentals extensions must lie within this range */
+       SBI_EXT_EXPERIMENTAL_START = 0x08000000,
+       SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
+
+       /* Vendor extensions must lie within this range */
+       SBI_EXT_VENDOR_START = 0x09000000,
+       SBI_EXT_VENDOR_END = 0x09FFFFFF,
  };

  enum sbi_ext_base_fid {
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index e03a4c94cf3f..6bfa1f24d3de 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -188,14 +188,6 @@ vdd_ldo11: ldo11 {
                                regulator-always-on;
                        };
                };
-
-               rtc {
-                       compatible = "dlg,da9063-rtc";
-               };
-
-               wdt {
-                       compatible = "dlg,da9063-watchdog";
-               };
        };
 };

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Make vmalloc/vmemmap end equal to the start of the next region

Anup Patel (1):
      RISC-V: Use SBI SRST extension when available

Aurelien Jarno (1):
      riscv: dts: enable more DA9063 functions for the SiFive HiFive Unmatched

Geert Uytterhoeven (11):
      riscv: dts: canaan: Fix SPI FLASH node names
      riscv: dts: canaan: Group tuples in interrupt properties
      riscv: dts: microchip: mpfs: Drop empty chosen node
      riscv: dts: microchip: mpfs: Fix PLIC node
      riscv: dts: microchip: mpfs: Fix reference clock node
      riscv: dts: microchip: mpfs: Fix clock controller node
      riscv: dts: microchip: mpfs: Group tuples in interrupt properties
      riscv: dts: sifive: Group tuples in interrupt properties
      riscv: dts: sifive: Group tuples in register properties
      riscv: dts: sifive: fu540-c000: Drop bogus soc node compatible values
      riscv: dts: sifive: fu540-c000: Fix PLIC node

Jisheng Zhang (17):
      riscv: remove unused __cmpxchg_user() macro
      riscv: consolidate __ex_table construction
      riscv: switch to relative exception tables
      riscv: bpf: move rv_bpf_fixup_exception signature to extable.h
      riscv: extable: make fixup_exception() return bool
      riscv: extable: use `ex` for `exception_table_entry`
      riscv: lib: uaccess: fold fixups into body
      riscv: extable: consolidate definitions
      riscv: extable: add `type` and `data` fields
      riscv: add gpr-num.h
      riscv: extable: add a dedicated uaccess handler
      riscv: vmlinux.lds.S|vmlinux-xip.lds.S: remove `.fixup` section
      riscv: remove cpu_stop()
      riscv: head: make secondary_start_common() static
      riscv: errata: alternative: mark vendor_patch_func __initdata
      riscv: head: remove useless __PAGE_ALIGNED_BSS and .balign
      riscv: mm: fix wrong phys_ram_base value for RV64

Kefeng Wang (1):
      riscv: mm: Enable PMD split page table lock for RV64

Mark Rutland (1):
      scripts/sorttable: Unify arm64 & x86 sort functions

Nanyong Sun (2):
      riscv/mm: Adjust PAGE_PROT_NONE to comply with THP semantics
      riscv/mm: Enable THP migration

Nick Kossifidis (3):
      riscv: Don't use va_pa_offset on kdump
      riscv: use hart id instead of cpu id on machine_kexec
      riscv: try to allocate crashkern region from 32bit addressible memory

Palmer Dabbelt (14):
      riscv: switch to relative extable and other improvements
      RISC-V: defconfigs: Set CONFIG_FB=y, for FB console
      RISC-V: MAXPHYSMEM_2GB doesn't depend on CMODEL_MEDLOW
      RISC-V: defconfigs: Sort CONFIG_BPF_SYSCALL
      RISC-V: defconfigs: Sort CONFIG_SYSFS_SYSCALL
      RISC-V: defconfigs: Sort CONFIG_SOC_POLARFIRE
      RISC-V: defconfigs: Sort CONFIG_PTP_1588_CLOCK
      RISC-V: defconfigs: Sort CONFIG_MMC
      RISC-V: defconfigs: Sort CONFIG_SURFACE_PLATFORMS
      RISC-V: defconfigs: Sort CONFIG_BLK_DEV_BSG
      RISC-V: defconfigs: Remove redundant CONFIG_POWER_RESET
      RISC-V: defconfigs: Remove redundant CONFIG_EFI=y
      RISC-V: defconfigs: Remove redundant K210 DT source
      RISC-V: Clean up the defconfigs

Sean Christopherson (1):
      RISC-V: Use common riscv_cpuid_to_hartid_mask() for both SMP=y and SMP=n

hasheddan (1):
      riscv/head: fix misspelling of guaranteed

 arch/riscv/Kconfig                                 |   4 +-
 arch/riscv/boot/dts/canaan/k210.dtsi               |  23 +--
 arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts     |   2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts    |   2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts      |   2 +-
 arch/riscv/boot/dts/canaan/sipeed_maixduino.dts    |   2 +-
 .../dts/microchip/microchip-mpfs-icicle-kit.dts    |   4 +
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi  |  60 +++-----
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi         |  40 ++---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi         |  14 +-
 .../riscv/boot/dts/sifive/hifive-unmatched-a00.dts |  12 ++
 arch/riscv/configs/defconfig                       |  13 +-
 arch/riscv/configs/nommu_k210_defconfig            |   2 -
 arch/riscv/configs/nommu_k210_sdcard_defconfig     |   3 -
 arch/riscv/configs/nommu_virt_defconfig            |   1 -
 arch/riscv/configs/rv32_defconfig                  |   6 +-
 arch/riscv/errata/alternative.c                    |   3 +-
 arch/riscv/include/asm/Kbuild                      |   1 -
 arch/riscv/include/asm/asm-extable.h               |  65 ++++++++
 arch/riscv/include/asm/extable.h                   |  48 ++++++
 arch/riscv/include/asm/futex.h                     |  30 +---
 arch/riscv/include/asm/gpr-num.h                   |  77 ++++++++++
 arch/riscv/include/asm/pgtable-bits.h              |   2 +-
 arch/riscv/include/asm/pgtable.h                   |  20 ++-
 arch/riscv/include/asm/sbi.h                       |  24 +++
 arch/riscv/include/asm/smp.h                       |  12 +-
 arch/riscv/include/asm/uaccess.h                   | 163 +++------------------
 arch/riscv/kernel/cpu-hotplug.c                    |   8 +-
 arch/riscv/kernel/head.S                           |  11 +-
 arch/riscv/kernel/kexec_relocate.S                 |  20 ++-
 arch/riscv/kernel/machine_kexec.c                  |   3 +-
 arch/riscv/kernel/sbi.c                            |  35 +++++
 arch/riscv/kernel/setup.c                          |  10 ++
 arch/riscv/kernel/smp.c                            |  10 --
 arch/riscv/kernel/vmlinux-xip.lds.S                |   1 -
 arch/riscv/kernel/vmlinux.lds.S                    |   3 +-
 arch/riscv/lib/uaccess.S                           |  28 ++--
 arch/riscv/mm/extable.c                            |  66 +++++++--
 arch/riscv/mm/fault.c                              |   2 +-
 arch/riscv/mm/init.c                               |  22 ++-
 arch/riscv/net/bpf_jit_comp64.c                    |   9 +-
 scripts/mod/modpost.c                              |  15 ++
 scripts/sorttable.c                                |  38 +----
 43 files changed, 524 insertions(+), 392 deletions(-)
 create mode 100644 arch/riscv/include/asm/asm-extable.h
 create mode 100644 arch/riscv/include/asm/extable.h
 create mode 100644 arch/riscv/include/asm/gpr-num.h
