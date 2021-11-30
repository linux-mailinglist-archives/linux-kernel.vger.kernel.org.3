Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE25463C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244188AbhK3QpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244206AbhK3Qo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:44:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B512CC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:41:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id k37so55368608lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kyy5kcZ43sXFDm38rNaL9n+3ZdImIUU9HCZzZTva2pY=;
        b=Ka0CXC3i9bvvecCDx9Z5im7sQPJIgugqFFi06WelJN+2Uq+b/sruqCcxGH+pjFeVuJ
         NhrN9uu138xKic4RAIY4aHvvcFA46faRlzmks5aXdCGipYzgDv6pp/OKF35rxQ87Aknu
         uwsrjCmZG+m1gA9Lfil7KQabYW983wOXTJDhjCLIgA9Y5Il5E4nI+1lVGKtcKmbtpqI4
         EqNbq7vApHnJjSnyAEcxJN6QnI1o0SAbWvGs9+atXwho80F920BYMZ+Wj5USP5ql6pzp
         P4b+XT+uPkeS2jFIdxuYvlnmWHNTxUbtRFg3SoNCNukj+dLHVjmzbAd+fwHkzQhTKx+d
         oeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kyy5kcZ43sXFDm38rNaL9n+3ZdImIUU9HCZzZTva2pY=;
        b=aY0izcFT7phmEyh+0Z2GbrN43KMZVRKsACiyMxA7EeuABrQllmv14E6DF8xikZAiq+
         U3cTEiYfW2eZ6kNfVQ513hWXcWhlt8OV7Xp63GcJxrofsPc0AKFSRrladYtVM1fZNyP7
         Zm0lPsS7WY5At80E10wT+I1Q8LUAN0LVjdodfOk9C9oCUCusNaikCQwQdtUb/Xv63Csy
         HWHvhwNrQR1KQmnxI3tf3hjEDJFWvYFiQwo+gSNyIuk5VQnk9bWZqEwhoSzf9xZzqY9j
         aGd+bDZfsAJDp7m+Cu87eOGDduDo2WC+3JF5grqtQymI6x5Nx2Xohf77i1rI/Y3rMiSx
         bCsg==
X-Gm-Message-State: AOAM532XeyZgOzEkQNm7tR9cUixdlIiVox/UiyIlYv/Ny0/GfyMccwo2
        3Gybvyteo1PL1LPGAmjpYIwK1ebXY4+HagohqbJ2Fw==
X-Google-Smtp-Source: ABdhPJw5X3mByHXC2oiBcxJWG43NolC0aFwsW33SuY3Ig18um9KB4iN/lu0rxCAd4GTVjMO0qU3uF3o9NSejEI9/xzM=
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr343838lfg.184.1638290496755;
 Tue, 30 Nov 2021 08:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <CAJZ5v0hrTDsCUn4vgmFrTTgd6H=orh-Kb5b3+_H9St4n8fTxBw@mail.gmail.com>
 <CAPDyKFre=tp4919FLoeU-wjLDJ02zmHaXY4wgTUmfmFbeaCadQ@mail.gmail.com>
 <4380690.LvFx2qVVIh@kreacher> <CAPDyKFpyPov-faJ9dUszi38Q7-4OsowX=i8w=NCnTQ66_zooHg@mail.gmail.com>
 <CAJZ5v0iEfE35Aig8XADKbQEJqb8PNmcghLnrVXHkemDjTOLr5g@mail.gmail.com>
In-Reply-To: <CAJZ5v0iEfE35Aig8XADKbQEJqb8PNmcghLnrVXHkemDjTOLr5g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Nov 2021 17:41:00 +0100
Message-ID: <CAPDyKFqVrYKyUjxoErPBuahcgDNX7esspWG4Vqi0q-8_u7MoFQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 at 14:02, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Nov 30, 2021 at 12:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > [...]
> >
> > > > > > > >
> > > > > > > > Am I thinking correctly that this is mostly about working around the
> > > > > > > > limitations of pm_runtime_force_suspend()?
> > > > > > >
> > > > > > > No, this isn't related at all.
> > > > > > >
> > > > > > > The cpuidle-psci driver doesn't have PM callbacks, thus using
> > > > > > > pm_runtime_force_suspend() would not work here.
> > > > > >
> > > > > > Just wanted to send a ping on this to see if we can come to a
> > > > > > conclusion. Or maybe we did? :-)
> > > > > >
> > > > > > I think in the end, what slightly bothers me, is that the behavior is
> > > > > > a bit inconsistent. Although, maybe it's the best we can do.
> > > > >
> > > > > I've been thinking about this and it looks like we can do better, but
> > > > > instead of talking about this I'd rather send a patch.
> > > >
> > > > Alright.
> > > >
> > > > I was thinking along the lines of make similar changes for
> > > > rpm_idle|suspend(). That would make the behaviour even more
> > > > consistent, I think.
> > > >
> > > > Perhaps that's what you have in mind? :-)
> > >
> > > Well, not exactly.
> > >
> > > The idea is to add another counter (called restrain_depth in the patch)
> > > to prevent rpm_resume() from running the callback when that is potentially
> > > problematic.  With that, it is possible to actually distinguish devices
> > > with PM-runtime enabled and it allows the PM-runtime status to be checked
> > > when it is still known to be meaningful.
> >
> > Hmm, I don't quite understand the benefit of introducing a new flag
> > for this. rpm_resume() already checks the disable_depth to understand
> > when it's safe to invoke the callback. Maybe there is a reason why
> > that isn't sufficient?
>
> The problem is that disable_depth > 0 may very well mean that runtime
> PM has not been enabled at all for the given device which IMO is a
> problem.
>
> As it stands, it is necessary to make assumptions, like disable_depth
> == 1 meaning that runtime PM is really enabled, but the PM core has
> disabled it temporarily, which is somewhat questionable.
>
> Another problem with disabling is that it causes rpm_resume() to fail
> even if the status is RPM_ACTIVE and it has to do that exactly because
> it cannot know why runtime PM has been disabled.  If it has never been
> enabled, rpm_resume() must fail, but if it has been disabled
> temporarily, rpm_resume() may return 1 when the status is RPM_ACTIVE.
>
> The new count allows the "enabled in general, but temporarily disabled
> at the moment" to be handled cleanly.

My overall comment is that I fail to understand why we need to
distinguish between these two cases. To me, it shouldn't really
matter, *why* runtime PM is (or have been) disabled for the device.

The important point is that the default state for a device is
RPM_SUSPENDED and someone has moved into RPM_ACTIVE, for whatever
reason. That should be sufficient to allow rpm_resume() to return '1'
when disable_depth > 0, shouldn't it?

>
> > >
> > > It requires quite a few changes, but is rather straightforward, unless I'm
> > > missing something.
> > >
> > > Please see the patch below.  I've only checked that it builds on x86-64.
> > >
> > > ---
> > >  drivers/base/power/main.c    |   18 +++----
> > >  drivers/base/power/runtime.c |  105 ++++++++++++++++++++++++++++++++++++-------
> > >  include/linux/pm.h           |    2
> > >  include/linux/pm_runtime.h   |    2
> > >  4 files changed, 101 insertions(+), 26 deletions(-)
> > >
> > > Index: linux-pm/include/linux/pm.h
> > > ===================================================================
> > > --- linux-pm.orig/include/linux/pm.h
> > > +++ linux-pm/include/linux/pm.h
> > > @@ -598,6 +598,7 @@ struct dev_pm_info {
> > >         atomic_t                usage_count;
> > >         atomic_t                child_count;
> > >         unsigned int            disable_depth:3;
> > > +       unsigned int            restrain_depth:3;       /* PM core private */
> > >         unsigned int            idle_notification:1;
> > >         unsigned int            request_pending:1;
> > >         unsigned int            deferred_resume:1;
> > > @@ -609,6 +610,7 @@ struct dev_pm_info {
> > >         unsigned int            use_autosuspend:1;
> > >         unsigned int            timer_autosuspends:1;
> > >         unsigned int            memalloc_noio:1;
> > > +       unsigned int            already_suspended:1;    /* PM core private */
> > >         unsigned int            links_count;
> > >         enum rpm_request        request;
> > >         enum rpm_status         runtime_status;
> > > Index: linux-pm/include/linux/pm_runtime.h
> > > ===================================================================
> > > --- linux-pm.orig/include/linux/pm_runtime.h
> > > +++ linux-pm/include/linux/pm_runtime.h
> > > @@ -46,6 +46,8 @@ extern void pm_runtime_enable(struct dev
> > >  extern void __pm_runtime_disable(struct device *dev, bool check_resume);
> > >  extern void pm_runtime_allow(struct device *dev);
> > >  extern void pm_runtime_forbid(struct device *dev);
> > > +extern void pm_runtime_restrain(struct device *dev);
> > > +extern void pm_runtime_relinquish(struct device *dev);
> > >  extern void pm_runtime_no_callbacks(struct device *dev);
> > >  extern void pm_runtime_irq_safe(struct device *dev);
> > >  extern void __pm_runtime_use_autosuspend(struct device *dev, bool use);
> > > Index: linux-pm/drivers/base/power/runtime.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > +++ linux-pm/drivers/base/power/runtime.c
> > > @@ -744,11 +744,11 @@ static int rpm_resume(struct device *dev
> > >   repeat:
> > >         if (dev->power.runtime_error)
> > >                 retval = -EINVAL;
> > > -       else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> > > -           && dev->power.runtime_status == RPM_ACTIVE)
> > > -               retval = 1;
> > >         else if (dev->power.disable_depth > 0)
> > >                 retval = -EACCES;
> > > +       else if (dev->power.restrain_depth > 0)
> > > +               retval = dev->power.runtime_status == RPM_ACTIVE ? 1 : -EAGAIN;
> > > +
> > >         if (retval)
> > >                 goto out;
> > >
> > > @@ -1164,9 +1164,9 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_acti
> > >   * @dev: Device to handle.
> > >   * @status: New runtime PM status of the device.
> > >   *
> > > - * If runtime PM of the device is disabled or its power.runtime_error field is
> > > - * different from zero, the status may be changed either to RPM_ACTIVE, or to
> > > - * RPM_SUSPENDED, as long as that reflects the actual state of the device.
> > > + * If runtime PM of the device is disabled or restrained, or its
> > > + * power.runtime_error field is nonzero, the status may be changed either to
> > > + * RPM_ACTIVE, or to RPM_SUSPENDED, as long as that reflects its actual state.
> > >   * However, if the device has a parent and the parent is not active, and the
> > >   * parent's power.ignore_children flag is unset, the device's status cannot be
> > >   * set to RPM_ACTIVE, so -EBUSY is returned in that case.
> > > @@ -1195,13 +1195,16 @@ int __pm_runtime_set_status(struct devic
> > >         spin_lock_irq(&dev->power.lock);
> > >
> > >         /*
> > > -        * Prevent PM-runtime from being enabled for the device or return an
> > > -        * error if it is enabled already and working.
> > > +        * Prevent PM-runtime from being used for the device or return an
> > > +        * error if it is in use already.
> > >          */
> > > -       if (dev->power.runtime_error || dev->power.disable_depth)
> > > -               dev->power.disable_depth++;
> > > -       else
> > > +       if (dev->power.runtime_error || dev->power.disable_depth ||
> > > +           dev->power.restrain_depth) {
> > > +               pm_runtime_get_noresume(dev);
> >
> > Why do we need to bump the usage count here? Except for balancing with
> > pm_runtime_relinquish() a few lines below, of course?
>
> First off, I need the usage count to be greater than 0 to prevent the
> runtime suspend callback from running while "restrained" (and the
> suspend could check the restrain count, but that's one more check in
> the suspend path which isn't necessary if the usage counter is always
> bumped up upfront).

If disable_depth > 0 (or restrain_depth > 0), the runtime PM core
should prevent the runtime suspend callback from being invoked, no
matter whether the usage count has been bumped or not. Or did I get
that wrong?

>
> Second, the PM core bumps up the usage counter during system-wide
> suspend, so bumping it up again isn't strictly needed if this
> "temporary disabling" is limited to the system-wide suspend-resume
> paths, but I'm not sure if it should be limited this way.
>
> I would prefer the "temporarily unavailable" case to be clearly
> different from the "disabled" one in any case, not just during
> system-wide suspend-resume.
>
> > > +               dev->power.restrain_depth++;
> > > +       } else {
> > >                 error = -EAGAIN;
> > > +       }
> > >
> > >         spin_unlock_irq(&dev->power.lock);
> > >
> > > @@ -1278,7 +1281,7 @@ int __pm_runtime_set_status(struct devic
> > >                 device_links_read_unlock(idx);
> > >         }
> > >
> > > -       pm_runtime_enable(dev);
> > > +       pm_runtime_relinquish(dev);
> > >
> > >         return error;
> > >  }
> > > @@ -1513,6 +1516,72 @@ void pm_runtime_allow(struct device *dev
> > >  EXPORT_SYMBOL_GPL(pm_runtime_allow);
> > >
> > >  /**
> > > + * pm_runtime_restrain - Temporarily block runtime PM of a device.
> > > + * @dev: Device to handle.
> > > + *
> > > + * Increase the device's usage count and its restrain_dpeth count.  If the
> > > + * latter was 0 initially, cancel the runtime PM work for @dev if pending and
> > > + * wait for all of the runtime PM operations on it in progress to complete.
> > > + *
> > > + * After this function has been called, attempts to runtime-suspend @dev will
> > > + * fail with -EAGAIN and attempts to runtime-resume it will succeed if its
> > > + * runtime PM status is RPM_ACTIVE and will fail with -EAGAIN otherwise.
> > > + *
> > > + * This function can only be called by the PM core.
> > > + */
> > > +void pm_runtime_restrain(struct device *dev)
> > > +{
> > > +       pm_runtime_get_noresume(dev);
> > > +
> > > +       spin_lock_irq(&dev->power.lock);
> > > +
> > > +       if (dev->power.restrain_depth++ > 0)
> > > +               goto out;
> > > +
> > > +       if (dev->power.disable_depth > 0) {
> > > +               dev->power.already_suspended = false;
> > > +               goto out;
> > > +       }
> > > +
> > > +       /* Update time accounting before blocking PM-runtime. */
> > > +       update_pm_runtime_accounting(dev);
> > > +
> > > +       __pm_runtime_barrier(dev);
> > > +
> > > +       dev->power.already_suspended = pm_runtime_status_suspended(dev);
> > > +
> > > +out:
> > > +       spin_unlock_irq(&dev->power.lock);
> > > +}
> >
> > What if someone calls pm_runtime_disable() after the PM core has
> > called pm_runtime_restrain() for a device? It looks like we may run
> > another round of __pm_runtime_barrier() and
> > update_pm_runtime_accounting(), does that really make sense?
>
> No, it doesn't, but it's a bug in the patch.  And there are other bugs in it ...
>
> In this particular case, __pm_runtime_disable() should check the
> "restrain" count and do nothing when it is nonzero.
>
> > > +
> > > +/**
> > > + * pm_runtime_relinquish - Unblock runtime PM of a device.
> > > + * @dev: Device to handle.
> > > + *
> > > + * Decrease the device's usage count and its restrain_dpeth count.
> > > + *
> > > + * This function can only be called by the PM core.
> > > + */
> > > +void pm_runtime_relinquish(struct device *dev)
> > > +{
> > > +       spin_lock_irq(&dev->power.lock);
> > > +
> > > +       if (dev->power.restrain_depth > 0) {
> > > +               dev->power.restrain_depth--;
> > > +
> > > +               /* About to unbolck runtime PM, set accounting_timestamp to now */
> > > +               if (!dev->power.restrain_depth && !dev->power.disable_depth)
> > > +                       dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
> > > +       } else {
> > > +               dev_warn(dev, "Unbalanced %s!\n", __func__);
> > > +       }
> > > +
> > > +       spin_unlock_irq(&dev->power.lock);
> > > +
> > > +       pm_runtime_put_noidle(dev);
> > > +}
> > > +
> > > +/**
> > >   * pm_runtime_no_callbacks - Ignore runtime PM callbacks for a device.
> > >   * @dev: Device to handle.
> > >   *
> > > @@ -1806,8 +1875,10 @@ int pm_runtime_force_suspend(struct devi
> > >         int (*callback)(struct device *);
> > >         int ret;
> > >
> > > -       pm_runtime_disable(dev);
> > > -       if (pm_runtime_status_suspended(dev))
> > > +       pm_runtime_restrain(dev);
> > > +
> > > +       /* No suspend if the device has already been suspended by PM-runtime. */
> > > +       if (!dev->power.already_suspended)
> >
> > I assume you are looking at using pm_runtime_force_suspend|resume() to
> > support my use case for the cpuidle-psci driver? In other words,
> > replace pm_runtime_get_sync() and pm_runtime_put_sync_suspend() in
> > __psci_enter_domain_idle_state(), right?
>
> Not really.  I've been looking at a general "temporarily unavailable"
> vs "disabled" problem.

Okay, so I understand that you want to distinguish between these two
cases, but honestly I fail to understand *why* that is needed, sorry.

>
> > If so, that doesn't really fit well, I think. Not only because we
> > don't have system suspend/resume callbacks available, which is really
> > the proper place to call the pm_runtime_force_*() functions from, but
> > also because we don't want to call __pm_runtime_barrier(), etc, every
> > time in the idle path of a CPU. If anything, we should instead strive
> > towards a more lightweight path than what we currently have.
>
> So IMO this can be done with the new counter in place, because for
> anything called between device_suspend_late() and
> device_resume_early(), PM-runtime would be restrained by the PM core
> (it is disabled now), so rpm_resume() would return 1 for devices with
> PM-runtime status equal to RPM_ACTIVE (it fails now, unless the usage
> counter is exactly 1) and you resume the devices in question upfront,
> so it would be always safe to call rpm_resume() and rpm_suspend() for
> them during the noirq suspend and resume phases (it is now tricky,
> because it depends on the exact usage counter value).
>
> Between dpm_suspend_noirq() and dpm_resume_noirq(), you need to switch
> over to a different type of handling anyway, because all of the
> devices are expected to be suspended then.

Not sure I understand correctly, but I don't think I need to switch to
another handling. The devices in __psci_enter_domain_idle_state() are
managed as syscore devices with genpd, for the later system suspend
phases, this works well.

Perhaps you also saying that the goal with your change is to allow
rpm_resume() to return 1, when the state is RPM_ACTIVE for the device
and when the PM core has called pm_runtime_restrain() instead of
__pm_runtime_disable()? Right?

Kind regards
Uffe
