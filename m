Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA574EF85D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349987AbiDAQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350068AbiDAQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:52:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D535FBB092
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:41:50 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so5770702pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=7f6j0z1BP2YZI8+G8t2I0PO2IUnoEVp389XAIMLoiBI=;
        b=B5MLssde5G3aFHKLWrw2bfzfhMbch92H4uyalWdGGwDvxnn6VjCCTrYcJz8K9TljT9
         9uqV4/v7fPjUUP9dVZXbJtj3JJIsGQO0+819dndJ9iV7yC9M7s32U9e6i++crdEJfbHT
         e3Gaeet+Ezf5YVxpgpWtvqT0N/U5AqOcVHpxFpx5UR4IWe7061cI0WExmozTbV8FkT9F
         PC6IfbS8wLaxp7fgLk/EeZVvVMEUJqswxpQEkY6d4oz2nIDDijdB0Aqulgdl+tnUOaPr
         ihSLtsdeVGolXwA+l2EBKScB72d2U+Vv8T01fe8gAbFUd+Qp9xK75Ub+zCPpkoWUxeOs
         L9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=7f6j0z1BP2YZI8+G8t2I0PO2IUnoEVp389XAIMLoiBI=;
        b=JX3UQOBqsG/qwZG0xoMd++JogNJjLOWPUMSv2/s9q86WE5zTR9/O/g/qZLp6ltjmHH
         bSlCLq5zBkWr7HvsyeWdLqirlHjLDn0pflU3PA1TlNivXxSLZ9OQuTqvC81z6EJPs4sv
         fr4DBL7J4WntJRp6SBtIxXhtO4Mx1T8pXZqx83RpjJcPTfrrQs4eL6+pHMh9RMOXjS2d
         7wgL+vlAUbEjGeH7MsLYh9R7HHQTGpZQ0R+WCli9byInWp/PUaNnfQkh1yTXGDXLtQ6v
         Xv0o6JfIyCHBnvXL6BpaoXJCUcSt3jV/gKaCm0Rmfj0TizXpwAEBomHsba97HI0gY1ap
         xoPw==
X-Gm-Message-State: AOAM532QYKh7KzUR8cy2vOM6sKzhcIZD3Yt9npspZVp5LVJoaTk4K5DR
        6JANg9hM0OVhgBA3r0NUdqjmvlSICw/YHg==
X-Google-Smtp-Source: ABdhPJxudcPgn55zLsGqr1hRo6Bevhqgl+MiYPI62e8CER1amNlGuSkHdMOGj+0wuEtAiqFtl8MIOQ==
X-Received: by 2002:a17:90a:205:b0:1c6:5b78:5c5 with SMTP id c5-20020a17090a020500b001c65b7805c5mr12729560pjc.54.1648831310254;
        Fri, 01 Apr 2022 09:41:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j16-20020a63e750000000b00373598b8cbfsm2862869pgk.74.2022.04.01.09.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 09:41:50 -0700 (PDT)
Date:   Fri, 01 Apr 2022 09:41:50 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Apr 2022 09:41:27 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.18 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-e0c01ab7-020f-4264-91da-0852f7e89534@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-5.18-mw0'
The following changes since commit aa5b537b0ecc16992577b013f11112d54c7ce869:

  Merge tag 'riscv-for-linus-5.18-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2022-03-25 10:11:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-mw1

for you to fetch changes up to 1464d00b27b2e29a5556f6a4099cf083886e883f:

  RISC-V: K210 defconfigs: Drop redundant MEMBARRIER=n (2022-03-31 17:19:27 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.18 Merge Window, Part 2

This has a handful of new features

* Support for CURRENT_STACK_POINTER, which enables some extra stack
  debugging for HARDENED_USERCOPY.
* Support for the new SBI CPU idle extension, via cpuidle and suspend
  drivers.
* Profiling has been enabled in the defconfigs.

but is mostly fixes and cleanups.

----------------------------------------------------------------
There are no merge conflicts.  I'm getting on allyesconfig warning in
drivers/misc/habanalabs, but that appears to just be a 32-bit problem (it's
happening on 32-bit x86 as well).  I've sent a patch for that, but I doubt it's
a RISC-V issue so I'm sending this at the same time.

With that patch I get clean build that boot after my test merge.

----------------------------------------------------------------
Anup Patel (9):
      RISC-V: Enable CPU_IDLE drivers
      RISC-V: Rename relocate() and make it global
      RISC-V: Add arch functions for non-retentive suspend entry/exit
      RISC-V: Add SBI HSM suspend related defines
      cpuidle: Factor-out power domain related code from PSCI domain driver
      cpuidle: Add RISC-V SBI CPU idle driver
      dt-bindings: Add common bindings for ARM and RISC-V idle states
      RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
      RISC-V: Enable profiling by default

Atish Patra (2):
      RISC-V: Fix a comment typo in riscv_of_parent_hartid()
      RISC-V: Declare per cpu boot data as static

Bagas Sanjaya (1):
      Documentation: riscv: remove non-existent directory from table of contents

Dmitry Vyukov (1):
      riscv: Increase stack size under KASAN

Fangrui Song (1):
      riscv module: remove (NOLOAD)

Kees Cook (1):
      riscv: Rename "sp_in_global" to "current_stack_pointer"

Nikita Shubin (1):
      riscv: Fix fill_callchain return value

Niklas Cassel (1):
      riscv: dts: canaan: Fix SPI3 bus width

Palmer Dabbelt (3):
      RISC-V CPU Idle Support
      RISC-V: defconfig: Drop redundant SBI HVC and earlycon
      RISC-V: K210 defconfigs: Drop redundant MEMBARRIER=n

Randy Dunlap (1):
      riscv: cpu.c: don't use kernel-doc markers for comments

Wu Caize (1):
      RISC-V: module: fix apply_r_riscv_rcv_branch_rela typo

 .../bindings/arm/msm/qcom,idle-state.txt           |   2 +-
 Documentation/devicetree/bindings/arm/psci.yaml    |   2 +-
 .../bindings/{arm => cpu}/idle-states.yaml         | 228 +++++++-
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   6 +
 Documentation/riscv/index.rst                      |   1 -
 MAINTAINERS                                        |  14 +
 arch/riscv/Kconfig                                 |   8 +
 arch/riscv/Kconfig.socs                            |   3 +
 arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts     |   2 +
 arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts    |   2 +
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts      |   2 +
 arch/riscv/boot/dts/canaan/sipeed_maixduino.dts    |   2 +
 arch/riscv/configs/defconfig                       |   5 +-
 arch/riscv/configs/nommu_k210_defconfig            |   1 -
 arch/riscv/configs/nommu_k210_sdcard_defconfig     |   1 -
 arch/riscv/configs/nommu_virt_defconfig            |   1 -
 arch/riscv/configs/rv32_defconfig                  |   5 +-
 arch/riscv/include/asm/asm.h                       |  26 +
 arch/riscv/include/asm/cpuidle.h                   |  24 +
 arch/riscv/include/asm/current.h                   |   2 +
 arch/riscv/include/asm/module.lds.h                |   6 +-
 arch/riscv/include/asm/suspend.h                   |  36 ++
 arch/riscv/include/asm/thread_info.h               |  10 +-
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/asm-offsets.c                    |   3 +
 arch/riscv/kernel/cpu.c                            |   6 +-
 arch/riscv/kernel/cpu_ops_sbi.c                    |   2 +-
 arch/riscv/kernel/head.S                           |  27 +-
 arch/riscv/kernel/module.c                         |   4 +-
 arch/riscv/kernel/perf_callchain.c                 |   2 +-
 arch/riscv/kernel/process.c                        |   3 +-
 arch/riscv/kernel/stacktrace.c                     |   6 +-
 arch/riscv/kernel/suspend.c                        |  87 +++
 arch/riscv/kernel/suspend_entry.S                  | 124 ++++
 drivers/cpuidle/Kconfig                            |   9 +
 drivers/cpuidle/Kconfig.arm                        |   1 +
 drivers/cpuidle/Kconfig.riscv                      |  15 +
 drivers/cpuidle/Makefile                           |   5 +
 drivers/cpuidle/cpuidle-psci-domain.c              | 138 +----
 drivers/cpuidle/cpuidle-psci.h                     |  15 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c                | 627 +++++++++++++++++++++
 drivers/cpuidle/dt_idle_genpd.c                    | 178 ++++++
 drivers/cpuidle/dt_idle_genpd.h                    |  50 ++
 43 files changed, 1491 insertions(+), 202 deletions(-)
 rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
 create mode 100644 arch/riscv/include/asm/cpuidle.h
 create mode 100644 arch/riscv/include/asm/suspend.h
 create mode 100644 arch/riscv/kernel/suspend.c
 create mode 100644 arch/riscv/kernel/suspend_entry.S
 create mode 100644 drivers/cpuidle/Kconfig.riscv
 create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.c
 create mode 100644 drivers/cpuidle/dt_idle_genpd.h
