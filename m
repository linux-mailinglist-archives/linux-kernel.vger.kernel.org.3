Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47504502615
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350929AbiDOHSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241498AbiDOHSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:18:41 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8660AAB4F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:16:09 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j2so13355167ybu.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wBcBHH/PMOFRThjI2yLsI4iV/L47XDeFwcTZ0pAL0k=;
        b=Ra5p3YxnUVyMIhwZz2xlFuEK6kV73zqhCP5qmtZkwQ1Nr4ou3o2JTvKHMPbW+E9FGg
         sv72IATx+hkDEATb4zF1ZrFX4gr41qtXPRuSf4L6tNfDOT6YpSff8GCMlxaHAFVQHcQd
         6Isj0+GTvPqPTrb9Frh5ROyBNYafLtTmsgJRSH4D1zzkYduZEJRAUGjm7GXrAQz3KagI
         LSV6XeN2v7KvFZRQPsKHHLitQ04zpfcHgOh8Kjjn7CP58cbTg/tiuPJksvjatdsShd47
         PFAmA1Y+qY4RIXsHoF62q5xhd9prZHA3/Oc/UADh9kR7yiVo3d3T+VWb84aIfafLX2AC
         S/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wBcBHH/PMOFRThjI2yLsI4iV/L47XDeFwcTZ0pAL0k=;
        b=Fscbzufjr9dVjSWqBEv2jJcstmzPS5wm1cLPbiKW1B+ip5qM6y2xrXED1HwLtqV8Hd
         JvluOWSbx/SEJ5JGpqKqqTzNMkdzpYxttS/z8DmtAkzLy3VzWXQWtKC5FL5vExZytjB+
         8dCAAY0lrkwKMPZQYYe89XTjeQvipdl9127BYqDx8vtdBtrPOvb7mgmptfSP3wq9rW22
         Hd3vx/3czjx1EwmbFEW1Zruzzlde7u3eXL1x99GZshCDX6VJBjB8z/PRUw+V02m2hqaz
         lWRekzuVwN3oUh/si4Yv8MylOitR9xFJCKAVRip+2ZPznzbHR+BfnUG8tdK5NsVV1yRL
         MjwQ==
X-Gm-Message-State: AOAM531KDWbVG9fv8k1/6KLc5snGuAQOh12TvvtROmiPjExq1tmdzQ82
        tmmmj/pGnR2mF1/jnAhgztdYj6npWCS3JUSpBqQ6lw==
X-Google-Smtp-Source: ABdhPJwM3+K5mNVc7L3rv/V/oPV2oQawuzlnT5LEvP1lIfhUxdhPVLEAm20g/2liwjRHfSDLd5RoEqpVVwUKN5oqI2Y=
X-Received: by 2002:a25:ad98:0:b0:641:ce37:e254 with SMTP id
 z24-20020a25ad98000000b00641ce37e254mr4462001ybi.241.1650006968504; Fri, 15
 Apr 2022 00:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411233447.rcencjivkhyltyxm@airbuntu> <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
 <CAKfTPtBWUvvFMsSnfcKsOpHFdvxvSWpjfuLpjwwQrwhQc7+xuw@mail.gmail.com>
 <20220413235719.xs72pm2kgihia46g@airbuntu> <CAKfTPtBtzmgJNM=2ekmE0-HT+r=qLqBJ6R1cggkGCNHbb3FPdQ@mail.gmail.com>
 <2956e0e1bbfe4309a749ebb3c8736799@AcuMS.aculab.com> <CAKfTPtB0EniWa_Wqx9596Zm5ZyoB3CRWwkgcYgxYB=318eWsWQ@mail.gmail.com>
 <5fc162f60ba84ab3a61992084d76c726@AcuMS.aculab.com>
In-Reply-To: <5fc162f60ba84ab3a61992084d76c726@AcuMS.aculab.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Apr 2022 09:15:57 +0200
Message-ID: <CAKfTPtDFZ+Kom5=2Eo8OPaw0v3d0fnxBHgWYLinGp3jHnx0BhA@mail.gmail.com>
Subject: Re: Scheduling tasks on idle cpu
To:     David Laight <David.Laight@aculab.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parth@linux.ibm.com" <parth@linux.ibm.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "pkondeti@codeaurora.org" <pkondeti@codeaurora.org>,
        "Valentin.Schneider@arm.com" <Valentin.Schneider@arm.com>,
        "patrick.bellasi@matbug.net" <patrick.bellasi@matbug.net>,
        "pjt@google.com" <pjt@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "qperret@google.com" <qperret@google.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Wei Wang <wvw@google.com>
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

On Thu, 14 Apr 2022 at 16:14, David Laight <David.Laight@aculab.com> wrote:
>
> From: Vincent Guittot
> > Sent: 14 April 2022 11:17
> ...
> > > > David can rerun is use case after disabling sched_feat(SIS_PROP)
> > >
> > > How would I do that?
> >
> > echo NO_SIS_PROP > /sys/kernel/debug/sched/features
>
> That may not be in the kernel I'm using.
>
> # cat /sys/kernel/debug/sched_features
> GENTLE_FAIR_SLEEPERS START_DEBIT NO_NEXT_BUDDY LAST_BUDDY CACHE_HOT_BUDDY WAKEUP_PREEMPTION ARCH_POWER NO_HRTICK NO_DOUBLE_TICK LB_BIAS NONTASK_POWER TTWU_QUEUE RT_RUNTIME_SHARE NO_LB_MIN NUMA NUMA_FAVOUR_HIGHER NO_NUMA_RESIST_LOWER

SIS_PROP has been normally added in v4.13  so I wonder which kernel
version you are using
Before SIS_PROP, the policy was either to loop all cpu or none
depending of avg_idle and avg_cost

>
> I've been looking at another ftrace output.
> The scheduler does like migrating the process to the current cpu.
> I have seen it migrate from one idle cpu to another idle cpu.
> I've not seen it migrate from an idle cpu to the current cpu.
>   (But I've not looked hard.)
>
> These are all the migrates:
>     TiNG task:12-1005  [026] d... 1111081.796560: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=11 dest_cpu=16
>     TiNG task:31-1026  [005] d... 1111081.836556: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=16 dest_cpu=11
>     TiNG task:28-1023  [033] d... 1111081.856589: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=11 dest_cpu=33
>     TiNG task:11-1004  [013] d... 1111081.856606: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=33 dest_cpu=13
>     TiNG task:19-1012  [002] d... 1111081.896564: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=13 dest_cpu=10
>     TiNG task:26-1019  [008] d... 1111081.956551: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=10 dest_cpu=18
>     TiNG task:34-1029  [001] d... 1111082.016527: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=18 dest_cpu=1
>     TiNG task:20-1013  [021] d... 1111082.016589: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=1 dest_cpu=21
>     TiNG task:32-1027  [000] d... 1111082.036455: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=21 dest_cpu=2
>     TiNG task:15-1008  [006] d... 1111082.056539: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=2 dest_cpu=14
>     TiNG task:34-1029  [001] d... 1111082.076536: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=14 dest_cpu=1
>     TiNG task:21-1014  [004] d... 1111082.076589: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=1 dest_cpu=4
>     TiNG task:11-1004  [013] d... 1111082.096526: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=4 dest_cpu=13
>     TiNG task:28-1023  [033] d... 1111082.096584: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=13 dest_cpu=33
>     TiNG task:25-1018  [029] d... 1111082.116549: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=33 dest_cpu=11
>     TiNG task:27-1020  [032] d... 1111082.176519: sched_migrate_task: comm=RTP sockets pid=990 prio=120 orig_cpu=11 dest_cpu=16
> There are a couple of places where there 2 wakeups before the schedule.
> The scheduler definitely doesn't like waking up a process on an even cpu from on odd one.

odd and even cpus don't belong to the same llc and we only migrate in
the llc at wakeup

> But there are also the 13->33 and 1->21 ones.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
