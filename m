Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4AB583DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiG1LjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbiG1Lij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:38:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62969F0D
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:38:15 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r14so1673748ljp.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCIgad1TfC0INHdkBO2Mjz8fv0SBwTv2Ap17/Wc1m4c=;
        b=VDc/5BNC6AzA6mTbzGGk9Aishrq6WBYLhkrkjlbvrkoHqMDqPGAgujLdQp0SzeoeV0
         v2YSp2w1jLBeUmlm3MWqKWAowhblsMArUXzguIHYLeU1h0R5S5YyCQHGFyBngtFUsKpf
         sDxvtiS4jQZpPWChSmkDWpENofV4GwpPuGxJ1JES0HQYukwWua73KTi+TZjJDlXO9kTL
         KmCPFdxe2hhaivAd+Bp5RxWSU2A018sR+YrLm/7VLKbN/wm4JRmYWHqJjn/2yAXwYZFn
         VARL54W48p3jK+6NdSsPH5o5bLnj7IoIJBIePoAzINTRkjB6eqK2ojpBa0AWSPZ5Msx+
         Q+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCIgad1TfC0INHdkBO2Mjz8fv0SBwTv2Ap17/Wc1m4c=;
        b=vrO9kkCCd3UVlNBZCsuMQO5woNFG2IBw7l5QTtnIb43X/xOQU1aiariZ1oEibeBKZL
         HnrcAyxrsTWjS5rxoF3ekrkgevW8wI68AGOxXXT6bYTEW2iMS09NpWYfSXflv9EiBSuS
         9ERnPODtYcko+ByKAanyvvb6OapEeLvP1IOzaYjyz1N8IK727nIeEjLOVbphDrPaTilw
         WD2LjpaFeh+S9Hfe+eXf1BiDdOyJzJ34fqQ7XqBG6YqbiJsGjwhTOU2xco1WFs0tkoWV
         sSvmQI8h5VzWkADmrMt/yEn2Qtmi0fPNx7nxbieb4k60NctULdBKhvFkz9CbuKWrJGjp
         IqXQ==
X-Gm-Message-State: AJIora/xSPrnSP1VYGT2PEZMXgv9pS8BGEC++VFuq/uVMG8qJpIfwrOv
        B88M8U8IDtv0uk+B+Hyal5QB/IURc1t0Xqzn0CgXiiULSMJYWQ==
X-Google-Smtp-Source: AGRyM1u1KCo+NrL1LxHGj4S8+TgV2Pc52CsIy43IdAPkHNoLzBtvJ0zp6V7CoX2LEiE6rn/hJxGquHdqy6tbYJeAWt4=
X-Received: by 2002:a2e:a5ca:0:b0:25e:1c49:70f4 with SMTP id
 n10-20020a2ea5ca000000b0025e1c4970f4mr3790201ljp.4.1659008294966; Thu, 28 Jul
 2022 04:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220720110246.762939-1-abel.vesa@linaro.org> <CAPDyKFoh8UV=QC6RhOkc=FSvoeqF_UiWp97h0Qp8dniB=sS+8A@mail.gmail.com>
 <YuA0luCtQ1J+ExBi@linaro.org>
In-Reply-To: <YuA0luCtQ1J+ExBi@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Jul 2022 13:37:38 +0200
Message-ID: <CAPDyKFo4tryzYQK=q6aPGxocmoq=duC2B1RMh1QoV_maVCApjA@mail.gmail.com>
Subject: Re: [RFC] PM: domains: Reverse the order of performance and enabling ops
To:     Abel Vesa <abel.vesa@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Dmitry, Thierry

On Tue, 26 Jul 2022 at 20:38, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 22-07-21 18:48:10, Ulf Hansson wrote:
> > On Wed, 20 Jul 2022 at 13:03, Abel Vesa <abel.vesa@linaro.org> wrote:
> > >
> > > Rather than enabling and then setting the performance state, which usually
> > > translates into two different levels (voltages) in order to get to the
> > > one required by the consumer, we could give a chance to the providers to
> > > cache the performance state needed by the consumer and then, when powering
> > > on the power domain, the provider could use the cached level instead.
> >
> > I don't think it's really clear what you want to do here. Let's see
> > what the discussion below brings us to, but for the next version
> > please elaborate a bit more in the commit message.
>
> Sorry about that. Will give more details in the next version.
>
> >
> > Although, if I understand correctly (also from our offlist
> > discussions), you want to make it possible to move from two calls,
> > into one call into the FW from the genpd provider. So it's basically
> > an optimization, which to me, certainly sounds worth doing.
> >
> > Furthermore, to get the complete picture, in the Qcom case, we set a
> > "default" low performance level from the genpd's ->power_on()
> > callback, which is needed to enable basic functionality for some
> > consumers.
> >
> > The second call that I refer to is made when genpd calls the
> > ->set_performance() callback (from genpd_runtime_suspend()), which is
> > done by genpd to potentially set a new value for an aggregated
> > performance state of the PM domain. In case when there actually is a
> > new performance state set in this path, we end up calling the FW twice
> > for the Qcom case, where this first one is unnecessary.
> >
> > Did I get that right?
>
> Actually, for every ->power_on, there is a ->set_performance right after.
>
> For example, on genpd_runtime_suspend, this is done:
>
>         genpd_lock(genpd);
>         ret = genpd_power_on(genpd, 0);
>         if (!ret)
>                 genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
>         genpd_unlock(genpd);
>
> And same thing on __genpd_dev_pm_attach.

I guess you refer to genpd_runtime_resume(), but never mind, I get it.

Note that, I only wanted to highlight  that genpd doesn't necessarily
invoke the ->set_performance() callback at genpd_runtime_resume(). It
depends on whether there is a new performance level to be set for the
device (which also needs to aggregate to a new level for the genpd in
question).

>
> Now, TBH, I can't think of any scenario where a consumer would want its PD powered,
> (which implies a non-zero voltage level) and then changed to a higher performance
> level (higher voltage).
>
> In most scenarios, though, the consumer needs the PD powered on to a specific voltage
> level.

Yes, this sounds reasonable to me too.

However, in some cases there are certain orders of how things need to
be "powered on", there may be clocks etc that need to be managed
carefully to not break HW or cause glitches, for example.

I have looped in Dmitry and Thierry to see if they think the change
should be fine for Tegra platforms too.

>
> Based on the two statements above, we need ->set_performance to actually act as
> a way to tell the provider to which voltage level to power on the power domain
> when the ->power_on will be called.
>
> So my suggestion with this patch is to reverse the order, do ->set_performance first
> and then ->power_on, this way the provider receives the voltage level required by
> a consumer before the request to power on the PD. Then a provider might use that
> info when powering on/off that PD.

Yes, that should work fine. At least for the power on scenario. Let's
discuss more about the power off scenario below.

>
> >
> > > Also the drop_performance and power_off have to be reversed so that
> > > when the last active consumer suspends, the level doesn't actually drop
> > > until the pd is disabled.
> >
> > I don't quite get what this part helps with, is it really needed to
> > improve the behaviour?
>
> Again, why would a consumer need its PD voltage dropped before being powered off?

Similar to powering on a device/PM domain, we need to be careful about
the order of how we turn things off. Other than that, you are probably
right.

However, I don't quite understand how reversing the order of calling
the ->power_off() callback and the ->set_performance_state() would
help the provider to implement this. See more below.

>
> I think it makes more sense for the ->set_performance in this case to act as a
> way to tell the provider that a specific device has yeilded its voltage level
> request. That way the provider can drop the voltage to the minimum requested by
> the active consumers of that PD.

The genpd provider can know if the PM domain is powered on or off,
when the ->set_performance_state() callback is invoked. If it's
powered off, it may then decide to "cache" the request for the
performance level request, until it gets powered on.

Although, I don't see how a genpd provider should be able to cache a
performance state request, when the PM domain is already powered on
(which is what you propose, if I understand correctly), that simply
doesn't work for the other scenarios.

>
> >
> > >
> > > For the power domains that do not provide the set_performance, things
> > > remain unchanged, as does for the power domains that only provide the
> > > set_performance but do not provide the power_on/off.
> >
> > Right, good points!
> >
> > I get back to review the code soon, just wanted to make sure I have
> > the complete picture first.
> >
> > Kind regards
> > Uffe
> >
> > >
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > ---
> > >  drivers/base/power/domain.c | 30 +++++++++++++++---------------
> > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 5a2e0232862e..38647c304b73 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -939,8 +939,8 @@ static int genpd_runtime_suspend(struct device *dev)
> > >                 return 0;
> > >
> > >         genpd_lock(genpd);
> > > -       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> > >         genpd_power_off(genpd, true, 0);
> > > +       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> > >         genpd_unlock(genpd);
> > >
> > >         return 0;
> > > @@ -978,9 +978,8 @@ static int genpd_runtime_resume(struct device *dev)
> > >                 goto out;
> > >
> > >         genpd_lock(genpd);
> > > +       genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
> > >         ret = genpd_power_on(genpd, 0);
> > > -       if (!ret)
> > > -               genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
> > >         genpd_unlock(genpd);
> > >
> > >         if (ret)
> > > @@ -1018,8 +1017,8 @@ static int genpd_runtime_resume(struct device *dev)
> > >  err_poweroff:
> > >         if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
> > >                 genpd_lock(genpd);
> > > -               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> > >                 genpd_power_off(genpd, true, 0);
> > > +               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> > >                 genpd_unlock(genpd);
> > >         }
> > >
> > > @@ -2747,17 +2746,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> > >         dev->pm_domain->detach = genpd_dev_pm_detach;
> > >         dev->pm_domain->sync = genpd_dev_pm_sync;
> > >
> > > -       if (power_on) {
> > > -               genpd_lock(pd);
> > > -               ret = genpd_power_on(pd, 0);
> > > -               genpd_unlock(pd);
> > > -       }
> > > -
> > > -       if (ret) {
> > > -               genpd_remove_device(pd, dev);
> > > -               return -EPROBE_DEFER;
> > > -       }
> > > -
> > >         /* Set the default performance state */
> > >         pstate = of_get_required_opp_performance_state(dev->of_node, index);
> > >         if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
> > > @@ -2769,6 +2757,18 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> > >                         goto err;
> > >                 dev_gpd_data(dev)->default_pstate = pstate;
> > >         }
> > > +
> > > +       if (power_on) {
> > > +               genpd_lock(pd);
> > > +               ret = genpd_power_on(pd, 0);
> > > +               genpd_unlock(pd);
> > > +       }
> > > +
> > > +       if (ret) {
> > > +               genpd_remove_device(pd, dev);
> > > +               return -EPROBE_DEFER;
> > > +       }
> > > +
> > >         return 1;
> > >
> > >  err:
> > > --
> > > 2.34.3
> > >
> >
