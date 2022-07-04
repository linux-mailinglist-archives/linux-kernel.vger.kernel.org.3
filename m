Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECE3565429
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiGDLyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiGDLyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:54:07 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F189911456
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:54:05 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d3so8400909ioi.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dr/dAh8uy9rWUQzcd6qVKRRT4VyM+idO9nLwxtihPIw=;
        b=zUndaHKAU95gs7fFge1Eq+6EOQvPzom0w9JwI3Rx3JifOqXeW+cbKMetSzOcAbeKTF
         LRJXgGfa/utiPqWXPO87oyXFqHu3zreZAteLC3kwanit9K7PT6QLqLg8gelRvhUxdhsE
         dP5AjRyGvhu1ehYZNUPa1tyzd5PcoVd0FfprBtFGN/ipHsFs4gyaWqhrdvSamf5iqiPr
         2+BpV1nv9msUvFqjuruYSRy5DeWOIQtWPrjHo5V/E/R1BfJ1SZAUyzwD/Qw3UYcFysl+
         Hudu6qkGUD5ElKwxu5iOxG0CK2w/66dr8x2Xcz1B8+pskSgTpkkW+Q3uY7BO7rgxiQBa
         VepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dr/dAh8uy9rWUQzcd6qVKRRT4VyM+idO9nLwxtihPIw=;
        b=g6UfvwYckdpjYjjXooIfuFAH0giW8ZjBkGsGhQJ+gRkBSIPqCY/rKt4kwTOl2KkMLb
         uMxhKaxQvAh14DI/eb1bc+9TLjLXsfPJ+fs0ggQa3GLaa0Zafm+Q12Vq1zWXHgBovIYX
         OOfis+caF7+HxJ8fQYcGKjz7h7zcf4RMN5kks+mRkI9o3Y9X+QXrteaRVrr0V0UvoDxd
         dAk+5vyl7IG++H9vA4e/juYx5uCBOAPOpsBjjE3sI/PawbOJ7XOQxR5dO1nGwFrXD5NN
         f0pxsyfSwwEqbttdUvhZqIs6Fr4MLUgTuNgtPC85LqxXYCxpOnLkmag6wORwiE41MNda
         3SMg==
X-Gm-Message-State: AJIora+IynMldE6Hh5exWNkL6vQ2baqXFVrJmJs/KQRIBY9tdBk/cSir
        hXxgKenl5UV1uWL2FZ8m1B0DRUeASR83Z+rNgRRtyyubRpsOUA==
X-Google-Smtp-Source: AGRyM1sbUVln7CqCICHmv/uS/Iyug/P/XOcDINRsxeH4EvfuE390gLWteC3YHBGFfV5rgbUEFKHG+mhlkMPbq0iahpg=
X-Received: by 2002:a05:6638:14d1:b0:339:e8ea:a7c4 with SMTP id
 l17-20020a05663814d100b00339e8eaa7c4mr18487332jak.309.1656935644355; Mon, 04
 Jul 2022 04:54:04 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 4 Jul 2022 17:23:53 +0530
Message-ID: <CA+G9fYu0CajqiX5bQq-zmp1rpOW2eniH=fcPaJA+Wwi_XmKCWQ@mail.gmail.com>
Subject: next-20220704: juno-r2: Unable to handle kernel NULL pointer
 dereference at virtual address - scpi_send_message
To:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        huhai <huhai@kylinos.cn>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Olof Johansson <olof@lixom.net>
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

[please ignore this if it is already reported]

Following kernel crash noticed on arm64 juno-r2 device while booting
the Linux next-20220704 kernel.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: b6f1f2fa2bddd69ff46a190b8120bd440fd50563
  git_describe: next-20220704
  kernel_version: 5.19.0-rc4
  kernel-config: https://builds.tuxbuild.com/2BTJuNI06nsF1Tg4INLiJo5PLKT/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/579259300
  artifact-location: https://builds.tuxbuild.com/2BTJuNI06nsF1Tg4INLiJo5PLKT
  System.map: https://builds.tuxbuild.com/2BTJuNI06nsF1Tg4INLiJo5PLKT/System.map
  vmlinux.xz: https://builds.tuxbuild.com/2BTJuNI06nsF1Tg4INLiJo5PLKT/vmlinux.xz
  toolchain: gcc-11


crash log:
----------
[    3.243109] dma-pl330 7ff00000.dma-controller: DBUFF-1024x16bytes
Num_Chans-8 Num_Peri-8 Num_Events-8
[    3.257144] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000010
[    3.265963] Mem abort info:
[    3.268764]   ESR = 0x0000000096000004
[    3.272532]   EC = 0x25: DABT (current EL), IL = 32 bits
[    3.277894]   SET = 0, FnV = 0
[    3.280960]   EA = 0, S1PTW = 0
[    3.284109]   FSC = 0x04: level 0 translation fault
[    3.289000] Data abort info:
[    3.291887]   ISV = 0, ISS = 0x00000004
[    3.295732]   CM = 0, WnR = 0
[    3.298702] [0000000000000010] user address but active_mm is swapper
[    3.305073] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    3.310654] Modules linked in:
[    3.313711] CPU: 2 PID: 10 Comm: kworker/u12:1 Not tainted
5.19.0-rc4-next-20220704 #1
[    3.321642] Hardware name: ARM Juno development board (r2) (DT)
[    3.327569] Workqueue: events_unbound deferred_probe_work_func
[    3.333424] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    3.340397] pc : scpi_send_message+0x30/0x290
[    3.344760] lr : scpi_probe+0x2ec/0x4d0
[    3.348598] sp : ffff80000b0d3a40
[    3.351913] x29: ffff80000b0d3a40 x28: ffff80000af6a000 x27: 0000000000000000
[    3.359065] x26: ffff000800982280 x25: ffff00082131b018 x24: ffff0008225f6b80
[    3.366217] x23: ffff0008009bcc10 x22: 0000000000000001 x21: ffff00082131b018
[    3.373367] x20: ffff80000af6a0b0 x19: ffff80000ad8dcc8 x18: ffffffffffffffff
[    3.380517] x17: 000000005d8019b5 x16: 00000000cd715321 x15: ffff80008b0d390d
[    3.387669] x14: 0000000000000001 x13: 007473696c5f7974 x12: 696e696666615f65
[    3.394819] x11: 0000000000000040 x10: ffff80000aa62c50 x9 : ffff80000902e8dc
[    3.401970] x8 : ffff000822601300 x7 : 0000000000000009 x6 : 0000000000000001
[    3.409120] x5 : 0000000000000000 x4 : 000000000000001c x3 : ffff80000b0d3b7c
[    3.416271] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[    3.423421] Call trace:
[    3.425864]  scpi_send_message+0x30/0x290
[    3.429877]  scpi_probe+0x2ec/0x4d0
[    3.433368]  platform_probe+0x74/0xf0
[    3.437034]  really_probe+0xc8/0x3e0
[    3.440611]  __driver_probe_device+0x84/0x190
[    3.444972]  driver_probe_device+0x44/0x100
[    3.449158]  __device_attach_driver+0xa4/0x150
[    3.453606]  bus_for_each_drv+0x84/0xe0
[    3.457448]  __device_attach+0xb0/0x1f0
[    3.461286]  device_initial_probe+0x20/0x30
[    3.465473]  bus_probe_device+0xa4/0xb0
[    3.469316]  deferred_probe_work_func+0xa8/0xfc
[    3.473855]  process_one_work+0x1dc/0x450
[    3.477872]  worker_thread+0x2d0/0x450
[    3.481625]  kthread+0x108/0x110
[    3.484856]  ret_from_fork+0x10/0x20
[    3.488439] Code: aa0103fb f9405785 a9025bf5 b9006fe4 (f94008a1)
[    3.494541] ---[ end trace 0000000000000000 ]---
[    4.383179] atkbd serio1: keyboard reset failed on 1c070000.kmi
[    5.365484] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    5.373920] ata1.00: ATA-9: SanDisk SSD PLUS 120GB, UE5000RL, max UDMA/133
[    5.380871] ata1.00: 234455040 sectors, multi 1: LBA48 NCQ (depth 31/32)
[    5.389317] ata1.00: Features: Dev-Sleep
[    5.400248] ata1.00: configured for UDMA/100
[    5.405730] scsi 0:0:0:0: Direct-Access     ATA      SanDisk SSD
PLUS 00RL PQ: 0 ANSI: 5
[    5.416154] sd 0:0:0:0: [sda] 234455040 512-byte logical blocks:
(120 GB/112 GiB)
[    5.423788] sd 0:0:0:0: [sda] Write Protect is off
[    5.428664] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.433913] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    5.443193] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    5.453537] sd 0:0:0:0: [sda] Attached SCSI disk
[    7.467294] ata2: SATA link down (SStatus 0 SControl 0)
[   10.970428] input: PS/2 Generic Mouse as
/devices/platform/bus@8000000/bus@8000000:motherboard-bus@8000000/bus@8000000:motherboard-bus@8000000:iofpga-bus@300000000/1c060000.kmi/serio0/input/input2
[   11.096505] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[   17.466565] input: PS/2 Generic Mouse as
/devices/platform/bus@8000000/bus@8000000:motherboard-bus@8000000/bus@8000000:motherboard-bus@8000000:iofpga-bus@300000000/1c070000.kmi/serio1/input/input3
[   17.592813] psmouse serio1: Failed to enable mouse on 1c070000.kmi
[   60.415405] random: crng init done

Full test log links,
https://qa-reports.linaro.org/lkft/linux-next-master-sanity/build/next-20220704/testrun/10494299/suite/log-parser-test/tests/
https://lkft.validation.linaro.org/scheduler/job/5239233#L1058

--
Linaro LKFT
https://lkft.linaro.org
