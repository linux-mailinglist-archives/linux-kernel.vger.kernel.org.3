Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92558CD69
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbiHHSOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHHSOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:14:10 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B2212AB3;
        Mon,  8 Aug 2022 11:14:09 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 21so14915636ybf.4;
        Mon, 08 Aug 2022 11:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=bxKc2JOmfIjFCRLmMBmrpd74/LhQZNp0OlKLoUT/fsk=;
        b=8ESokfa09TXXpz6BuzL/P9lmVkc/EOAag6lcYPRIq6Rt2xTVoth4++UJ/yOWqqClC3
         dGxiZG3rIUnZzSCAdi3I3WBH3vf0zD3YVeIF+E4RybZGuJxC2BoZ4QUdF57Gkl8/QQjb
         Ly2HbclCAcZVJPhU/ICAZzFjnmbidGRQcqjDKGB+wXKRp0NXwFkgTJV0mP16z1bKFamf
         WfyhEMNHW7YeNsfHqJeotOBSo3dUKSAJ4FHV912tIMMcn/Y+0ombD/0Ow9rrMgEJSHqa
         /wbZGM3wAzu+9SH0V35r7M0G+o7LJfpD3icLvkLWLVfRs38Fu4oXlIJpHSkMRpGdN3LF
         FZ0w==
X-Gm-Message-State: ACgBeo3h+yWNrAGUpnZiYvoFiOI8qWXpXDc90aIsgZUSnGxNmzo8JMsM
        2dx6I5l+J7Tfd2202tCMsB+f6QhyDiE+fiqY+S+Q9UgVhgA=
X-Google-Smtp-Source: AA6agR7fzj5iRdE+xPWoBxckcigsj+UMrQuSYoplDiNwQD/viRPhYFncrj4zJOharXWhllPRMViSCTGoqGYdkEtNsvI=
X-Received: by 2002:a25:cc51:0:b0:676:ccba:875 with SMTP id
 l78-20020a25cc51000000b00676ccba0875mr17820260ybf.137.1659982448619; Mon, 08
 Aug 2022 11:14:08 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Aug 2022 20:13:57 +0200
Message-ID: <CAJZ5v0i8zu7SUgf2Bp3TZnxzHS_Oa9oQVKSN2rezDAisYdrWZQ@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.20-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.20-rc1-2

with top-most commit c3f834df191ac2e5e58c215b9110e7e19553100f

 Merge branch 'pm-cpufreq'

on top of commit a771ea6413c00cf4af0570745f2e27084d7e2376

 Merge tag 'pm-5.20-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.20-rc1.

These are ARM cpufreq updates and operating performance points (OPP)
updates plus one cpuidle update adding a new trace point.

Specifics:

 - Fix return error code in mtk_cpu_dvfs_info_init (Yang Yingliang).

 - Minor cleanups and support for new boards for Qcom cpufreq drivers
   (Bryan O'Donoghue, Konrad Dybcio, Pierre Gondois, and Yicong Yang).

 - Fix sparse warnings for Tegra cpufreq driver (Viresh Kumar).

 - Make dev_pm_opp_set_regulators() accept NULL terminated list (Viresh
   Kumar).

 - Add dev_pm_opp_set_config() and friends and migrate other users and
   helpers to using them (Viresh Kumar).

 - Add support for multiple clocks for a device (Viresh Kumar and
   Krzysztof Kozlowski).

 - Configure resources before adding OPP table for Venus (Stanimir
   Varbanov).

 - Keep reference count up for opp->np and opp_table->np while they are
   still in use (Liang He).

 - Minor OPP cleanups (Viresh Kumar and Yang Li).

 - Add a trace event for cpuidle to track missed (too deep or too
   shallow) wakeups (Kajetan Puchalski).

Thanks!


---------------

Bryan O'Donoghue (3):
      dt-bindings: opp: opp-v2-kryo-cpu: Fix example binding checks
      dt-bindings: opp: Add missing compat devices
      dt-bindings: opp: Add msm8939 to the compatible list

Kajetan Puchalski (1):
      cpuidle: Add cpu_idle_miss trace event

Konrad Dybcio (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM6375 compatible

Krzysztof Kozlowski (1):
      dt-bindings: opp: accept array of frequencies

Liang He (2):
      OPP: Don't drop opp_table->np reference while it is still in use
      OPP: Don't drop opp->np reference while it is still in use

Pierre Gondois (4):
      cpufreq: qcom-hw: Reset cancel_throttle when policy is re-enabled
      cpufreq: qcom-hw: Disable LMH irq when disabling policy
      cpufreq: qcom-hw: Remove deprecated irq_set_affinity_hint() call
      cpufreq: Change order of online() CB and policy->cpus modification

Stanimir Varbanov (1):
      venus: pm_helpers: Fix warning in OPP during probe

Tang Bin (1):
      opp: Fix error check in dev_pm_opp_attach_genpd()

Viresh Kumar (38):
      OPP: Fix typo in comment
      OPP: Track if clock name is configured by platform
      OPP: Make dev_pm_opp_set_regulators() accept NULL terminated list
      OPP: Add dev_pm_opp_set_config() and friends
      cpufreq: qcom-nvmem: Migrate to dev_pm_opp_set_config()
      cpufreq: sti: Migrate to dev_pm_opp_set_config()
      cpufreq: ti: Migrate to dev_pm_opp_set_config()
      drm/lima: Migrate to dev_pm_opp_set_config()
      soc/tegra: Add comment over devm_pm_opp_set_clkname()
      soc/tegra: Migrate to dev_pm_opp_set_config()
      OPP: Migrate set-regulators API to use set-config helpers
      OPP: Migrate set-supported-hw API to use set-config helpers
      OPP: Migrate set-clk-name API to use set-config helpers
      OPP: Migrate set-opp-helper API to use set-config helpers
      OPP: Migrate attach-genpd API to use set-config helpers
      OPP: Migrate set-prop-name helper API to use set-config helpers
      OPP: Add support for config_regulators() helper
      OPP: Make _generic_set_opp_regulator() a config_regulators() interface
      OPP: Add dev_pm_opp_get_supplies()
      OPP: ti: Migrate to dev_pm_opp_set_config_regulators()
      OPP: Remove custom OPP helper support
      OPP: Remove dev_pm_opp_find_freq_ceil_by_volt()
      OPP: Add generic key finding helpers and use them for freq APIs
      OPP: Use generic key finding helpers for level key
      OPP: Use generic key finding helpers for bandwidth key
      OPP: Use consistent names for OPP table instances
      OPP: Remove rate_not_available parameter to _opp_add()
      OPP: Reuse _opp_compare_key() in _opp_add_static_v2()
      OPP: Make dev_pm_opp_set_opp() independent of frequency
      OPP: Allow multiple clocks for a device
      OPP: Compare bandwidths for all paths in _opp_compare_key()
      OPP: Add key specific assert() method to key finding helpers
      OPP: Assert clk_count == 1 for single clk helpers
      OPP: Provide a simple implementation to configure multiple clocks
      OPP: Allow config_clks helper for single clk case
      PM / devfreq: tegra30: Register config_clks helper
      OPP: Remove dev{m}_pm_opp_of_add_table_noclk()
      cpufreq: tegra194: Staticize struct tegra_cpufreq_soc instances

Yang Li (1):
      opp: Fix some kernel-doc comments

Yang Yingliang (1):
      cpufreq: mediatek: fix error return code in mtk_cpu_dvfs_info_init()

Yicong Yang (1):
      cpufreq: qcom-cpufreq-hw: use HZ_PER_KHZ macro in units.h

---------------

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |    1 +
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       |    7 +
 .../devicetree/bindings/opp/opp-v2-base.yaml       |   10 +
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   |   15 +
 drivers/cpufreq/cpufreq-dt.c                       |   19 +-
 drivers/cpufreq/cpufreq.c                          |    6 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |   12 +-
 drivers/cpufreq/mediatek-cpufreq.c                 |    1 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  |   14 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |  109 +-
 drivers/cpufreq/sti-cpufreq.c                      |   27 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c             |   31 +-
 drivers/cpufreq/tegra194-cpufreq.c                 |    4 +-
 drivers/cpufreq/tegra20-cpufreq.c                  |   12 +-
 drivers/cpufreq/ti-cpufreq.c                       |   42 +-
 drivers/cpuidle/cpuidle.c                          |    6 +-
 drivers/devfreq/exynos-bus.c                       |   21 +-
 drivers/devfreq/tegra30-devfreq.c                  |   22 +-
 drivers/gpu/drm/lima/lima_devfreq.c                |   12 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |    3 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |   15 +-
 drivers/media/platform/qcom/venus/pm_helpers.c     |   10 +-
 drivers/memory/tegra/tegra124-emc.c                |   11 +-
 drivers/opp/core.c                                 | 1577 ++++++++++----------
 drivers/opp/cpu.c                                  |   12 +-
 drivers/opp/debugfs.c                              |   27 +-
 drivers/opp/of.c                                   |  150 +-
 drivers/opp/opp.h                                  |   56 +-
 drivers/opp/ti-opp-supply.c                        |   77 +-
 drivers/soc/tegra/common.c                         |   49 +-
 drivers/soc/tegra/pmc.c                            |    4 +-
 include/linux/pm_opp.h                             |  322 ++--
 include/trace/events/power.h                       |   22 +
 33 files changed, 1421 insertions(+), 1285 deletions(-)
