Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866494ED93D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiCaMGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiCaMF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:05:59 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E613E5ED
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:04:10 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y142so41861577ybe.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vVg2+GBr03vvdC1xuzhWdwYhm3SEo/ZuYCT/xeS6niE=;
        b=XNIiZdqQuTo9cCA9QknJGojKVZIDaKhcCSFvqVYy8YyUk0bpVsdrbTjVTg7Lp1nLew
         IY5YwQesdZeJO98Wtkf0gJDBPUKL0m9+Wn0YFc7j2yQlVMrw9N4nJUZZN9iaJHSGV8GE
         wIfWgiVS8+lJwlFzJnR0mXEnPFYJwx9CWMy5YXQ7WbWrfvP429nyRcq2mne7+JpnESyV
         cqRzfXEOIrPHo33blb3UFUEL2zzeQB+/vqt3oqOIJcbDGv83tPNxRMjYKdFa9Z7k33Cp
         /ihZLKJMJerWNVDj3vJ38u2daHkYQUbIR7pwbvAk49sNYBMw23xdUWia+PkY7jqErTnZ
         OdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vVg2+GBr03vvdC1xuzhWdwYhm3SEo/ZuYCT/xeS6niE=;
        b=WnnANkWdtUTENfJKvbNrWP8fHeJhXXcdu7YpeBBNIg0qOw0IKwjpoS7TYZPezmn3vp
         Xn5HeimfEo1OuKaz1zjJ51uTIo5QD/pqxKgI68m/JFIb0dbpPrCxshVVowI1RtqjBoEw
         27VMn9tkjvW19xUNt688FSK5Oav/TT+frqcHc7DYLd79Ug4YNV+tHpC/39yUrNL1zTxA
         YJLpDxBbXSLXalJDmD2ma5p9Y3xZQnoaw0mdLTrNtbReHJ7knVGi6uCqaPIr06T5ka/l
         VWC6U7w4IEiwiZ47L2SmqOeiTKZTAM73GJZcg0Av0SzgICO5yctSmV82MITVAVCu21fY
         /gFQ==
X-Gm-Message-State: AOAM532pLw3+rbloo2j7fPoGnMMV7Yf7drx/8pL0wucJPXVUciXz2mjw
        6AbUdQgMzoN4u19UY678S69QeSucrBiQjf44GfwTxKKZLgk4Jxw+
X-Google-Smtp-Source: ABdhPJyuBIMuDDH57X67oIQx5rSGcAvWFmiQQo2st/DsFD9hZKNBoW+8nuJ7Dfs4pq8CE5AAmKpXj6tqdVl0JB0YC4I=
X-Received: by 2002:a25:548:0:b0:633:81bd:e319 with SMTP id
 69-20020a250548000000b0063381bde319mr3993613ybf.603.1648728248547; Thu, 31
 Mar 2022 05:04:08 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 31 Mar 2022 17:33:57 +0530
Message-ID: <CA+G9fYuqU45hHmK4WMUNEXQbmBucE+9fB=S9wcHEfEHaZ2jgcQ@mail.gmail.com>
Subject: [next] db845c: WARNING: CPU: 5 PID: 8 at drivers/clk/clk-divider.c:139
 divider_recalc_rate
To:     linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     gabriel.fernandez@foss.st.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
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

Following kernel warning noticed on db845c while booting linux next-20220331.

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: fdcbcd1348f4ef713668bae1b0fa9774e1811205
  git_describe: next-20220331
  kernel_version: 5.17.0
  kernel-config: https://builds.tuxbuild.com/278RLnhgJL7XdlJbcbv07jiwbYB/config

Boot log:
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
[    0.000000] Linux version 5.17.0-next-20220331 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 11.2.0-18) 11.2.0, GNU ld (GNU Binutils
for Debian) 2.38) #1 SMP PREEMPT @1648699852
[    0.000000] Machine model: Thundercomm Dragonboard 845c
<trim>
[    8.131366] ------------[ cut here ]------------
[    8.131374] dsi0_pll_bit_clk: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set
[    8.131387] WARNING: CPU: 5 PID: 8 at drivers/clk/clk-divider.c:139
divider_recalc_rate+0x8c/0xc0
[    8.131398] Modules linked in: qcom_spmi_adc5 snd_soc_sdm845
qcom_vadc_common qcom_spmi_temp_alarm qcom_pon crct10dif_ce rtc_pm8xxx
snd_soc_rt5663 msm snd_soc_qcom_common gpu_sched snd_soc_rl6231
soundwire_bus reset_qcom_pdc drm_dp_helper qcom_camss hci_uart
videobuf2_dma_sg btqca v4l2_fwnode venus_core ath10k_snoc v4l2_async
btbcm ath10k_core i2c_qcom_geni v4l2_mem2mem videobuf2_memops
videobuf2_v4l2 ath bluetooth camcc_sdm845 videobuf2_common
spi_geni_qcom i2c_qcom_cci qcom_rng mac80211 xhci_pci qcom_q6v5_mss
xhci_pci_renesas cfg80211 icc_osm_l3 slim_qcom_ngd_ctrl qcom_wdt
rfkill qrtr lmh pdr_interface display_connector slimbus qcom_q6v5_pas
drm_kms_helper qcom_pil_info qcom_q6v5 qcom_sysmon qcom_common
qcom_glink_smem qmi_helpers drm mdt_loader socinfo rmtfs_mem fuse
[    8.131462] CPU: 5 PID: 8 Comm: kworker/u16:0 Not tainted
5.17.0-next-20220331 #1
[    8.131465] Hardware name: Thundercomm Dragonboard 845c (DT)
[    8.131467] Workqueue: events_unbound deferred_probe_work_func
[    8.131475] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    8.131477] pc : divider_recalc_rate+0x8c/0xc0
[    8.131479] lr : divider_recalc_rate+0x8c/0xc0
[    8.131481] sp : ffff8000080936c0
[    8.131482] x29: ffff8000080936c0 x28: ffff781940e58d00 x27: ffffa7f3f1bc6d38
[    8.131485] x26: ffffa7f3f1bc6cf8 x25: 0000000000000000 x24: ffffffffffffffff
[    8.131488] x23: ffff781947e8a400 x22: 000000003b9aca50 x21: ffff781940be0800
[    8.131491] x20: ffff781947e8a800 x19: 000000003b9aca50 x18: 0000000000000000
[    8.131494] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    8.131497] x14: ffff7819bd718000 x13: 0a74657320746f6e x12: 204f52455a5f574f
[    8.131500] x11: 4c4c415f52454449 x10: 5649445f4b4c4320 x9 : ffffa7f3f011de84
[    8.131502] x8 : 445f4b4c4320646e x7 : 6120726f73697669 x6 : 0000000000000001
[    8.131505] x5 : ffffa7f3f288f000 x4 : ffffa7f3f288f2d0 x3 : 0000000000000000
[    8.131508] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff7819402c7000
[    8.131511] Call trace:
[    8.131512]  divider_recalc_rate+0x8c/0xc0
[    8.131513]  clk_divider_recalc_rate+0x64/0x90
[    8.131515]  clk_recalc+0x40/0xb0
[    8.131519]  clk_calc_subtree+0x58/0x90
[    8.131521]  clk_calc_subtree+0x70/0x90
[    8.131523]  clk_calc_new_rates+0x150/0x290
[    8.131526]  clk_calc_new_rates+0x100/0x290
[    8.131528]  clk_calc_new_rates+0x100/0x290
[    8.131530]  clk_calc_new_rates+0x100/0x290
[    8.131533]  clk_core_set_rate_nolock+0xa0/0x2a4
[    8.131535]  clk_set_rate_range_nolock.part.0+0xbc/0x2a0
[    8.131538]  __clk_put+0x70/0x140
[    8.131540]  clk_put+0x1c/0x30
[    8.131543]  of_clk_set_defaults+0x140/0x3c0
[    8.131546]  platform_probe+0x48/0xf0
[    8.131548]  really_probe+0x184/0x3d0
[    8.131550]  __driver_probe_device+0x11c/0x190
[    8.131553]  driver_probe_device+0x44/0xf4
[    8.131556]  __device_attach_driver+0xa4/0x140
[    8.131558]  bus_for_each_drv+0x84/0xe0
[    8.131561]  __device_attach+0xe4/0x1c0
[    8.131563]  device_initial_probe+0x20/0x30
[    8.131565]  bus_probe_device+0xa4/0xb0
[    8.131567]  deferred_probe_work_func+0xa8/0xfc
[    8.131570]  process_one_work+0x1dc/0x450
[    8.131575]  worker_thread+0x154/0x450
[    8.131577]  kthread+0x100/0x110
[    8.131579]  ret_from_fork+0x10/0x20
[    8.131584] ---[ end trace 0000000000000000 ]---
[    8.131588] ------------[ cut here ]------------
[    8.131589] dsi0_phy_pll_out_dsiclk: Zero divisor and
CLK_DIVIDER_ALLOW_ZERO not set
[    8.131596] WARNING: CPU: 5 PID: 8 at drivers/clk/clk-divider.c:139
divider_recalc_rate+0x8c/0xc0
[    8.131599] Modules linked in: qcom_spmi_adc5 snd_soc_sdm845 qcom_vadc_commo#
n qcom_spmi_temp_alarm qcom_pon crct10dif_ce rtc_pm8xxx snd_soc_rt5663
msm snd_soc_qcom_common gpu_sched snd_soc_rl6231 soundwire_bus
reset_qcom_pdc drm_dp_helper qcom_camss hci_uart videobuf2_dma_sg
btqca v4l2_fwnode venus_core ath10k_snoc v4l2_async btbcm ath10k_core
i2c_qcom_geni v4l2_mem2mem videobuf2_memops videobuf2_v4l2 ath
bluetooth camcc_sdm845 videobuf2_common spi_geni_qcom i2c_qcom_cci
qcom_rng mac80211 xhci_pci qcom_q6v5_mss xhci_pci_renesas cfg80211
icc_osm_l3 slim_qcom_ngd_ctrl qcom_wdt rfkill qrtr lmh pdr_interface
display_connector slimbus qcom_q6v5_pas drm_kms_helper qcom_pil_info
qcom_q6v5 qcom_sysmon qcom_common qcom_glink_smem qmi_helpers drm
mdt_loader socinfo rmtfs_mem fuse
[    8.131637] CPU: 5 PID: 8 Comm: kworker/u16:0 Tainted: G        W
      5.17.0-next-20220331 #1
[    8.131639] Hardware name: Thundercomm Dragonboard 845c (DT)
[    8.131640] Workqueue: events_unbound deferred_probe_work_func
[    8.131643] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    8.131645] pc : divider_recalc_rate+0x8c/0xc0
[    8.131647] lr : divider_recalc_rate+0x8c/0xc0
[    8.131648] sp : ffff800008093680
[    8.131649] x29: ffff800008093680 x28: ffff781940e58d00 x27: ffffa7f3f1bc6d38
[    8.131652] x26: ffffa7f3f1bc6cf8 x25: 0000000000000000 x24: ffffffffffffffff
[    8.131655] x23: ffff781947e8a400 x22: 000000003b9aca50 x21: ffff781940be0800
[    8.131657] x20: ffff781947e8b300 x19: 000000003b9aca50 x18: 0000000000000000
[    8.131660] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    8.131663] x14: ffff7819bd718000 x13: 0a74657320746f6e x12: 204f52455a5f574f
[    8.131666] x11: 4c4c415f52454449 x10: 5649445f4b4c4320 x9 : ffffa7f3f011de84
[    8.131669] x8 : 445f4b4c4320646e x7 : 6120726f73697669 x6 : 0000000000000001
[    8.131671] x5 : ffffa7f3f288f000 x4 : ffffa7f3f288f2d0 x3 : 0000000000000000
[    8.131674] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff7819402c7000
[    8.131677] Call trace:
[    8.131677]  divider_recalc_rate+0x8c/0xc0
[    8.131679]  clk_divider_recalc_rate+0x64/0x90
[    8.131680]  clk_recalc+0x40/0xb0
[    8.131683]  clk_calc_subtree+0x58/0x90
[    8.131685]  clk_calc_subtree+0x70/0x90
[    8.131687]  clk_calc_subtree+0x70/0x90
[    8.131690]  clk_calc_subtree+0x70/0x90
[    8.131692]  clk_calc_new_rates+0x150/0x290
[    8.131694]  clk_calc_new_rates+0x100/0x290
[    8.131697]  clk_calc_new_rates+0x100/0x290
[    8.131699]  clk_calc_new_rates+0x100/0x290
[    8.131701]  clk_core_set_rate_nolock+0xa0/0x2a4
[    8.131704]  clk_set_rate_range_nolock.part.0+0xbc/0x2a0
[    8.131707]  __clk_put+0x70/0x140
[    8.131708]  clk_put+0x1c/0x30
[    8.131710]  of_clk_set_defaults+0x140/0x3c0
[    8.131712]  platform_probe+0x48/0xf0
[    8.131714]  really_probe+0x184/0x3d0
[    8.131716]  __driver_probe_device+0x11c/0x190
[    8.131719]  driver_probe_device+0x44/0xf4
[    8.131722]  __device_attach_driver+0xa4/0x140
[    8.131723]  bus_for_each_drv+0x84/0xe0
[    8.131726]  __device_attach+0xe4/0x1c0
[    8.131728]  device_initial_probe+0x20/0x30
[    8.131730]  bus_probe_device+0xa4/0xb0
[    8.131732]  deferred_probe_work_func+0xa8/0xfc
[    8.131735]  process_one_work+0x1dc/0x450
[    8.131737]  worker_thread+0x154/0x450
[    8.131739]  kthread+0x100/0x110
[    8.131741]  ret_from_fork+0x10/0x20
[    8.131743] ---[ end trace 0000000000000000 ]---
[    8.131756] ------------[ cut here ]#
------------
[    8.131757] dsi0_pll_bit_clk: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

[1] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220331/testrun/8808185/suite/linux-log-parser/test/check-kernel-exception-4814166/log
