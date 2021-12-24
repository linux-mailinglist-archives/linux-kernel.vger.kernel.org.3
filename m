Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90F47EB54
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 05:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbhLXEUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 23:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbhLXEUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 23:20:39 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D01FC061759
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 20:20:38 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v138so22326445ybb.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 20:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jYo6YkmVrLTkVANAZPQsd6sDnBee07nclp7YcfHkw2Q=;
        b=ISMBhG2WYO0XFD/SK7m9lApvFe7IqI7+VQN/v/bq9HrF1/HDscB3xfEyopMCVqRHbu
         wfYAXg60HgtNJDz+E1vIEA+QlBw8ZX8UV8zheW0+2/90Sy8aevgZYrl/pn2Sqvi16tTG
         zbEEf5YFgPwn3MXzhOcjrc90BrI0QzVnHo7aeNqD/LLEF9Bo9ZtbLo3csvG1xOH5gM5K
         v65zCl1ZWsnvAg9vfowIwxP5kKo0jjWy7t8Nt86NtkZ3s7mlzH9Clrtr1FJg7j2J0YQ4
         S+LLoHJbEBapwwq/nv4S7VFuPfbk0cRPn1meYZA+cLyMvO+vGfqokCWPy0BLksqaNV9g
         xG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jYo6YkmVrLTkVANAZPQsd6sDnBee07nclp7YcfHkw2Q=;
        b=EVBRIhEO8zWIR+d3H+4vXvhfm4gJJ7DB1eH4wgg9A3dDdAa3BIbWrkch7QAkNH/iLL
         FelS38BBbggeCaRHDljEe0pBxkYeemODKInnccbgIe5PFn5vDGh9NPaCycySs5Egkq0d
         Dn0ek6hzoLo4JFfiI4CC6A5IAgm5EniFhvTr+dxkfZahQHFxj4oUZgPs6QrejV79G4JH
         aEs/5PXaAQlaTzvfadyn1o4pAoai6adO4vUme7eP+F8EQUYDQS/7xHUT6me0E0v6CozQ
         hrzucZK9snEEk0RSlQVXGvQXYivVaa5aWcLvDgpgQbI03JUcsT30zFrJtB0EjDM7Losu
         LUVg==
X-Gm-Message-State: AOAM533J2TyETEobt/WfmYp+lqT7X20VMoicmP8h16r4miNnjxXMw43Z
        p27FOR0zk/KPvK/hZy+uBBT1yjMDM2abmEB0YpRpjgSojxN4Mg==
X-Google-Smtp-Source: ABdhPJwn+QTa4c/Txxk/fnSeFaEwZN/JlL0o6VcTneifm/QJQ5n2iBGzBWyXNz+lf16D15CunaRgGxIhR3qpG8H3EkQ=
X-Received: by 2002:a25:60a:: with SMTP id 10mr7211569ybg.704.1640319637270;
 Thu, 23 Dec 2021 20:20:37 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 24 Dec 2021 09:50:26 +0530
Message-ID: <CA+G9fYvKSrW9PSZ2YmgL60v3Q4Po+WVKejughrmy_TpjdORx-w@mail.gmail.com>
Subject: WARNING: CPU: 2 PID: 7 at drivers/reset/core.c:765 __reset_control_get_internal
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        regressions@lists.linux.dev, linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While booting Linux next 20211220 on dragonboard 410c device
the following kernel warning was noticed.

[    0.000000] Linux version 5.16.0-rc5-next-20211220
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0, GNU
ld (GNU Binutils for Debian) 2.37) #1 SMP PREEMPT @1640001868
[    0.000000] Machine model: Qualcomm Technologies, Inc. APQ 8016 SBC
<>
[    2.456354] ------------[ cut here ]------------
[    2.456471] l12: Bringing 0uV into 1750000-1750000uV
[    2.459881] WARNING: CPU: 2 PID: 7 at drivers/reset/core.c:765
__reset_control_get_internal+0x70/0x170
[    2.465553] l13: Bringing 0uV into 1750000-1750000uV
[    2.469438] Modules linked in:
[    2.469448] CPU: 2 PID: 7 Comm: kworker/u8:0 Not tainted
5.16.0-rc5-next-20211220 #1
[    2.469460] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    2.469467] Workqueue: events_unbound deferred_probe_work_func
[    2.479645] l14: Bringing 0uV into 1750000-1750000uV
[    2.483658]
[    2.483663] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.483675] pc : __reset_control_get_internal+0x70/0x170
[    2.487640] l15: Bringing 0uV into 1750000-1750000uV
[    2.494430] lr : __of_reset_control_get+0x178/0x1e0
[    2.494442] sp : ffff80000805b5c0
[    2.494447] x29: ffff80000805b5c0 x28: 0000000000000000
[    2.502681] l16: Bringing 0uV into 1750000-1750000uV
[    2.506752]  x27: 0000000000000000
[    2.506761] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000001
[    2.506778] x23: 0000000000000000 x22: ffff000003838b90 x21: 0000000000000022
[    2.513016] l17: Bringing 0uV into 3300000-3300000uV
[    2.513353] x20: ffff000003838bb0 x19: ffff000003804980
[    2.521207] l18: Bringing 0uV into 1750000-1750000uV
[    2.525588]  x18: ffffffffffffffff
[    2.525597] x17: 000000040044ffff x16: 00400032b5503510 x15: ffff000004b70a1c
[    2.584795] x14: ffffffffffffffff x13: 0000000000000000 x12: 0101010101010101
[    2.592001] x11: 0000000000000038 x10: 0101010101010101 x9 : ffff80000896e3a8
[    2.599117] x8 : 7f7f7f7f7f7f7f7f x7 : ff726b6b64622c73 x6 : 0000000000000001
[    2.606235] x5 : fffffbfffdc0a678 x4 : 0000000000000000 x3 : 0000000000000001
[    2.613354] x2 : 0000000000000022 x1 : 0000000000000022 x0 : 0000000000000000
[    2.620473] Call trace:
[    2.627578]  __reset_control_get_internal+0x70/0x170
[    2.629843]  __of_reset_control_get+0x178/0x1e0
[    2.635048]  __reset_control_get+0x54/0x1e4
[    2.639301]  __devm_reset_control_get+0x84/0xfc
[    2.643469]  ci_hdrc_msm_probe+0xa4/0x410
[    2.647983]  platform_probe+0x74/0xf0
[    2.652148]  really_probe+0xc4/0x470
[    2.655793]  __driver_probe_device+0x11c/0x190
[    2.659441]  driver_probe_device+0x48/0x104
[    2.663694]  __device_attach_driver+0xa4/0x140
[    2.667774]  bus_for_each_drv+0x84/0xe0
[    2.672287]  __device_attach+0xe4/0x1c0
[    2.676020]  device_initial_probe+0x20/0x30
[    2.679840]  bus_probe_device+0xa4/0xb0
[    2.684005]  device_add+0x3c4/0x8d0
[    2.687824]  platform_device_add+0x124/0x280
[    2.691299]  ci_hdrc_add_device+0x4e0/0x600
[    2.695812]  ci_hdrc_msm_probe+0x2fc/0x410
[    2.699719]  platform_probe+0x74/0xf0
[    2.703885]  really_probe+0xc4/0x470
[    2.707616]  __driver_probe_device+0x11c/0x190
[    2.711264]  driver_probe_device+0x48/0x104
[    2.715516]  __device_attach_driver+0xa4/0x140
[    2.719598]  bus_for_each_drv+0x84/0xe0
[    2.724110]  __device_attach+0xe4/0x1c0
[    2.727842]  device_initial_probe+0x20/0x30
[    2.731663]  bus_probe_device+0xa4/0xb0
[    2.735829]  deferred_probe_work_func+0xa8/0xfc
[    2.739649]  process_one_work+0x1e0/0x48c
[    2.744162]  worker_thread+0x2c8/0x470
[    2.748330]  kthread+0x16c/0x180
[    2.751974]  ret_from_fork+0x10/0x20
[    2.755360] ---[ end trace 0000000000000000 ]---
[    2.759144] msm_hsusb: probe of ci_hdrc.0 failed with error -16

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log link,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20211220/testrun/6957084/suite/linux-log-parser/test/check-kernel-warning-4175814/log
https://lkft.validation.linaro.org/scheduler/job/4175814#L2228


metadata:
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git commit: 07f8c60fe60f84977dc815ec8a6b1100827c34dd
  git describe: next-20211220
  make_kernelversion: 5.16.0-rc5
  kernel-config: https://builds.tuxbuild.com/22Y5Y3VmXo40DO70QoRQ1izVM5p/config
  build: https://builds.tuxbuild.com/22Y5Y3VmXo40DO70QoRQ1izVM5p/
  vmlinux: https://builds.tuxbuild.com/22Y5Y3VmXo40DO70QoRQ1izVM5p/vmlinux.xz
  System.map: https://builds.tuxbuild.com/22Y5Y3VmXo40DO70QoRQ1izVM5p/System.map

--
Linaro LKFT
https://lkft.linaro.org
