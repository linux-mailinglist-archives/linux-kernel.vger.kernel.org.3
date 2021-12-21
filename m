Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0EB47B860
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhLUCa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhLUCaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:30:25 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463F0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:30:25 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id d10so34463361ybe.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 18:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRTGu73/k0t/mdtRHX05cYpTq6nHGxrLblYCIW5/tCA=;
        b=qhSw40lNSnZxmM1E5dLkm+lH1OwvLwc7yFldfukulGVOl8qak6Dsc+itTaV/h21N/5
         3UsXcrAftZ3HWcxO5vEl6Nmj3RPZ4H9vNFL//nSLAWmmh+PGy347g0TqouCyQRmEfRBj
         k0gGXvUOWeqVENFY13ZON7HnoxvydHanJTSei7LmfH4jGhnZrMXyVBW88Djk6PYmHPsr
         /f9zmX/bRr1HbT4tAfMQa/3AXJh+UnnHc0iMhrCfTwdhS5RCa3fitgxB+c2wgAV+YzOt
         nnts8Vozk6H8eVJPjBctpuZqAzejUQdtRSEVCuIai0XkQYq5tbR0bpm9k2jcF6+xAKi1
         I7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRTGu73/k0t/mdtRHX05cYpTq6nHGxrLblYCIW5/tCA=;
        b=llrT1BdxdhAMNWCS6czn62kYbjlFaa+VEuv75mlezf8lTOLX7RMvevi4eF1yKvsok1
         TKYbBx71I5V16pwSR2jmU82g/NiN5vA6jJSNZPi7hJ1CXbC3ucW52d2h89fecirJ0QYh
         R331QBlfwGBWU8qSEqgguvqPSXzovD6VFT2lX2UpArfg6q9D/N05Ulg0EO+H47KMorEJ
         oUG0IzS6Y0QCf5Jq69mLpCxX1vNGGZ6JIbiDNGknmQjG3j2PWDBjoZ8Vup0I+nxd3ytB
         dYTfm2vpDOemCcVWhwsSIh7d1IaPxGKiRmFixX2gd7T74DtKKl0/3v4CQ8+em7mKTjNr
         G+2A==
X-Gm-Message-State: AOAM53266RjIyePALKVeIgcclzQ1AH69TAtyNA+8s7p+bqfSUCHVFkF/
        XFMT06eoy+2YvqGeHYjtUiTrPUAlYm1uctY4AkromK8cT6OegMB2
X-Google-Smtp-Source: ABdhPJzFpVQ24i88siv67sw2QRVq86+eOYljMKVVOewsHicad8QLj8eEt5LRb3rxlPXisC5OjzJ5ke9XMop5tTwqc6Q=
X-Received: by 2002:a05:6902:552:: with SMTP id z18mr1632898ybs.318.1640053824150;
 Mon, 20 Dec 2021 18:30:24 -0800 (PST)
MIME-Version: 1.0
References: <1639721264-12294-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznGdvLobshPvg2KY+D71Zh0625+V=WsAS9uExRspRFFjVQ@mail.gmail.com>
 <CAJuCfpF9tJupcyWVeDHyEBnQqTZTnoyKVcKLqB1wWXyks6Z0Cw@mail.gmail.com> <CAGWkznG8ipn96YgyOatF=i5acLGoLp9G8E4jD7vHKMw9aOV1ZA@mail.gmail.com>
In-Reply-To: <CAGWkznG8ipn96YgyOatF=i5acLGoLp9G8E4jD7vHKMw9aOV1ZA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 20 Dec 2021 18:30:13 -0800
Message-ID: <CAJuCfpEmvVVQGso4bKeigdJwNG4aqViay_P3oXo2Tu4sm-HKXw@mail.gmail.com>
Subject: Re: [PATCH] psi: fix possible trigger missing in the window
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 5:57 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Tue, Dec 21, 2021 at 3:58 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, Dec 17, 2021 at 10:03 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > >
> > > loop Suren
> >
> > Thanks.
> >
> >
> > >
> > > On Fri, Dec 17, 2021 at 2:08 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> > > >
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > There could be missing wake up if the rest of the window remain the
> > > > same stall states as the polling_total updates for every polling_min_period.
> >
> > Could you please expand on this description? I'm unclear what the
> > problem is. I assume "polling_min_period" in this description refers
> > to the group->poll_min_period.
> >
> > From the code, looks like the change results in update_triggers()
> > calling window_update() once there was a new stall recorded for the
> > trigger state and until the tracking window is complete. I don't see
> > the point of calling window_update() if there was no stall change
> > since the last call to window_update(). The resulting growth will not
> > increase if there is no new stall.
> > Maybe what you want to achieve here is more than one trigger per
> > window if the stall limit was breached? If so, then this goes against
> > the design for psi triggers in which we want to rate-limit the number
> > of generated triggers per tracking window (see:
> > https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L545).
> > Please clarify the issue and the intentions here.
> > Thanks!
> Please correct me if I am wrong. Imagine that there is a new stall
> during the 1st polling_min_period among 10 of them in the window and
> group->polling_total will be updated to total without trigger. If the
> rest of 9 polling_min_periods remain the same states, the trigger will
> be missed when window timing is reached.

I don't see why updating group->polling_total after the first
registered stall is an issue here. window_update() calculates growth
using current group->total[] and win->start_value (see:
https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L483)
which is set at the beginning of the window (see:
https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L462).
If the calculated growth did not reach t->threshold then the trigger
should not be fired (see:
https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L542).
We fire the trigger only if growth within a given window is higher
than the threshold.

In your scenario if the stall recorded in the 1st polling_min_period
was less than the threshold and in the other 9 polling_min_periods no
new stalls were registered then there should be no triggers fired in
that window. This is intended behavior. Trigger is fired only when the
recorded stall within the window breaches the threshold. And there
will be only one trigger generated per window, no matter how much
stall is being recorded after the threshold was breached.
Hopefully this clarifies the behavior?

> >
> > > >
> > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > ---
> > > >  include/linux/psi_types.h |  2 ++
> > > >  kernel/sched/psi.c        | 30 ++++++++++++++++++------------
> > > >  2 files changed, 20 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > > > index 0a23300..9533d2e 100644
> > > > --- a/include/linux/psi_types.h
> > > > +++ b/include/linux/psi_types.h
> > > > @@ -132,6 +132,8 @@ struct psi_trigger {
> > > >
> > > >         /* Refcounting to prevent premature destruction */
> > > >         struct kref refcount;
> > > > +
> > > > +       bool new_stall;
> > > >  };
> > > >
> > > >  struct psi_group {
> > > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > > index 1652f2b..402718c 100644
> > > > --- a/kernel/sched/psi.c
> > > > +++ b/kernel/sched/psi.c
> > > > @@ -458,9 +458,12 @@ static void psi_avgs_work(struct work_struct *work)
> > > >  static void window_reset(struct psi_window *win, u64 now, u64 value,
> > > >                          u64 prev_growth)
> > > >  {
> > > > +       struct psi_trigger *t = container_of(win, struct psi_trigger, win);
> > > > +
> > > >         win->start_time = now;
> > > >         win->start_value = value;
> > > >         win->prev_growth = prev_growth;
> > > > +       t->new_stall = false;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -515,7 +518,6 @@ static void init_triggers(struct psi_group *group, u64 now)
> > > >  static u64 update_triggers(struct psi_group *group, u64 now)
> > > >  {
> > > >         struct psi_trigger *t;
> > > > -       bool new_stall = false;
> > > >         u64 *total = group->total[PSI_POLL];
> > > >
> > > >         /*
> > > > @@ -523,19 +525,26 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > > >          * watchers know when their specified thresholds are exceeded.
> > > >          */
> > > >         list_for_each_entry(t, &group->triggers, node) {
> > > > -               u64 growth;
> > > > -
> > > >                 /* Check for stall activity */
> > > >                 if (group->polling_total[t->state] == total[t->state])
> > > >                         continue;
> > > >
> > > >                 /*
> > > > -                * Multiple triggers might be looking at the same state,
> > > > -                * remember to update group->polling_total[] once we've
> > > > -                * been through all of them. Also remember to extend the
> > > > -                * polling time if we see new stall activity.
> > > > +                * update the trigger if there is new stall which will be
> > > > +                * reset when run out of the window
> > > >                  */
> > > > -               new_stall = true;
> > > > +               t->new_stall = true;
> > > > +
> > > > +               memcpy(&group->polling_total[t->state], &total[t->state],
> > > > +                               sizeof(group->polling_total[t->state]));
> > > > +       }
> > > > +
> > > > +       list_for_each_entry(t, &group->triggers, node) {
> > > > +               u64 growth;
> > > > +
> > > > +               /* check if new stall happened during this window*/
> > > > +               if (!t->new_stall)
> > > > +                       continue;
> > > >
> > > >                 /* Calculate growth since last update */
> > > >                 growth = window_update(&t->win, now, total[t->state]);
> > > > @@ -552,10 +561,6 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > > >                 t->last_event_time = now;
> > > >         }
> > > >
> > > > -       if (new_stall)
> > > > -               memcpy(group->polling_total, total,
> > > > -                               sizeof(group->polling_total));
> > > > -
> > > >         return now + group->poll_min_period;
> > > >  }
> > > >
> > > > @@ -1152,6 +1157,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > > >         t->last_event_time = 0;
> > > >         init_waitqueue_head(&t->event_wait);
> > > >         kref_init(&t->refcount);
> > > > +       t->new_stall = false;
> > > >
> > > >         mutex_lock(&group->trigger_lock);
> > > >
> > > > --
> > > > 1.9.1
> > > >
