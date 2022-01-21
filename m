Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5C549620A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 16:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381529AbiAUP1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 10:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381557AbiAUP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 10:27:37 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47561C061401
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 07:27:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u6so2882450lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLn2yS2nAej+U02iOG8bOxDcn/TM9LIeVcFhxmU1SgU=;
        b=xZBIJ1tUtblD8IdU92MDBrzhTUHg5EwCo0uU4zTGMqZWMA1QyoXE5inPsXizlK98Sr
         f92YhSZsySYio/sp3ASisDvM/FFak/phWCsVzL668xtU3uWkinuVtI+EKdQ/axPKNdMO
         ohpz7TAiLc8HHhUIyDzLP0b4KoSadtvfn5ZlmK3jcuvLN3CqXAA/ijo0/LvoA+qPebWz
         thfU5dldowE7b+jJKYAW5APXHk6JX6yq9NZ2BbLuvkZT/giU1d8RFQtNq0ioRK74aiuE
         l80gV/lqjMLCmEx+MujHlZnKu/B4bJyqH9JME9n2physHUy5yP+4epkVYjBIqys7OHKY
         N2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLn2yS2nAej+U02iOG8bOxDcn/TM9LIeVcFhxmU1SgU=;
        b=BmH0VyPlLW+J9ULQbG8+dnoglCeUr8zF/qrVzXik+brzHiglU/pnMio5wkNe+9MHBT
         OU0gMXKfb2ggci6Mx3BOVLOVRo4HMoJvrBPcUyBTUeTXkOZcQjUnFdYzqRqhuftWCKTZ
         gTyVoUpcBnXFVTkKrLDhj66NCmeoMYw91CX8Di7fWv/gNBlaB/tGg864hn61iW34sUPa
         5TYw22zTVmXmaZD6BGMUxFs1M4HPBNwgpS8MSi75HvhiLSw/Ia0/y6ODGk3Wie7CCQpj
         lprKxlX/l/XUpddMIrWDIMSBqpqMVz3wxhhdb1+k9NA4mzyZSstuAZOb6Zao6IVdDkLW
         yA2w==
X-Gm-Message-State: AOAM533xgAJyLpnuHlkZe42Dy9dOHepRaggsKwjnZWHqfHR8pEY/3eI6
        ICplw/BVMsyQrJnkiwj4vEL+iZ0aQ1abVPJ42GGx1w==
X-Google-Smtp-Source: ABdhPJypRmv98JW+0V+jkYuOF7vcgIHTmMDgMhvpWJjVJhjRAuY4LXdd7EakprKqoXt+97Fyx+xLwqs76YPI5voHZ1A=
X-Received: by 2002:a05:6512:78d:: with SMTP id x13mr274995lfr.32.1642778855076;
 Fri, 21 Jan 2022 07:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
 <20220112161230.836326-3-vincent.donnefort@arm.com> <CAKfTPtC2wCw4U9w=saW0dGYHfOKo42nBKU7oHcEM7KeDj7MzWA@mail.gmail.com>
 <Yeac5Y5Fzu/jaUf0@FVFF7649Q05P> <CAKfTPtAdTTP+qGruYy8gi6rfhS0W1gAdjgeLCtrLZHxyCEHo9g@mail.gmail.com>
 <Yef8kTnlP5h4I7/1@FVFF7649Q05P> <CAKfTPtB=CJNFDrpXY9o8g5XfjBfnVTUgb2rWke1SyWMUxz0M+g@mail.gmail.com>
 <YenQIsHJhaEuJFQl@FVFF7649Q05P>
In-Reply-To: <YenQIsHJhaEuJFQl@FVFF7649Q05P>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Jan 2022 16:27:23 +0100
Message-ID: <CAKfTPtC+F_KqGYVtS9u-VM+9TshSRZG9kW3uL-wHyh-hkaAQbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] sched/fair: Decay task PELT values during migration
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com, Morten.Rasmussen@arm.com,
        Chris.Redpath@arm.com, qperret@google.com, Lukasz.Luba@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 at 22:12, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> [...]
>
> > > > And if cpu is not idle, you can't apply the diff between clk_pelt and clock_task
> > > >
> > > > >
> > > > > > - (B) doesn't seem to be accurate as you skip irq and steal time
> > > > > > accounting and you don't apply any scale invariance if the cpu is not
> > > > > > idle
> > > > >
> > > > > The missing irq and paravirt time is the reason why it is called "estimator".
> > > > > But maybe there's a chance of improving this part with a lockless version of
> > > > > rq->prev_irq_time and rq->prev_steal_time_rq?
> > > > >
> > > > > > - IIUC your explanation in the commit message above, the (A) period
> > > > > > seems to be a problem only when idle but you apply it unconditionally.
> > > > >
> > > > > If the CPU is idle (and clock_pelt == clock_task), only the B part would be
> > > > > worth something:
> > > > >
> > > > >   A + B = [clock_task - clock_pelt] + [sched_clock_cpu() - clock]
> > > > >                       A                            B
> > > > >
> > > > > > If cpu is idle you can assume that clock_pelt should be equal to
> > > > > > clock_task but you can't if cpu is not idle otherwise your sync will
> > > > > > be inaccurate and defeat the primary goal of this patch. If your
> > > > > > problem with clock_pelt is that the pending idle time is not accounted
> > > > > > for when entering idle but only at the next update (update blocked
> > > > > > load or wakeup of a thread). This patch below should fix this and
> > > > > > remove your A.
> > > > >
> > > > > That would help slightly the current situation, but this part is already
> > > > > covered by the estimator.
> > > >
> > > > But the estimator, as you name it, is wrong beaus ethe A part can't be
> > > > applied unconditionally
> > >
> > > Hum, it is used only in the !active migration. So we know the task was sleeping
> > > before that migration. As a consequence, the time we need to account is "sleeping"
> > > time from the task point of view, which is clock_pelt == clock_task (for
> > > __update_load_avg_blocked_se()). Otherwise, we would only decay with the
> > > "wallclock" idle time instead of the "scaled" one wouldn't we?
> >
> > clock_pelt == clock_task only when cpu is idle and after updating
> > lost_idle_time but you have no idea of the state of the cpu when
> > migrating the task
>
> I was just applying the time scaling at the task level. Why shall it depends on
> the CPU state?
>
> The situation would be as follows:
>
>                     <--X--> <--Y-->
>            +-------+-------+-------+
> CPUX    ___|   B   |   A   |   B   |___
>                                   ^
>                                migrate A
>
> In a such scenario, CPUX's PELT clock is indeed scaled. The Task A running
> time (X) has already been accounted, so what's left is to get an idle time (Y)
> contribution accurate. We would usually rely on the CPU being idle for the
> catch-up and that time would be Y + (X - scaled(X)). Without the catch-up, we
> would account at the migration, for the sleeping time Y, only (scaled(Y)). Applied
> to the same graph as for update_rq_clock_pelt()'s:
>
>  clock_task    | 1| 2| 3| 4| 5| 6| 7| 8|
>  clock_pelt    | 1   | 2   | 3   | 4   |  (CPU's running, clock_pelt is scaled)
>  expected      | 1   | 2   | 5| 6| 7| 8|
>                <---- X ---><--- Y ---->
>  Task A -------************----------
>                                    ^
>                                migrate A
>
> Contribution for Task A idle time at the migration (as we know we won't have
> another chance to catch-up clock_task later) should be 6, not 2, regardless of
> the CPU state.

If task A wakes up on the same CPU, we sync with the scaled clock_pelt
so why using something different here

>
> _But_ indeed, there would be a risk of hitting the lost_idle_time threshold and
> decay too much... (which is absolutely not handled in the current version). So
> now, if we don't want to bother too much, we could simplify the problem and
> say (which is true with NOHZ_IDLE) that if the CPU is running, the clock must
> not be that old anyway. So we should only care of the idle case, which is
> mitigated with your proposed snippet and I allow to get rid of the [A]
> part (clock_task - clock_pelt).
>
> As per sched_clock_cpu() usage, I haven't measured anything yet but notice it's
> already used in the wakeup path in ttwu_queue_wakelist().
>
