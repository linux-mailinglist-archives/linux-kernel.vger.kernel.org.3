Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1607B48A8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiAKHyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348754AbiAKHyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:54:32 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E41C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 23:54:31 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x6so53233663lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 23:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mVkx1LI+zPocvRrKE2R4cG9ZBr7aaInh7cFXNgORfho=;
        b=LN0juXaxA9tVwJXZRuY9egGBTmaSUYrCHgO27ujgdpnJR4V1Yviw5JKAysLSEukThd
         cdTrmijULzElk6t9Y8LQKiJOEhnEcIXIBUo1nxrFo3cqcyE8nDfLnV0W3HQMZioNb9aC
         XsYyscifecQTpZ/zelqIIGGk4FZvzV9I8c5tZUzGR36X0Liklpa/mYWWzSEQZaQoYlL6
         paAqbAVll02qifRcxHutVItDy7A75ZfqWitfUl0TyUvIG2KP2Yp3BEap4BXQzmdeogEz
         KYXRfz0n5bu1KaWCUSSDTPiBoL/s9PGUhJKpxv/1WyS87l7j8iWbxtKrsR/o2hE+oB5c
         WL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mVkx1LI+zPocvRrKE2R4cG9ZBr7aaInh7cFXNgORfho=;
        b=if+LMTjS+TX9scJMqzHLR0Bwg7gBLYwtFo989OWHPZLVhx0DY5CVp3b6xFmnTCeryD
         fO2+rfxZV0RJvf5k8gGsVXFmjF2YWE6MZDMJWWx7AIqdr7hNMmAZow9iPNdivWG8zBmX
         JBzuKqGPninPppf2/cusEo2k7CdXRjdjRB+98uXGo39MlrTAplLcXyYY6q11Tdp77L4t
         9cqxTQ4k0ReszPrCl/nkTA5YaehVhHNEm1XuSjU2kNsOHa0aLju70juMcPBmjKhB5IZq
         KP7qFdsccyiVsch9ZoWd2vWZcDvivFdrmzE45yKcLGQPXO+7XJfj8BQkvvowFwh1lSeK
         qShg==
X-Gm-Message-State: AOAM531MzkJWIUb5ZCGipfhvzR/UrZ0BgsYBW5qY+0LUDYMNtqfKCuvU
        z+DHRTdac7onjZk1VKMqexzEABbJg5gytBSI53bCbQ==
X-Google-Smtp-Source: ABdhPJz1/rb+3w2JrqZCiqQv07Gem85CX8i7vfbfVikfoqKAFTBhHBDaxADXrOJtNjoRgddqGe4NvlFOBCWd4g6RCF0=
X-Received: by 2002:a2e:968a:: with SMTP id q10mr2045001lji.381.1641887669835;
 Mon, 10 Jan 2022 23:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
 <20211222093802.22357-2-vincent.guittot@linaro.org> <9e526482-905c-e759-8aa6-1ff84bb5b2a3@arm.com>
 <CAKfTPtBR3BWCwEaJe0Cq6K5__zNxfU7FFo2f0bpOPkvzxKdiww@mail.gmail.com>
 <8f39d837-2589-4f7b-5232-1ed134fb1ad7@arm.com> <CAKfTPtCVD40GiDEG0pnU+k-nwMAh2PSu_OXq4w3k0A0zR4cLpw@mail.gmail.com>
 <f1549032-50f6-e9fc-a7ae-24373352576b@arm.com> <CAKfTPtAREuJtj8AuZPwfe_=W7v8J-UOXDWeyBL0-VcKGaTSr5Q@mail.gmail.com>
In-Reply-To: <CAKfTPtAREuJtj8AuZPwfe_=W7v8J-UOXDWeyBL0-VcKGaTSr5Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 11 Jan 2022 08:54:18 +0100
Message-ID: <CAKfTPtCgxwK6tYxKK69nBuGwNjsFBbE+WuohmhWJRo++pPKqog@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/pelt: Don't sync hardly util_sum with uti_avg
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al, sachinp@linux.vnet.ibm.com,
        naresh.kamboju@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 at 16:21, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Fri, 7 Jan 2022 at 12:43, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >
> > On 05/01/2022 14:57, Vincent Guittot wrote:
> > > On Wed, 5 Jan 2022 at 14:15, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >>
> > >> On 04/01/2022 14:42, Vincent Guittot wrote:
> > >>> On Tue, 4 Jan 2022 at 12:47, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >>>>
> > >>>> On 22/12/2021 10:38, Vincent Guittot wrote:
> > >>
> > >> [...]
> > >>
> > >>>> I still wonder whether the regression only comes from the changes in
> > >>>> update_cfs_rq_load_avg(), introduced by 1c35b07e6d39.
> > >>>> And could be fixed only by this part of the patch-set (A):
> > >>>
> > >>> I have been able to trigger the warning even with (A) though It took
> > >>> much more time.
> > >>> And I have been able to catch wrong situations  (with additional
> > >>> traces) in the 3 places A, B and C
> > >>
> > >> OK. By wrong situation you mean '_sum < _avg * MIN_DIVIDER' ?
> > >
> > > not only.
> > > also util_sum == 0 but util_avg !=0 in different places although these
> >
> > Ah OK, I saw this one as part of '_sum < _avg * MIN_DIVIDER'.
> >
> > > situation didn't trigger sched_warn because some other sync happened
> > > before the periodic call of __update_blocked_fair
> > > or if nr_running == 1 and  and task's util_avg/sum > cfs' util_avg/sum
> > > just before removing the task
> >
> > I see.
> >
> > >>>> @@ -3677,15 +3706,22 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq
> > >>>> *cfs_rq)
> > >>>>
> > >>>>     r = removed_load;
> > >>>>     sub_positive(&sa->load_avg, r);
> > >>>> -   sa->load_sum = sa->load_avg * divider;
> > >>>> +   sub_positive(&sa->load_sum, r * divider);
> > >>>> +   sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * MIN_DIVIDER);
> > >>>>
> > >>>>     r = removed_util;
> > >>>>     sub_positive(&sa->util_avg, r);
> > >>>> -   sa->util_sum = sa->util_avg * divider;
> > >>>> +   sub_positive(&sa->util_sum, r * divider);
> > >>>> +   sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
> > >>>>
> > >>>>     r = removed_runnable;
> > >>>>     sub_positive(&sa->runnable_avg, r);
> > >>>> -   sa->runnable_sum = sa->runnable_avg * divider;
> > >>>> +   sub_positive(&sa->runnable_sum, r * divider);
> > >>>> +   sa->runnable_sum = max_t(u32, sa->runnable_sum,
> > >>>> +                                 sa->runnable_avg * MIN_DIVIDER);
> > >>>>
> > >>>> i.e. w/o changing update_tg_cfs_X() (and
> > >>>> detach_entity_load_avg()/dequeue_load_avg()).
> > >>>>
> > >>>> update_load_avg()
> > >>>>   update_cfs_rq_load_avg()    <---
> > >>>>   propagate_entity_load_avg()
> > >>>>     update_tg_cfs_X()         <---
> > >>>>
> > >>>>
> > >>>> I didn't see the SCHED_WARN_ON() [cfs_rq_is_decayed()] when looping on
> > >>>> hackbench in several different sched group levels on
> > >>>> [Hikey620 (Arm64, 8 CPUs, SMP, 4 taskgroups: A/B C/D E/F G/H), >12h uptime].
> > >>>
> > >>> IIRC, it was with hikey960 with cgroup v1
> > >>> As a side note, I never trigger the problem with dragonboard845 and cgroup v2
> > >>
> > >> OK, just started a test on hikey960 cgroupv1. Let's see if I can catch it.
> >
> > Still no sign of the issue (hikey960, cgroupv1,  4 taskgroups: A/B C/D
> > E/F G/H > 45h uptime
> >
> > >>>>> @@ -3780,7 +3799,11 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> > >>>>>
> > >>>>>       dequeue_load_avg(cfs_rq, se);
> > >>>>>       sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
> > >>>>> -     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
> > >>>>> +     sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
> > >>>>> +     /* See update_tg_cfs_util() */
> > >>>>> +     cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
> > >>>>> +                                       cfs_rq->avg.util_avg * MIN_DIVIDER);
> > >>>>> +
> > >>>>
> > >>>> Maybe add a:
> > >>>>
> > >>>> Fixes: fcf6631f3736 ("sched/pelt: Ensure that *_sum is always synced
> > >>>> with *_avg")
> > >>>
> > >>> I spent time thinking about adding fixes tag. There is no crash/warn
> > >>> so far so should we propagate it back in LTS for better performance ?
> > >>
> > >> Not sure I understand. What do you mean by 'should we propagate it back
> > >> in LTS'?
> > >
> > > Sorry I had any stables in mind and not only LTS.
> > >
> > > Some of the changes done in PELT signal propagation that replace
> > > subtracting util_sum  by using util_avg * divider instead, are related
> > > to other problems with sched group hierarchy and
> > > throttling/unthrottling. I'm not 100% confident that using fixes tag
> > > to backport this on stables doesn't need to backport more patches on
> > > other areas in order to not resurrect old problems. So I wonder if
> > > it's worth  backporting this on stables
> >
> > OK, I see. So only 1c35b07e6d39 (i.e. the util _sum/_avg change in
> > update_cfs_rq_load_avg() (1)) caused the CPU frequency regression. That
> > was the reason why I initially suggested to split the patch-set
> > differently. But you said that you saw the issue also when (1) is fixed.
>
> Ok, I think that we were not speaking about the same setup. I wrongly
> read that you were saying that
> sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
> was only needed in update_cfs_rq_load_avg() but not in the other places.
>
> But what you said is that we only need the below to fix the perf
> regression raised by rick ?
>      r = removed_util;
>      sub_positive(&sa->util_avg, r);
>  -   sa->util_sum = sa->util_avg * divider;
>  +   sub_positive(&sa->util_sum, r * divider);
>  +   sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);

The test with the code above doesn't trigger any SCHEd_WARN over the
weekend so it's probably ok to make a dedicated patch for this with
tag.
I'm going to prepare a v2

>
> The WARN that I mentioned in my previous email was about not adding
> the max_t in all 3 places. I rerun some test today and I triggered the
> WARN after a detach without the max_t line.
>
> I can probably isolate the code above in a dedicated patch for the
> regression raised by Rick and we could consider adding a fixes tag; I
> will run more tests with only this part during the weekend.
> That being said, we need to stay consistent in all 3 places where we
> move or propagate some *_avg. In particular, using  "sa->util_sum =
> sa->util_avg * divider" has the drawback of filtering the contribution
> not already accounted for in util_avg and the impact is much larger
> than expected. It means that  although fixing only
> update_cfs_rq_load_avg() seems enough for rick's case, some other
> cases could be impacted by the 2 other places and we need to fixed
> them now that we have a better view of the root cause
