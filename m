Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B4A4EF9FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351287AbiDASkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245002AbiDASkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:40:51 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1665849267
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:39:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u12so990234plg.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=UUpRwvWU3uzIY9akgrfvRv+/WSVKa7HyF5aV+QFu1po=;
        b=IgF2TA1aF0OrplQ/Rawp8uU8q4QN2pNzNwlx+f/PMkcIsNy7NJI+tskgwXrtHvGWpV
         lVb09x84BNcnvWV0A2U0lmP8OCuteY7vNH6e/50LdGp3QR1E/rKRUk0ssKfxMB2/XvCN
         CLqGBi78pFJ1maXIC7WECr6eWriKvTdJfA++ZZt88SceW3y3c1teh46gcZVIJutkqt6u
         Digoj2qDqmOrdf11I/UX/sZD1329puBY/vRAM3ZICYDneBGohnWsnRcMmUrH4dM0dwkv
         XmdG9hGBE4NENsrWLQsoUXem67qr+azG/54BR4CrkLO8IqCZFfS2jBna9kmNgWT9XUI8
         nxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=UUpRwvWU3uzIY9akgrfvRv+/WSVKa7HyF5aV+QFu1po=;
        b=abRBd1d6kkcO9hp80RVQxpdc1N2eV7ZBiFtxjTrwqhBeQkZ6lCbh3ewEygX6h0UZa+
         q32oPR2poS2nQyy8M3n8AanE2bd2LGnUctj9rxEMmBXPCGyQJrtcUCQz4VgeDMsLI+cO
         8DEDNQc9dj9G3ksErQ/eMFtcEKcj8UOzaJuwaCtYcBhZ1ansjlS/Nc4btYNKFbsSf4cM
         hVKWzn/zKVTJoSdZjefvHtjKTZff/XBZPw1xVgXfV+C9sOhY6AEr/Y02A5s8gtVUZRtO
         xY6wFBgZDVFTYIr3HsmuxvdYPvtsuy9+X+QGdmbUP5RrGsndPSzispl5aschDl3ovxYj
         pSVA==
X-Gm-Message-State: AOAM531kXIawMdeEVqW6DL2ZoNDY/+vTZehDTVqY3JTgtjtrkKy9Hlgp
        uZ5H1uYKLcbUUiO3aYHZ+0RyAw==
X-Google-Smtp-Source: ABdhPJzAjjzA6zKZ0LzuSBwarhjN+Kc2YYfhvv4EFoVHW53bpNwlQdMXNmPYHLdTOvXTpseMGnv7JA==
X-Received: by 2002:a17:90b:1201:b0:1c9:ec7a:7f5c with SMTP id gl1-20020a17090b120100b001c9ec7a7f5cmr13345048pjb.101.1648838339427;
        Fri, 01 Apr 2022 11:38:59 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a0015ce00b004fab49cd65csm3699896pfu.205.2022.04.01.11.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 11:38:58 -0700 (PDT)
Date:   Fri, 01 Apr 2022 11:38:58 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Apr 2022 11:38:57 PDT (-0700)
Subject:     Re: [PATCH v11 0/8] RISC-V CPU Idle Support
In-Reply-To: <CAL_JsqJm7kz1LTrTBMB3rd-K48e2584v6Nn3LwmnLzH8rk_D2w@mail.gmail.com>
CC:     apatel@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        ulf.hansson@linaro.org, rjw@rjwysocki.net, pavel@ucw.cz,
        milun.tripathy@gmail.com, atishp@atishpatra.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        liush@allwinnertech.com, anup@brainfault.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvm-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     robh+dt@kernel.org
Message-ID: <mhng-dda0f137-102d-480e-a67c-34eb713a24b1@palmer-mbp2014>
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

On Fri, 01 Apr 2022 11:13:32 PDT (-0700), robh+dt@kernel.org wrote:
> On Wed, Mar 30, 2022 at 7:16 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Wed, 09 Feb 2022 21:49:39 PST (-0800), apatel@ventanamicro.com wrote:
>> > From: Anup Patel <anup.patel@wdc.com>
>> >
>> > This series adds RISC-V CPU Idle support using SBI HSM suspend function.
>> > The RISC-V SBI CPU idle driver added by this series is highly inspired
>> > from the ARM PSCI CPU idle driver.
>> >
>> > At high-level, this series includes the following changes:
>> > 1) Preparatory arch/riscv patches (Patches 1 to 3)
>> > 2) Defines for RISC-V SBI HSM suspend (Patch 4)
>> > 3) Preparatory patch to share code between RISC-V SBI CPU idle driver
>> >    and ARM PSCI CPU idle driver (Patch 5)
>> > 4) RISC-V SBI CPU idle driver and related DT bindings (Patches 6 to 7)
>> >
>> > These patches can be found in riscv_sbi_hsm_suspend_v11 branch of
>> > https://github.com/avpatel/linux.git
>> >
>> > Special thanks Sandeep Tripathy for providing early feeback on SBI HSM
>> > support in all above projects (RISC-V SBI specification, OpenSBI, and
>> > Linux RISC-V).
>> >
>> > Changes since v10:
>> >  - Rebased on Linux-5.17-rc3
>> >  - Typo fix in commit description of PATCH6
>> >
>> > Changes since v9:
>> >  - Rebased on Linux-5.17-rc1
>> >
>> > Changes since v8:
>> >  - Rebased on Linux-5.15-rc5
>> >  - Fixed DT schema check errors in PATCH7
>> >
>> > Changes since v7:
>> >  - Rebased on Linux-5.15-rc3
>> >  - Renamed cpuidle-sbi.c to cpuidle-riscv-sbi.c in PATCH6
>> >
>> > Changes since v6:
>> >  - Fixed error reported by "make DT_CHECKER_FLAGS=-m dt_binding_check"
>> >
>> > Changes since v5:
>> >  - Rebased on Linux-5.13-rc5
>> >  - Removed unnecessary exports from PATCH5
>> >  - Removed stray ";" from PATCH5
>> >  - Moved sbi_cpuidle_pd_power_off() under "#ifdef CONFIG_DT_IDLE_GENPD"
>> >    in PATCH6
>> >
>> > Changes since v4:
>> >  - Rebased on Linux-5.13-rc2
>> >  - Renamed all dt_idle_genpd functions to have "dt_idle_" prefix
>> >  - Added MAINTAINERS file entry for dt_idle_genpd
>> >
>> > Changes since v3:
>> >  - Rebased on Linux-5.13-rc2
>> >  - Fixed __cpu_resume_enter() which was broken due to XIP kernel support
>> >  - Removed "struct dt_idle_genpd_ops" abstraction which simplifies code
>> >    sharing between ARM PSCI and RISC-V SBI drivers in PATCH5
>> >
>> > Changes since v2:
>> >  - Rebased on Linux-5.12-rc3
>> >  - Updated PATCH7 to add common DT bindings for both ARM and RISC-V
>> >    idle states
>> >  - Added "additionalProperties = false" for both idle-states node and
>> >    child nodes in PATCH7
>> >
>> > Changes since v1:
>> >  - Fixex minor typo in PATCH1
>> >  - Use just "idle-states" as DT node name for CPU idle states
>> >  - Added documentation for "cpu-idle-states" DT property in
>> >    devicetree/bindings/riscv/cpus.yaml
>> >  - Added documentation for "riscv,sbi-suspend-param" DT property in
>> >    devicetree/bindings/riscv/idle-states.yaml
>> >
>> > Anup Patel (8):
>> >   RISC-V: Enable CPU_IDLE drivers
>> >   RISC-V: Rename relocate() and make it global
>> >   RISC-V: Add arch functions for non-retentive suspend entry/exit
>> >   RISC-V: Add SBI HSM suspend related defines
>> >   cpuidle: Factor-out power domain related code from PSCI domain driver
>> >   cpuidle: Add RISC-V SBI CPU idle driver
>> >   dt-bindings: Add common bindings for ARM and RISC-V idle states
>> >   RISC-V: Enable RISC-V SBI CPU Idle driver for QEMU virt machine
>> >
>> >  .../bindings/arm/msm/qcom,idle-state.txt      |   2 +-
>> >  .../devicetree/bindings/arm/psci.yaml         |   2 +-
>> >  .../bindings/{arm => cpu}/idle-states.yaml    | 228 ++++++-
>> >  .../devicetree/bindings/riscv/cpus.yaml       |   6 +
>> >  MAINTAINERS                                   |  14 +
>> >  arch/riscv/Kconfig                            |   7 +
>> >  arch/riscv/Kconfig.socs                       |   3 +
>> >  arch/riscv/configs/defconfig                  |   2 +
>> >  arch/riscv/configs/rv32_defconfig             |   2 +
>> >  arch/riscv/include/asm/asm.h                  |  27 +
>> >  arch/riscv/include/asm/cpuidle.h              |  24 +
>> >  arch/riscv/include/asm/sbi.h                  |  27 +-
>> >  arch/riscv/include/asm/suspend.h              |  36 +
>> >  arch/riscv/kernel/Makefile                    |   2 +
>> >  arch/riscv/kernel/asm-offsets.c               |   3 +
>> >  arch/riscv/kernel/cpu_ops_sbi.c               |   2 +-
>> >  arch/riscv/kernel/head.S                      |  28 +-
>> >  arch/riscv/kernel/process.c                   |   3 +-
>> >  arch/riscv/kernel/suspend.c                   |  87 +++
>> >  arch/riscv/kernel/suspend_entry.S             | 124 ++++
>> >  arch/riscv/kvm/vcpu_sbi_hsm.c                 |   4 +-
>> >  drivers/cpuidle/Kconfig                       |   9 +
>> >  drivers/cpuidle/Kconfig.arm                   |   1 +
>> >  drivers/cpuidle/Kconfig.riscv                 |  15 +
>> >  drivers/cpuidle/Makefile                      |   5 +
>> >  drivers/cpuidle/cpuidle-psci-domain.c         | 138 +---
>> >  drivers/cpuidle/cpuidle-psci.h                |  15 +-
>> >  drivers/cpuidle/cpuidle-riscv-sbi.c           | 627 ++++++++++++++++++
>> >  drivers/cpuidle/dt_idle_genpd.c               | 178 +++++
>> >  drivers/cpuidle/dt_idle_genpd.h               |  50 ++
>> >  30 files changed, 1484 insertions(+), 187 deletions(-)
>> >  rename Documentation/devicetree/bindings/{arm => cpu}/idle-states.yaml (74%)
>> >  create mode 100644 arch/riscv/include/asm/cpuidle.h
>> >  create mode 100644 arch/riscv/include/asm/suspend.h
>> >  create mode 100644 arch/riscv/kernel/suspend.c
>> >  create mode 100644 arch/riscv/kernel/suspend_entry.S
>> >  create mode 100644 drivers/cpuidle/Kconfig.riscv
>> >  create mode 100644 drivers/cpuidle/cpuidle-riscv-sbi.c
>> >  create mode 100644 drivers/cpuidle/dt_idle_genpd.c
>> >  create mode 100644 drivers/cpuidle/dt_idle_genpd.h
>>
>> Thanks, these are on for-next.
>
> For 5.18? You are not supposed to put new material into linux-next
> during the merge window.

Ya, I was aiming for these for 5.18 -- I know it's late, but I'd been 
trying to chase folks around for reviews and figured it was good enough.  
I just sent Linus a PR, it's not merged yet so if this is a problem I 
can re-spin it now.

Sorry!

>
> In any case, this now cause warnings on 'cpu-idle-states':
>
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/cpu/idle-states.example.dtb:
> cpu@0: cpu-idle-states:0: [1, 2, 3, 4] is too long
> From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/cpus.yaml
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/cpu/idle-states.example.dtb:
> cpu@1: cpu-idle-states:0: [1, 2, 3, 4] is too long
> From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/cpus.yaml
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/cpu/idle-states.example.dtb:
> cpu@100: cpu-idle-states:0: [1, 2, 3, 4] is too long
> From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/cpus.yaml
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/cpu/idle-states.example.dtb:
> cpu@101: cpu-idle-states:0: [1, 2, 3, 4] is too long
> From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/cpus.yaml
>
> See commit 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas")
> for how to fix.
>
> Rob
