Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2150F36B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbiDZIM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbiDZIMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:12:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B41212C8C8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:09:47 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id p65so31494023ybp.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MO0SAYWlxIdf9DEpmMwZioSXQuy43DY18gZl0F6LMjk=;
        b=xaaQ8/zzHCUnHalSZlS6+zqSI2jDcTnNs/gGVfe3X+rXJceNfyx51heYYfmgNTUxy9
         zZtL/xGKD4NsOhEi0oEblv4gz3TocboP6jR/rR1XzSqOxVA1OT6+q6reMfxMwT3x9DBi
         sdUYTMv7JaxBilvbCbrRB2QvYv5SYZhA9rtKR1oA/uHRPNAQls0Xp09bXhY5szBMfIiH
         jczyjgn9pPTGOJBrdQXe9UNw7sBDPg0CrLvv3GuZ7gkMY3CaoOVMEBNCWkE52o9kXnwW
         df5lrCDuH+r+jUglgw+lhlHmPmVCtB9Rpb2phsw7FsuIasAADOib2v5V/y8GyRPrWhnA
         CUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MO0SAYWlxIdf9DEpmMwZioSXQuy43DY18gZl0F6LMjk=;
        b=bJuOAOWeVSoviKu1wu3hySELU9d+wGBZTSrUB2LEBkVkncvSS06qeXUeg3ZxdK1OdF
         8DUhkjhmKYDzDf3gK+hhcm/RC/w6pXc1utg/72o9bo9VWPGkDnKGIAmXVgJUxGoXT4OL
         zC1t+LHQLYhdYw4E1dpZ/ytt2TFeTq3uM8aXeIBZPCE2iuEy2pcrr/JDeMssF43zRZMk
         ecBt38NAvXTbYPTG3mvEUhWqWhV9sdRmaF7sP6svvF+Nn3P7SbggRTUABJpsRi72a71v
         LkKNUgGMyeRa8W8kf1Xzwph9FyeQLYhCS9EtErNQF/s3qPI8vQm56zT366O5+216zo3b
         OFEg==
X-Gm-Message-State: AOAM531LyI5tS/OTt/jb3Z9mrRjS9OOMw2/qPVIUMZg5/jKl7gU1px+o
        H6ipTCWFVcZlZBJgJFU4ttrkObJ6ifOP3773R4sjeg==
X-Google-Smtp-Source: ABdhPJwjSvz8z2JyWVttrO2z9jByltpzGheHLjfIPGM58tgkdZ/Bd5EEc3NkHR4LTsoxqIVahguTNE27EKHr61sfBXY=
X-Received: by 2002:a05:6902:1c2:b0:63e:6bd:3a5b with SMTP id
 u2-20020a05690201c200b0063e06bd3a5bmr19081324ybh.424.1650960586619; Tue, 26
 Apr 2022 01:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
 <20220421161509.asz25zmh25eurgrk@airbuntu> <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
 <20220425161209.ydugtrs3b7gyy3kk@airbuntu> <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
In-Reply-To: <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 26 Apr 2022 10:09:35 +0200
Message-ID: <CAKfTPtBswQ6bk8MrvcLmqc-9V2-SeWn3H_-gRvF5isdjL_acqA@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
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

On Tue, 26 Apr 2022 at 04:07, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> On Tue, Apr 26, 2022 at 12:12 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 04/25/22 09:31, Xuewen Yan wrote:
> > > On Fri, Apr 22, 2022 at 12:15 AM Qais Yousef <qais.yousef@arm.com> wr=
ote:
> > > > Is it okay to share what the capacities of the littles, mediums and=
 bigs on
> > > > your system? And how they change under worst case scenario thermal =
pressure?
> > > > Only IF you have these numbers handy :-)
> > >
> > > Okay, the little/mid/big cpu scale capacity is 350/930/1024, but the
> > > cpu frequency point is discrete, the big core's high freq point may i=
s
> > > just a few more than the mid core's highest.
> > > In this case, once the thermal decrease the scaling_max_freq, the
> > > maximum frequency of the large core is easily lower than that of the
> > > medium core.
> > > Of course, the corner case is due to the frequency design of the soc
> > > and  our thermal algorithm.
> >
> > Okay, thanks for the info!
> >
> > >
> > > >
> > > > Is it actually an indication of a potential other problem if you sw=
ing into
> > > > capacity inversion in the bigs that often? I've seen a lot of syste=
ms where the
> > > > difference between the meds and bigs is small. But frequent inversi=
on could be
> > > > suspicious still.
> > > >
> > > > Do the littles and the mediums experience any significant thermal p=
ressure too?
> > >
> > > In our platform, it's not.
> >
> > Good.
> >
> > > > It doesn't seem it'll cause a significant error, but still it seems=
 to me this
> > > > function wants the original capacity passed to it.
> > > >
> > > > There are similar questions to be asked since you modify sg_cpu->ma=
x. Every
> > > > user needs to be audited if they're fine with this change or not.
> > > >
> > > > I'm not sure still what we are achieving here. You want to force sc=
hedutil not
> > > > to request higher frequencies if thermal pressure is high? Should s=
chedutil
> > > > actually care? Shouldn't the cpufreq driver reject this request and=
 pick the
> > > > next best thing if it can't satisfy it? I could be missing somethin=
g, I haven't
> > > > looked that hard tbh :-)
> > >
> > > I changed this just want to make it more responsive to the real
> > > capacity of the cpu, if it will cause other problems, maybe it would
> > > be better not to change it.:)
> >
> > There are others who can give you a better opinion. But AFAICS we're no=
t fixing
> > anything but risking breaking other things. So I vote for not to change=
 it :)
> >
> > > > It depends on the severity of the problem. The simplest thing I can=
 suggest is
> > > > to check if the cpu is in capacity inversion state, and if it is, t=
hen make
> > > > rt_task_fits_capacity() return false always.
> > > >
> > > > If we need a generic solution to handle thermal pressure omitting O=
PPs, then
> > > > the search needs to become more complex. The proposal in this patch=
 is not
> > > > adequate because tasks that want to run at capacity_orig_of(cpu) wi=
ll wrongly
> > > > omit some cpus because of any tiny thermal pressure. For example if=
 the
> > > > capacity_orig_of(medium_cpu) =3D 700, and uclamp_min for RT is set =
to 700, then
> > > > any small thermal pressure on mediums will cause these tasks to run=
 on big cpus
> > > > only, which is not what we want. Especially if these big cpus can e=
nd up in
> > > > capacity inversion later ;-)
> > > >
> > > > So if we want to handle this case, then we need to ensure the searc=
h returns
> > > > false only if
> > > >
> > > >         1. Thermal pressure results in real OPP to be omitted.
> > > >         2. Another CPU that can provide this performance level is a=
vailable.
> > > >
> > > > Otherwise we should still fit it on this CPU because it'll give us =
the closest
> > > > thing to what was requested.
> > > >
> > > > I can think of 2 ways to implement this, but none of them seem part=
icularly
> > > > pretty :-/
> > >
> > > Maybe as Lukasz Luba said:
> > >
> > > https://lore.kernel.org/all/ae98a861-8945-e630-8d4c-8112723d1007@arm.=
com/
> > >
> > > > Let's meet in the middle:
> > > > 1) use the thermal PELT signal in RT:
> > > > capacity =3D capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu))
> > > > 2) introduce a more configurable thermal_pressure shifter instead
> > > > 'sched_thermal_decay_shift', which would allow not only to make the
> > > > decaying longer, but also shorter when the platform already might d=
o
> > > > that, to not cause too much traffic.
> > >
> > > But even if this is changed, there will still be the same problem, I
> > > look forward to Lukasz's patch:)
> >
> > This will not address my concern unless I missed something.
> >
> > The best (simplest) way forward IMHO is to introduce a new function
> >
> >         bool cpu_in_capacity_inversion(int cpu);
> >
> > (feel free to pick another name) which will detect the scenario you're =
in. You
> > can use this function then in rt_task_fits_capacity()
> >
> >         diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> >         index a32c46889af8..d48811a7e956 100644
> >         --- a/kernel/sched/rt.c
> >         +++ b/kernel/sched/rt.c
> >         @@ -462,6 +462,9 @@ static inline bool rt_task_fits_capacity(st=
ruct task_struct *p, int cpu)
> >                 if (!static_branch_unlikely(&sched_asym_cpucapacity))
> >                         return true;
> >
> >         +       if (cpu_in_capacity_inversion(cpu))
> >         +               return false;
> >         +
> >                 min_cap =3D uclamp_eff_value(p, UCLAMP_MIN);
> >                 max_cap =3D uclamp_eff_value(p, UCLAMP_MAX);
> >
> > You'll probably need to do something similar in dl_task_fits_capacity()=
.
> >
> > This might be a bit aggressive though as we'll steer away all RT tasks =
from
> > this CPU (as long as there's another CPU that can fit it). I need to th=
ink more
> > about it. But we could do something like this too
> >
> >         diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> >         index a32c46889af8..f2a34946a7ab 100644
> >         --- a/kernel/sched/rt.c
> >         +++ b/kernel/sched/rt.c
> >         @@ -462,11 +462,14 @@ static inline bool rt_task_fits_capacity(=
struct task_struct *p, int cpu)
> >                 if (!static_branch_unlikely(&sched_asym_cpucapacity))
> >                         return true;
> >
> >         +       cpu_cap =3D capacity_orig_of(cpu);
> >         +
> >         +       if (cpu_in_capacity_inversion(cpu))
>
> It's  a good idea, but as you said, in mainline, the
> sysctl_sched_uclamp_util_min_rt_default is always 1024,
> Maybe it's better to add it to the judgment?
>
>  +       if (sysctl_sched_uclamp_util_min_rt_default !=3D
> SCHED_CAPACITY_SCALE && cpu_in_capacity_inversion(cpu))
>
> >         +               cpu_cap -=3D thermal_load_avg(cpu_rq(cpu));
>
> Why use thermal_load_avg? If thermal is always in effect=EF=BC=8Cthe
> thermal_load_avg would get bigger and bigger, as a result, the cpu_cap
> maybe smaller than (capacity_orig - thermal_pressure).

For a fixed thermal_pressure(), thermal_load_avg() will not be higher
than thermal_pressure() but will increase to reach thermal_pressure()

In the current implementation for sched_asym_cpucapacity topology, we
do a 1st iteration trying to find a cpu that fits a task's capacity
but if it fails, we run a normal cpupri_find that doesn't care about
capacity.

Do I understand correctly that in your case you would like to run
a 1st iteration that takes into account capacity_orig_of(cpu) -
thermal_load_avg(cpu_rq(cpu))
If it fails run another iteration only with capacity_orig_of(cpu)
and finally tries without capacity constraint

>
> Thanks!
>
> >         +
> >                 min_cap =3D uclamp_eff_value(p, UCLAMP_MIN);
> >                 max_cap =3D uclamp_eff_value(p, UCLAMP_MAX);
> >
> >         -       cpu_cap =3D capacity_orig_of(cpu);
> >         -
> >                 return cpu_cap >=3D min(min_cap, max_cap);
> >          }
> >          #else
> >
> > Thoughts?
>
> >
> >
> > Thanks!
> >
> > --
> > Qais Yousef
