Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC26465175
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350839AbhLAP0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350855AbhLAP0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:26:25 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8222AC061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:23:04 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id n12so63891196lfe.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/UE9GmYow1k1PWf3LBN8TNIf82lFPT5QQxXcHxr6sY=;
        b=ueCE0K3Oz0C/stDYYeR8j4byYg1FkjSsltBv05sGeHwPlW8hG1TA/zP5t6duumyZKP
         QE3YmJ19ZKn7QF3qsPGtvE79QXiL8diKGI89PXHCdj7nUpPHNr3KnHCZPCvEwr2/Ads0
         0w+/lk7HDptb74TDWsmCrD/PMhRDxUuW4ux15jWwJBlD1re1PJs69jf8N9GTE/PFVN9d
         Mh4OY1CFRMJuy3zZdVV0sZO7L0HSpQLApbpQYts6qw8YW3aZmLwdv8HFdsZrO9n6xLuW
         CPOpyCuLKKW2n2OodLJaIpuaQQTcSAgE0kLHACP1gCK4+HX90OyDNDNylHs6k51BFfE8
         L2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/UE9GmYow1k1PWf3LBN8TNIf82lFPT5QQxXcHxr6sY=;
        b=uuZouvqxA0oNgXgWB6x69nQLr3o8fcUNM+XMLi0Mw/cUo9mMH2XaAkehm36y9OKKt3
         QGsO5ggaGBHa9Ic07FIdu2ZjlBtSbQhsZl0N6I9Sx4AXs33kD0D4upnxmnfIfdeDbN9X
         paNzd4fp+uc3Ak4F44gSnDF5t3rFYilqj9k0u2k1W6v2ZvasLcTy4YXqXUiaMW6AnDrW
         VEZImQ77xBFdTFuKB/hRNIy6XR3YGZwV37wMLp9teFBWSehuBD5vhu6awIj5Sn39MF8p
         BCvgaf56toGXjXUIA1ABeGWml8TVrhOyJcXpmt+bJTSKhQGtD+e/z067tDUHkxsk+dn1
         5UTg==
X-Gm-Message-State: AOAM533i6Q7bXcYwpSxnd9B423ta5T1u1nwXHvop3yTxlgJ/QwzYhUgB
        Rz7WCH2pEc5KufVkUd7STzY8td9Do6tA5lnQvMTfsA==
X-Google-Smtp-Source: ABdhPJzMT+0MoupztBbQCqirwFNEbtmJDhlZUAXMZjKiFV15UfYUsYspFuhcUJaiDr1PX/c1Gyn2QW9SB9Q7HuNCW0s=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr6564852lfq.254.1638372182687;
 Wed, 01 Dec 2021 07:23:02 -0800 (PST)
MIME-Version: 1.0
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <CAJZ5v0hrTDsCUn4vgmFrTTgd6H=orh-Kb5b3+_H9St4n8fTxBw@mail.gmail.com>
 <CAPDyKFre=tp4919FLoeU-wjLDJ02zmHaXY4wgTUmfmFbeaCadQ@mail.gmail.com>
 <4380690.LvFx2qVVIh@kreacher> <CAPDyKFpyPov-faJ9dUszi38Q7-4OsowX=i8w=NCnTQ66_zooHg@mail.gmail.com>
 <CAJZ5v0iEfE35Aig8XADKbQEJqb8PNmcghLnrVXHkemDjTOLr5g@mail.gmail.com>
 <CAPDyKFqVrYKyUjxoErPBuahcgDNX7esspWG4Vqi0q-8_u7MoFQ@mail.gmail.com>
 <CAJZ5v0jV5QS6yxBgK0OHJ_7ivDPs7tL7Ms19dNBTUAYSfKDkCg@mail.gmail.com>
 <CAPDyKFp+eWx3BHuPw1-GRp0uUAusNBLkhKpRkY3G+8zjXn5FZw@mail.gmail.com> <CAJZ5v0j+NOmatva7zf6Pet9ecv3qLyrMBV2-DG86r8eaW=aSJg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+NOmatva7zf6Pet9ecv3qLyrMBV2-DG86r8eaW=aSJg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Dec 2021 16:22:26 +0100
Message-ID: <CAPDyKFrFdt_U7By_bqk4DBHxCBLpDe00aRb6P6BmwR4MYM2OmQ@mail.gmail.com>
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

On Wed, 1 Dec 2021 at 14:49, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 1, 2021 at 10:02 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 30 Nov 2021 at 18:26, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Nov 30, 2021 at 5:41 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Tue, 30 Nov 2021 at 14:02, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > >
> > > > > On Tue, Nov 30, 2021 at 12:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Am I thinking correctly that this is mostly about working around the
> > > > > > > > > > > > limitations of pm_runtime_force_suspend()?
> > > > > > > > > > >
> > > > > > > > > > > No, this isn't related at all.
> > > > > > > > > > >
> > > > > > > > > > > The cpuidle-psci driver doesn't have PM callbacks, thus using
> > > > > > > > > > > pm_runtime_force_suspend() would not work here.
> > > > > > > > > >
> > > > > > > > > > Just wanted to send a ping on this to see if we can come to a
> > > > > > > > > > conclusion. Or maybe we did? :-)
> > > > > > > > > >
> > > > > > > > > > I think in the end, what slightly bothers me, is that the behavior is
> > > > > > > > > > a bit inconsistent. Although, maybe it's the best we can do.
> > > > > > > > >
> > > > > > > > > I've been thinking about this and it looks like we can do better, but
> > > > > > > > > instead of talking about this I'd rather send a patch.
> > > > > > > >
> > > > > > > > Alright.
> > > > > > > >
> > > > > > > > I was thinking along the lines of make similar changes for
> > > > > > > > rpm_idle|suspend(). That would make the behaviour even more
> > > > > > > > consistent, I think.
> > > > > > > >
> > > > > > > > Perhaps that's what you have in mind? :-)
> > > > > > >
> > > > > > > Well, not exactly.
> > > > > > >
> > > > > > > The idea is to add another counter (called restrain_depth in the patch)
> > > > > > > to prevent rpm_resume() from running the callback when that is potentially
> > > > > > > problematic.  With that, it is possible to actually distinguish devices
> > > > > > > with PM-runtime enabled and it allows the PM-runtime status to be checked
> > > > > > > when it is still known to be meaningful.
> > > > > >
> > > > > > Hmm, I don't quite understand the benefit of introducing a new flag
> > > > > > for this. rpm_resume() already checks the disable_depth to understand
> > > > > > when it's safe to invoke the callback. Maybe there is a reason why
> > > > > > that isn't sufficient?
> > > > >
> > > > > The problem is that disable_depth > 0 may very well mean that runtime
> > > > > PM has not been enabled at all for the given device which IMO is a
> > > > > problem.
> > > > >
> > > > > As it stands, it is necessary to make assumptions, like disable_depth
> > > > > == 1 meaning that runtime PM is really enabled, but the PM core has
> > > > > disabled it temporarily, which is somewhat questionable.
> > > > >
> > > > > Another problem with disabling is that it causes rpm_resume() to fail
> > > > > even if the status is RPM_ACTIVE and it has to do that exactly because
> > > > > it cannot know why runtime PM has been disabled.  If it has never been
> > > > > enabled, rpm_resume() must fail, but if it has been disabled
> > > > > temporarily, rpm_resume() may return 1 when the status is RPM_ACTIVE.
> > > > >
> > > > > The new count allows the "enabled in general, but temporarily disabled
> > > > > at the moment" to be handled cleanly.
> > > >
> > > > My overall comment is that I fail to understand why we need to
> > > > distinguish between these two cases. To me, it shouldn't really
> > > > matter, *why* runtime PM is (or have been) disabled for the device.
> > >
> > > It matters if you want to trust the status, because "disabled" means
> > > "the status doesn't matter".
> >
> > Well, that doesn't really match how the runtime PM interface is being
> > used today.
>
> Well, I clearly disagree.

Alright, then we can agree to disagree. :-)

>
> > For example, we have a whole bunch of helper functions, allowing us to
> > update and check the runtime PM state of the device, even when the
> > disable_depth > 0. Some functions, like pm_runtime_set_active() for
> > example, even take parents and device-links into account.
>
> That's true, but that's for a purpose.
>
> If runtime PM becomes enabled after using pm_runtime_set_active(), the
> status should better be consistent with the settings of the parent
> etc.
>
> > >
> > > If you want the status to stay meaningful, but prevent callbacks from
> > > running, you need something else.
> > >
> > > > The important point is that the default state for a device is
> > > > RPM_SUSPENDED and someone has moved into RPM_ACTIVE, for whatever
> > > > reason. That should be sufficient to allow rpm_resume() to return '1'
> > > > when disable_depth > 0, shouldn't it?
> > >
> > > No, because there is no rule by which the status of devices with
> > > PM-runtime disabled must be RPM_SUSPENDED.
> >
> > That's not what I was trying to say.
> >
> > The initial/default runtime PM state for a device is RPM_SUSPENDED,
> > which is being set in pm_runtime_init(). Although, I agree that it
> > can't be trusted that this state actually reflects the state of the
> > HW, it's still a valid state for the device from a runtime PM point of
> > view.
>
> No, it is not.  It's just the default.
>
> > However, and more importantly, if the state has moved to RPM_ACTIVE,
> > someone must have deliberately moved the device into that state.
>
> Sure, but it cannot be regarded as an indication on whether or not
> runtime PM is supported and has ever been enabled for the given
> device.
>
> Again, there is no rule regarding the status value for devices with
> runtime PM disabled, either way.

If I understand correctly, that means you think the
pm_runtime_status_suspended() should really be converted to an
internal runtime PM interface, not being exported to users outside.
Right?

When it comes to the pm_runtime_active() interface, I noticed that
it's actually completely broken, as it returns "true" when runtime PM
has been disabled for the device - no matter whether the state is
RPM_ACTIVE or not. It's quite heavily used, so I guess the behaviour
is what the callers expect?

>
> > For this reason, I believe it seems reasonable to trust it, both from HW
> > point of view, but definitely also from a runtime PM point of view. If
> > not, then what should we do?
>
> Trust it only when runtime PM is enabled, ie. dev->power.disable_depth == 0.
>
> That's exactly the reason why pm_runtime_suspended() returns false if
> runtime PM is disabled for the target device and if
> pm_runtime_suspended() is called during system-wide suspend and
> resume, it is not clear how to interpret its return value.

To me, I don't think there is a problem interpreting
pm_runtime_suspended()'s return value. As you said, it tells whether
runtime PM has been enabled and whether the state is RPM_SUSPENDED.

For those that want to know the state when runtime PM has been
disabled, they can use pm_runtime_status_suspended().

What's the issue?

>
> If it returns true outside the system suspend-resume code path, that
> means "runtime PM has been enabled and the device has been
> runtime-suspended" and I want it to mean exactly the same thing during
> system-wide suspend and resume, so people don't need to wonder about
> the context in which the code is running.

Well, even if this seems nice, I wonder how useful this would be in the end.

Perhaps you have some concrete examples where this could improve things?

Kind regards
Uffe
