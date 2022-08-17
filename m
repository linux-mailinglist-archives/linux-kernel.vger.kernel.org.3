Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A96596D4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiHQLFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHQLE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:04:59 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B054765653
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:04:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bx38so13184522ljb.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eNBaDOsM1mF3vNbE5P9XrcAF8Kja7p5dBt6p2PWAbeQ=;
        b=UW8T/uu73IvWeG/1fEnpr+LhOAUFu6JIEajv0sf8dAocRepWUoSo0h3CsXPiNASPTJ
         2yqCQQ3hIuRhGWaUNtD5kJ6i7PtmekdBSUUmGFh7b3UGKNTCdMGf/NRjDTjla2dShv/V
         5Wdvcv+XCLqYdZhR17R+Sda8rp6D4XwM6l04XSPEYgdZRXalY5tbQbJV78EvnW6znUfF
         lHBrXg1/Zs3wB2/wqcGd+aFGEzqS99tWVcDa2AM1HhKtgl2fVLjd/514WTQ3Ygr5nuwx
         sqQdpxFCGeSuaOCFFClEmScYVmuxaK0HCTwjGMpGPLAdxr8svJvQta6pgsHGoXpUq8tM
         VgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eNBaDOsM1mF3vNbE5P9XrcAF8Kja7p5dBt6p2PWAbeQ=;
        b=tj4kuKxCSFHMgi+mZ0VtjrSUE0Zr71COenQQp6AYTm2vVXrdvNniPpBbhCt6XBLaAh
         IyGEE4OAQ38RVxEPOE8RJ2k7uUC2I0CmON8JLnwypyPzE51zsDjsV0JNthdtgsz1iNhf
         MrMWAO9ow+5s6RXiqRLXdb91+BwByOuXeBGU63tGXKaXcCGWVdDYHnH0NDu133qfdn+8
         6+cA41yxcXGL9rOvwFaRTnI4zE7jl/4okbddFO1n62l8lfVAMvetU1wQdcLkBhA3RVvX
         pm93mG2EGXFDPAzT2JMIajyKfd3lb1VoNVirZ73RE7m9SRw+BYqh6xFpHE5X/rcZxWDJ
         584A==
X-Gm-Message-State: ACgBeo01SpW0wuAjL8ZEWtFh1TtsXEERAO0Z8wzoHVLDFz2BoDbaFBQI
        adSV6+9mz3eaASK/4SaNAXKpUhZfKFjLpGUEkIr8ng==
X-Google-Smtp-Source: AA6agR6T4CWqSrU5VkAt137uXEVbowo+dvlJxB7J0Jzg6w1n2O8KjJytP7sRGcpTOW7kdRZ7a1c6og2uHun+0DKX81E=
X-Received: by 2002:a2e:904c:0:b0:261:8b4d:7c11 with SMTP id
 n12-20020a2e904c000000b002618b4d7c11mr4409722ljg.4.1660734295770; Wed, 17 Aug
 2022 04:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220720110246.762939-1-abel.vesa@linaro.org> <CAPDyKFoh8UV=QC6RhOkc=FSvoeqF_UiWp97h0Qp8dniB=sS+8A@mail.gmail.com>
 <YuA0luCtQ1J+ExBi@linaro.org> <CAPDyKFo4tryzYQK=q6aPGxocmoq=duC2B1RMh1QoV_maVCApjA@mail.gmail.com>
 <20220729094646.xqlhfjzxo3gk4n27@linaro.org> <CAPDyKFoEzvD1PRGEc4NQmAGnewZtxyW226vWRWndAijSn=fbNw@mail.gmail.com>
 <YvZ13R9st43MHBKJ@linaro.org> <CAPDyKFoaTu4nGa-hdjd98ngE7RQ0yhFi8PpUt-HBkW7Srf-=Tg@mail.gmail.com>
 <YvuMPJPsqPIO0tYy@linaro.org>
In-Reply-To: <YvuMPJPsqPIO0tYy@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 17 Aug 2022 13:04:19 +0200
Message-ID: <CAPDyKFp0RdUPr-WrG4_dEcSeBoK2D4TsCQkYETLhOa53JU+Wkw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 at 14:23, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> On 22-08-16 12:48:20, Ulf Hansson wrote:
> > [...]
> >
> > > > >
> > > > > When the last active consumer suspends (in our case here, device A), ->power_off
> > > > > will be called first disabling the PD, then the ->set_performance will
> > > > > 'release' that lowest perf level the device A requested but will not
> > > > > call to FW since the PD is already disabled. This would make
> > > > > sure there are not two calls with two different levels to the FW.
> > > >
> > > > I understand what you want to achieve, but I think the ->power_off()
> > > > scenario may be a bit more tricky.
> > > >
> > > > For example, it would be perfectly fine for genpd to keep the PM
> > > > domain powered-on, even when the device A gets runtime suspended (a
> > > > genpd governor may prevent it). In other words, we may end up not
> > > > getting the ->power_off() callback invoked at all, even if there are
> > > > no runtime resumed devices in the PM domain.
> > > >
> > > > Could this lead to problems on the provider side, when trying to take
> > > > into account the different combinations of sequences?
> > >
> > > Correct me if I'm wrong, but even if a genpd governor would prevent
> > > the power_off to be called, if we do the reversal, since the power
> > > domain is not off, the provider would lower the performance state and
> > > that's it. The responsability falls on the provider, but so does with
> > > the current order of the calls.
> > >
> > > So I don't see how this could lead to problems compared to the current
> > > order of the calls.
> >
> > Alright, I agree, it shouldn't really matter then.
> >
> > >
> > > Maybe I missunderstood your point, so please correct me if I'm getting
> > > this wrong.
> > >
> > > >
> > > > >
> > > > > Now, most of this depends on the provider's way of doing things.
> > > > > But in order to allow the provider to do what is described above, it
> > > > > needs to know about the perf level before it is asked to power on a PD.
> > > > > Same applies to powering off.
> > > > >
> > > > > > >
> > > > > > > I think it makes more sense for the ->set_performance in this case to act as a
> > > > > > > way to tell the provider that a specific device has yeilded its voltage level
> > > > > > > request. That way the provider can drop the voltage to the minimum requested by
> > > > > > > the active consumers of that PD.
> > > > > >
> > > > > > The genpd provider can know if the PM domain is powered on or off,
> > > > > > when the ->set_performance_state() callback is invoked. If it's
> > > > > > powered off, it may then decide to "cache" the request for the
> > > > > > performance level request, until it gets powered on.
> > > > >
> > > > > But the ->set_performance is called only after ->power_on, so the PD
> > > > > will always be on when ->set_performance checks. And this is what my
> > > > > patch is trying to change actually.
> > > > >
> > > > > >
> > > > > > Although, I don't see how a genpd provider should be able to cache a
> > > > > > performance state request, when the PM domain is already powered on
> > > > > > (which is what you propose, if I understand correctly), that simply
> > > > > > doesn't work for the other scenarios.
> > > > >
> > > > > I explained this above. The provider will need to check if the PD is on
> > > > > and only write to FW if it is. Otherwise it will cache the value for
> > > > > when the power_on is called.
> > > >
> > > > As indicated above, it looks to me that you may need to check a
> > > > combination of things at the provider side. Is relying on whether
> > > > genpd is on/off to decide when to apply or cache a performance state,
> > > > really sufficient? I could certainly be wrong though.
> > >
> > > I don't think there is any change from this point of view, when compared
> > > to the current order. Even with the current order, the provider would
> > > either cache the performance state if the power domain is off, or would
> > > apply it if the power domain is on.
> >
> > For the Qcom case, I don't think it's that simple on the genpd provider side.
> >
> > With the changes you propose in the $subject patch, I think there are
> > two specific scenarios when the genpd can be powered off and when the
> > ->set_performance_state() callback can get called. These scenarios can
> > just rely on whether the genpd is powered off or not, to make the best
> > decision. See more below.
> >
> > *) In genpd_runtime_resume() we make sure to *raise* the performance
> > state prior to power on the PM domain, if the PM domain is powered
> > off, of course. In this way the ->set_performance_state() callback may
> > be invoked when the genpd is powered off, to *raise* the performance
> > state.
>
> I'm not sure I understand the issue with this one. Please note that the
> genpd will not decide whether to call the ->set_performance_state() or
> not. The change I propose here is to _always_ call ->set_performance_state()
> before calling ->power_on(). There is no condition there.

The idea was to describe two scenarios under when
->set_performance_state() is invoked when the genpd is *powered off*.
In these two scenarios, it looks to me that we may want to make two
different decisions.

In the first scenario above, we want to cache/postpone the call to the
FW to set a new performance state, until the next time the PM domain
gets powered on.

In the second scenario below, we directly want to make the call the
FW, to avoid running at a higher performance level than really needed.

>
> Since the provider will always get the call to ->set_performance_state(),
> and based on the state of the genpd (powered on or not), it will either
> call to FW or will cache the value for when the next ->power_on() call is
> done.

Yes, that makes sense for me too.

>
> >
> > **) In genpd_runtime_suspend() we may power off the PM domain, before
> > invoking the ->set_performance_state() callback to *lower* the
> > performance state.
>
> Yeah, this is so that it would not undervolt the consumer.
> In some cases, an undevolt, on some platforms, could actually result in a
> consumer's HW FSM hang.
>
> And it really doesn't make sense to drop the voltage right before powering
> off the genpd. Instead, it makes sense to let the provider know that a
> specific perf state is not voted for by a consumer anymore, only after the genpd
> is powered off.

I agree, it seems like a reasonable change to make to genpd.

>
> Now, that being said, there is the case where a consumer drops its vote
> for a specific perf state, but since there is another consumer using
> that genpd, it doesn't power down. So that could result in undervolt
> too, but if there is a know such issue on a platform, the responsability
> to handle that would fall on the provider, and there are ways to do
> that.

I believe I understand this use case too, but please correct me if I am wrong.

The "last" consumer device that keeps the PM domain powered on, may
need some basic performance level to be functional (but without having
to put a vote on a performance state from genpd point of view).

That's the main reason why we need to make use of the ->power_on|off()
callbacks in combination with the >set_performance_state() callback
for the Qcom platforms. Otherwise, we could have settled with just
using the ->set_performance_state() callback, like in the Tegra case.

>
> I hope I'm not complicating the problem we're trying to solve here even
> more by adding more scenarios.

No worries, it's fine.

>
> >
> > In other words, just checking whether the genpd is powered off, to
> > decide to cache/postpone the call to the FW to set a new performance
> > state, would mean that we may end up running in a higher performance
> > state than actually needed, right?
>
> Assuming I understood your comment right, in the first scenario you mentioned,
> the actual point when a specific performance state is actually started is on
> ->power_on(), not on ->set_performance(). As you said, the genpd is off,
> so between ->set_performance() and the ->power_on() calls, the
> performance state is still 0 (genpd disabled).
>
> >
> > Perhaps if we would check if the performance state is lowered (or set
> > to zero) too, that should improve the situation, right?
> >
>
> Unless I wrong in the statements I made above, I don't see a need for such a
> check.
>
> Or maybe I missed your point.

Yes, unfortunately I think you did.

On the other hand, it doesn't really matter much. You have convinced
me that the $subject patch makes sense. May I suggest you make a new
submission, skipping the RFC - and try to clarify a bit on the problem
for Qcom specifically in the commit message. Then I will happily give
it my blessing.

[...]

Kind regards
Uffe
