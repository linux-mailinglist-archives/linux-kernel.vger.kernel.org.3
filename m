Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0CF510E14
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356807AbiD0Blt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356792AbiD0Bls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:41:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07487FDD3C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:38:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p12so630327lfs.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6m5EHrFngIj7a8PPgOziSOXfTBY72BssfH/5Kk6E1D4=;
        b=PVJfNSNmwOFSwuRQYJl7lRIWs85Ihb8IB/CXKjJ/hTifHzTqyOwGYGtunthhHXZyNq
         9Xv2EAynR4aE6fg/gYDTv/fNdk0R7qDP/SZopBaqX1/La+/4OnlVTbmohoFdfgfyJYas
         v/wEOvwinXJN9jziMsAEYFq5T/nSePXu2/zVTVZjFDPtc9G85zITyQBUjCbM26SekN9w
         NipTfo/DiPMzDOAZHukq7Of5Za+PbVBkGmjrRII9HD1qNojrTAgMbI03vPYHTJVr9fLr
         vkXG5DbfKIX0Z3o5d3xmGrtqWZBVcI1KCcUzvLiPPF1BhlVwXolmPc7AhO5nP1DSasXZ
         IlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6m5EHrFngIj7a8PPgOziSOXfTBY72BssfH/5Kk6E1D4=;
        b=nDGD5m4/Pc72CPvrrmArqLyKwk+FyaP6k55HWfRoFv9MPGUa8unDF2Yjj8EUBysDJT
         6gc+0dztZ7YdF0+PwTJPF4O7fT9hq617tdGBROLmCjof5WxKdqsSWs6IzkfegYXQcYiS
         yZOPIhfuE6N1mU4A9ygqhgT8dp8UoxIq/i1zC081Gk1KDJN7aQowMkdw3V5a8AqzJuKD
         tMxYbGlyv/usc1awQFpLxcY9yZv3wiQj1p1y7FmL7mACLbrdMsdi8x3vmclu11Iw1RYc
         +kYQts9dlxe6SlwnMubN9cpXaFEtKUAJ9M2SLARg27LtRGPuJiTmQfnFobFfyZBGeSoK
         vqrQ==
X-Gm-Message-State: AOAM531A64OSvwL+AGGnzXhEtCrNS40A7S9ygl0aH7fjqMq/G6SyA3uk
        GDMhI9mxN8qSojIWiMVpDJDys6ms6ViJ761uP40=
X-Google-Smtp-Source: ABdhPJyUWynFQtuLaJtH6v3lSTh02LJWIR3EDRz2nvzQjjg6lR+d9YiaHCxT6Dhb9NzpYBwQD1VnAzzyp8Idg448Q/E=
X-Received: by 2002:a05:6512:13a1:b0:448:887e:da38 with SMTP id
 p33-20020a05651213a100b00448887eda38mr19011317lfa.298.1651023517177; Tue, 26
 Apr 2022 18:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
 <20220421161509.asz25zmh25eurgrk@airbuntu> <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
 <20220425161209.ydugtrs3b7gyy3kk@airbuntu> <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
 <20220426092142.lppfj5eqgt3d24nb@airbuntu>
In-Reply-To: <20220426092142.lppfj5eqgt3d24nb@airbuntu>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 27 Apr 2022 09:38:26 +0800
Message-ID: <CAB8ipk_tM8WhZOLwURkqyi5XDSNJ=twOg1Zub=dsTB_b9N9BRg@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > The best (simplest) way forward IMHO is to introduce a new function
> > >
> > >         bool cpu_in_capacity_inversion(int cpu);
> > >
> > > (feel free to pick another name) which will detect the scenario you're in. You
> > > can use this function then in rt_task_fits_capacity()
> > >
> > >         diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > >         index a32c46889af8..d48811a7e956 100644
> > >         --- a/kernel/sched/rt.c
> > >         +++ b/kernel/sched/rt.c
> > >         @@ -462,6 +462,9 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> > >                 if (!static_branch_unlikely(&sched_asym_cpucapacity))
> > >                         return true;
> > >
> > >         +       if (cpu_in_capacity_inversion(cpu))
> > >         +               return false;
> > >         +
> > >                 min_cap = uclamp_eff_value(p, UCLAMP_MIN);
> > >                 max_cap = uclamp_eff_value(p, UCLAMP_MAX);
> > >
> > > You'll probably need to do something similar in dl_task_fits_capacity().
> > >
> > > This might be a bit aggressive though as we'll steer away all RT tasks from
> > > this CPU (as long as there's another CPU that can fit it). I need to think more
> > > about it. But we could do something like this too
> > >
> > >         diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > >         index a32c46889af8..f2a34946a7ab 100644
> > >         --- a/kernel/sched/rt.c
> > >         +++ b/kernel/sched/rt.c
> > >         @@ -462,11 +462,14 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> > >                 if (!static_branch_unlikely(&sched_asym_cpucapacity))
> > >                         return true;
> > >
> > >         +       cpu_cap = capacity_orig_of(cpu);
> > >         +
> > >         +       if (cpu_in_capacity_inversion(cpu))
> >
> > It's  a good idea, but as you said, in mainline, the
> > sysctl_sched_uclamp_util_min_rt_default is always 1024,
> > Maybe it's better to add it to the judgment?
>
> I don't think so. If we want to handle finding the next best thing, we need to
> make the search more complex than that. This is no worse than having 2 RT tasks
> waking up at the same time while there's only a single big CPU. One of them
> will end up on a medium or a little and we don't provide better guarantees
> here.

I may have misunderstood your patch before, do you mean this:
1. the cpu has to be inversion, if not, the cpu's capacity is still
the biggest, although the sysctl_sched_uclamp_util_min_rt_default
=1024, it still can put on the cpu.
2. If the cpu is inversion, the thermal pressure should be considered,
at this time, if the sysctl_sched_uclamp_util_min_rt_default is not
1024, make the rt still have chance to select the cpu.
    If the sysctl_sched_uclamp_util_min_rt_default is 1024, all of the
cpu actually can not fit the rt, at this time, select cpu without
considering the cap_orig_of(cpu). The worst thing may be that  rt
would put on the small core.

I understand right? If so, Perhaps this approach has the least impact
on the current code complexity.

Thanks!
BR
---
xuewen
