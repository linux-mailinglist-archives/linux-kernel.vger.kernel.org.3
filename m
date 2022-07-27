Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F265821E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiG0IRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiG0IQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:16:59 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845CD20BDA;
        Wed, 27 Jul 2022 01:16:58 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id z14so411160uaq.13;
        Wed, 27 Jul 2022 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rNPsaPqY5EmKOD+xGcG809itbPBmUiis0DTGAwkiyHw=;
        b=kDojwPo/uMQkQTf9VpJ6yjQ8DVAqm3e+O9my9ByySiZV3yk0UCYQGvRKhJooTK/bho
         PpJ7hfPpCCkGnU0y9O+b1mfOuRl+hV7l3YalZlPC/5oD6KMSEnpwFMd206ZYg1j121Ux
         XZ0gZcEJ2YwUNNwfetpvdHg4phiUV8PNMpHuVpdg47tfj7DeXtyA1Y0norUNp6E0EydO
         LAib9G6bPzvkn9qT42YfDMVNTSaJJF3n7UARAxi+GcLJYFKhpabMyx6odE6pjuYhPp1J
         JKXSIJgjIIsrTKUn+qQAeJa04f5N2svtINNayjZ1mb/Le0wcAdcBeZWjnq1WumpIPHOq
         2y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rNPsaPqY5EmKOD+xGcG809itbPBmUiis0DTGAwkiyHw=;
        b=3Jcepz+GXJ/IS57TI5qRE+dJTdh9+/Do3126Sf9Ui2K7o4oGXjbuH/AibzuiE81qLP
         Z9jCJmLnWdd7f5WuG3rqBlHwNxaiOWTJNwe6fQQWQTPviczNcOk4OCKV1M6ROa69T8i+
         9vn0WSdp2MDT1yU+jFLhX++vSyy09Oh181oZn6PzgSaFOpRnhhJla/n0wOyXTb5bBana
         J6EIGi+ki7NIzu+p2XkRWEF1KpuAnKw165QxNWN0lizznZZvdGP8ZEFG00ALYoPTrF/h
         c3RaEnAdGH90cXkX0F3ED2jqGHnHINYxCwIFECDPio2rabfoTKT4/2n5jgZUCqIJv6dB
         Z5Xw==
X-Gm-Message-State: AJIora+S/HjaspyS6sepNjOm6GaGGssQiPx1un5tt+YU69O1ZtxbYmu7
        q/doyrq48re4FICI8RAusRGrDcHsJxicjMJLI2ezqMvWkk0=
X-Google-Smtp-Source: AGRyM1vx22HQoW59Y7hSsXB3wZ51WgZt7VfAxd5VuDU4db7OZjtyOWGnaU7pI0DIervf46hBh7v3yOmsNsFW9/7AlUo=
X-Received: by 2002:ab0:3cc:0:b0:384:defe:ff2 with SMTP id 70-20020ab003cc000000b00384defe0ff2mr172658uau.71.1658909817634;
 Wed, 27 Jul 2022 01:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220722084314.17816-1-di.shen@unisoc.com> <CAJZ5v0iKWH2QkztewmJXiqGwnzBxCo5MWni9Q3VODwV+huvuQA@mail.gmail.com>
 <12043680.O9o76ZdvQC@kreacher> <CAHYJL4r85vyJ9GukmhVki8EHt2VTAr0549-DA4ND0WGQHWpGqA@mail.gmail.com>
In-Reply-To: <CAHYJL4r85vyJ9GukmhVki8EHt2VTAr0549-DA4ND0WGQHWpGqA@mail.gmail.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Wed, 27 Jul 2022 16:16:46 +0800
Message-ID: <CAHYJL4r9Mqv96dg+KaNa0Vh6_EuXSkMy7uLwDFYGMfZP9UTRfg@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] thermal/sysfs: Clear cooling_device_stats_attr_group
 before initialized
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Di Shen <di.shen@unisoc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jeson.gao@unisoc.com, xuewen.yan@unisoc.com, ke.wang@unisoc.com
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

Hi Rafael,
I have tested this patch on our platform, and it works. Later, I will
send the patch v3.
Thanks!
--
Di

On Tue, Jul 26, 2022 at 3:39 PM Di Shen <cindygm567@gmail.com> wrote:
>
> On Sat, Jul 23, 2022 at 2:42 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Friday, July 22, 2022 7:18:42 PM CEST Rafael J. Wysocki wrote:
> > > On Fri, Jul 22, 2022 at 10:44 AM Di Shen <di.shen@unisoc.com> wrote:
> > > >
> > > > There's a space allocated for cooling_device_stats_attr_group
> > > > within cooling_device_attr_groups. This space is shared by all
> > > > cooling devices.
> > >
> > > That's correct.
> > >
> > > > If the stats structure of one cooling device successfully
> > > > creates stats sysfs. After that, another cooling device fails
> > > > to get max_states in cooling_device_stats_setup(). It can
> > > > return directly without initializing the stats structure, but
> > > > the cooling_device_stats_attr_group is still the attribute
> > > > group of the last cooling device.
> > >
> > > I cannot parse the above, sorry.
> > >
> > > For example, how can a "stats structure of one cooling device" create
> > > anything?   As a data structure, it is a passive entity, so it doesn't
> > > carry out any actions.
> > >
> > > I think (but I am not sure) that you are referring to the error code
> > > path in which the ->get_max_state() callback fails for a cooling
> > > device after cooling_device_stats_setup() has completed successfully
> > > for another one.
> > >
> > > > At this time, read or write stats sysfs nodes can cause kernel
> > > > crash. Like the following, kernel crashed when
> > > > 'cat time_in_state_ms'.
> > > >
> > > > [<5baac8d4>] panic+0x1b4/0x3c8
> > > > [<9d287b0f>] arm_notify_die+0x0/0x78
> > > > [<094fc22c>] __do_kernel_fault+0x94/0xa4
> > > > [<3b4b69a4>] do_page_fault+0xd4/0x364
> > > > [<23793e7a>] do_translation_fault+0x38/0xc0
> > > > [<6e5cc52a>] do_DataAbort+0x4c/0xd0
> > > > [<a28c16b8>] __dabt_svc+0x5c/0xa0
> > > > [<747516ae>] _raw_spin_lock+0x20/0x60
> > > > [<9a9e4cd4>] time_in_state_ms_show+0x28/0x148
> > > > [<cb78325e>] dev_attr_show+0x38/0x64
> > > > [<aea3e364>] sysfs_kf_seq_show+0x8c/0xf0
> > > > [<c0a843ab>] seq_read+0x244/0x620
> > > > [<b316b374>] vfs_read+0xd8/0x218
> > > > [<3aebf5fa>] sys_read+0x80/0xe4
> > > > [<7cf100f5>] ret_fast_syscall+0x0/0x28
> > > > [<08cbe22f>] 0xbe8c1198
> > > >
> > > > stats sysfs:
> > > > phone:/sys/class/thermal/cooling_device2/stats # ls
> > > > reset  time_in_state_ms  total_trans  trans_table
> > > >
> > > > The same as cat total_trans, trans_table, and echo reset.
> >
> > So does the (untested) patch below work too?
> >
>
> Yes, I agree with you. I will test it on our platform and give
> a reply later. Thanks.
>
> > ---
> >  drivers/thermal/thermal_sysfs.c |   10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/thermal_sysfs.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> > +++ linux-pm/drivers/thermal/thermal_sysfs.c
> > @@ -813,12 +813,13 @@ static const struct attribute_group cool
> >
> >  static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
> >  {
> > +       const struct attribute_group *stats_attr_group = NULL;
> >         struct cooling_dev_stats *stats;
> >         unsigned long states;
> >         int var;
> >
> >         if (cdev->ops->get_max_state(cdev, &states))
> > -               return;
> > +               goto out;
> >
> >         states++; /* Total number of states is highest state + 1 */
> >
> > @@ -828,7 +829,7 @@ static void cooling_device_stats_setup(s
> >
> >         stats = kzalloc(var, GFP_KERNEL);
> >         if (!stats)
> > -               return;
> > +               goto out;
> >
> >         stats->time_in_state = (ktime_t *)(stats + 1);
> >         stats->trans_table = (unsigned int *)(stats->time_in_state + states);
> > @@ -838,9 +839,12 @@ static void cooling_device_stats_setup(s
> >
> >         spin_lock_init(&stats->lock);
> >
> > +       stats_attr_group = &cooling_device_stats_attr_group;
> > +
> > +out:
> >         /* Fill the empty slot left in cooling_device_attr_groups */
> >         var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
> > -       cooling_device_attr_groups[var] = &cooling_device_stats_attr_group;
> > +       cooling_device_attr_groups[var] = stats_attr_group;
> >  }
> >
> >  static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
> >
> >
> >
> --
> Best regards,
