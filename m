Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6AA595A27
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiHPLbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbiHPLak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:30:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8272FB6D2A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:48:58 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u6so10118938ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 03:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yoruPDP1aiC8RJyOCtcGULTlufmmra/L6wgFn2dsg08=;
        b=fhL+EfuDsWrS2ZG1mSw1173qJBqJqRRo9W1DGIoot06s4TT0WXttNkuz8Vqb4ja4W9
         uhEBfYIZhciRIx8GdTMYYhaF+6sFWE38sEymJWA9fkq6USVStMdCAOyjNhEE87/3hhG2
         JC0ZxMVVcTSw2bO4CJPzFsgq61m7cg+7FlV+kGiSIy60e6YdtDwM1+Vay3BT1Qn/oGxU
         71UezoByD0zfQTZbvAQhe9VQmlGHE1UiwQV5UNXEmKJRQ/wxhs5QwS/ucd6bVjStQeoA
         hWrj2Gv4ONh9RXAi7SKnii9gZsMEOVFKLksjQlGroO0MAeDHGy2OU9Qs5v0FUddjinAv
         51YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yoruPDP1aiC8RJyOCtcGULTlufmmra/L6wgFn2dsg08=;
        b=nI3zF9P0ywP09LA56sLwEQAk8d7uDeARHvp6Rl8215iWSIdgJ6asBYD3tG9S9lD5FV
         3SvqXC6beUp+ylO/5zP4Fpfqaz5xXAgh/9e2u2lySN3NJEE/DiP0WAqK67casNPA82ZR
         rr28N2jS5H6vADdS6sHEWi1I4VToLR/5WtTmZtWywSwBPRnEmehZobdew1n/b7d2PbiI
         nOV2xaySrhNGzFkya2CNlhbndWWHKc39XHU/5MjR3Qjw/dE4yPVmkfElunDX0fhFz2+C
         IL2xGPZXjEMHp97RAe8X6hlGJkRjL0ytniBCaiMmAwUkNIi1Ahs603WQkfVF5Z8kBb3+
         CybA==
X-Gm-Message-State: ACgBeo0lzl/dFnSGSWX8a7oowkG8Hb2bXV5wCuEdHfYyoyWZmgpCXk9g
        70597KakOf7Rpt0b2Z8PoN5oh4Xp4ayGsO7JBFHSXg==
X-Google-Smtp-Source: AA6agR7IKXoNDqsYjdqUQzU9TxaA3kcaID6PPPNJxCEIsf3C2nU3K89i4coNmYBs2BKyJ3DKNO/zNCBzcmPJ0n/qb7g=
X-Received: by 2002:a2e:8885:0:b0:25e:bf9b:2de2 with SMTP id
 k5-20020a2e8885000000b0025ebf9b2de2mr6653312lji.367.1660646936615; Tue, 16
 Aug 2022 03:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220720110246.762939-1-abel.vesa@linaro.org> <CAPDyKFoh8UV=QC6RhOkc=FSvoeqF_UiWp97h0Qp8dniB=sS+8A@mail.gmail.com>
 <YuA0luCtQ1J+ExBi@linaro.org> <CAPDyKFo4tryzYQK=q6aPGxocmoq=duC2B1RMh1QoV_maVCApjA@mail.gmail.com>
 <20220729094646.xqlhfjzxo3gk4n27@linaro.org> <CAPDyKFoEzvD1PRGEc4NQmAGnewZtxyW226vWRWndAijSn=fbNw@mail.gmail.com>
 <YvZ13R9st43MHBKJ@linaro.org>
In-Reply-To: <YvZ13R9st43MHBKJ@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Aug 2022 12:48:20 +0200
Message-ID: <CAPDyKFoaTu4nGa-hdjd98ngE7RQ0yhFi8PpUt-HBkW7Srf-=Tg@mail.gmail.com>
Subject: Re: [RFC] PM: domains: Reverse the order of performance and enabling ops
To:     Abel Vesa <abel.vesa@linaro.org>
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

[...]

> > >
> > > When the last active consumer suspends (in our case here, device A), ->power_off
> > > will be called first disabling the PD, then the ->set_performance will
> > > 'release' that lowest perf level the device A requested but will not
> > > call to FW since the PD is already disabled. This would make
> > > sure there are not two calls with two different levels to the FW.
> >
> > I understand what you want to achieve, but I think the ->power_off()
> > scenario may be a bit more tricky.
> >
> > For example, it would be perfectly fine for genpd to keep the PM
> > domain powered-on, even when the device A gets runtime suspended (a
> > genpd governor may prevent it). In other words, we may end up not
> > getting the ->power_off() callback invoked at all, even if there are
> > no runtime resumed devices in the PM domain.
> >
> > Could this lead to problems on the provider side, when trying to take
> > into account the different combinations of sequences?
>
> Correct me if I'm wrong, but even if a genpd governor would prevent
> the power_off to be called, if we do the reversal, since the power
> domain is not off, the provider would lower the performance state and
> that's it. The responsability falls on the provider, but so does with
> the current order of the calls.
>
> So I don't see how this could lead to problems compared to the current
> order of the calls.

Alright, I agree, it shouldn't really matter then.

>
> Maybe I missunderstood your point, so please correct me if I'm getting
> this wrong.
>
> >
> > >
> > > Now, most of this depends on the provider's way of doing things.
> > > But in order to allow the provider to do what is described above, it
> > > needs to know about the perf level before it is asked to power on a PD.
> > > Same applies to powering off.
> > >
> > > > >
> > > > > I think it makes more sense for the ->set_performance in this case to act as a
> > > > > way to tell the provider that a specific device has yeilded its voltage level
> > > > > request. That way the provider can drop the voltage to the minimum requested by
> > > > > the active consumers of that PD.
> > > >
> > > > The genpd provider can know if the PM domain is powered on or off,
> > > > when the ->set_performance_state() callback is invoked. If it's
> > > > powered off, it may then decide to "cache" the request for the
> > > > performance level request, until it gets powered on.
> > >
> > > But the ->set_performance is called only after ->power_on, so the PD
> > > will always be on when ->set_performance checks. And this is what my
> > > patch is trying to change actually.
> > >
> > > >
> > > > Although, I don't see how a genpd provider should be able to cache a
> > > > performance state request, when the PM domain is already powered on
> > > > (which is what you propose, if I understand correctly), that simply
> > > > doesn't work for the other scenarios.
> > >
> > > I explained this above. The provider will need to check if the PD is on
> > > and only write to FW if it is. Otherwise it will cache the value for
> > > when the power_on is called.
> >
> > As indicated above, it looks to me that you may need to check a
> > combination of things at the provider side. Is relying on whether
> > genpd is on/off to decide when to apply or cache a performance state,
> > really sufficient? I could certainly be wrong though.
>
> I don't think there is any change from this point of view, when compared
> to the current order. Even with the current order, the provider would
> either cache the performance state if the power domain is off, or would
> apply it if the power domain is on.

For the Qcom case, I don't think it's that simple on the genpd provider side.

With the changes you propose in the $subject patch, I think there are
two specific scenarios when the genpd can be powered off and when the
->set_performance_state() callback can get called. These scenarios can
just rely on whether the genpd is powered off or not, to make the best
decision. See more below.

*) In genpd_runtime_resume() we make sure to *raise* the performance
state prior to power on the PM domain, if the PM domain is powered
off, of course. In this way the ->set_performance_state() callback may
be invoked when the genpd is powered off, to *raise* the performance
state.

**) In genpd_runtime_suspend() we may power off the PM domain, before
invoking the ->set_performance_state() callback to *lower* the
performance state.

In other words, just checking whether the genpd is powered off, to
decide to cache/postpone the call to the FW to set a new performance
state, would mean that we may end up running in a higher performance
state than actually needed, right?

Perhaps if we would check if the performance state is lowered (or set
to zero) too, that should improve the situation, right?

>
> >
> > Perhaps if you can provide a corresponding patch for the genpd
> > provider side too, that can help to convince me.
>
> The qcom-rpmhpd actually does that even now. On set_performance, it caches
> the performance state (corner) if the power domain is disabled, and it
> applies (aggregates the corner) if the power domain is enabled.

Okay, good!

As stated above, this sounds like it can be improved then, right?

Kind regards
Uffe
