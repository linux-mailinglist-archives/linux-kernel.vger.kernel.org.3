Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A646C56510A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiGDJhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiGDJg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:36:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB191D4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:36:55 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id u20so8114945iob.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=M4PHJyWoqviqJDX9j/AeRUcG7kFnr6lVLWzGBNI2k4A=;
        b=Ns0XW+mjEaz17ha9UNolHB3Tw5s4ruam0MMbB0kfg+OmU+nUjeLt+3QNSjYnhGwnCR
         86NIlg70NUJMXerT+eejnMyIYi38jhnM+0c4wQStsgi5vHZvMxGO5GINPL2+hgfm29Po
         iiFVj3lx0tuVjU9+v+vaovhRcC3ngrjjXfYvxjgmEuOK3b2vtPoO5JBEmbo0qMGoVmlO
         Z7lCcr6nq8gT00W0P7RCAj/R8i6o7E2i3TREuaM0C9GclBjd41LDUssvPzGDGgrFNPXT
         oY5oNUvHi4sRVHlnT9Bmj10BWLA01cF+XZAjr4Th9pJsnTkIF3Mm06BXjrZyPlgulHVP
         wt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=M4PHJyWoqviqJDX9j/AeRUcG7kFnr6lVLWzGBNI2k4A=;
        b=1UnGlEJcyy7Ukrz2mrtRXHZfpkNKsOD2RNGbUl8M1qU0p644sauGGL0qkhQU/slyne
         uFb5KzmYFn05WwL5M8w2wapftzbWN31CrpMr9CZca4+QvNfxCUGVk8yEZzXl0ow+ICb1
         wn2tfOb44wGhyuZZCSbmbAtt1n0EO6DagftrsJ2tQm2C9RcD/e03e7/6paP3NrtQ1elw
         qdrIcCrwktxXnHIPpbvgfGIijvF0UBdPRp8Fb0jDc9fKtdLwQQWp3Ead3/eE66XnTA+3
         +5lf+5ifPwk9xXxhXVgN2ESxlcFe53PFGYsT23snq+WrScRIG/XBsWy2Unqdw0XJZvm6
         N+TQ==
X-Gm-Message-State: AJIora/Y5+8lIkAgODsbyaazMfM95xVzmOBGkr5yyWk3mYiItJsZl8WO
        yLzpFPiaMZCPAkz5XoYFNrV1tGwH936qKEDe+BJ7oamokslUNg==
X-Google-Smtp-Source: AGRyM1uvQZvVzsJPPykVVolv64ey85zoHlS5rvzKygERnG2CQoxvFiUw/KDbWDW04LFg5ZYSK4a9f7LZnBVbmq1Xx0I=
X-Received: by 2002:a05:6638:468e:b0:33e:be92:ec40 with SMTP id
 bq14-20020a056638468e00b0033ebe92ec40mr6041972jab.74.1656927414391; Mon, 04
 Jul 2022 02:36:54 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 4 Jul 2022 15:06:43 +0530
Message-ID: <CA+G9fYszKbZE4uKig8unFki0KxiMC2xf+2ZNK+1sT_kCXYqv9w@mail.gmail.com>
Subject: 5.19.0-rc5 : WARNING: CPU: 0 PID: 17 at kernel/irq/manage.c:789 __enable_irq+0x58/0x90
To:     open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        LTP List <ltp@lists.linux.it>
Cc:     Vinod Koul <vinod.koul@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running LTP cpuhotplug the following kernel warning was noticed
on arm64 Thundercomm Dragonboard 845c device.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 88084a3df1672e131ddc1b4e39eeacfd39864acf
  git_describe: v5.19-rc5
  kernel_version: 5.19.0-rc5
  kernel-config: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/579007773
  artifact-location: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh
  vmlinux.xz: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/vmlinux.xz
  System.map: https://builds.tuxbuild.com/2BSEyt8Sb19HSj6SnBFiMo6kiQh/System.map
  toolchain: gcc-11

steps to reproduce:
# cd /opt/ltp
# ./runltp -p -q -f cpuhotplug

cpuhotplug04 1 TPASS: System prevented us from offlining the last CPU - cpu7
cpuhotplug04 2 TPASS: Success
[   37.419206] Detected VIPT I-cache on CPU0
[   37.419326] GICv3: CPU0: found redistributor 0 region 0:0x0000000017a60000
[   37.419473] CPU0: Booted secondary processor 0x0000000000 [0x517f803c]
[   37.477891] ------------[ cut here ]------------
[   37.482610] Unbalanced enable for IRQ 131
[   37.486730] WARNING: CPU: 0 PID: 17 at kernel/irq/manage.c:789
__enable_irq+0x58/0x90
[   37.494722] Modules linked in: snd_soc_hdmi_codec lontium_lt9611
venus_enc venus_dec mcp251xfd videobuf2_dma_contig can_dev hci_uart
btqca btbcm qcom_pon qcom_spmi_adc5 qcom_spmi_temp_alarm rtc_pm8xxx
qcom_vadc_common crct10dif_ce snd_soc_sdm845 snd_soc_rt5663
snd_soc_qcom_common snd_soc_rl6231 bluetooth soundwire_bus msm
reset_qcom_pdc qcom_camss gpu_sched videobuf2_dma_sg drm_dp_aux_bus
i2c_qcom_geni v4l2_fwnode drm_display_helper v4l2_async
videobuf2_memops i2c_qcom_cci camcc_sdm845 venus_core v4l2_mem2mem
spi_geni_qcom videobuf2_v4l2 videobuf2_common ath10k_snoc gpi qcom_rng
ath10k_core ath mac80211 xhci_pci xhci_pci_renesas qcom_q6v5_mss qrtr
qcom_q6v5_pas qcom_pil_info slim_qcom_ngd_ctrl qcom_q6v5 pdr_interface
qcom_sysmon cfg80211 qcom_common icc_osm_l3 rfkill qcom_glink_smem
display_connector lmh qmi_helpers slimbus qcom_wdt mdt_loader
drm_kms_helper rmtfs_mem drm socinfo fuse
[   37.574852] CPU: 0 PID: 17 Comm: cpuhp/0 Not tainted 5.19.0-rc5 #1
[   37.581155] Hardware name: Thundercomm Dragonboard 845c (DT)
[   37.586916] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   37.593999] pc : __enable_irq+0x58/0x90
[   37.597937] lr : __enable_irq+0x58/0x90
[   37.601862] sp : ffff800008223cb0
[   37.605247] x29: ffff800008223cb0 x28: 0000000000000000 x27: ffff1a0201cdce18
[   37.612531] x26: 0000000000000000 x25: ffffcde3da0e4000 x24: ffff1a0201cdcc20
[   37.619813] x23: ffffcde3d9b53308 x22: ffffcde3d9b70fc8 x21: 0000000000000000
[   37.627095] x20: 0000000000000083 x19: ffff1a02002a1600 x18: ffffffffffffffff
[   37.634373] x17: 0000000009a60b40 x16: 000000009e1ad4d3 x15: 0720072007200720
[   37.641653] x14: 0720072007200720 x13: 0720072007200720 x12: 0720072007200720
[   37.648933] x11: 0720072007200720 x10: ffffcde3d9bca7a8 x9 : ffffcde3d7321528
[   37.656213] x8 : 00000000ffffefff x7 : ffffcde3d9bca7a8 x6 : 0000000000000000
[   37.663489] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[   37.670766] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1a0200342080
[   37.678043] Call trace:
[   37.680552]  __enable_irq+0x58/0x90
[   37.684135]  enable_irq+0x54/0xb0
[   37.687539]  qcom_cpufreq_ready+0x2c/0x40
[   37.691649]  cpufreq_online+0x550/0xa04
[   37.695582]  cpuhp_cpufreq_online+0x1c/0x2c
[   37.699857]  cpuhp_invoke_callback+0x16c/0x5b0
[   37.704407]  cpuhp_thread_fun+0xd0/0x1c4
[   37.708419]  smpboot_thread_fn+0x1ec/0x220
[   37.712607]  kthread+0x100/0x110
[   37.715924]  ret_from_fork+0x10/0x20
[   37.719597] ---[ end trace 0000000000000000 ]---
[   37.778938] Detected VIPT I-cache on CPU1

Full test log:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.19-rc5/testrun/10489108/suite/log-parser-test/test/check-kernel-warning-5238386/details/
https://lkft.validation.linaro.org/scheduler/job/5238386#L4318

--
Linaro LKFT
https://lkft.linaro.org
