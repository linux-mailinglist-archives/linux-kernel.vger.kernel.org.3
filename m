Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697A94E4445
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbiCVQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiCVQfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:35:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38384614A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:34:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id g3so1281653plo.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=brcU2nO6QqDCnc/aKXyKE9+waR5SCKo3rxSe1BMuA1o=;
        b=kiS1cCGL/REUt0zXeKlAJyrQljUCqBSXBlRoawnyoX2QZ4zSaq+sJGic9bWkowfZgq
         v9qFMYULiQ9PJk0DPDmdVvuXBZ45Ph4HC+Dj2t4RebruXLVLcbWwixC5QMLFerdRlS4d
         7CSd1BGXlwuMGR+Vhdf9qeuJbm70fKhq016LLnDZNkyRTdaltOEOQdfbxaoVJ0UoWAX0
         y92Z5gbUxyq44KoBxb6dMh6Kl48MMbzHWsSXnrRE2hhYHchX1F9Jzn2z/FVIsB9UB4SM
         lOUl+whpRZFKIuuBFJNa/4SImd6ANdsP2P7NZ9ZiyydfO39bVNoNsY+G2zowMvMojsw1
         GIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=brcU2nO6QqDCnc/aKXyKE9+waR5SCKo3rxSe1BMuA1o=;
        b=Zp5odTWQ958IA44vKjW7TdVbCgSx+A0giu/8Fn1p5dG0fYyKcKBWKJdPmaaepGk9gA
         qXInPSYaD124zPe03iNHgp8neXnDsArs41s5dl8iKsfA/XYKGpWSejFVR63GwhO/MYdF
         cpLf9xwR2fyR43uFnZlGyRyPGB8/X3gqxykBGAnSo6qBBooe89au6k0PMcvpueDu/f6N
         VAvExHWlPyCwt2s3InoU1Akfv1qbr6DiPTgDNzLIIdIBHcrgapT7s6ZNZ8R9NHieXm4o
         jtbXoKh4MshetWJcVFcN7K5iMHgij8ZoEFw9sdm4PZgL3oJDDx/pKxB5c7LYp0Tz2DYO
         dRiw==
X-Gm-Message-State: AOAM533MX+KbNP6L8egaA2sjxlB/bDe8y8LrrRAikjZXUg1xYTPWp+C3
        bzghXt6GpWO8zlfWJOt+aHV+sg==
X-Google-Smtp-Source: ABdhPJwoMM9MGKG2rXVenoOC5R+VXbKPwEtztHPeW46UMwsmabaAwA7Rr0HVo7PJYSn7B44Usq7fbw==
X-Received: by 2002:a17:902:8f94:b0:14f:d9b3:52c2 with SMTP id z20-20020a1709028f9400b0014fd9b352c2mr18826905plo.103.1647966845737;
        Tue, 22 Mar 2022 09:34:05 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:a113:6fc:a7b4:4226? ([2409:8a28:e62:3990:a113:6fc:a7b4:4226])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm17584716pgo.6.2022.03.22.09.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 09:34:05 -0700 (PDT)
Message-ID: <0a7ebd49-cfdd-911e-3982-44f594320b0f@bytedance.com>
Date:   Wed, 23 Mar 2022 00:33:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v2 2/6] perf/core: Introduce percpu
 perf_cgroup
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com>
 <YjnIpn/PCM6wKpOC@hirez.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YjnIpn/PCM6wKpOC@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/22 9:01 下午, Peter Zijlstra wrote:
> On Tue, Mar 22, 2022 at 08:08:30PM +0800, Chengming Zhou wrote:
>> Although we don't have incosistency problem any more, we can
>> have other problem like:
>>
>> CPU1					CPU2
>> (in context_switch)			(attach running task)
>> 					prev->cgroups = cgrp2
>> perf_cgroup_sched_switch(prev, next)
>> 	cgrp2 == cgrp2 is True
>>
> 
> Again, I'm not following, how can you attach to a running task from
> another CPU ?

Hi Peter, I make a little testcase which can reproduce the race
problem, on system with PSI disabled. Because when PSI enabled,
cgroup_move_task() will hold rq lock to assign task->cgroups.

```
#!/bin/bash

cd /sys/fs/cgroup/perf_event

mkdir cg1
mkdir cg2

perf stat -e cycles --cgroup /cg1 &

cg_run()
{
        cg=$1
        shift
        echo $BASHPID > $cg/cgroup.procs
        $@
}

cg_run cg1 schbench -r 100 &
cg_run cg2 schbench -r 100 &

while true; do
        for i in $(cat cg1/cgroup.procs); do
                echo $i > cg2/cgroup.procs
        done
        for i in $(cat cg2/cgroup.procs); do
                echo $i > cg1/cgroup.procs
        done
done
```

Some seconds later, dmesg will show the WARNING message:

[   51.777830] WARNING: CPU: 2 PID: 1849 at kernel/events/core.c:869 perf_cgroup_switch+0x246/0x290
[   51.779167] Modules linked in:
[   51.779696] CPU: 2 PID: 1849 Comm: schbench Not tainted 5.17.0-rc8 #28
[   51.780691] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   51.782353] RIP: 0010:perf_cgroup_switch+0x246/0x290
[   51.783145] Code: 0f 0b e9 0b ff ff ff 48 83 7c 24 08 00 74 0c e8 00 7e f7 ff fb 66 0f 1f 44 00 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b e9 4f fe ff ff e8 be 7e f7 ff e8 a9 1f 93 00 89 c0 49 c7 c5
[   51.785804] RSP: 0018:ffffba4440fcbd80 EFLAGS: 00010086
[   51.786617] RAX: 0000000000000002 RBX: ffff8d78eb8b7200 RCX: 0000000000000000
[   51.787696] RDX: 0000000000000000 RSI: ffffffffae1c83db RDI: ffffffffae185a69
[   51.788777] RBP: ffff8d78eb8aad40 R08: 0000000000000001 R09: 0000000000000001
[   51.789854] R10: 0000000000000000 R11: ffff8d78eb8b7220 R12: ffff8d78eb8b7208
[   51.790929] R13: ffff8d78eb8aafa0 R14: ffff8d74cd6bb600 R15: 0000000000000000
[   51.792006] FS:  00007fedaaffd700(0000) GS:ffff8d78eb880000(0000) knlGS:0000000000000000
[   51.793223] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   51.794122] CR2: 000055e4bf2b696c CR3: 00000001128a2003 CR4: 0000000000370ee0
[   51.795209] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   51.796292] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   51.797375] Call Trace:
[   51.797828]  <TASK>
[   51.798229]  __perf_event_task_sched_in+0x151/0x350
[   51.799009]  ? lock_release+0x1ed/0x2e0
[   51.799640]  finish_task_switch+0x1d3/0x2e0
[   51.800328]  ? __switch_to+0x136/0x4b0
[   51.800953]  __schedule+0x33e/0xae0
[   51.801535]  schedule+0x4e/0xc0
[   51.802080]  exit_to_user_mode_prepare+0x172/0x2a0
[   51.802850]  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
[   51.803675]  irqentry_exit_to_user_mode+0x5/0x40
[   51.804413]  sysvec_apic_timer_interrupt+0x5c/0xd0
[   51.805183]  asm_sysvec_apic_timer_interrupt+0x12/0x20

Thanks.

