Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C49A500AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbiDNKUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiDNKTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:19:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36DE71A06
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:16:49 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i20so8531867ybj.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDa3LynvAWi9G+t+qDhkZRMBEIo8Z9HoZR7DqBkZoTw=;
        b=An3vk4uE3ZKFrbF1hAOQIl6/JG9QKiJVxe6AxjV0nZqCr7Kz/Wi2u5+nxew/idPPIZ
         ESqg8cvJZoA+AYHcMR4JVf9zGir9PAvp2JoCFjEf8mcgB9GyfpqpP4B1iVrpSyPuduuZ
         RavZ/OOL563MxsK7nV5k5VtBQivOPW/Yz2qpYSI7mNwgweHB8WtspbsP1BVf3RsUin+s
         YvIiKnRjh1vW2Zply5d++0ktoQz4n2Pt8KQnJnhh9e7aLF+m1psDF6Ky8+4T/w5YQ2Wb
         ljK0k4qKcb9IOjJ1kx23YYbzw2AHxEIWkplQlsWSjXe4xGMit3B7iJpNlACbJwS88dBf
         RxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDa3LynvAWi9G+t+qDhkZRMBEIo8Z9HoZR7DqBkZoTw=;
        b=pEkJLT28NUgDxR29cbXe8hYsikzN3PcI3/2c/IXvtgJ2eeYbww7x4mJqAXnCbTOSzT
         uWMOBFf0eol+vQH/bDDKgChxWCrHSrzUxAy9ntH4l8AOqqqhgXVlImzS5r6Eb/d1QZTL
         VKPxjdcFXtpJbUuNAcevqtJ50PDeP5+wslscBdRC312mKf7ErAP5xgzrOshqgA5AlKlM
         rqzv/FwGF18dTGTHNHDgpoKkzzodHIm5nvoGqOuiQAuBbTodv36qrRX5CxOVB68b8f36
         jUxSw0zwv0kx74w8t4jDhlOVZMlAll/qftjkRAUi99jYjcusbB/DWpQFcaZglXTbV5D1
         gMog==
X-Gm-Message-State: AOAM532hxXypFLBdQ3DUTn62t6mVAuiuyNwmucDWX/tsmNJ+lRreRsGO
        qzDkXGajOnY317Zp1rKDhf+6wgelcGSkLYuqRV++mw==
X-Google-Smtp-Source: ABdhPJyUoyz9HxUuWijcfs8B79lAnJ1m33JWanb2J3NFOpZtRwEccgqzlRv/mN00zGG0MR6dhLl3v5pc9ex6vK3Cpnw=
X-Received: by 2002:a25:e703:0:b0:641:f7ba:cda7 with SMTP id
 e3-20020a25e703000000b00641f7bacda7mr812557ybh.211.1649931408712; Thu, 14 Apr
 2022 03:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <030aacb0c1304e43ab917924dcf4f138@AcuMS.aculab.com>
 <20220411233447.rcencjivkhyltyxm@airbuntu> <4ca5cd70904d47bea0df93f7c0979c66@AcuMS.aculab.com>
 <CAKfTPtBWUvvFMsSnfcKsOpHFdvxvSWpjfuLpjwwQrwhQc7+xuw@mail.gmail.com>
 <20220413235719.xs72pm2kgihia46g@airbuntu> <CAKfTPtBtzmgJNM=2ekmE0-HT+r=qLqBJ6R1cggkGCNHbb3FPdQ@mail.gmail.com>
 <2956e0e1bbfe4309a749ebb3c8736799@AcuMS.aculab.com>
In-Reply-To: <2956e0e1bbfe4309a749ebb3c8736799@AcuMS.aculab.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Apr 2022 12:16:37 +0200
Message-ID: <CAKfTPtB0EniWa_Wqx9596Zm5ZyoB3CRWwkgcYgxYB=318eWsWQ@mail.gmail.com>
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

On Thu, 14 Apr 2022 at 10:35, David Laight <David.Laight@aculab.com> wrote:
>
> From: Vincent Guittot
> > Sent: 14 April 2022 08:54
> >
> > On Thu, 14 Apr 2022 at 01:57, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 04/12/22 11:07, Vincent Guittot wrote:
> > > > On Tue, 12 Apr 2022 at 10:39, David Laight <David.Laight@aculab.com> wrote:
> > > > > Yes I want the CFS scheduler to pick an idle cpu in preference
> > > > > to an active RT one.
> > > >
> > > > When task 34512 wakes up, scheduler checks if prev or this cpu are
> > > > idle which is not the case for you. Then, it compares the load of prev
> > > > and this_cpu and seems to select this_cpu (cpu17).
> > > >
> > > > Once cpu17 selected, it will try to find an idle cpu which shares LLC
> > > > but it seems that the scheduler didn't find one and finally keeps task
> > > > 34512 on this_cpu.
> > > >
> > > > Note that during the next tick, a load balance will be trigger if
> > > > this_cpu still have both RT and task 34512,
> > >
> > > David said there are idle cpus
> > >
> > >         "  There are two physical cpu with 20 cores each (with hyperthreading).
> > >         16, 18, 34, 36 and 38 were idle. So both 16 and 18 should be on the
> > >         same NUMA node. All the others are running the same RT thread code.  "
> > >
> > > Except for the possibility of them becoming idle just after the task has woken
> > > up, shouldn't one of them have been picked?
> >
> > we don't loop on all cpus in the LLC to find an idle one but compute a
> > reasonable number of iteration based on the avg_idle
>
> Is there a way to dump the kernel NUMA/LLC tables?
> This might be relevant (with everything idle):
> # cat /proc/schedstat
> version 15
> timestamp 5388989193
> cpu0 0 0 0 0 0 0 117226041384582 250531565354 206276873
> domain0 00,00100001 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> domain1 55,55555555 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> domain2 ff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> cpu1 0 0 0 0 0 0 115978661288718 251736933814 297093280
> domain0 00,00200002 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> domain1 aa,aaaaaaaa 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> domain2 ff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> All the later cpu follow the same pattern (domain0 shifts left every cpu).
>
> I could interpret that as meaning:
> cpu n and (n + 20) are the hyperthreading pairs.
> Even numbered cpu are on one chip, odd numbered on the other.
>
> The migrate was:
>   34533 [017]: sched_migrate_task: pid=34512 prio=120 orig_cpu=14 dest_cpu=17
> All the idle cpu were even.
>
> > David can rerun is use case after disabling sched_feat(SIS_PROP)
>
> How would I do that?

echo NO_SIS_PROP > /sys/kernel/debug/sched/features

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
