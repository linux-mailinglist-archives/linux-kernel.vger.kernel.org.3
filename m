Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89CD538661
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbiE3Qwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiE3Qwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:52:44 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C17A775E;
        Mon, 30 May 2022 09:52:43 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-30c1b401711so51927127b3.2;
        Mon, 30 May 2022 09:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SKfptvkUxwMfk/IlJMA5wzd9eIE+N9x3Mg+MDZPogb8=;
        b=pOuvvtTVjWYY9ELT63w+lURVcnghWojFZsKTvb/ITypDrkRbmDe97VjM5k41EjhYnL
         qp8WR6uMRA6Lbl0bxtw2YF7gLzWXogblgaCXRtpF4gfjCtvMyb1iU93SGWFBYou2lg+9
         1aAtoc52HfKyJzr6RL6qQlMRNN8SLk2pNmmPy2OrbCSlULAuLnURrQqlQqVyfG1MbWGS
         Jo76FY7Mn0pGgQI99HPRiOVdn2g6jRvoESVJ45rND2by3T9UDmGyzL/mHYe5fBsWRKG8
         MWP35LWU1CpoJvCjqQJ4scvPJBp/yuKbvVTu/8w+lYsHRW+3jQnHX3ECqdDIPfXBtAdq
         KjEQ==
X-Gm-Message-State: AOAM531/bjZ5do1T4F8sCrr9zBwvCQPFvFKBafvycJoMEkdF9TpFn5SP
        zZ4aVBj8lI63kUbxNPbUytwdbMbbGRZbr7+wwnvMw929x6w=
X-Google-Smtp-Source: ABdhPJzNm+1BBfEDF6cSPCx7vpjf+0qINBPR1xZ1kgGdSiVdl2F57iSoFO7sLXZlEviHeqL4Qk67sd+s0D0XroUiWB8=
X-Received: by 2002:a0d:c442:0:b0:2fe:beab:1fef with SMTP id
 g63-20020a0dc442000000b002febeab1fefmr61019215ywd.196.1653929562908; Mon, 30
 May 2022 09:52:42 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 May 2022 18:52:31 +0200
Message-ID: <CAJZ5v0hJ2X6aR6rLsm2g1ysiYaSvePTwXhE6k5cW-q+8dcLOmA@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.19-rc1-2

with top-most commit 9f9c1f6844bdacb4a011cc69e19b929997038f4f

 Merge branch 'pm-sysoff'

on top of commit 09583dfed2cb9723da31601cb7080490c2e2e2d7

 Merge tag 'pm-5.19-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.19-rc1.

These update the ARM cpufreq drivers and fix up the CPPC cpufreq
driver after recent changes, update the OPP code and PM documentation
and add power sequences support to the system reboot and power off
code.

Specifics:

 - Add Tegra234 cpufreq support (Sumit Gupta).

 - Clean up and enhance the Mediatek cpufreq driver (Wan Jiabing,
   Rex-BC Chen, and Jia-Wei Chang).

 - Fix up the CPPC cpufreq driver after recent changes (Zheng Bin,
   Pierre Gondois).

 - Minor update to dt-binding for Qcom's opp-v2-kryo-cpu (Yassine
   Oudjana).

 - Use list iterator only inside the list_for_each_entry loop (Xiaomeng
   Tong, and Jakob Koschel).

 - New APIs related to finding OPP based on interconnect bandwidth
   (Krzysztof Kozlowski).

 - Fix the missing of_node_put() in _bandwidth_supported() (Dan
   Carpenter).

 - Cleanups (Krzysztof Kozlowski, and Viresh Kumar).

 - Add Out of Band mode description to the intel-speed-select utility
   documentation (Srinivas Pandruvada).

 - Add power sequences support to the system reboot and power off
   code and make related platform-specific changes for multiple
   platforms (Dmitry Osipenko, Geert Uytterhoeven).

Thanks!


---------------

Dan Carpenter (1):
      OPP: call of_node_put() on error path in _bandwidth_supported()

Dmitry Osipenko (28):
      notifier: Add atomic_notifier_call_chain_is_empty()
      notifier: Add blocking/atomic_notifier_chain_register_unique_prio()
      kernel/reboot: Introduce sys-off handler API
      kernel/reboot: Wrap legacy power-off callbacks into sys-off handlers
      kernel/reboot: Add do_kernel_power_off()
      kernel/reboot: Add stub for pm_power_off
      kernel/reboot: Add kernel_can_power_off()
      kernel/reboot: Add register_platform_power_off()
      ARM: Use do_kernel_power_off()
      csky: Use do_kernel_power_off()
      riscv: Use do_kernel_power_off()
      arm64: Use do_kernel_power_off()
      parisc: Use do_kernel_power_off()
      xen/x86: Use do_kernel_power_off()
      powerpc: Use do_kernel_power_off()
      m68k: Switch to new sys-off handler API
      sh: Use do_kernel_power_off()
      x86: Use do_kernel_power_off()
      ia64: Use do_kernel_power_off()
      mips: Use do_kernel_power_off()
      memory: emif: Use kernel_can_power_off()
      ACPI: power: Switch to sys-off handler API
      regulator: pfuze100: Use devm_register_sys_off_handler()
      reboot: Remove pm_power_off_prepare()
      soc/tegra: pmc: Use sys-off handler API to power off Nexus 7 properly
      kernel/reboot: Add devm_register_power_off_handler()
      kernel/reboot: Add devm_register_restart_handler()
      kernel/reboot: Change registration order of legacy power-off handler

Geert Uytterhoeven (1):
      m68k: virt: Switch to new sys-off handler API

Jakob Koschel (1):
      opp: replace usage of found with dedicated list iterator variable

Jia-Wei Chang (8):
      cpufreq: mediatek: Use module_init and add module_exit
      cpufreq: mediatek: Cleanup variables and error handling in
mtk_cpu_dvfs_info_init()
      cpufreq: mediatek: Remove unused headers
      cpufreq: mediatek: Enable clocks and regulators
      cpufreq: mediatek: Record previous target vproc value
      cpufreq: mediatek: Make sram regulator optional
      cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()
      cpufreq: mediatek: Add support for MT8186

Krzysztof Kozlowski (2):
      PM: opp: simplify with dev_err_probe()
      opp: Add apis to retrieve opps with interconnect bandwidth

Pierre Gondois (1):
      cpufreq: CPPC: Fix unused-function warning

Rex-BC Chen (7):
      cpufreq: mediatek: Use device print to show logs
      cpufreq: mediatek: Replace old_* with pre_*
      cpufreq: mediatek: Unregister platform device on exit
      cpufreq: mediatek: Move voltage limits to platform data
      cpufreq: mediatek: Add opp notification support
      dt-bindings: cpufreq: mediatek: Add MediaTek CCI property
      cpufreq: mediatek: Link CCI device to CPU

Srinivas Pandruvada (1):
      Documentation: admin-guide: PM: Add Out of Band mode

Sumit Gupta (4):
      dt-bindings: Document Tegra CCPLEX Cluster
      cpufreq: tegra194: add soc data to support multiple soc
      cpufreq: tegra194: Add support for Tegra234
      arm64: tegra: add node for tegra234 cpufreq

Viresh Kumar (1):
      opp: Reorder definition of ceil/floor helpers

Wan Jiabing (2):
      cpufreq: mediatek: Fix NULL pointer dereference in mediatek-cpufreq
      cpufreq: mediatek: Fix potential deadlock problem in
mtk_cpufreq_set_target

Xiaomeng Tong (1):
      opp: use list iterator only inside the loop

Yassine Oudjana (1):
      dt-bindings: opp: opp-v2-kryo-cpu: Remove SMEM

Zheng Bin (1):
      cpufreq: CPPC: Fix build error without CONFIG_ACPI_CPPC_CPUFREQ_FIE

---------------

 .../admin-guide/pm/intel-speed-select.rst          |  22 +
 .../arm/tegra/nvidia,tegra-ccplex-cluster.yaml     |  52 ++
 .../bindings/cpufreq/cpufreq-mediatek.txt          |   7 +
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   |  56 +-
 arch/arm/kernel/reboot.c                           |   4 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   7 +
 arch/arm64/kernel/process.c                        |   3 +-
 arch/csky/kernel/power.c                           |   6 +-
 arch/ia64/kernel/process.c                         |   4 +-
 arch/m68k/emu/natfeat.c                            |   3 +-
 arch/m68k/include/asm/machdep.h                    |   1 -
 arch/m68k/kernel/process.c                         |   5 +-
 arch/m68k/kernel/setup_mm.c                        |   1 -
 arch/m68k/kernel/setup_no.c                        |   1 -
 arch/m68k/mac/config.c                             |   4 +-
 arch/m68k/virt/config.c                            |   4 +-
 arch/mips/kernel/reset.c                           |   3 +-
 arch/parisc/kernel/process.c                       |   4 +-
 arch/powerpc/kernel/setup-common.c                 |   4 +-
 arch/powerpc/xmon/xmon.c                           |   3 +-
 arch/riscv/kernel/reset.c                          |  12 +-
 arch/sh/kernel/reboot.c                            |   3 +-
 arch/x86/kernel/reboot.c                           |   4 +-
 arch/x86/xen/enlighten_pv.c                        |   4 +-
 drivers/acpi/sleep.c                               |  16 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  20 +-
 drivers/cpufreq/mediatek-cpufreq.c                 | 636 ++++++++++++++-------
 drivers/cpufreq/tegra194-cpufreq.c                 | 246 ++++++--
 drivers/memory/emif.c                              |   2 +-
 drivers/opp/core.c                                 | 339 +++++++----
 drivers/opp/debugfs.c                              |  10 +-
 drivers/opp/of.c                                   |   2 +-
 drivers/regulator/pfuze100-regulator.c             |  42 +-
 drivers/soc/tegra/pmc.c                            |  87 ++-
 include/linux/notifier.h                           |   7 +
 include/linux/pm.h                                 |   1 -
 include/linux/pm_opp.h                             |  41 +-
 include/linux/reboot.h                             |  91 +++
 kernel/notifier.c                                  | 101 +++-
 kernel/reboot.c                                    | 348 ++++++++++-
 40 files changed, 1655 insertions(+), 551 deletions(-)
