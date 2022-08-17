Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED7B597292
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiHQPIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240479AbiHQPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:08:25 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AE59D65D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:08:23 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-335624d1e26so39846457b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RptizGALOcGDZUaMSejU1Y48xlCDOc6zbnU/3jqvVSU=;
        b=i5vVDoAdUT1wNEh6TTFJmIvzcPK8JyoFGBTSTAjRCy6PmTl0oUfurtrjsgLVVZUUuC
         HIqeMgKN+Zzrys4bzn50422vz1YipmDJwolIqatz5fa1flvlAFVrNlqM7imjNblbuw6/
         LuqeQXemUTOKtKL1E91HyDlo3QnyDwCpnjxUnMI3U3uoeWMqDFjdE3ySYEMFgdMonj9j
         gvCLTSTYW2RRHn77dDwiwEiAdbxRlV/yPKmQkgBLNn2fhGoI0IkC+eTOzt05jbfAtYfo
         ZTGbWEq+Nbz/buQvtTDOIoTVhqnwM2fet/GWp4PW8b0RMktLI/ovXmmNfuuAL+c7m9Pv
         4yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RptizGALOcGDZUaMSejU1Y48xlCDOc6zbnU/3jqvVSU=;
        b=U+3rHSoAN/o99QD6uWqRwguG9lRYjTRuxKHVyAm7uqN60Jh9L8qupTbHccRdwavo/k
         dZKy2VFp/61Vs4IjNwPc6OH2Dvxuu7xllAI2xPM4oRUGBmZBof9PJ3ehcX3oGYaNJDOH
         X946Tv6rCyJtTStBa8ETqxY31pgRUac/DTHrpHrFqEeDy9ASBAfttdE3JywYSljx3MnG
         9MZs4P6kuvJb9/XrWaiBL7o02HOBVmIl+8QyZk0YJzqOkr/TKc0TkSHGOWh9clnCYpa7
         LYowoHXHcSTJ/tFhn64PQuLzJaamBBzvTUpkDGPlVpo77wxVBP6JRj53p1ff+oBxbaqX
         DrMw==
X-Gm-Message-State: ACgBeo0nd0RXMnhhzaie/ZPoxf1yKeXcdCW7xPq37LKhV0fAIpX8QW8d
        PULWyGmBjNtN/uAWkpsfH/Nf66x3DKuwealI9PT3mA==
X-Google-Smtp-Source: AA6agR4Kh7XKd42YFRE4fLJZ24Hk1ziFruRUTG9ZTc8GZG07Pj+S6jz8YvWE+qjBYTWcTREH6SFqAnVAy2AWF2tqUjk=
X-Received: by 2002:a0d:cb02:0:b0:334:e16c:8d36 with SMTP id
 n2-20020a0dcb02000000b00334e16c8d36mr3713665ywd.86.1660748901817; Wed, 17 Aug
 2022 08:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220808125745.22566-1-zhouchengming@bytedance.com>
 <20220808125745.22566-7-zhouchengming@bytedance.com> <CAKfTPtBbKoJ0r=tE+9E9KxHkCy1ucev_DxLRqeQrx39ZzizqGA@mail.gmail.com>
 <fa2e11fc-5a49-b88a-1daa-ad6e5f5dea51@bytedance.com>
In-Reply-To: <fa2e11fc-5a49-b88a-1daa-ad6e5f5dea51@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 17 Aug 2022 17:08:10 +0200
Message-ID: <CAKfTPtC=zfd6SekH--_jrZQg-YPkCD4-W0S2WgVTZ_RqY_NdGw@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] sched/fair: fix another detach on unattached task
 corner case
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 at 17:04, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2022/8/17 23:01, Vincent Guittot wrote:
> > On Mon, 8 Aug 2022 at 14:58, Chengming Zhou <zhouchengming@bytedance.com> wrote:
> >>
> >> commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
> >> fixed two load tracking problems for new task, including detach on
> >> unattached new task problem.
> >>
> >> There still left another detach on unattached task problem for the task
> >> which has been woken up by try_to_wake_up() and waiting for actually
> >> being woken up by sched_ttwu_pending().
> >>
> >> try_to_wake_up(p)
> >>   cpu = select_task_rq(p)
> >>   if (task_cpu(p) != cpu)
> >>     set_task_cpu(p, cpu)
> >>       migrate_task_rq_fair()
> >>         remove_entity_load_avg()       --> unattached
> >>         se->avg.last_update_time = 0;
> >>       __set_task_cpu()
> >>   ttwu_queue(p, cpu)
> >>     ttwu_queue_wakelist()
> >>       __ttwu_queue_wakelist()
> >>
> >> task_change_group_fair()
> >>   detach_task_cfs_rq()
> >>     detach_entity_cfs_rq()
> >>       detach_entity_load_avg()   --> detach on unattached task
> >>   set_task_rq()
> >>   attach_task_cfs_rq()
> >>     attach_entity_cfs_rq()
> >>       attach_entity_load_avg()
> >>
> >> The reason of this problem is similar, we should check in detach_entity_cfs_rq()
> >> that se->avg.last_update_time != 0, before do detach_entity_load_avg().
> >>
> >> This patch move detach/attach_entity_cfs_rq() functions up to be together
> >> with other load tracking functions to avoid to use another #ifdef CONFIG_SMP.
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> ---
> >>  kernel/sched/fair.c | 132 +++++++++++++++++++++++---------------------
> >>  1 file changed, 68 insertions(+), 64 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index f52e7dc7f22d..4bc76d95a99d 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -874,9 +874,6 @@ void init_entity_runnable_average(struct sched_entity *se)
> >>  void post_init_entity_util_avg(struct task_struct *p)
> >>  {
> >>  }
> >> -static void update_tg_load_avg(struct cfs_rq *cfs_rq)
> >> -{
> >> -}
> >>  #endif /* CONFIG_SMP */
> >>
> >>  /*
> >> @@ -3176,6 +3173,7 @@ void reweight_task(struct task_struct *p, int prio)
> >>         load->inv_weight = sched_prio_to_wmult[prio];
> >>  }
> >>
> >> +static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
> >>  static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
> >>
> >>  #ifdef CONFIG_FAIR_GROUP_SCHED
> >> @@ -4086,6 +4084,71 @@ static void remove_entity_load_avg(struct sched_entity *se)
> >>         raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
> >>  }
> >>
> >> +#ifdef CONFIG_FAIR_GROUP_SCHED
> >> +/*
> >> + * Propagate the changes of the sched_entity across the tg tree to make it
> >> + * visible to the root
> >> + */
> >> +static void propagate_entity_cfs_rq(struct sched_entity *se)
> >> +{
> >> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >> +
> >> +       if (cfs_rq_throttled(cfs_rq))
> >> +               return;
> >> +
> >> +       if (!throttled_hierarchy(cfs_rq))
> >> +               list_add_leaf_cfs_rq(cfs_rq);
> >> +
> >> +       /* Start to propagate at parent */
> >> +       se = se->parent;
> >> +
> >> +       for_each_sched_entity(se) {
> >> +               cfs_rq = cfs_rq_of(se);
> >> +
> >> +               update_load_avg(cfs_rq, se, UPDATE_TG);
> >> +
> >> +               if (cfs_rq_throttled(cfs_rq))
> >> +                       break;
> >> +
> >> +               if (!throttled_hierarchy(cfs_rq))
> >> +                       list_add_leaf_cfs_rq(cfs_rq);
> >> +       }
> >> +}
> >> +#else
> >> +static void propagate_entity_cfs_rq(struct sched_entity *se) { }
> >> +#endif
> >> +
> >> +static void detach_entity_cfs_rq(struct sched_entity *se)
> >> +{
> >> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >> +
> >> +       /*
> >> +        * In case the task sched_avg hasn't been attached:
> >> +        * - A forked task which hasn't been woken up by wake_up_new_task().
> >> +        * - A task which has been woken up by try_to_wake_up() but is
> >> +        *   waiting for actually being woken up by sched_ttwu_pending().
> >> +        */
> >> +       if (!se->avg.last_update_time)
> >> +               return;
> >
> > The 2 lines above and the associated comment are the only relevant
> > part of the patch, aren't they ?
> > Is everything else just code moving from one place to another one
> > without change ?
>
> Yes, everything else is just code movement.

Could you remove such code movement ? It doesn't add any value to the
patch, does it ? But It makes the patch quite difficult to review and
I wasted a lot of time looking for what really changed in the code

Thanks

>
> Thanks!
>
> >
> >> +
> >> +       /* Catch up with the cfs_rq and remove our load when we leave */
> >> +       update_load_avg(cfs_rq, se, 0);
> >> +       detach_entity_load_avg(cfs_rq, se);
> >> +       update_tg_load_avg(cfs_rq);
> >> +       propagate_entity_cfs_rq(se);
> >> +}
> >> +
> >> +static void attach_entity_cfs_rq(struct sched_entity *se)
> >> +{
> >> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >> +
> >> +       /* Synchronize entity with its cfs_rq */
> >> +       update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
> >> +       attach_entity_load_avg(cfs_rq, se);
> >> +       update_tg_load_avg(cfs_rq);
> >> +       propagate_entity_cfs_rq(se);
> >> +}
> >> +
> >>  static inline unsigned long cfs_rq_runnable_avg(struct cfs_rq *cfs_rq)
> >>  {
> >>         return cfs_rq->avg.runnable_avg;
> >> @@ -4308,11 +4371,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >>  }
> >>
> >>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
> >> -
> >> -static inline void
> >> -attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
> >> -static inline void
> >> -detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
> >> +static inline void detach_entity_cfs_rq(struct sched_entity *se) {}
> >> +static inline void attach_entity_cfs_rq(struct sched_entity *se) {}
> >>
> >>  static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
> >>  {
> >> @@ -11519,62 +11579,6 @@ static inline bool vruntime_normalized(struct task_struct *p)
> >>         return false;
> >>  }
> >>
> >> -#ifdef CONFIG_FAIR_GROUP_SCHED
> >> -/*
> >> - * Propagate the changes of the sched_entity across the tg tree to make it
> >> - * visible to the root
> >> - */
> >> -static void propagate_entity_cfs_rq(struct sched_entity *se)
> >> -{
> >> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >> -
> >> -       if (cfs_rq_throttled(cfs_rq))
> >> -               return;
> >> -
> >> -       if (!throttled_hierarchy(cfs_rq))
> >> -               list_add_leaf_cfs_rq(cfs_rq);
> >> -
> >> -       /* Start to propagate at parent */
> >> -       se = se->parent;
> >> -
> >> -       for_each_sched_entity(se) {
> >> -               cfs_rq = cfs_rq_of(se);
> >> -
> >> -               update_load_avg(cfs_rq, se, UPDATE_TG);
> >> -
> >> -               if (cfs_rq_throttled(cfs_rq))
> >> -                       break;
> >> -
> >> -               if (!throttled_hierarchy(cfs_rq))
> >> -                       list_add_leaf_cfs_rq(cfs_rq);
> >> -       }
> >> -}
> >> -#else
> >> -static void propagate_entity_cfs_rq(struct sched_entity *se) { }
> >> -#endif
> >> -
> >> -static void detach_entity_cfs_rq(struct sched_entity *se)
> >> -{
> >> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >> -
> >> -       /* Catch up with the cfs_rq and remove our load when we leave */
> >> -       update_load_avg(cfs_rq, se, 0);
> >> -       detach_entity_load_avg(cfs_rq, se);
> >> -       update_tg_load_avg(cfs_rq);
> >> -       propagate_entity_cfs_rq(se);
> >> -}
> >> -
> >> -static void attach_entity_cfs_rq(struct sched_entity *se)
> >> -{
> >> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >> -
> >> -       /* Synchronize entity with its cfs_rq */
> >> -       update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
> >> -       attach_entity_load_avg(cfs_rq, se);
> >> -       update_tg_load_avg(cfs_rq);
> >> -       propagate_entity_cfs_rq(se);
> >> -}
> >> -
> >>  static void detach_task_cfs_rq(struct task_struct *p)
> >>  {
> >>         struct sched_entity *se = &p->se;
> >> --
> >> 2.36.1
> >>
