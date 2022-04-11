Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EAC4FB9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345645AbiDKKih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345625AbiDKKi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:38:29 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA6A43EC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:36:14 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u19so9918063ljd.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWbA8BxSlOYVP3LVwiIDtHxC35MchtX1bQhiwUUgIBM=;
        b=wQZ5G4wbP6asggk3xfZw8FnN5ffLC093ppWdL3I2U0Ii5eh+cP2bkUc5jPU/z/n8VP
         6fTLvwZu/vYB7UOXSZJipSL1SLu/3fP5wrA5YJQLwpIRaCL0ritC/xdeoKq6Jt8F1dix
         6t/H2rlxbAH0hAj+8GioML/2lI/jlw94KbL4csTtPG59Whl4ZFO0GnGjWDGBxtiMv2/N
         vpWW4Qy01T02tBh4jWiNanQKhMgnZ+IPhEKXUfwOvXQxF4m/I6yr0/rnV/w7n8szSz4u
         2PJnK185zzerZKxrK6on34Ww6HIEwIIMrdL9e2sMg10IbXiJlhLWVVM1qwtSH1HX5D2K
         q8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWbA8BxSlOYVP3LVwiIDtHxC35MchtX1bQhiwUUgIBM=;
        b=Evhpj5tjBN5gRrIko3QixWq0E/3pa7QlKK3ZjGK7bQWrXtwUUQfCFxrH9fJX5Zv+aW
         /DWe4Ci3UqiotMoK5OvfwsQlCoDVRAz7b4efx1NV0/PV64wDDDfQLLVbDp2xBHojSXPW
         m5xAvUfDPyaZlB12+diT2leXyLaHv71C0vefj/1JtfraupQq32XHZO2Yos4cH66cOyBD
         nddRj7R933vwuwhwUMrmKDK6aHIl4c80nd+GlLcBemefg9R1NwtgcDV6+yl48MOqCNoA
         SlSFzWFS+W+3F4pXB8qz83vW0gCSmfLmJJTAbEPQVZHIWd9tVN91FOWLwik2TbE4AIL3
         cyqg==
X-Gm-Message-State: AOAM533VHgvcG5t/8YXd/ky3bL/KJpcoHk8RuTSGiceJMM1zbmq+NlNf
        RGiYdjBc7TQ+DPGfuwBTzhdnEwxJktQrord0dF3PBPJimEvXxg==
X-Google-Smtp-Source: ABdhPJzMSB6szqj7+JrFClK5+oBXYA0BTO3VojX36KJWRQfEbbmK9WnDf60M+AqYlDUEuv1kX2aRaWUgyewAkiIWS94=
X-Received: by 2002:a2e:9048:0:b0:249:78bb:375e with SMTP id
 n8-20020a2e9048000000b0024978bb375emr20336046ljg.229.1649673372244; Mon, 11
 Apr 2022 03:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <1836398.tdWV9SEqCh@kreacher> <CAPDyKFoop_mtWV0i+fH8GSmaxbPCyCPmOeNi6GuK5Qrj7ZVo1g@mail.gmail.com>
 <CAJZ5v0geG77Npdy_Ae7XnpWukPPSJ1nE0DFF-vbJViKj6GtCWA@mail.gmail.com>
In-Reply-To: <CAJZ5v0geG77Npdy_Ae7XnpWukPPSJ1nE0DFF-vbJViKj6GtCWA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Apr 2022 12:35:35 +0200
Message-ID: <CAPDyKFo9t__WV00yp5gt+M0BhYtgJU2HmKXF2fXEDtjvSEUhhw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Avoid device usage count underflows
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 at 19:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Apr 8, 2022 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 6 Apr 2022 at 21:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > A PM-runtime device usage count underflow is potentially critical,
> > > because it may cause a device to be suspended when it is expected to
> > > be operational.
> >
> > I get the point. Although, perhaps we should also state that it's a
> > programming problem that we would like to catch and warn about?
>
> OK, I can add that to the changelog.
>
> > >
> > > For this reason, (1) make rpm_check_suspend_allowed() return an error
> > > when the device usage count is negative to prevent devices from being
> > > suspended in that case, (2) introduce rpm_drop_usage_count() that will
> > > detect device usage count underflows, warn about them and fix them up,
> > > and (3) use it to drop the usage count in a few places instead of
> > > atomic_dec_and_test().
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c |   44 ++++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 37 insertions(+), 7 deletions(-)
> > >
> > > Index: linux-pm/drivers/base/power/runtime.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > +++ linux-pm/drivers/base/power/runtime.c
> > > @@ -263,7 +263,7 @@ static int rpm_check_suspend_allowed(str
> > >                 retval = -EINVAL;
> > >         else if (dev->power.disable_depth > 0)
> > >                 retval = -EACCES;
> > > -       else if (atomic_read(&dev->power.usage_count) > 0)
> > > +       else if (atomic_read(&dev->power.usage_count))
> > >                 retval = -EAGAIN;
> > >         else if (!dev->power.ignore_children &&
> > >                         atomic_read(&dev->power.child_count))
> > > @@ -1039,13 +1039,33 @@ int pm_schedule_suspend(struct device *d
> > >  }
> > >  EXPORT_SYMBOL_GPL(pm_schedule_suspend);
> > >
> > > +static int rpm_drop_usage_count(struct device *dev)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret = atomic_sub_return(1, &dev->power.usage_count);
> > > +       if (ret >= 0)
> > > +               return ret;
> > > +
> > > +       /*
> > > +        * Because rpm_resume() does not check the usage counter, it will resume
> > > +        * the device even if the usage counter is 0 or negative, so it is
> > > +        * sufficient to increment the usage counter here to reverse the change
> > > +        * made above.
> > > +        */
> > > +       atomic_inc(&dev->power.usage_count);
> >
> > Rather than this two-step process, couldn't we just do an
> > "atomic_add_unless(&dev->power.usage_count, -1, 0)" - and check the
> > return value?
>
> No, we couldn't, because atomic_add_unless() returns a bool and we
> need to know the new counter value (and in particular whether or not
> it is 0).

atomic_add_unless(&dev->power.usage_count, -1, 0) would return true as
long as the counter value is greater than 0.

If the counter has become 0, atomic_add_unless() would return false
and not continue to decrease the value below zero. Isn't this exactly
what we want?

>
> I thought that it would be better to do the extra access in the
> failing case only.
>
> > > +       dev_warn(dev, "Runtime PM usage count underflow!\n");
> > > +       return -EINVAL;
> > > +}
> > > +
> >
> > [...]

Kind regards
Uffe
