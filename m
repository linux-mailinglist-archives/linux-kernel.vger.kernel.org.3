Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E0B516EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiEBLl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiEBLlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:41:25 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037B81658E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 04:37:57 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso144349267b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 04:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DMkPSgxZM5AQN6EshlE5SLiEaMFkrEIbSFMXH8q3vts=;
        b=PsSDon90rtoyjo8e4wbdvLjh2MCzDgY3clE0xRJ1mM7+7EyDvqI6Ssx8OwqanYOAsL
         fxe8l3HRLLKAwjMkT+wkXVht0HDRaH8wlfQVDxEhjOGcjROsukmhGrl1rJ0tXDii6epH
         ZGksvKrWrhZuSMhzCp6AR85NLFW5cuGzfoAc6KyA9x5vXCnpbEqX4oOl4c6nV1hvv4kt
         mllo/kvVyWG81tUGE8VwgN7Hehmh71/RlQ6++Qs/F9QBHN9IikSMqBpCc+K1ljJSfLlk
         jAX327Mi0wHFWVLtQ1dzFsvPlMh4NVqt75spapiqUVCIeYDXDYHr52xt+L52iS2mMEQA
         mvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DMkPSgxZM5AQN6EshlE5SLiEaMFkrEIbSFMXH8q3vts=;
        b=P+yb6c/kQHOHpetsiJdyLSiMyNl3YM2V87xLvD5rBx5pVDO3I9nFa/pJbtpsukTRqm
         QuoKGfGq152doL6Tk9oYLLNFgbeTfsJQ8VKEVCSGajAdZpX14euEWBD4S0V45X3ADly+
         BPcPDM32MqBLodAMuhSA2Pdk/KzXQIMWTXjWkpWTHQuxwczDnw39T3Heqo61of2xtkBe
         lA1B31ZM90uSwL5222piCooMZy3jyGIBr799TFqyuAv0FtKWI1GdEeqZoP+am9ooCwzU
         uSN0SBBShOk/qLpZ5218mniWRfuFVHVURzGZ4aWA0Db2drNFfgtjvGFyMCrm3MHdrNPe
         VcMw==
X-Gm-Message-State: AOAM532MdRj8uo2Hd24E8ed0ImoamyHDKNmSKZs6S7YnROnvBG4DCuaX
        9Eqr03Cks8rXB1vCx3RyS6DkLCspioki+S2ImKgr8mD9rpzMGw==
X-Google-Smtp-Source: ABdhPJywyYZLGRJsLdvL4wKjy4QIbdRQ0E4q+DPB++QWvf0qJ946y081b+L2o3fcQmPtGSq8zHv/8qJfXMWvbsEvqRY=
X-Received: by 2002:a81:9210:0:b0:2f4:d8f7:98e9 with SMTP id
 j16-20020a819210000000b002f4d8f798e9mr10606539ywg.265.1651491475390; Mon, 02
 May 2022 04:37:55 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 2 May 2022 17:07:44 +0530
Message-ID: <CA+G9fYuBNB+iuVLFG4t-=5fsRsPdeXSSafkQECf353VxikmW-w@mail.gmail.com>
Subject: [db845c] WARNING: possible recursive locking detected - lock(&irq_desc_lock_class)
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel DEADLOCK warning noticed on arm64 Qcom db845c device while
booting the device with kselftest merge config build image [1] & [2].

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a
  git_describe: v5.18-rc5
  kernel_version: 5.18.0-rc5
  kernel-config: https://builds.tuxbuild.com/28a2o8LHusNjoIzC0DyjxMuD9pA/config
  vmlinux.xz: https://builds.tuxbuild.com/28a2o8LHusNjoIzC0DyjxMuD9pA/vmlinux.xz
  System.map: https://builds.tuxbuild.com/28a2o8LHusNjoIzC0DyjxMuD9pA/System.map
  artifact-location: https://builds.tuxbuild.com/28a2o8LHusNjoIzC0DyjxMuD9pA
  toolchain: gcc-11


Test log:
---------
[   12.978152] cpu cpu0: EM: created perf domain
[   12.984226] remoteproc remoteproc0: request_firmware failed: -2
[   12.991986]
[   12.996140] ============================================
[   13.001506] WARNING: possible recursive locking detected
[   13.006874] 5.18.0-rc5 #1 Not tainted
[   13.010584] --------------------------------------------
[   13.015946] kworker/u16:9/254 is trying to acquire lock:
[   13.019488] qcom_q6v5_pas remoteproc-cdsp: supply cx not found,
using dummy regulator
[   13.021314] ffff09e7811f8cf8 (&irq_desc_lock_class){-.-.}-{2:2},
at: __irq_get_desc_lock+0x64/0xa4
[   13.021342]
[   13.021342] but task is already holding lock:
[   13.021344] ffff09e785f4c0f8
[   13.037483] qcom_q6v5_pas remoteproc-cdsp: supply px not found,
using dummy regulator
[   13.038298]  (&irq_desc_lock_class
[   13.044607] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[   13.047108] ){-.-.}-{2:2}, at: __irq_get_desc_lock+0x64/0xa4
[   13.047116]
[   13.047116] other info that might help us debug this:
[   13.074565] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.078588]  Possible unsafe locking scenario:
[   13.078588]
[   13.078591]        CPU0
[   13.078593]        ----
[   13.078595]   lock(&irq_desc_lock_class);
[   13.078601]   lock(&irq_desc_lock_class);
[   13.078607]
[   13.078607]  *** DEADLOCK ***
[   13.078607]
[   13.078609]  May be due to missing lock nesting notation
[   13.078609]
[   13.078612] 6 locks held by kworker/u16:9/254:
[   13.078616]  #0:
[   13.085399] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[   13.091177] ffff09e780018d38
((wq_completion)events_unbound){+.+.}-{0:0}, at:
process_one_work+0x1e8/0x6e0
[   13.091196]  #1:
[   13.093692] cfg80211: failed to load regulatory.db
[   13.096138] ffff800008de3dd0 (deferred_probe_work){+.+.}-{0:0}, at:
process_one_work+0x1e8/0x6e0
[   13.157611]  #2: ffff09e7812e2988 (&dev->mutex){....}-{3:3}, at:
__device_attach+0x40/0x1d0
[   13.166066]  #3: ffffa9861bcd0b70 (cpu_hotplug_lock){++++}-{0:0},
at: cpus_read_lock+0x1c/0x2c
[   13.174783]  #4: ffff09e780f90918 (subsys mutex#8){+.+.}-{3:3}, at:
subsys_interface_register+0x64/0x150
[   13.184374]  #5: ffff09e785f4c0f8
(&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0x64/0xa4
[   13.193869]
[   13.193869] stack backtrace:
[   13.198274] CPU: 3 PID: 254 Comm: kworker/u16:9 Not tainted 5.18.0-rc5 #1
[   13.205137] Hardware name: Thundercomm Dragonboard 845c (DT)
[   13.210856] Workqueue: events_unbound deferred_probe_work_func
[   13.216759] Call trace:
[   13.219238]  dump_backtrace+0xc0/0x134
[   13.223032]  show_stack+0x24/0x7c
[   13.226381]  dump_stack_lvl+0x8c/0xb8
[   13.230090]  dump_stack+0x18/0x34
[   13.233442]  __lock_acquire+0xbc0/0x2180
[   13.237406]  lock_acquire.part.0+0xe0/0x230
[   13.241639]  lock_acquire+0x68/0x84
[   13.245164]  _raw_spin_lock_irqsave+0x88/0x170
[   13.249659]  __irq_get_desc_lock+0x64/0xa4
[   13.253806]  enable_irq+0x40/0xb0
[   13.257158]  lmh_enable_interrupt+0x38/0x44 [lmh]
[   13.261924]  irq_enable+0x4c/0xa0
[   13.265277]  __irq_startup+0x80/0xb0
[   13.268896]  irq_startup+0x84/0x174
[   13.272432]  __enable_irq+0x7c/0x90
[   13.275967]  enable_irq+0x54/0xb0
[   13.279320]  qcom_cpufreq_ready+0x2c/0x40
[   13.283382]  cpufreq_online+0x7dc/0xa50
[   13.287263]  cpufreq_add_dev+0xd4/0xf0
[   13.291053]  subsys_interface_register+0x138/0x150
[   13.295899]  cpufreq_register_driver+0x180/0x300
[   13.300572]  qcom_cpufreq_hw_driver_probe+0xe0/0x150
[   13.305588]  platform_probe+0x74/0x100
[   13.309378]  really_probe+0x18c/0x3e0
[   13.313086]  __driver_probe_device+0x124/0x1a0
[   13.317577]  driver_probe_device+0x44/0x110
[   13.321809]  __device_attach_driver+0xb0/0x154
[   13.326302]  bus_for_each_drv+0x84/0xe0
[   13.330178]  __device_attach+0xe0/0x1d0
[   13.334056]  device_initial_probe+0x20/0x30
[   13.338288]  bus_probe_device+0xac/0xb4
[   13.342166]  deferred_probe_work_func+0xc8/0x120
[   13.346840]  process_one_work+0x280/0x6e0
[   13.350892]  worker_thread+0x80/0x434
[   13.354597]  kthread+0x10c/0x120
[   13.357863]  ret_from_fork+0x10/0x20
[   13.415473] xhci_hcd 0000:01:00.0: Adding to iommu group 6
[   13.423508] cpu cpu4: EM: created perf domain


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4975803#L3721
[2] https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.18-rc5/testrun/9321027/suite/linux-log-parser/test/check-kernel-warning-4975803/log
