Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A486F47B890
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbhLUCvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbhLUCvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:51:23 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:51:22 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id r6so6944464qvr.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLHHwkH6kNjaF0t9kjoiGI4SRHPFzG04wLGsPZKoEoI=;
        b=c1dl8FodFoIn9XVKeG6ZGNQT7lbv9kRwCyegE+1V2p3KokY5ENjsuEoiaun78in0xD
         zjZRFUlP0BEMR6IPN8Lry8Gk/ox46WdeY7eLhEifZH7kjrHL18FHXDWad/PExGOUbdA+
         NEi4kGZnP/Gl+O6vPsw3zbYoW+UyKumF2hPvr/Sh6ieJgEoTciS7cigycFWvm753FLJS
         itjbnnsKCWslZkxLpOib/Ixre+djbIhD8BIlg8XwLKr5y6OHSuWBm/6SnLGNOJI7yTgQ
         fOJUuzwLfMnCP4xRDrRkwql4BXLXkoTdMhdAT7p2affdjpa8B4R6iJScv0i23dROUukc
         r8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLHHwkH6kNjaF0t9kjoiGI4SRHPFzG04wLGsPZKoEoI=;
        b=AC8Ysq3FKAH8eeN4qkqAhxa3+Wuuem8EuCIGZFnesO9oQYsL+hRfBO5MuLgMyOaB8C
         moNsyhT/oD5zFYQ+38BSpML27ogrqE4//XjmHyWhMdy0uZs/oJLNSS9Z9TxSwF1zLXx1
         CBgcHwO7N0XMuMDu9CWYnT57NXJOVTr6fr0p9QjrbpCmA3FuGaw2/M8R25K5MAJzCIuf
         Z+j/JMG0G6YimhD+i/ls1QduufYBiLOuh7cvoPpPOyBGqrOG/LtQO3T189OlxYI7eTCX
         Yk8tGhC8haa+1Xacj8e/FkRpC/Ke7YKNByZ5LQsXC9ouhs01fgprYYAFlH1bK2w3la1Z
         4qHA==
X-Gm-Message-State: AOAM53268Bzd0CO/j+wm2YEwVmqCGZOWvZ+L8DMMbt2GayU3ViyeOk/3
        pTqVqdJlOeRXgMv3m4WEtzyfQIv9bTYXJdY3zQkmwQXsnn5jW+33
X-Google-Smtp-Source: ABdhPJyCDUUQOlCEpPUscgu8ExM2LaLWYvXU4qzi4tajsbornvv2ewxHqSjwzEkcF7E2PhBNFQgih/cB12DXLz9w4rs=
X-Received: by 2002:a05:6214:2a88:: with SMTP id jr8mr912495qvb.18.1640055081686;
 Mon, 20 Dec 2021 18:51:21 -0800 (PST)
MIME-Version: 1.0
References: <1639721264-12294-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznGdvLobshPvg2KY+D71Zh0625+V=WsAS9uExRspRFFjVQ@mail.gmail.com>
 <CAJuCfpF9tJupcyWVeDHyEBnQqTZTnoyKVcKLqB1wWXyks6Z0Cw@mail.gmail.com>
 <CAGWkznG8ipn96YgyOatF=i5acLGoLp9G8E4jD7vHKMw9aOV1ZA@mail.gmail.com> <CAJuCfpEmvVVQGso4bKeigdJwNG4aqViay_P3oXo2Tu4sm-HKXw@mail.gmail.com>
In-Reply-To: <CAJuCfpEmvVVQGso4bKeigdJwNG4aqViay_P3oXo2Tu4sm-HKXw@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 21 Dec 2021 10:51:01 +0800
Message-ID: <CAGWkznGk07jkuA8rftR0f5upq-7B6tkybSb_DMJYau0HjhYUnQ@mail.gmail.com>
Subject: Re: [PATCH] psi: fix possible trigger missing in the window
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:30 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Dec 20, 2021 at 5:57 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > On Tue, Dec 21, 2021 at 3:58 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > On Fri, Dec 17, 2021 at 10:03 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > > >
> > > > loop Suren
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > On Fri, Dec 17, 2021 at 2:08 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> > > > >
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > There could be missing wake up if the rest of the window remain the
> > > > > same stall states as the polling_total updates for every polling_min_period.
> > >
> > > Could you please expand on this description? I'm unclear what the
> > > problem is. I assume "polling_min_period" in this description refers
> > > to the group->poll_min_period.
> > >
> > > From the code, looks like the change results in update_triggers()
> > > calling window_update() once there was a new stall recorded for the
> > > trigger state and until the tracking window is complete. I don't see
> > > the point of calling window_update() if there was no stall change
> > > since the last call to window_update(). The resulting growth will not
> > > increase if there is no new stall.
> > > Maybe what you want to achieve here is more than one trigger per
> > > window if the stall limit was breached? If so, then this goes against
> > > the design for psi triggers in which we want to rate-limit the number
> > > of generated triggers per tracking window (see:
> > > https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L545).
> > > Please clarify the issue and the intentions here.
> > > Thanks!
> > Please correct me if I am wrong. Imagine that there is a new stall
> > during the 1st polling_min_period among 10 of them in the window and
> > group->polling_total will be updated to total without trigger. If the
> > rest of 9 polling_min_periods remain the same states, the trigger will
> > be missed when window timing is reached.
>
> I don't see why updating group->polling_total after the first
> registered stall is an issue here. window_update() calculates growth
> using current group->total[] and win->start_value (see:
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L483)
> which is set at the beginning of the window (see:
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L462).
> If the calculated growth did not reach t->threshold then the trigger
> should not be fired (see:
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L542).
> We fire the trigger only if growth within a given window is higher
> than the threshold.
>
> In your scenario if the stall recorded in the 1st polling_min_period
> was less than the threshold and in the other 9 polling_min_periods no
> new stalls were registered then there should be no triggers fired in
> that window. This is intended behavior. Trigger is fired only when the
The stall in the 1st polling_min_period was *LARGE* then the threshold
will also be ignored here.

> recorded stall within the window breaches the threshold. And there
> will be only one trigger generated per window, no matter how much
> stall is being recorded after the threshold was breached.
> Hopefully this clarifies the behavior?

I don't think so. According to your opinion, if the total keeps no
change in the last polling_min_period, then the growth during the 1-9
min_periods which is much larger than the threshold will also be
ignored. It does not make sense.

https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L529
>
> > >
> > > > >
> > > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > ---
> > > > >  include/linux/psi_types.h |  2 ++
> > > > >  kernel/sched/psi.c        | 30 ++++++++++++++++++------------
> > > > >  2 files changed, 20 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > > > > index 0a23300..9533d2e 100644
> > > > > --- a/include/linux/psi_types.h
> > > > > +++ b/include/linux/psi_types.h
> > > > > @@ -132,6 +132,8 @@ struct psi_trigger {
> > > > >
> > > > >         /* Refcounting to prevent premature destruction */
> > > > >         struct kref refcount;
> > > > > +
> > > > > +       bool new_stall;
> > > > >  };
> > > > >
> > > > >  struct psi_group {
> > > > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > > > index 1652f2b..402718c 100644
> > > > > --- a/kernel/sched/psi.c
> > > > > +++ b/kernel/sched/psi.c
> > > > > @@ -458,9 +458,12 @@ static void psi_avgs_work(struct work_struct *work)
> > > > >  static void window_reset(struct psi_window *win, u64 now, u64 value,
> > > > >                          u64 prev_growth)
> > > > >  {
> > > > > +       struct psi_trigger *t = container_of(win, struct psi_trigger, win);
> > > > > +
> > > > >         win->start_time = now;
> > > > >         win->start_value = value;
> > > > >         win->prev_growth = prev_growth;
> > > > > +       t->new_stall = false;
> > > > >  }
> > > > >
> > > > >  /*
> > > > > @@ -515,7 +518,6 @@ static void init_triggers(struct psi_group *group, u64 now)
> > > > >  static u64 update_triggers(struct psi_group *group, u64 now)
> > > > >  {
> > > > >         struct psi_trigger *t;
> > > > > -       bool new_stall = false;
> > > > >         u64 *total = group->total[PSI_POLL];
> > > > >
> > > > >         /*
> > > > > @@ -523,19 +525,26 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > > > >          * watchers know when their specified thresholds are exceeded.
> > > > >          */
> > > > >         list_for_each_entry(t, &group->triggers, node) {
> > > > > -               u64 growth;
> > > > > -
> > > > >                 /* Check for stall activity */
> > > > >                 if (group->polling_total[t->state] == total[t->state])
> > > > >                         continue;
> > > > >
> > > > >                 /*
> > > > > -                * Multiple triggers might be looking at the same state,
> > > > > -                * remember to update group->polling_total[] once we've
> > > > > -                * been through all of them. Also remember to extend the
> > > > > -                * polling time if we see new stall activity.
> > > > > +                * update the trigger if there is new stall which will be
> > > > > +                * reset when run out of the window
> > > > >                  */
> > > > > -               new_stall = true;
> > > > > +               t->new_stall = true;
> > > > > +
> > > > > +               memcpy(&group->polling_total[t->state], &total[t->state],
> > > > > +                               sizeof(group->polling_total[t->state]));
> > > > > +       }
> > > > > +
> > > > > +       list_for_each_entry(t, &group->triggers, node) {
> > > > > +               u64 growth;
> > > > > +
> > > > > +               /* check if new stall happened during this window*/
> > > > > +               if (!t->new_stall)
> > > > > +                       continue;
> > > > >
> > > > >                 /* Calculate growth since last update */
> > > > >                 growth = window_update(&t->win, now, total[t->state]);
> > > > > @@ -552,10 +561,6 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > > > >                 t->last_event_time = now;
> > > > >         }
> > > > >
> > > > > -       if (new_stall)
> > > > > -               memcpy(group->polling_total, total,
> > > > > -                               sizeof(group->polling_total));
> > > > > -
> > > > >         return now + group->poll_min_period;
> > > > >  }
> > > > >
> > > > > @@ -1152,6 +1157,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > > > >         t->last_event_time = 0;
> > > > >         init_waitqueue_head(&t->event_wait);
> > > > >         kref_init(&t->refcount);
> > > > > +       t->new_stall = false;
> > > > >
> > > > >         mutex_lock(&group->trigger_lock);
> > > > >
> > > > > --
> > > > > 1.9.1
> > > > >
