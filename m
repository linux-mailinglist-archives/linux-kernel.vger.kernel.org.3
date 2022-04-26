Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE750EE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiDZCLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiDZCK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:10:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F531F62E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:07:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y19so8842296ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 19:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pXEkOmmSsTJFz31b0SJkYcwiI42fXsEpYKdly29pDBQ=;
        b=Em6lIrQk6KiF2V8eI7qtoUbCg0vszwwLhceUQHk5KfYy/P4khEcaZefP7UcLqsEM95
         M4pYQUKnrz+VfmUhnU0WeKoVRxWnTHYtsoBaiApKdnnvx3bp7m59R/GGdnuJmRunXpeu
         l1KYOP2hyQks/N8ipWt/77FMTvjayTeKT1LIZ98B41WW60AI38uSJ5qHnVqa7wUWAanC
         heTua7mwRvm0O8FxwEXIBal4nrOrp02dbUnWrwZ85XwD7fpKp4CMKVfT19jIVUYVthUO
         oA46BnlyWjq1zHdcBTcrwJZT0fwVC+OUbg9CDkdMSs5VvzuspVgKoIMPCUgqZJhOoWfx
         GT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pXEkOmmSsTJFz31b0SJkYcwiI42fXsEpYKdly29pDBQ=;
        b=RmMiCveuFnMEm88md1NDtsUfbKM9lKbuqeANgg4KDdDKnYK8bRltv8lJADQJESA85z
         q0htcWR+YHuv6L16EKmHfieGyi5wzfQdHsXaraUlffcEXimwKIiWQ1VE29BWkYOid2fC
         R4ZoelFuO2KJYFWpn4aVIsQHG5Yi2L+f9yEIEYVYm3dHng4oSgTCju9Uh8SNjc8HUg22
         z0jAOb6xuOQhH88rTOc9/AgEdHaj9ljMAqdZXd3jg1W0LUwQKEgR+mfEL1RolewpN0Z6
         lmcVtQPpyDEMP5Qld3ra3Sji64CeFlyZxn8S7DbcccTrHeH5aT2LNZl3aJn72bTPDzKD
         t/2Q==
X-Gm-Message-State: AOAM530SmtpPQ4YYnL9ojP15alny4/q6LGJVsqiWQGTgd2ClCOfViiCR
        PpH0FfhiMBnTci7sYuhZIYfb/KIjDu+GI9R7BTRHEDLuAgw=
X-Google-Smtp-Source: ABdhPJx0hNE0LbwawJRi+bqnBmcrYzVzr31Ay7Su+c0Xc4+VVAqDBtBzPeQNhLi2xXH/FDDv318RmPxKccYMSC8EZDw=
X-Received: by 2002:a2e:a78b:0:b0:24e:f008:fbe0 with SMTP id
 c11-20020a2ea78b000000b0024ef008fbe0mr13128096ljf.416.1650938870055; Mon, 25
 Apr 2022 19:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
 <20220421161509.asz25zmh25eurgrk@airbuntu> <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
 <20220425161209.ydugtrs3b7gyy3kk@airbuntu>
In-Reply-To: <20220425161209.ydugtrs3b7gyy3kk@airbuntu>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 26 Apr 2022 10:07:39 +0800
Message-ID: <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:12 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 04/25/22 09:31, Xuewen Yan wrote:
> > On Fri, Apr 22, 2022 at 12:15 AM Qais Yousef <qais.yousef@arm.com> wrot=
e:
> > > Is it okay to share what the capacities of the littles, mediums and b=
igs on
> > > your system? And how they change under worst case scenario thermal pr=
essure?
> > > Only IF you have these numbers handy :-)
> >
> > Okay, the little/mid/big cpu scale capacity is 350/930/1024, but the
> > cpu frequency point is discrete, the big core's high freq point may is
> > just a few more than the mid core's highest.
> > In this case, once the thermal decrease the scaling_max_freq, the
> > maximum frequency of the large core is easily lower than that of the
> > medium core.
> > Of course, the corner case is due to the frequency design of the soc
> > and  our thermal algorithm.
>
> Okay, thanks for the info!
>
> >
> > >
> > > Is it actually an indication of a potential other problem if you swin=
g into
> > > capacity inversion in the bigs that often? I've seen a lot of systems=
 where the
> > > difference between the meds and bigs is small. But frequent inversion=
 could be
> > > suspicious still.
> > >
> > > Do the littles and the mediums experience any significant thermal pre=
ssure too?
> >
> > In our platform, it's not.
>
> Good.
>
> > > It doesn't seem it'll cause a significant error, but still it seems t=
o me this
> > > function wants the original capacity passed to it.
> > >
> > > There are similar questions to be asked since you modify sg_cpu->max.=
 Every
> > > user needs to be audited if they're fine with this change or not.
> > >
> > > I'm not sure still what we are achieving here. You want to force sche=
dutil not
> > > to request higher frequencies if thermal pressure is high? Should sch=
edutil
> > > actually care? Shouldn't the cpufreq driver reject this request and p=
ick the
> > > next best thing if it can't satisfy it? I could be missing something,=
 I haven't
> > > looked that hard tbh :-)
> >
> > I changed this just want to make it more responsive to the real
> > capacity of the cpu, if it will cause other problems, maybe it would
> > be better not to change it.:)
>
> There are others who can give you a better opinion. But AFAICS we're not =
fixing
> anything but risking breaking other things. So I vote for not to change i=
t :)
>
> > > It depends on the severity of the problem. The simplest thing I can s=
uggest is
> > > to check if the cpu is in capacity inversion state, and if it is, the=
n make
> > > rt_task_fits_capacity() return false always.
> > >
> > > If we need a generic solution to handle thermal pressure omitting OPP=
s, then
> > > the search needs to become more complex. The proposal in this patch i=
s not
> > > adequate because tasks that want to run at capacity_orig_of(cpu) will=
 wrongly
> > > omit some cpus because of any tiny thermal pressure. For example if t=
he
> > > capacity_orig_of(medium_cpu) =3D 700, and uclamp_min for RT is set to=
 700, then
> > > any small thermal pressure on mediums will cause these tasks to run o=
n big cpus
> > > only, which is not what we want. Especially if these big cpus can end=
 up in
> > > capacity inversion later ;-)
> > >
> > > So if we want to handle this case, then we need to ensure the search =
returns
> > > false only if
> > >
> > >         1. Thermal pressure results in real OPP to be omitted.
> > >         2. Another CPU that can provide this performance level is ava=
ilable.
> > >
> > > Otherwise we should still fit it on this CPU because it'll give us th=
e closest
> > > thing to what was requested.
> > >
> > > I can think of 2 ways to implement this, but none of them seem partic=
ularly
> > > pretty :-/
> >
> > Maybe as Lukasz Luba said:
> >
> > https://lore.kernel.org/all/ae98a861-8945-e630-8d4c-8112723d1007@arm.co=
m/
> >
> > > Let's meet in the middle:
> > > 1) use the thermal PELT signal in RT:
> > > capacity =3D capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu))
> > > 2) introduce a more configurable thermal_pressure shifter instead
> > > 'sched_thermal_decay_shift', which would allow not only to make the
> > > decaying longer, but also shorter when the platform already might do
> > > that, to not cause too much traffic.
> >
> > But even if this is changed, there will still be the same problem, I
> > look forward to Lukasz's patch:)
>
> This will not address my concern unless I missed something.
>
> The best (simplest) way forward IMHO is to introduce a new function
>
>         bool cpu_in_capacity_inversion(int cpu);
>
> (feel free to pick another name) which will detect the scenario you're in=
. You
> can use this function then in rt_task_fits_capacity()
>
>         diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>         index a32c46889af8..d48811a7e956 100644
>         --- a/kernel/sched/rt.c
>         +++ b/kernel/sched/rt.c
>         @@ -462,6 +462,9 @@ static inline bool rt_task_fits_capacity(stru=
ct task_struct *p, int cpu)
>                 if (!static_branch_unlikely(&sched_asym_cpucapacity))
>                         return true;
>
>         +       if (cpu_in_capacity_inversion(cpu))
>         +               return false;
>         +
>                 min_cap =3D uclamp_eff_value(p, UCLAMP_MIN);
>                 max_cap =3D uclamp_eff_value(p, UCLAMP_MAX);
>
> You'll probably need to do something similar in dl_task_fits_capacity().
>
> This might be a bit aggressive though as we'll steer away all RT tasks fr=
om
> this CPU (as long as there's another CPU that can fit it). I need to thin=
k more
> about it. But we could do something like this too
>
>         diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>         index a32c46889af8..f2a34946a7ab 100644
>         --- a/kernel/sched/rt.c
>         +++ b/kernel/sched/rt.c
>         @@ -462,11 +462,14 @@ static inline bool rt_task_fits_capacity(st=
ruct task_struct *p, int cpu)
>                 if (!static_branch_unlikely(&sched_asym_cpucapacity))
>                         return true;
>
>         +       cpu_cap =3D capacity_orig_of(cpu);
>         +
>         +       if (cpu_in_capacity_inversion(cpu))

It's  a good idea, but as you said, in mainline, the
sysctl_sched_uclamp_util_min_rt_default is always 1024,
Maybe it's better to add it to the judgment?

 +       if (sysctl_sched_uclamp_util_min_rt_default !=3D
SCHED_CAPACITY_SCALE && cpu_in_capacity_inversion(cpu))

>         +               cpu_cap -=3D thermal_load_avg(cpu_rq(cpu));

Why use thermal_load_avg? If thermal is always in effect=EF=BC=8Cthe
thermal_load_avg would get bigger and bigger, as a result, the cpu_cap
maybe smaller than (capacity_orig - thermal_pressure).

Thanks!

>         +
>                 min_cap =3D uclamp_eff_value(p, UCLAMP_MIN);
>                 max_cap =3D uclamp_eff_value(p, UCLAMP_MAX);
>
>         -       cpu_cap =3D capacity_orig_of(cpu);
>         -
>                 return cpu_cap >=3D min(min_cap, max_cap);
>          }
>          #else
>
> Thoughts?

>
>
> Thanks!
>
> --
> Qais Yousef
