Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBA3509950
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385958AbiDUHkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385923AbiDUHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:39:39 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FFB1C912
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:36:22 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id t67so7237729ybi.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v8AMwh/JDN4z1/FW5dwPnPJ4bBvGSplOm2vBHS9uy/8=;
        b=dt5Eb5TXe0FCP4DfcY5iu1jz9fbcrAmmEROy4FB8KIt6qGgHLCLhk8TZAjFwdeakCS
         sUfBKZl8LfaodUZj9Mevlx5nOJ7rBvj9hEL/r0RCYYA3gPUZMF5lKsB2ENVBiWiJL5tn
         CL8AUOCiP83LRkQek3uy8HzDpjd9CwuTeLCaCO0Kv4hUaTgnMBgjaT1Rfww+w1xcUriC
         m4Q214oYZFrjQg1v0wOVYpOK5Wfw+2oAAyhXd+O7mm2FrfRH7kik80ZjEFdMEPaPBLjI
         vWYr8Fo8ZgrMNpdUJmrjt4AELYsjIp+v49dTVCzmPNE32X3lCdxJ0nQN2d6prsvXIKvH
         7thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v8AMwh/JDN4z1/FW5dwPnPJ4bBvGSplOm2vBHS9uy/8=;
        b=arAQplXe93y0TtgT9seG+q99XPddvSgSwEXwvCBzblYtSPEG95QB6Mi/oZilmUpigK
         sahP4uyzzkALrpWXd3TvUFlYs89pGmX5Wqw+4X9aYMSF8gdEPgc5K5LGc8SdkR34z8jh
         4rBsjzdJ+p+c5DcxKkV/eVNn9MLK6p3LOJFKoZiZ3vdB/COtuzgVbTMsVjKc+QrxPInF
         S/J4v0AH6RHsS5xcqoMGixb688fpD909yMh+EsjbGd/gZOVrl7hXV3Pfqj00njKzlFVY
         G+wOEaZgBXaSVO3sRL98aBsP5I+Hln18fpj8qceW3vHs0uYNDZGumyl4n9EOjGRd3Ifx
         eVew==
X-Gm-Message-State: AOAM532Gnotm4dtCr3InCitpOhqa7VUl0FuA6yR9TIg2ohCq2NSMdmfs
        ZKo54njTtTmIFUofy0o/nut9XcbqFQdV0M0Ntt55yCGX498jpg==
X-Google-Smtp-Source: ABdhPJzlgN0TrkVorTkjoFdwRBt5OKmEY1/Q8bD23gbhcfgt0wcmLkS+L1qV4y7/W4ARfqt5mh18/8jfnTTWXTjppBs=
X-Received: by 2002:a25:da06:0:b0:645:380a:7ba3 with SMTP id
 n6-20020a25da06000000b00645380a7ba3mr11697973ybf.300.1650526580987; Thu, 21
 Apr 2022 00:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220412134220.1588482-1-vincent.donnefort@arm.com>
 <20220412134220.1588482-3-vincent.donnefort@arm.com> <CAKfTPtAZMwgKK8m5vdEjsXRJ73YWrZePoCtCu5KKBELtQMp3DA@mail.gmail.com>
 <0d354ce1-9b43-feae-1065-5d8a78c56ccc@arm.com> <20220419162758.GA26133@vingu-book>
 <87fdf203-2a61-4234-4310-88ff67aab531@arm.com>
In-Reply-To: <87fdf203-2a61-4234-4310-88ff67aab531@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 21 Apr 2022 09:36:08 +0200
Message-ID: <CAKfTPtCK3x63Gbv5nRfs_EOZeNUDSZtqkUXPBXYQ0D6Br1Rb=w@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] sched/fair: Decay task PELT values during wakeup migration
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, Chris.Redpath@arm.com, qperret@google.com
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

On Wed, 20 Apr 2022 at 11:34, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> On 19/04/2022 17:27, Vincent Guittot wrote:
> > Le mardi 19 avril 2022 =C3=AF=C2=BF=C2=BD 13:23:27 (+0100), Vincent Don=
nefort a =C3=AF=C2=BF=C2=BDcrit :
> >>
> >>
> >> On 19/04/2022 11:08, Vincent Guittot wrote:
> >>> On Tue, 12 Apr 2022 at 15:42, Vincent Donnefort
> >>> <vincent.donnefort@arm.com> wrote:
> >>>>
> >>>> Before being migrated to a new CPU, a task sees its PELT values
> >>>> synchronized with rq last_update_time. Once done, that same task wil=
l also
> >>>> have its sched_avg last_update_time reset. This means the time betwe=
en
> >>>> the migration and the last clock update (B) will not be accounted fo=
r in
> >>>> util_avg and a discontinuity will appear. This issue is amplified by=
 the
> >>>> PELT clock scaling. If the clock hasn't been updated while the CPU i=
s
> >>>> idle, clock_pelt will not be aligned with clock_task and that time (=
A)
> >>>> will be also lost.
> >>>>
> >>>>      ---------|----- A -----|-----------|------- B -----|>
> >>>>           clock_pelt   clock_task     clock            now
> >>>>
> >>>> This is especially problematic for asymmetric CPU capacity systems w=
hich
> >>>> need stable util_avg signals for task placement and energy estimatio=
n.
> >>>>
> >>>> Ideally, this problem would be solved by updating the runqueue clock=
s
> >>>> before the migration. But that would require taking the runqueue loc=
k
> >>>> which is quite expensive [1]. Instead estimate the missing time and =
update
> >>>> the task util_avg with that value:
> >>>>
> >>>>     A + B =3D clock_task - clock_pelt + sched_clock_cpu() - clock
> >>>>
> >>>> Neither clock_task, clock_pelt nor clock can be accessed without the
> >>>> runqueue lock. The new cfs_rq last_update_lag is therefore created a=
nd
> >>>> contains those three values when the last_update_time value for that=
 very
> >>>> same cfs_rq is updated.
> >>>>
> >>>>     last_update_lag =3D clock - clock_task + clock_pelt
> >>>>
> >>>> And we can then write the missing time as follow:
> >>>>
> >>>>     A + B =3D sched_clock_cpu() - last_update_lag
> >>>>
> >>>> The B. part of the missing time is however an estimation that doesn'=
t take
> >>>> into account IRQ and Paravirt time.
> >>>>
> >>>> Now we have an estimation for A + B, we can create an estimator for =
the
> >>>> PELT value at the time of the migration. We need for this purpose to
> >>>> inject last_update_time which is a combination of both clock_pelt an=
d
> >>>> lost_idle_time. The latter is a time value which is completely lost =
from a
> >>>> PELT point of view and must be ignored. And finally, we can write:
> >>>>
> >>>>     now =3D last_update_time + A + B
> >>>>         =3D last_update_time + sched_clock_cpu() - last_update_lag
> >>>>
> >>>> This estimation has a cost, mostly due to sched_clock_cpu(). Limit t=
he
> >>>> usage to the case where the source CPU is idle as we know this is wh=
en the
> >>>> clock is having the biggest risk of being outdated.
> >>>>
> >>>> [1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath=
@arm.com/
> >>>>
> >>>> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> > [...]
> >
> >>>
> >>> I'm worried that we will call this for each and every
> >>> update_cfs_rq_load_avg() whereas the content will be used only when
> >>> idle and not throttled. Can't we use these conditions to save values
> >>> only when needed and limit the number of useless updates ?
> >>
> >> I don't think we can use idle here as a condition, once it is idle, it=
 is
> >> too late to get those clock values.
> >
> > As an example, the patch below should work. It doesn't handle the throt=
tled case yet and still has to
> > make sure that rq->enter_idle and rq->clock_pelt_idle are coherent in r=
egards to ILB that
> > update blocked load.
>
>
> I had to abandon the per-rq approach from v1 to v2. This is because of
> the following example:
>
> 1. task A sleep
> 2. rq's clock updated (e.g another task runs)
> 3. task A migrated
>
> With a per-rq lag, we would miss the time delta between 1 and 2. We know
> how old is the last clock update. But what we actually want is how old
> is the task's last_update_time.

I don't get your point here. Even after 2, won't task A be correctly
updated with the patch below ? As I mentioned, this doesn't take into
account case where cfs can be throttled (ie CFS_BANDWIDTH)

But applying similar scheme should work

>
> >
> > ---
> >   kernel/sched/fair.c  | 30 ++++++++++++++++++++++++++++++
> >   kernel/sched/pelt.h  | 21 ++++++++++++++-------
> >   kernel/sched/sched.h |  3 ++-
> >   3 files changed, 46 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e6ecf530f19f..f00843f9dd01 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7005,6 +7005,35 @@ select_task_rq_fair(struct task_struct *p, int p=
rev_cpu, int wake_flags)
> >
> >   static void detach_entity_cfs_rq(struct sched_entity *se);
> >
> > +#ifdef CONFIG_NO_HZ_COMMON
> > +static inline void migrate_se_pelt_lag(struct sched_entity *se)
> > +{
> > +       u64 now;
> > +       struct cfs_rq *cfs_rq;
> > +       struct rq *rq;
> > +       bool is_idle;
> > +
> > +       cfs_rq =3D cfs_rq_of(se);
> > +       rq =3D rq_of(cfs_rq);
> > +
> > +       rcu_read_lock();
> > +       is_idle =3D is_idle_task(rcu_dereference(rq->curr));
> > +       rcu_read_unlock();
> > +
> > +       if (!is_idle)
> > +               return;
> > +
> > +     /* TODO handle throttled cfs */
> > +     /* TODO handle update ilb blocked load update */
> > +     now =3D READ_ONCE(rq->clock_pelt_idle);
> > +     now +=3D sched_clock_cpu(cpu_of(rq)) - READ_ONCE(rq->enter_idle);
> > +
> > +       __update_load_avg_blocked_se(now, se);
> > +}
> > +#else
> > +static void migrate_se_pelt_lag(struct sched_entity *se) {}
> > +#endif
> > +
> >   /*
> >    * Called immediately before a task is migrated to a new CPU; task_cp=
u(p) and
> >    * cfs_rq_of(p) references at time of call are still valid and identi=
fy the
> > @@ -7056,6 +7085,7 @@ static void migrate_task_rq_fair(struct task_stru=
ct *p, int new_cpu)
> >                * sounds not bad.
> >                */
> >               remove_entity_load_avg(&p->se);
> > +             migrate_se_pelt_lag(&p->se);
> >       }
> >
> >       /* Tell new CPU we are migrated */
> > diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> > index c336f5f481bc..ece4423026e5 100644
> > --- a/kernel/sched/pelt.h
> > +++ b/kernel/sched/pelt.h
> > @@ -61,6 +61,14 @@ static inline void cfs_se_util_change(struct sched_a=
vg *avg)
> >       WRITE_ONCE(avg->util_est.enqueued, enqueued);
> >   }
> >
> > +static inline u64 rq_clock_pelt(struct rq *rq)
> > +{
> > +     lockdep_assert_rq_held(rq);
> > +     assert_clock_updated(rq);
> > +
> > +     return rq->clock_pelt - rq->lost_idle_time;
> > +}
> > +
> >   /*
> >    * The clock_pelt scales the time to reflect the effective amount of
> >    * computation done during the running delta time but then sync back =
to
> > @@ -78,6 +86,8 @@ static inline void update_rq_clock_pelt(struct rq *rq=
, s64 delta)
> >       if (unlikely(is_idle_task(rq->curr))) {
> >               /* The rq is idle, we can sync to clock_task */
> >               rq->clock_pelt  =3D rq_clock_task(rq);
> > +             WRITE_ONCE(rq->enter_idle, rq_clock(rq)); /* this could b=
e factorized with idle_stamp */
> > +             WRITE_ONCE(rq->clock_pelt_idle, rq_clock_pelt(rq)); /* la=
st pelt clock update when idle */
> >               return;
> >       }
> >
> > @@ -130,14 +140,11 @@ static inline void update_idle_rq_clock_pelt(stru=
ct rq *rq)
> >        */
> >       if (util_sum >=3D divider)
> >               rq->lost_idle_time +=3D rq_clock_task(rq) - rq->clock_pel=
t;
> > -}
> >
> > -static inline u64 rq_clock_pelt(struct rq *rq)
> > -{
> > -     lockdep_assert_rq_held(rq);
> > -     assert_clock_updated(rq);
> > -
> > -     return rq->clock_pelt - rq->lost_idle_time;
> > +     /* The rq is idle, we can sync with clock_task */
> > +     rq->clock_pelt  =3D rq_clock_task(rq);
> > +     WRITE_ONCE(rq->enter_idle, rq_clock(rq)); /* this could be factor=
ized with idle_stamp */
> > +     WRITE_ONCE(rq->clock_pelt_idle, rq_clock_pelt(rq)); /* last pelt =
clock update when idle */
> >   }
> >
> >   #ifdef CONFIG_CFS_BANDWIDTH
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 6ab77b171656..108698446762 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1007,7 +1007,8 @@ struct rq {
> >       u64                     clock_task ____cacheline_aligned;
> >       u64                     clock_pelt;
> >       unsigned long           lost_idle_time;
> > -
> > +     u64                     clock_pelt_idle;
> > +     u64                     enter_idle;
> >       atomic_t                nr_iowait;
> >
> >   #ifdef CONFIG_SCHED_DEBUG
