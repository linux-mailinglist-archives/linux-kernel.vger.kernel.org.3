Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8841B519B38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346930AbiEDJNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346934AbiEDJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:13:44 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D079715724
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:10:08 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y2so1312885ybi.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Iyk7Telsa6alr1Cm3d9QjTuLw+CTzaW9JeZH/BH2TNU=;
        b=W3SNX/8e5ew+o7roNgYeqoqKCNiNO5i6OBohb95OASIH6IIgIoiUwPVTmzDHMhv3ah
         844MQflnz6XRm0nB/R8FZp2PTfr+wOmAfOoR11Wp2ghnp6bOy/0IWWiy1uKOE/yeSfC4
         yxkuXPwTLxDe3XkO/rrsaYMVbr43AmKmOJWZT+YB+1wS7avZsAjPSuvlxDZckBRLn9s9
         lmoREYBHs618yp8S564lX+2KSdQ13ogvY54q83OHVWNzqRxb8P9zAW4E0+FNH41QZoqo
         GkAq4f60PARYlLKb51VkQC0y+uMcal6gsRKQlkK/maM6/dYlBealmJOcdtibxWX/fmPz
         OXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Iyk7Telsa6alr1Cm3d9QjTuLw+CTzaW9JeZH/BH2TNU=;
        b=TFvfzIVnl5IE9gGqBFdHfQhkfN3A7qeWLnoArSyss21IDWMHAxZOvXzoGE9HUB70oQ
         hynY28h4elKvKerizRUr0nqIKJZVB8LbP3SMXX6yitMpntH0KADd2VtLuS20eHEgX8kv
         rJGpFtJ0aMQDpK6jz36wu/zg3mUOHSnIY1OB1DMj46xAFgIDZA7ONMwCQHjC53plhY9e
         c+gs3atLbZzFXZ8LbU1FJtD7IkHEz/l3uebzwmndrSrA08p0vzB92yGiBkhu52yHWVOD
         MHBOLnKKTIU94EOROdbVyMg1utjIxdfZuPyDT8BY8yHc2//fV9iysBrQkKNsPSpOHZw/
         FWlQ==
X-Gm-Message-State: AOAM531kdbnYPY4iRh+rThhuwIqtUbtropfzpHKCrhfld+X+dOhV6hzk
        3LH3H3RUTJflGC73/9dr3R8r4cQnpR0iNm6wN1jjig==
X-Google-Smtp-Source: ABdhPJzz9y6VhFg+7Jp6RtTE21aDhSqzKXcXHceVn5JEVTRJGve87XN4aq7YfCE4QXFbdNaOnEQgO2ZK0GyYPG0AoeI=
X-Received: by 2002:a25:c64b:0:b0:649:11d:9db1 with SMTP id
 k72-20020a25c64b000000b00649011d9db1mr16569675ybf.128.1651655407901; Wed, 04
 May 2022 02:10:07 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 4 May 2022 14:39:56 +0530
Message-ID: <CA+G9fYtYRVKKRx=W7npj911E8QPY9UObSBCppFyGGkT=wZsXFQ@mail.gmail.com>
Subject: [next] db410c: WARNING: CPU: 3 PID: 57 at kernel/locking/mutex.c:582 __mutex_lock
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

Following kernel DEBUG_LOCKS_WARN_ON(lock->magic != lock) noticed on arm64
dragonboard 410c device while booting Linux next-20220502 tag kernel.

warning:
---------
[    6.052275] ------------[ cut here ]------------
[    6.052289] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[    6.052314] WARNING: CPU: 3 PID: 57 at kernel/locking/mutex.c:582
__mutex_lock+0x1dc/0x420
[    6.052345] Modules linked in:
[    6.052361] CPU: 3 PID: 57 Comm: kworker/u8:2 Not tainted
5.18.0-rc5-next-20220502 #1
[    6.052374] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    6.052384] Workqueue: events_unbound deferred_probe_work_func
[    6.052408] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.052421] pc : __mutex_lock+0x1dc/0x420
[    6.052434] lr : __mutex_lock+0x1dc/0x420
[    6.052446] sp : ffff80000c42b9a0
[    6.052453] x29: ffff80000c42b9a0 x28: ffff80000b314860 x27: ffff00000408810d
[    6.052481] x26: ffff80000adb4bb8 x25: ffff000005220a74 x24: 0000000000000000
[    6.052506] x23: 0000000000000000 x22: ffff800008bbef8c x21: 0000000000000002
[    6.052533] x20: 0000000000000000 x19: ffff00000c1a5110 x18: 0000000000000000
[    6.052558] x17: ffff800008bbd594 x16: ffff800008bc10f4 x15: ffff80000927b6c4
[    6.052585] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 5f534b434f4c5f47
[    6.052611] x11: 656820747563205b x10: 0000000000000029 x9 : ffff8000081cc7b8
[    6.052637] x8 : 0000000000000029 x7 : 0000000000000013 x6 : 0000000000000001
[    6.267204] x5 : ffff80000adb5000 x4 : ffff80000adb54f0 x3 : 0000000000000000
[    6.274321] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000005265080
[    6.281439] Call trace:
[    6.288524]  __mutex_lock+0x1dc/0x420
[    6.290789]  mutex_lock_nested+0x4c/0x90
[    6.294610]  driver_set_override+0x12c/0x160
[    6.298605]  qcom_smd_register_edge+0x2d8/0x52c
[    6.302860]  qcom_smd_probe+0x64/0x90
[    6.307106]  platform_probe+0x74/0x100
[    6.310928]  really_probe+0x1a4/0x3f4
[    6.314572]  __driver_probe_device+0x124/0x1a0
[    6.318310]  driver_probe_device+0x44/0x110
[    6.322648]  __device_attach_driver+0xb0/0x154
[    6.326730]  bus_for_each_drv+0x84/0xe0
[    6.331240]  __device_attach+0xe0/0x1d0
[    6.334974]  device_initial_probe+0x20/0x30
[    6.338795]  bus_probe_device+0xac/0xb4
[    6.342958]  deferred_probe_work_func+0xc8/0x120
[    6.346784]  process_one_work+0x280/0x6e0
[    6.351641]  worker_thread+0x230/0x434
[    6.355546]  kthread+0x10c/0x120
[    6.359188]  ret_from_fork+0x10/0x20
[    6.362577] irq event stamp: 4049
[    6.366132] hardirqs last  enabled at (4049): [<ffff8000096ac248>]
_raw_spin_unlock_irqrestore+0xa8/0xc4
[    6.369392] hardirqs last disabled at (4048): [<ffff8000096ac968>]
_raw_spin_lock_irqsave+0xd8/0x170
[    6.378938] softirqs last  enabled at (1496): [<ffff800008090cd8>]
__do_softirq+0x528/0x654
[    6.388046] softirqs last disabled at (1491): [<ffff80000812f99c>]
__irq_exit_rcu+0x17c/0x1b0
[    6.396120] ---[ end trace 0000000000000000 ]---

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 9f9b9a2972eb8dcaad09d826c5c6d7488eaca3e6
  git_describe: next-20220502
  kernel_version: 5.18.0-rc5
  kernel-config: https://builds.tuxbuild.com/28bnDcc7Sy8tyxRNdWwIkoP1qQK/config
  artifact-location: https://builds.tuxbuild.com/28bnDcc7Sy8tyxRNdWwIkoP1qQK
  toolchain: gcc-11


--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4978421#L2608
[2] https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220502/testrun/9336158/suite/linux-log-parser/test/check-kernel-exception-4978421/log
