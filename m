Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619504EFA2D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351409AbiDASyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiDASyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:54:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6551320D534
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:52:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso3343505pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=RZh9juZoTBIiX8Bbm6BhqUlYnUH2sVezQDviTshosWQ=;
        b=KqeGgMYZGarYqqjGcQIrPA003P1ZIuxKr7TVaXW0hwX4dqooYiu1ld6ojGHBnsYs9O
         mfOM9ynyZHNuizb4njWm3y2fsoeXnjJ2uVxn/w48hibGCc2B9iI9SgiIunz+0+RygirC
         AExJMIgtCt1v8ZUGN+6Ie4guFa5YR3ixPCcutmiBboezJDup5dyFn2/tRZFG2SB7I+2X
         kJ0hHsULJ4V8Veu+R6uy6BsF+K3BDIucP52hNU3GEU+phBcFS+VbCXNnDP6rQcVD15bc
         PABZXTnvdf4vLDRBMzfwbHS5fTP/1JUMXSeG9cV6EN2efFQkUN5x8+ayI3SS7Yaxuxjy
         TQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=RZh9juZoTBIiX8Bbm6BhqUlYnUH2sVezQDviTshosWQ=;
        b=r4X0f/BzRNnbmQVUpTNcMI84B7CaZccE0ZLYDIn2h3KY9MAQ9YV8UzEJAZjVYzVUa3
         SBExT8BjxNjlU/NNiPlrvsdrB/H3jfe3ZQ4ASM/HnsPg75tN8wdw23ZNqL+/F4FIvljX
         tTcPU1Jo0cJ/I44RoZivrj3l0JZdgVKmUKCWbsChHhcrUp3mL7Y/v3yS96b3fhNxuLqe
         G6uiXXRHE1CN2OHm2ApBfntGI4eCKzYAeNoqXMaVogRndKBBC7zzf0n0YqZP7Q5ypNe0
         8/TqYSu6qInbPzx8894J+B5VqkXcKJC0xS0jUiwZgCeejRz8LqXlhI35O6qV5Nq6JohH
         7MMw==
X-Gm-Message-State: AOAM5313kCRJKWR8Za5ZbFpaBfFy7RYC3ZKPBEJ1eY/KPJ5L9YKOf94r
        tBR1+zyRwZyGo/8lbPbVUn/ZNg==
X-Google-Smtp-Source: ABdhPJxmld77bZzTpbPVjEqpwLqj1nPBaAAoFsJdqPumduG+x4HHCC2BOkspRl2Sk2WmeaTUH2oijg==
X-Received: by 2002:a17:902:f544:b0:153:bb8a:9374 with SMTP id h4-20020a170902f54400b00153bb8a9374mr11846581plf.154.1648839152814;
        Fri, 01 Apr 2022 11:52:32 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id pj9-20020a17090b4f4900b001c744034e7csm14674887pjb.2.2022.04.01.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 11:52:32 -0700 (PDT)
Date:   Fri, 01 Apr 2022 11:52:32 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Apr 2022 11:52:28 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.18 Merge Window, Part 2
In-Reply-To: <mhng-e0c01ab7-020f-4264-91da-0852f7e89534@palmer-mbp2014>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>, robh+dt@kernel.org
Message-ID: <mhng-149533f0-8756-4510-9724-e8e61f2e62c5@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Apr 2022 09:41:50 PDT (-0700), Palmer Dabbelt wrote:
> merged tag 'riscv-for-linus-5.18-mw0'
> The following changes since commit aa5b537b0ecc16992577b013f11112d54c7ce869:
>
>   Merge tag 'riscv-for-linus-5.18-mw0' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2022-03-25 10:11:38 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-mw1
>
> for you to fetch changes up to 1464d00b27b2e29a5556f6a4099cf083886e883f:
>
>   RISC-V: K210 defconfigs: Drop redundant MEMBARRIER=n (2022-03-31 17:19:27 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 5.18 Merge Window, Part 2
>
> This has a handful of new features
>
> * Support for CURRENT_STACK_POINTER, which enables some extra stack
>   debugging for HARDENED_USERCOPY.
> * Support for the new SBI CPU idle extension, via cpuidle and suspend
>   drivers.

Sorry, looks like there are some issues with this series that Rob 
pointed out.  I'm going to re-spin this PR without those, unfortunately 
they're towards the beginning.

> * Profiling has been enabled in the defconfigs.
>
> but is mostly fixes and cleanups.
>
> ----------------------------------------------------------------
> There are no merge conflicts.  I'm getting on allyesconfig warning in
> drivers/misc/habanalabs, but that appears to just be a 32-bit problem (it's
> happening on 32-bit x86 as well).  I've sent a patch for that, but I doubt it's
> a RISC-V issue so I'm sending this at the same time.
>
> With that patch I get clean build that boot after my test merge.
>
> ----------------------------------------------------------------
> Anup Patel (9):
>       RISC-V: Enable CPU_IDLE drivers
>       RISC-V: Rename relocate() and make it global
>       RISC-V: Add arch functions for non-retentive suspend entry/exit
>       RISC-V: Add SBI HSM suspend related defines
>       cpuidle: Factor-out power domain related code from PSCI domain driver
>       cpuidle: Add RISC-V SBI CPU idle driver
>       dt-bindings: Add common bindings for ARM and RISC-V idle states
>       RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
>       RISC-V: Enable profiling by default
>
> Atish Patra (2):
>       RISC-V: Fix a comment typo in riscv_of_parent_hartid()
>       RISC-V: Declare per cpu boot data as static
>
> Bagas Sanjaya (1):
>       Documentation: riscv: remove non-existent directory from table of contents
>
> Dmitry Vyukov (1):
>       riscv: Increase stack size under KASAN
>
> Fangrui Song (1):
>       riscv module: remove (NOLOAD)
>
> Kees Cook (1):
>       riscv: Rename "sp_in_global" to "current_stack_pointer"
>
> Nikita Shubin (1):
>       riscv: Fix fill_callchain return value
>
> Niklas Cassel (1):
>       riscv: dts: canaan: Fix SPI3 bus width
>
> Palmer Dabbelt (3):
>       RISC-V CPU Idle Support
>       RISC-V: defconfig: Drop redundant SBI HVC and earlycon
>       RISC-V: K210 defconfigs: Drop redundant MEMBARRIER=n
>
> Randy Dunlap (1):
>       riscv: cpu.c: don't use kernel-doc markers for comments
>
> Wu Caize (1):
>       RISC-V: module: fix apply_r_riscv_rcv_branch_rela typo
>
>  .../bindings/arm/msm/qcom,idle-state.txt           |   2 +-
>  Documentation/devicetree/bindings/arm/psci.yaml    |   2 +-
>  .../bindings/{arm => cpu}/idle-states.yaml         | 228 +++++++-
>  Documentation/devicetree/bindings/riscv/cpus.yaml  |   6 +
>  Documentation/riscv/index.rst                      |   1 -
>  MAINTAINERS                                        |  14 +
>  arch/riscv/Kconfig                                 |   8 +
>  arch/riscv/Kconfig.socs                            |   3 +
>  arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts     |   2 +
>  arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts    |   2 +
>  arch/riscv/boot/dts/canaan/sipeed_maix_go.dts      |   2 +
>  arch/riscv/boot/dts/canaan/sipeed_maixduino.dts    |   2 +
>  arch/riscv/configs/defconfig                       |   5 +-
>  arch/riscv/configs/nommu_k210_defconfig            |   1 -
>  arch/riscv/configs/nommu_k210_sdcard_defconfig     |   1 -
>  arch/riscv/configs/nommu_virt_defconfig            |   1 -
>  arch/riscv/configs/rv32_defconfig                  |   5 +-
>  arch/riscv/include/asm/asm.h                       |  26 +
>  arch/riscv/include/asm/cpuidle.h                   |  24 +
>  arch/riscv/include/asm/current.h                   |   2 +
>  arch/riscv/include/asm/module.lds.h                |   6 +-
>  arch/riscv/include/asm/suspend.h                   |  36 ++
>  arch/riscv/include/asm/thread_info.h               |  10 +-
>  arch/riscv/kernel/Makefile                         |   2 +
>  arch/riscv/kernel/asm-offsets.c                    |   3 +
>  arch/riscv/kernel/cpu.c                            |   6 +-
>  arch/riscv/kernel/cpu_ops_sbi.c                    |   2 +-
>  arch/riscv/kernel/head.S                           |  27 +-
>  arch/riscv/kernel/module.c                         |   4 +-
>  arch/riscv/kernel/perf_callchain.c                 |   2 +-
>  arch/riscv/kernel/process.c                        |   3 +-
>  arch/riscv/kernel/stacktrace.c                     |   6 +-
>  arch/riscv/kernel/suspend.c                        |  87 +++
>  arch/riscv/kernel/suspend_entry.S                  | 124 ++++
>  drivers/cpuidle/Kconfig                            |   9 +
>  drivers/cpuidle/Kconfig.arm                        |   1 +
>  drivers/cpuidle/Kconfig.riscv                      |  15 +
>  drivers/cpuidle/Makefile                           |   5 +
>  drivers/cpuidle/cpuidle-psci-domain.c              | 138 +----
>  drivers/cpuidle/cpuidle-psci.h                     |  15 +-
>  drivers/cpuidle/cpuidle-riscv-sbi.c                | 627 +++++++++++++++++++++
>  drivers/cpuidle/dt_idle_genpd.c                    | 178 ++++++
>  drivers/cpuidle/dt_idle_genpd.h                    |  50 ++
>  43 files changed, 1491 insertions(+), 202 deletions(-)
>  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
>  create mode 100644 arch/riscv/include/asm/cpuidle.h
>  create mode 100644 arch/riscv/include/asm/suspend.h
>  create mode 100644 arch/riscv/kernel/suspend.c
>  create mode 100644 arch/riscv/kernel/suspend_entry.S
>  create mode 100644 drivers/cpuidle/Kconfig.riscv
>  create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
>  create mode 100644 drivers/cpuidle/dt_idle_genpd.c
>  create mode 100644 drivers/cpuidle/dt_idle_genpd.h
