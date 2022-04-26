Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C818850FA6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiDZKap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348793AbiDZKa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:30:28 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE81CB03B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:06:29 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2f16645872fso176162487b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2mfYh1WYoQqyzbevOyCNmK7afan85oSbTYAVCu2SIpM=;
        b=VOUCxbzLCayzyG9rVZhrf1FbvbI1qUjD3BCbbOcyigl6JGEmcK4r9hQS3p79EiSFic
         YkC68djToBM0LCqr21jG6L4DjAQ1oL4ufQVuOB1nzF+WPtK/3mf4I02+Nb3QNOvyqu/y
         p/jK0B/H1vL8BtNg/oFgIU5NTnbuBJzFE8a0rju2EQh+W3ctsPJC6tsRhul7JXXZMx4o
         C45hw1i2eYANQdHvVDtdK7DelzUjiC3xS7uBPJYjyNYq/TRvlHb0YacuERxvDwBF25PG
         nfxoL1WzfxuhuNQ6UXeHDodPwETFS6JikelwPnL2XEJeCLB8LBW9hFQ/5jRN4uF3yciX
         qCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2mfYh1WYoQqyzbevOyCNmK7afan85oSbTYAVCu2SIpM=;
        b=mMUOdRBpOqGssWrdpdPnIHQ1GOz7PiDtThy1mI1fr2HDMiPBMo+pRN4kqAbKxoU4iA
         DwKLhZRO+kyryuddmZeD5BFms3HWSiMe0aCpUe8auyZU8EgJuPsLmjWzOT1WlD4SEYj1
         BxlWaK6YlvNc0L+2KKZIZcRp4wEo/XZ/7MuyRHJpGS7pz17+ECigz/XpurW3pbdYH+87
         ZOpXZ3E1hVpRhf4Omiq2WaDriv+gSeg/fCYw3H4gPXZfG7FUgyaMfBeu4yWlofSXsjTB
         1QxngjfifQPhPJZFMQit44Zo5fMucpKD7Dw9wdW3LEtwSXuvkM91LvyUB0j8Dh4RWHaa
         C2Bw==
X-Gm-Message-State: AOAM531vU2VdxP218qidqZpimEqKaA/y5wBbEeAtO0nAUCZYUPd7fjlS
        9exsYNTQbx/fa2OHtv9NK0/ijfpvkb0erZvRas0mpuXCFkU=
X-Google-Smtp-Source: ABdhPJwFT7DwUaa+lZEIVbNkfPGhmw0NdajXV25JxaZLtr66pVJvmRhJna6916tL8TXv7jEqGZUj5qDWAGYha0kfv80=
X-Received: by 2002:a0d:df87:0:b0:2f7:cd38:22d7 with SMTP id
 i129-20020a0ddf87000000b002f7cd3822d7mr12980912ywe.67.1650967588657; Tue, 26
 Apr 2022 03:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
 <20220421161509.asz25zmh25eurgrk@airbuntu> <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
 <20220425161209.ydugtrs3b7gyy3kk@airbuntu> <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
 <CAKfTPtBswQ6bk8MrvcLmqc-9V2-SeWn3H_-gRvF5isdjL_acqA@mail.gmail.com> <20220426093056.uxnsz4tv4vhvbipe@airbuntu>
In-Reply-To: <20220426093056.uxnsz4tv4vhvbipe@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 26 Apr 2022 12:06:17 +0200
Message-ID: <CAKfTPtDtpYs38aZG8UVkbrrWxbARKwFnV204vjRoyf58K=+4oQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 at 11:31, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 04/26/22 10:09, Vincent Guittot wrote:
> > On Tue, 26 Apr 2022 at 04:07, Xuewen Yan <xuewen.yan94@gmail.com> wrote=
:
> > >
> > > On Tue, Apr 26, 2022 at 12:12 AM Qais Yousef <qais.yousef@arm.com> wr=
ote:
> > > >
> > > > On 04/25/22 09:31, Xuewen Yan wrote:
> > > > > On Fri, Apr 22, 2022 at 12:15 AM Qais Yousef <qais.yousef@arm.com=
> wrote:
> > > > > > Is it okay to share what the capacities of the littles, mediums=
 and bigs on
> > > > > > your system? And how they change under worst case scenario ther=
mal pressure?
> > > > > > Only IF you have these numbers handy :-)
> > > > >
> > > > > Okay, the little/mid/big cpu scale capacity is 350/930/1024, but =
the
> > > > > cpu frequency point is discrete, the big core's high freq point m=
ay is
> > > > > just a few more than the mid core's highest.
> > > > > In this case, once the thermal decrease the scaling_max_freq, the
> > > > > maximum frequency of the large core is easily lower than that of =
the
> > > > > medium core.
> > > > > Of course, the corner case is due to the frequency design of the =
soc
> > > > > and  our thermal algorithm.
> > > >
> > > > Okay, thanks for the info!
> > > >
> > > > >
> > > > > >
> > > > > > Is it actually an indication of a potential other problem if yo=
u swing into
> > > > > > capacity inversion in the bigs that often? I've seen a lot of s=
ystems where the
> > > > > > difference between the meds and bigs is small. But frequent inv=
ersion could be
> > > > > > suspicious still.
> > > > > >
> > > > > > Do the littles and the mediums experience any significant therm=
al pressure too?
> > > > >
> > > > > In our platform, it's not.
> > > >
> > > > Good.
> > > >
> > > > > > It doesn't seem it'll cause a significant error, but still it s=
eems to me this
> > > > > > function wants the original capacity passed to it.
> > > > > >
> > > > > > There are similar questions to be asked since you modify sg_cpu=
->max. Every
> > > > > > user needs to be audited if they're fine with this change or no=
t.
> > > > > >
> > > > > > I'm not sure still what we are achieving here. You want to forc=
e schedutil not
> > > > > > to request higher frequencies if thermal pressure is high? Shou=
ld schedutil
> > > > > > actually care? Shouldn't the cpufreq driver reject this request=
 and pick the
> > > > > > next best thing if it can't satisfy it? I could be missing some=
thing, I haven't
> > > > > > looked that hard tbh :-)
> > > > >
> > > > > I changed this just want to make it more responsive to the real
> > > > > capacity of the cpu, if it will cause other problems, maybe it wo=
uld
> > > > > be better not to change it.:)
> > > >
> > > > There are others who can give you a better opinion. But AFAICS we'r=
e not fixing
> > > > anything but risking breaking other things. So I vote for not to ch=
ange it :)
> > > >
> > > > > > It depends on the severity of the problem. The simplest thing I=
 can suggest is
> > > > > > to check if the cpu is in capacity inversion state, and if it i=
s, then make
> > > > > > rt_task_fits_capacity() return false always.
> > > > > >
> > > > > > If we need a generic solution to handle thermal pressure omitti=
ng OPPs, then
> > > > > > the search needs to become more complex. The proposal in this p=
atch is not
> > > > > > adequate because tasks that want to run at capacity_orig_of(cpu=
) will wrongly
> > > > > > omit some cpus because of any tiny thermal pressure. For exampl=
e if the
> > > > > > capacity_orig_of(medium_cpu) =3D 700, and uclamp_min for RT is =
set to 700, then
> > > > > > any small thermal pressure on mediums will cause these tasks to=
 run on big cpus
> > > > > > only, which is not what we want. Especially if these big cpus c=
an end up in
> > > > > > capacity inversion later ;-)
> > > > > >
> > > > > > So if we want to handle this case, then we need to ensure the s=
earch returns
> > > > > > false only if
> > > > > >
> > > > > >         1. Thermal pressure results in real OPP to be omitted.
> > > > > >         2. Another CPU that can provide this performance level =
is available.
> > > > > >
> > > > > > Otherwise we should still fit it on this CPU because it'll give=
 us the closest
> > > > > > thing to what was requested.
> > > > > >
> > > > > > I can think of 2 ways to implement this, but none of them seem =
particularly
> > > > > > pretty :-/
> > > > >
> > > > > Maybe as Lukasz Luba said:
> > > > >
> > > > > https://lore.kernel.org/all/ae98a861-8945-e630-8d4c-8112723d1007@=
arm.com/
> > > > >
> > > > > > Let's meet in the middle:
> > > > > > 1) use the thermal PELT signal in RT:
> > > > > > capacity =3D capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cp=
u))
> > > > > > 2) introduce a more configurable thermal_pressure shifter inste=
ad
> > > > > > 'sched_thermal_decay_shift', which would allow not only to make=
 the
> > > > > > decaying longer, but also shorter when the platform already mig=
ht do
> > > > > > that, to not cause too much traffic.
> > > > >
> > > > > But even if this is changed, there will still be the same problem=
, I
> > > > > look forward to Lukasz's patch:)
> > > >
> > > > This will not address my concern unless I missed something.
> > > >
> > > > The best (simplest) way forward IMHO is to introduce a new function
> > > >
> > > >         bool cpu_in_capacity_inversion(int cpu);
> > > >
> > > > (feel free to pick another name) which will detect the scenario you=
're in. You
> > > > can use this function then in rt_task_fits_capacity()
> > > >
> > > >         diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > > >         index a32c46889af8..d48811a7e956 100644
> > > >         --- a/kernel/sched/rt.c
> > > >         +++ b/kernel/sched/rt.c
> > > >         @@ -462,6 +462,9 @@ static inline bool rt_task_fits_capacit=
y(struct task_struct *p, int cpu)
> > > >                 if (!static_branch_unlikely(&sched_asym_cpucapacity=
))
> > > >                         return true;
> > > >
> > > >         +       if (cpu_in_capacity_inversion(cpu))
> > > >         +               return false;
> > > >         +
> > > >                 min_cap =3D uclamp_eff_value(p, UCLAMP_MIN);
> > > >                 max_cap =3D uclamp_eff_value(p, UCLAMP_MAX);
> > > >
> > > > You'll probably need to do something similar in dl_task_fits_capaci=
ty().
> > > >
> > > > This might be a bit aggressive though as we'll steer away all RT ta=
sks from
> > > > this CPU (as long as there's another CPU that can fit it). I need t=
o think more
> > > > about it. But we could do something like this too
> > > >
> > > >         diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > > >         index a32c46889af8..f2a34946a7ab 100644
> > > >         --- a/kernel/sched/rt.c
> > > >         +++ b/kernel/sched/rt.c
> > > >         @@ -462,11 +462,14 @@ static inline bool rt_task_fits_capac=
ity(struct task_struct *p, int cpu)
> > > >                 if (!static_branch_unlikely(&sched_asym_cpucapacity=
))
> > > >                         return true;
> > > >
> > > >         +       cpu_cap =3D capacity_orig_of(cpu);
> > > >         +
> > > >         +       if (cpu_in_capacity_inversion(cpu))
> > >
> > > It's  a good idea, but as you said, in mainline, the
> > > sysctl_sched_uclamp_util_min_rt_default is always 1024,
> > > Maybe it's better to add it to the judgment?
> > >
> > >  +       if (sysctl_sched_uclamp_util_min_rt_default !=3D
> > > SCHED_CAPACITY_SCALE && cpu_in_capacity_inversion(cpu))
> > >
> > > >         +               cpu_cap -=3D thermal_load_avg(cpu_rq(cpu));
> > >
> > > Why use thermal_load_avg? If thermal is always in effect=EF=BC=8Cthe
> > > thermal_load_avg would get bigger and bigger, as a result, the cpu_ca=
p
> > > maybe smaller than (capacity_orig - thermal_pressure).
> >
> > For a fixed thermal_pressure(), thermal_load_avg() will not be higher
> > than thermal_pressure() but will increase to reach thermal_pressure()
> >
> > In the current implementation for sched_asym_cpucapacity topology, we
> > do a 1st iteration trying to find a cpu that fits a task's capacity
> > but if it fails, we run a normal cpupri_find that doesn't care about
> > capacity.
> >
> > Do I understand correctly that in your case you would like to run
> > a 1st iteration that takes into account capacity_orig_of(cpu) -
> > thermal_load_avg(cpu_rq(cpu))
> > If it fails run another iteration only with capacity_orig_of(cpu)
> > and finally tries without capacity constraint
>
> Wouldn't this be expensive to have 3 loops? That was my other suggestion =
but
> wasn't sure the complexity was worth it. So I suggested handling the capa=
city
> inversion case only.

3 loops might be too expensive. I mainly want to make sure to
understand what should be done to fix Xuewen case without breaking
others. Then we can see how to optimize this in a reasonable number of
loop

>
>
> Thanks
>
> --
> Qais Yousef
