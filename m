Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39C47C1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbhLUOwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbhLUOwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:52:23 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CB5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:52:22 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id j2so39411760ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 06:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lPecjuYH2sRt3YsiNb+7U2s9NUIfUFmtOepdin22CgA=;
        b=nivnD2BKaYV5UJYwQDC/5g3SWtOM0hQ5o4ImmZRodEIJyenK2iBRi3N3o5v7nIf/RN
         zhK3SSfVxAOzo0wg6oIVx3jZnTPpFrnfUcbGEo179m7VgBXfR2YlGrmZ9CUE1wcULQ9k
         F4JbZII0o0bfFswOya+MXCaYn5U5ZxNiuFExgberG64w2EKrDhgIBSV5XVFZAkm99U0C
         Ew+GvOKuPJKCZMTH/eIjJAaBv8MxQc7qu401q3cJlE2UuG1DxUdxgc17DS2nH09Xx12y
         ebnuBka3UrFQ90P82f6R+uowaYYg9/gE6EInNoMQkcM0Rr37kkjLg88hDOJzi7b0xSS6
         dJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lPecjuYH2sRt3YsiNb+7U2s9NUIfUFmtOepdin22CgA=;
        b=bubqo2V5MSHReU4QyHvcfM0mTTYsGxClRGkwGsYXgaqUECaCX8Uc30U16jBaci0UEC
         gH0K8scejylggq5KJWCrOft19t6aBUqlXYn0v+t+hTI4fb5td9heAkrTaBpvG4jRQnqS
         ByY0SdcJKlwNu1u467+vvzANeVv0cKyJHt5C7WA17t5d/y1HbSw84OkvEwsd3P41ex89
         FgZKYkjRIKvtE7/OmwtWTLs87zjKXcIMg27uONw300t54lbcc3/JFNRdDLp+yCcWLr8a
         P1mLsSwzQuugm8QdBO3JtwZ6+yymYLOjXQfpz/sYsphtTxMCBeF8D2DVE5p284odWJuq
         EBYQ==
X-Gm-Message-State: AOAM532T5M1MErejrPa2/VucFKXGlN/7/+ZaA2sOWuSvHl0gopuNQjpl
        wvofX11oXGVzneCcpTsIJr92/AkfuTHbQxfqlUf+cp2Ru9vJjg==
X-Google-Smtp-Source: ABdhPJwQp2NqG8bCknQsI6uWBjEQ5KK4O5nWdq86Oulm10lLmAk6li+163inPeGRBc7a56fcfx6f5x2pEoCZCvgH2gQ=
X-Received: by 2002:a25:300b:: with SMTP id w11mr5233833ybw.108.1640098341406;
 Tue, 21 Dec 2021 06:52:21 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 21 Dec 2021 20:22:10 +0530
Message-ID: <CA+G9fYvLaR5CF777CKeWTO+qJFTN6vAvm95gtzN+7fw3Wi5hkA@mail.gmail.com>
Subject: [next] WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:9469 sched_init
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please ignore this email if it is already reported ]

While booting Linux next 20211221 on x86_64, i386, arm and arm64.
the following kernel crash reported.

kernel warning while booting.

Starting kernel ...
[    0.000000] Linux version 5.16.0-rc6-next-20211221
(tuxmake@tuxmake) (x86_64-linux-gnu-gcc (Debian 11.2.0-10) 11.2.0, GNU
ld (GNU Binutils for Debian) 2.37) #1 SMP PREEMPT @1640092006
<trim>
[    0.106683] ------------[ cut here ]------------
[    0.106684] WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:9469
sched_init+0x417/0x534
[    0.106689] Modules linked in:
[    0.106692] CPU: 0 PID: 0 Comm: swapper Not tainted
5.16.0-rc6-next-20211221 #1
[    0.106694] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.5 11/26/2020
[    0.106696] RIP: 0010:sched_init+0x417/0x534
[    0.106698] Code: ff 05 69 0d e1 ff 65 4c 8b 24 25 40 ad 01 00 48
c7 c7 00 a9 37 a0 4c 89 e6 e8 d1 ed f8 fd 4c 89 e7 e8 f9 ba 07 fe 84
c0 74 02 <0f> 0b e8 5e 12 ea fe 31 db 45 31 ed 49 c7 c4 40 9d 02 00 89
c6 65
[    0.106700] RSP: 0000:ffffffffa0203ea0 EFLAGS: 00010002
[    0.106702] RAX: 0000000000000001 RBX: ffff944aa7ba9d40 RCX: 0000000000000001
[    0.106703] RDX: ffffffffa0700160 RSI: ffffffff9fe13fc0 RDI: ffff94474007c028
[    0.106704] RBP: ffffffffa0203ec8 R08: 0000000000000080 R09: 0000000000000000
[    0.106706] R10: ffff94474007c000 R11: 00000000000273c0 R12: ffffffffa0218940
[    0.106707] R13: 0000000000000000 R14: 0000000000029d40 R15: ffff944aa7ba9e40
[    0.106708] FS:  0000000000000000(0000) GS:ffff944aa7a00000(0000)
knlGS:0000000000000000
[    0.106710] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.106711] CR2: ffff9447d3201000 CR3: 0000000192c10001 CR4: 00000000000606b0
[    0.106712] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.106713] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.106714] Call Trace:
[    0.106716]  <TASK>
[    0.106718]  start_kernel+0x3e0/0x695
[    0.106722]  x86_64_start_reservations+0x24/0x26
[    0.106724]  x86_64_start_kernel+0xa0/0xa6
[    0.106727]  secondary_startup_64_no_verify+0xd5/0xdb
[    0.106730]  </TASK>
[    0.106731] ---[ end trace 0000000000000000 ]---
[    0.107612] Dynamic Preempt: voluntary
[    0.107632] rcu: Preemptible hierarchical RCU implementation.
[    0.107633] rcu: RCU event tracing is enabled.
[    0.107634] rcu: RCU restricting CPUs from N#
R_CPUS=64 to nr_cpu_ids=4.
[    0.107636] Trampoline variant of Tasks RCU enabled.
[    0.107636] Rude variant of Tasks RCU enabled.
[    0.107637] rcu: RCU calculated value of scheduler-enlistment delay
is 100 jiffies.
[    0.107638] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.108792] NR_IRQS: 4352, nr_irqs: 456, preallocated irqs: 16
[    0.109168] kfence: initialized - using 2097152 bytes for 255
objects at 0x(____ptrval____)-0x(____ptrval____)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log link,
https://qa-reports.linaro.org/lkft/linux-next-master-sanity/build/next-20211221/testrun/6972816/suite/linux-log-parser/test/check-kernel-warning-4190375/log
https://lkft.validation.linaro.org/scheduler/job/4190375#L475

metadata:
---------
  git branch: master
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git commit: 2850c2311ef4bf30ae8dd8927f0f66b026ff08fb
  git describe: next-20211221
  make_kernelversion: 5.16.0-rc6
  kernel-config: https://builds.tuxbuild.com/22b2KawnzAREmulZd4tc18MxX1C/config

--
Linaro LKFT
https://lkft.linaro.org
