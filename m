Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B51582871
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiG0OUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiG0OU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:20:26 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C85AE70;
        Wed, 27 Jul 2022 07:20:24 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id c131so30416832ybf.9;
        Wed, 27 Jul 2022 07:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZZQrQFuZsMC74d9YHFngh8zcNejUotEWaL+cgwpy5r0=;
        b=LQkjDTUri6/kMt9NiJi5nMaMMjW2AtwqcAjBjMD1x7eTCmHWAzMPw7mg737aS6qaCn
         Hn3ZVGK+u/luEU/3kEsysyW03Xxw8uxXMl3cWjmUt4SsgIcJcVJuxqI/IthjcSFve+BO
         db+4js5+48kIpSlEqv67RW9bc1mxQJOo23TjlSqGIW7x5r9LwxZa3Yov848VdKjCly+q
         GTY0kn6GFvX5287kd0dcl1aVfWsoYH7zl1oUnIFDkjW00BUDl0EKwZagg+kxwIVPB6in
         gdMoCyf4dgQ4+rOFZyfaVDx/Vg9j3VGU9BunlOecWjZAsBRT86HPQ0sBTicZL/O134YZ
         J9Bw==
X-Gm-Message-State: AJIora9jdi0FN3axmBxkbbvKPu1BLRNsLf5HV19RuTUjOAkDegAhInZr
        i8WF8hI5FA4DEuWl8IWhMexyKgtes09bJ/FXVA0=
X-Google-Smtp-Source: AGRyM1uGIbmyr0q0QRHW5y2W97GwmCI+dp+iGYjJTRfR+7+eLpW5l6PCtu03bh+mBT295lnvedtmIkIaHWNi783kI9w=
X-Received: by 2002:a05:6902:1541:b0:670:ac02:58c3 with SMTP id
 r1-20020a056902154100b00670ac0258c3mr17346883ybu.622.1658931623636; Wed, 27
 Jul 2022 07:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220722084314.17816-1-di.shen@unisoc.com> <CAJZ5v0iKWH2QkztewmJXiqGwnzBxCo5MWni9Q3VODwV+huvuQA@mail.gmail.com>
 <12043680.O9o76ZdvQC@kreacher> <CAHYJL4r85vyJ9GukmhVki8EHt2VTAr0549-DA4ND0WGQHWpGqA@mail.gmail.com>
 <CAHYJL4r9Mqv96dg+KaNa0Vh6_EuXSkMy7uLwDFYGMfZP9UTRfg@mail.gmail.com>
In-Reply-To: <CAHYJL4r9Mqv96dg+KaNa0Vh6_EuXSkMy7uLwDFYGMfZP9UTRfg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Jul 2022 16:20:12 +0200
Message-ID: <CAJZ5v0j9B7=3r=2tvtuhQyPV1egZJzQ=Yf8OKXTa+QJO0vO_xg@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] thermal/sysfs: Clear cooling_device_stats_attr_group
 before initialized
To:     Di Shen <cindygm567@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Di Shen <di.shen@unisoc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jeson.gao@unisoc.com, xuewen.yan@unisoc.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 10:17 AM Di Shen <cindygm567@gmail.com> wrote:
>
> Hi Rafael,
> I have tested this patch on our platform, and it works. Later, I will
> send the patch v3.

Well, no need.  I'll use the one that you've just tested.

Thanks!


> On Tue, Jul 26, 2022 at 3:39 PM Di Shen <cindygm567@gmail.com> wrote:
> >
> > On Sat, Jul 23, 2022 at 2:42 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Friday, July 22, 2022 7:18:42 PM CEST Rafael J. Wysocki wrote:
> > > > On Fri, Jul 22, 2022 at 10:44 AM Di Shen <di.shen@unisoc.com> wrote:
> > > > >
> > > > > There's a space allocated for cooling_device_stats_attr_group
> > > > > within cooling_device_attr_groups. This space is shared by all
> > > > > cooling devices.
> > > >
> > > > That's correct.
> > > >
> > > > > If the stats structure of one cooling device successfully
> > > > > creates stats sysfs. After that, another cooling device fails
> > > > > to get max_states in cooling_device_stats_setup(). It can
> > > > > return directly without initializing the stats structure, but
> > > > > the cooling_device_stats_attr_group is still the attribute
> > > > > group of the last cooling device.
> > > >
> > > > I cannot parse the above, sorry.
> > > >
> > > > For example, how can a "stats structure of one cooling device" create
> > > > anything?   As a data structure, it is a passive entity, so it doesn't
> > > > carry out any actions.
> > > >
> > > > I think (but I am not sure) that you are referring to the error code
> > > > path in which the ->get_max_state() callback fails for a cooling
> > > > device after cooling_device_stats_setup() has completed successfully
> > > > for another one.
> > > >
> > > > > At this time, read or write stats sysfs nodes can cause kernel
> > > > > crash. Like the following, kernel crashed when
> > > > > 'cat time_in_state_ms'.
> > > > >
> > > > > [<5baac8d4>] panic+0x1b4/0x3c8
> > > > > [<9d287b0f>] arm_notify_die+0x0/0x78
> > > > > [<094fc22c>] __do_kernel_fault+0x94/0xa4
> > > > > [<3b4b69a4>] do_page_fault+0xd4/0x364
> > > > > [<23793e7a>] do_translation_fault+0x38/0xc0
> > > > > [<6e5cc52a>] do_DataAbort+0x4c/0xd0
> > > > > [<a28c16b8>] __dabt_svc+0x5c/0xa0
> > > > > [<747516ae>] _raw_spin_lock+0x20/0x60
> > > > > [<9a9e4cd4>] time_in_state_ms_show+0x28/0x148
> > > > > [<cb78325e>] dev_attr_show+0x38/0x64
> > > > > [<aea3e364>] sysfs_kf_seq_show+0x8c/0xf0
> > > > > [<c0a843ab>] seq_read+0x244/0x620
> > > > > [<b316b374>] vfs_read+0xd8/0x218
> > > > > [<3aebf5fa>] sys_read+0x80/0xe4
> > > > > [<7cf100f5>] ret_fast_syscall+0x0/0x28
> > > > > [<08cbe22f>] 0xbe8c1198
> > > > >
> > > > > stats sysfs:
> > > > > phone:/sys/class/thermal/cooling_device2/stats # ls
> > > > > reset  time_in_state_ms  total_trans  trans_table
> > > > >
> > > > > The same as cat total_trans, trans_table, and echo reset.
> > >
> > > So does the (untested) patch below work too?
> > >
> >
> > Yes, I agree with you. I will test it on our platform and give
> > a reply later. Thanks.
> >
> > > ---
> > >  drivers/thermal/thermal_sysfs.c |   10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > > @@ -813,12 +813,13 @@ static const struct attribute_group cool
> > >
> > >  static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
> > >  {
> > > +       const struct attribute_group *stats_attr_group = NULL;
> > >         struct cooling_dev_stats *stats;
> > >         unsigned long states;
> > >         int var;
> > >
> > >         if (cdev->ops->get_max_state(cdev, &states))
> > > -               return;
> > > +               goto out;
> > >
> > >         states++; /* Total number of states is highest state + 1 */
> > >
> > > @@ -828,7 +829,7 @@ static void cooling_device_stats_setup(s
> > >
> > >         stats = kzalloc(var, GFP_KERNEL);
> > >         if (!stats)
> > > -               return;
> > > +               goto out;
> > >
> > >         stats->time_in_state = (ktime_t *)(stats + 1);
> > >         stats->trans_table = (unsigned int *)(stats->time_in_state + states);
> > > @@ -838,9 +839,12 @@ static void cooling_device_stats_setup(s
> > >
> > >         spin_lock_init(&stats->lock);
> > >
> > > +       stats_attr_group = &cooling_device_stats_attr_group;
> > > +
> > > +out:
> > >         /* Fill the empty slot left in cooling_device_attr_groups */
> > >         var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
> > > -       cooling_device_attr_groups[var] = &cooling_device_stats_attr_group;
> > > +       cooling_device_attr_groups[var] = stats_attr_group;
> > >  }
> > >
> > >  static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
> > >
> > >
> > >
> > --
> > Best regards,
