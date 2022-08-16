Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B92595BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiHPMXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiHPMXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:23:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC993ECDD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:23:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so3635503wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=vbopr3rJvN0NVVeeKaAGJIhJ9kW8zjdQsJTIzrNLIbM=;
        b=FFKboseAQFPmJoFy4woEkPABSIuHoYnoQhCfRnNUhmvBLHeXtRgVPKSNSYs9R2comL
         2qupdzjl3gpgv3tdjZCJ3eAlO1HO3F51MghhgStIepnjV/ar2OYRd9ESMLY2gt98oFyO
         E/3TIgr84X9V3jus9ekyftpVCmwg1rg8nupCgkg3KX4IYxjMv9zW5HsIB4b49MIdERnM
         Cv8Z3Wqzr21NvoEMqb/nqR9yQo8lHVHiYeVF/xSZewvr5Q4RO74O6ui98+LYh4vwz9px
         gSEhXWy7Crg/Fcxp2Xf310eijK1YvRKl2kXizx37rmKgJKr/m+vhUpBInwuEtd99rRmX
         ZhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vbopr3rJvN0NVVeeKaAGJIhJ9kW8zjdQsJTIzrNLIbM=;
        b=n8Kc3WXOpUYJuG9e1R+OEimadtCtXx2hXVsPyNqjM6rZoJFMAb8bQ8ppzpPoJ554Gi
         Vlj/mcDG8XUUZ8scR+CHQT6AOftM8cysuludjgx7kOLjy/z3abrZKL0j677j3aTi2vWb
         iWAO0wkIkOzMDhmOM325cUh/UXpEisQAYSzUC8Qy3/Q+EIFkVOPKMMqEnFOQw8eloNll
         ackKsfwiYVBGvEDsDVL6Q2j7TvynrOYADGtWsgLgJe4e2wt+EzGPFvP0M70iYSY+GRQW
         GvdkzCFfj2rT/jzkMljfDHegXH18VayLAokn5/4/+GIu4JeiEZCLcL4ydQeGvHUKaIEq
         43Kw==
X-Gm-Message-State: ACgBeo19qbNg2eYXCkAsb/wcT9ZzzLWR3V7PkJeZb8MdgD2Dx7auTnH2
        vezRCq9/8Tk//KcUWFGk88cctw==
X-Google-Smtp-Source: AA6agR5krhoEulLrmrgU/jXU6lVD1HTXUAa2hZrxN8NG2DRJrOYihPU6fpUHCjVnPd2ao00B4TKtQQ==
X-Received: by 2002:a05:600c:384c:b0:3a3:744d:8dd2 with SMTP id s12-20020a05600c384c00b003a3744d8dd2mr19513540wmr.117.1660652607627;
        Tue, 16 Aug 2022 05:23:27 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b003a4eea0aa48sm1501482wmq.0.2022.08.16.05.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 05:23:26 -0700 (PDT)
Date:   Tue, 16 Aug 2022 15:23:24 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC] PM: domains: Reverse the order of performance and enabling
 ops
Message-ID: <YvuMPJPsqPIO0tYy@linaro.org>
References: <20220720110246.762939-1-abel.vesa@linaro.org>
 <CAPDyKFoh8UV=QC6RhOkc=FSvoeqF_UiWp97h0Qp8dniB=sS+8A@mail.gmail.com>
 <YuA0luCtQ1J+ExBi@linaro.org>
 <CAPDyKFo4tryzYQK=q6aPGxocmoq=duC2B1RMh1QoV_maVCApjA@mail.gmail.com>
 <20220729094646.xqlhfjzxo3gk4n27@linaro.org>
 <CAPDyKFoEzvD1PRGEc4NQmAGnewZtxyW226vWRWndAijSn=fbNw@mail.gmail.com>
 <YvZ13R9st43MHBKJ@linaro.org>
 <CAPDyKFoaTu4nGa-hdjd98ngE7RQ0yhFi8PpUt-HBkW7Srf-=Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoaTu4nGa-hdjd98ngE7RQ0yhFi8PpUt-HBkW7Srf-=Tg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-16 12:48:20, Ulf Hansson wrote:
> [...]
> 
> > > >
> > > > When the last active consumer suspends (in our case here, device A), ->power_off
> > > > will be called first disabling the PD, then the ->set_performance will
> > > > 'release' that lowest perf level the device A requested but will not
> > > > call to FW since the PD is already disabled. This would make
> > > > sure there are not two calls with two different levels to the FW.
> > >
> > > I understand what you want to achieve, but I think the ->power_off()
> > > scenario may be a bit more tricky.
> > >
> > > For example, it would be perfectly fine for genpd to keep the PM
> > > domain powered-on, even when the device A gets runtime suspended (a
> > > genpd governor may prevent it). In other words, we may end up not
> > > getting the ->power_off() callback invoked at all, even if there are
> > > no runtime resumed devices in the PM domain.
> > >
> > > Could this lead to problems on the provider side, when trying to take
> > > into account the different combinations of sequences?
> >
> > Correct me if I'm wrong, but even if a genpd governor would prevent
> > the power_off to be called, if we do the reversal, since the power
> > domain is not off, the provider would lower the performance state and
> > that's it. The responsability falls on the provider, but so does with
> > the current order of the calls.
> >
> > So I don't see how this could lead to problems compared to the current
> > order of the calls.
> 
> Alright, I agree, it shouldn't really matter then.
> 
> >
> > Maybe I missunderstood your point, so please correct me if I'm getting
> > this wrong.
> >
> > >
> > > >
> > > > Now, most of this depends on the provider's way of doing things.
> > > > But in order to allow the provider to do what is described above, it
> > > > needs to know about the perf level before it is asked to power on a PD.
> > > > Same applies to powering off.
> > > >
> > > > > >
> > > > > > I think it makes more sense for the ->set_performance in this case to act as a
> > > > > > way to tell the provider that a specific device has yeilded its voltage level
> > > > > > request. That way the provider can drop the voltage to the minimum requested by
> > > > > > the active consumers of that PD.
> > > > >
> > > > > The genpd provider can know if the PM domain is powered on or off,
> > > > > when the ->set_performance_state() callback is invoked. If it's
> > > > > powered off, it may then decide to "cache" the request for the
> > > > > performance level request, until it gets powered on.
> > > >
> > > > But the ->set_performance is called only after ->power_on, so the PD
> > > > will always be on when ->set_performance checks. And this is what my
> > > > patch is trying to change actually.
> > > >
> > > > >
> > > > > Although, I don't see how a genpd provider should be able to cache a
> > > > > performance state request, when the PM domain is already powered on
> > > > > (which is what you propose, if I understand correctly), that simply
> > > > > doesn't work for the other scenarios.
> > > >
> > > > I explained this above. The provider will need to check if the PD is on
> > > > and only write to FW if it is. Otherwise it will cache the value for
> > > > when the power_on is called.
> > >
> > > As indicated above, it looks to me that you may need to check a
> > > combination of things at the provider side. Is relying on whether
> > > genpd is on/off to decide when to apply or cache a performance state,
> > > really sufficient? I could certainly be wrong though.
> >
> > I don't think there is any change from this point of view, when compared
> > to the current order. Even with the current order, the provider would
> > either cache the performance state if the power domain is off, or would
> > apply it if the power domain is on.
> 
> For the Qcom case, I don't think it's that simple on the genpd provider side.
> 
> With the changes you propose in the $subject patch, I think there are
> two specific scenarios when the genpd can be powered off and when the
> ->set_performance_state() callback can get called. These scenarios can
> just rely on whether the genpd is powered off or not, to make the best
> decision. See more below.
> 
> *) In genpd_runtime_resume() we make sure to *raise* the performance
> state prior to power on the PM domain, if the PM domain is powered
> off, of course. In this way the ->set_performance_state() callback may
> be invoked when the genpd is powered off, to *raise* the performance
> state.

I'm not sure I understand the issue with this one. Please note that the
genpd will not decide whether to call the ->set_performance_state() or
not. The change I propose here is to _always_ call ->set_performance_state()
before calling ->power_on(). There is no condition there.

Since the provider will always get the call to ->set_performance_state(),
and based on the state of the genpd (powered on or not), it will either
call to FW or will cache the value for when the next ->power_on() call is
done.

> 
> **) In genpd_runtime_suspend() we may power off the PM domain, before
> invoking the ->set_performance_state() callback to *lower* the
> performance state.

Yeah, this is so that it would not undervolt the consumer.
In some cases, an undevolt, on some platforms, could actually result in a
consumer's HW FSM hang.

And it really doesn't make sense to drop the voltage right before powering
off the genpd. Instead, it makes sense to let the provider know that a
specific perf state is not voted for by a consumer anymore, only after the genpd
is powered off.

Now, that being said, there is the case where a consumer drops its vote
for a specific perf state, but since there is another consumer using
that genpd, it doesn't power down. So that could result in undervolt
too, but if there is a know such issue on a platform, the responsability
to handle that would fall on the provider, and there are ways to do
that.

I hope I'm not complicating the problem we're trying to solve here even
more by adding more scenarios.

> 
> In other words, just checking whether the genpd is powered off, to
> decide to cache/postpone the call to the FW to set a new performance
> state, would mean that we may end up running in a higher performance
> state than actually needed, right?

Assuming I understood your comment right, in the first scenario you mentioned,
the actual point when a specific performance state is actually started is on
->power_on(), not on ->set_performance(). As you said, the genpd is off,
so between ->set_performance() and the ->power_on() calls, the
performance state is still 0 (genpd disabled).

> 
> Perhaps if we would check if the performance state is lowered (or set
> to zero) too, that should improve the situation, right?
> 

Unless I wrong in the statements I made above, I don't see a need for such a
check.

Or maybe I missed your point.

> >
> > >
> > > Perhaps if you can provide a corresponding patch for the genpd
> > > provider side too, that can help to convince me.
> >
> > The qcom-rpmhpd actually does that even now. On set_performance, it caches
> > the performance state (corner) if the power domain is disabled, and it
> > applies (aggregates the corner) if the power domain is enabled.
> 
> Okay, good!
> 
> As stated above, this sounds like it can be improved then, right?
> 

I would certainly say so.

> Kind regards
> Uffe
