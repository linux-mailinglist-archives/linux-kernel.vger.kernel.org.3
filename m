Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D708657D9C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 07:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiGVFcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 01:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 01:32:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B498951EF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 22:32:01 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v12so4550719edc.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 22:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=J12RlWpg1XLxCQs673M+W3iUd5cD4FAYxDqqZcN0Pyo=;
        b=MAOU0OWYWhl4uiv6fnh/7t9W12B1R8lxrYG2ze4wvne50ytYrYhG08pSW4obaX8wZ5
         Wmqw/gEM+jLWUuTCb1KhOZzHb+WFwK9Qtee2X4do2tQ6uostzuEt7somvH4oa9JLn/t6
         JWpRslF0ikr6UPqdn1KDNdSVwcT9twT3GoFMizpMu4RvK5pKe5LjvqvE7qJ8unm+AkS5
         fpnqBIr2p4Vv9DJmxndv0YCWf+jsx0KDizJ8mPkgNXgABq+PaJvfEJszXmmQIQv/H57q
         40yU9JzVKqMG8b24Q/sc7VvJms/IMv1OLrX/E7Y2zgY1i0ptHJnUiAZy9Qo3NoJxCDZV
         pP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=J12RlWpg1XLxCQs673M+W3iUd5cD4FAYxDqqZcN0Pyo=;
        b=ybUb6u+FDLrclOvPHQ9U9wATYqVT+OTKnldA2zXyHkkwqiRNVM8GIIpErEh6Ei3NVY
         G57dJkRuXYTFZVCG3mnDo8m78HcbI7wzBF9rUmryJocn4uZ6xTg6ud+nHDJAU2SrcH9+
         3r5Ofrl2lNUrDkO76Zy5VdC8RmU7SHfoP6QmsL+rUDoKRZXyFIK1LN0lqVC9viXhoSdk
         lzzGLhgTVnUl34/InZ75CG3reURHDvP1+6SMvU64dIkohUlCvG9BBGo54QRSDeFPJhAp
         ee5T236oe/IHuSSVS7Mh2kKsSjof/rVxFgg567h/+fQKGyR2H3OUi5/SLlaQR5sYB5x3
         QHWA==
X-Gm-Message-State: AJIora9ysSutZwzFMTq/zpRcMNaA6Tu3a7wrdu/P9HFmeWir91xr6wHu
        AqeHicqNBjmsWVnPSLS1PG1ogSlzqx9hnXiCdzokk0NHgEqnRw==
X-Google-Smtp-Source: AGRyM1um9GWwTVvNubz/eer7Pf7iXXdZnZ4ivi5kbJbqiXHfK5WntpzGRM6ZTSC7VUBPrcluLV5uVgghw3WKca2LHHw=
X-Received: by 2002:a05:6402:1d53:b0:43a:9ba7:315b with SMTP id
 dz19-20020a0564021d5300b0043a9ba7315bmr1774571edb.350.1658467919515; Thu, 21
 Jul 2022 22:31:59 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Jul 2022 11:01:48 +0530
Message-ID: <CA+G9fYuGFReF0Z9qj7-80eY0gz-J2C5MVpno_8NjrGSH5_RB0Q@mail.gmail.com>
Subject: WARNING: CPU: 4 PID: 326 at drivers/opp/core.c:2471 dev_pm_opp_set_config+0x344/0x620
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, Linux PM <linux-pm@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have found this warning on db845c while booting Linux next-20220720.
Please find more details in the below link,

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

[    9.769688] WARNING: CPU: 4 PID: 326 at drivers/opp/core.c:2471
dev_pm_opp_set_config+0x344/0x620
[    9.769698] i2c 16-0010: Fixing up cyclic dependency with acb3000.camss
[    9.810991] msm-mdss ae00000.mdss: Adding to iommu group 15
[    9.811082] Modules linked in: hci_uart qcom_camss msm(+) videobuf2_dma_sg
[    9.823435] ath10k_snoc 18800000.wifi: supply vdd-3.3-ch1 not
found, using dummy regulator
[    9.827664]  ath10k_snoc(+) btqca v4l2_fwnode btbcm ath10k_core
venus_core(+) gpu_sched camcc_sdm845 reset_qcom_pdc v4l2_async
v4l2_mem2mem i2c_qcom_geni videobuf2_memops ath drm_dp_aux_bus
drm_display_helper videobuf2_v4l2 bluetooth mac80211 i2c_qcom_cci
videobuf2_common qcom_rng spi_geni_qcom gpi(+) qcom_q6v5_mss xhci_pci
qrtr xhci_pci_renesas cfg80211 rfkill slim_qcom_ngd_ctrl lmh
icc_osm_l3 pdr_interface slimbus qcom_wdt display_connector icc_bwmon
qcom_q6v5_pas qcom_pil_info qcom_q6v5 qcom_sysmon drm_kms_helper
qcom_common qcom_glink_smem qmi_helpers mdt_loader drm socinfo
rmtfs_mem fuse
[    9.885445] qcom-camss acb3000.camss: Adding to iommu group 16
[    9.911179] platform ae94000.dsi: Fixing up cyclic dependency with
ae01000.display-controller
[[0;32m  OK  [0m] Started D-Bus System Message Bus.[    9.911593]
Bluetooth: hci0: setting up wcn399x
[    9.928261] CPU: 4 PID: 326 Comm: systemd-udevd Not tainted
5.19.0-rc7-next-20220720 #1

[    9.928265] Hardware name: Thundercomm Dragonboard 845c (DT)
[    9.928267] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    9.928269] pc : dev_pm_opp_set_config+0x344/0x620
[    9.977763] lr : dev_pm_opp_set_config+0x68/0x620
[    9.982508] sp : ffff8000089337b0
[    9.985846] x29: ffff8000089337b0 x28: ffff800008933c90 x27: ffff3e2780f9bc10
[    9.993030] x26: ffffb9048f76dd40 x25: ffffb904d98c8de8 x24: ffff3e278da60080
[   10.000226] x23: ffff3e2780f9bc10 x22: ffff8000089338b0 x21: ffff3e278eda0d80
[   10.007416] x20: ffff3e2780f9bc10 x19: ffff3e2786ffe000 x18: ffffffffffffffff
[   10.014602] x17: 0000000000000000 x16: ffffb904d7d90f50 x15: 6f63713d305f454c
[   10.021795] x14: ffffb904d9df6a20 x13: 0000000000000040 x12: 0000000000000228
[   10.028981] x11: 0000000000000000 x10: 0000000000000bd0 x9 : ffffb904d7d905e0
[   10.036166] x8 : ffff3e27833a8c30 x7 : 0000000000000018 x6 : 0000000000000001
[   10.043361] x5 : ffffb904d982f000 x4 : ffff3e27833a8000 x3 : ffffb904d9bf2c20
[   10.043365] x2 : 0000000000000000 x1 : ffff3e2786f70d00 x0 : ffff3e2786ffe060
[   10.043368] Call trace:
[   10.043369]  dev_pm_opp_set_config+0x344/0x620
[   10.043373]  devm_pm_opp_set_config+0x24/0x80
[   10.043376]  core_get_v4+0x244/0x360 [venus_core]
[   10.043393]  venus_probe+0x100/0x470 [venus_core]
[   10.043404]  platform_probe+0x74/0xf0
[   10.043410]  really_probe+0xc8/0x3e0
[   10.043413]  __driver_probe_device+0x84/0x190
[[0;32m  OK  [0m] Started Avahi mDNS/DNS-SD Stack.
[   10.043414]  driver_probe_device+0x44/0x100
[   10.043416]  __driver_attach+0xd8/0x210
[   10.043418]  bus_for_each_dev+0x7c/0xe0
[   10.043420]  driver_attach+0x30/0x3c
[   10.043422]  bus_add_driver+0x188/0x244
[   10.043424]  driver_register+0x84/0x140
[   10.043426]  __platform_driver_register+0x34/0x40
[   10.043428]  qcom_venus_driver_init+0x30/0x1000 [venus_core]
[   10.043440]  do_one_initcall+0x50/0x2b0
[   10.043445]  do_init_module+0x50/0x200
[   10.043448]  load_module+0x1b5c/0x1fc4
[   10.043449]  __do_sys_finit_module+0xac/0x12c
[   10.043451]  __arm64_sys_finit_module+0x2c/0x40
[   10.043453]  invoke_syscall+0x50/0x120
[   10.043457]  el0_svc_common.constprop.0+0x104/0x124
[   10.043460]  do_el0_svc+0x3c/0xd0
[   10.043463]  el0_svc+0x30/0x94
[   10.043467]  el0t_64_sync_handler+0xbc/0x140
[   10.043469]  el0t_64_sync+0x18c/0x190
[   10.043471] ---[ end trace 0000000000000000 ]---

Link:
https://qa-reports.linaro.org/lkft/linux-next-master/build/v5.19-rc6-12429-g4ee7eaa411ee/testrun/10922376/suite/log-parser-test/test/check-kernel-warning-5303907/details/

Build: https://builds.tuxbuild.com/2CD0dD2GUweY5lvh8VnF3rWZWEm/
vmlinux: https://builds.tuxbuild.com/2CD0dD2GUweY5lvh8VnF3rWZWEm/vmlinux.xz
System.map: https://builds.tuxbuild.com/2CD0dD2GUweY5lvh8VnF3rWZWEm/System.map

--
Linaro LKFT
https://lkft.linaro.org
