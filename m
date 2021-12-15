Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D347651E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhLOWC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhLOWC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:02:26 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468E5C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:02:26 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id l22so45768038lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D37sSrKXvPjTBTZeLgaiDtC505FZLtGgW+LNt7fG/kc=;
        b=j6Im5dU+2Plha+sn4zkYp7vxP7KbKIUWhCbacEbxeVmC20OoFcXjx+KEciYbYX7mxd
         LBu+MwHgSVDwRamwjX7Y26mNmyoPYltRT+RvLbNAhaJZD8NBklmh/9/NAIKCIJqG+fLz
         amve9cIZnY75BKG8klZVKUwHHKEewacaN9TNvN0tALR7GrO9lCpumjdoBodyAozYBr6E
         RarsaPC3K8IbmeJIurRxclSMIRvvil4sg04+Tt3p6hvBC3GEK6viYNR4TW90uLBoZfD+
         UJ3AUg9OIwGWy4Ey5iJxfjslEnYLmwRtPUyq3SDmaHX9ZrjlVDvJGyNmygGa5xs7CoUz
         XclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D37sSrKXvPjTBTZeLgaiDtC505FZLtGgW+LNt7fG/kc=;
        b=dOeRAbiO+hhEFKC0nEqZvL4JySvNL+AcsqYMDxoDYm5s7FcsYTie91D9tdl6KR8C/w
         /jXyHhhZEX7QpvEs4TrowLqhmNB82fLGUCNTmp11DTCvVpzwh4cyx0wrxz1zg3nmF8bl
         C1y7g+6vm4SS611/7Vfygi2JVRaVK6zxgKB9TCvwQpZBbG+52b0K9lxdA3Iml85NTOu9
         xIO1PRv7Ow+KRG+kFH2A0PRPBguxRNXFRYR6yhgQkbs2178ukGAkcAIPQTOfZsVR8O9Q
         q9Sn2SzUBOzdfzIHuMsqZOuQ5VtZsWaST4AQiihwt/0/AeBPpfZyJo+zsVzlr204VGDq
         B6ag==
X-Gm-Message-State: AOAM533Jn36dlviPxAmsiZX9SNzfvMsTRDszfIWHITWZsSHoQzzHXzgv
        esNjwqya+EixZo7zW4l2IsNFPlm21cbkUUP/eck99w==
X-Google-Smtp-Source: ABdhPJwVHqr0NdUemN6rxMcZ1uq5pf33jpn4oyhNEifOJhIm0nCqTbxxJ0Kh8yTfOUiMl4DH8u53UAvV1W4x/dL08Uo=
X-Received: by 2002:a05:6512:12c3:: with SMTP id p3mr11997107lfg.298.1639605744442;
 Wed, 15 Dec 2021 14:02:24 -0800 (PST)
MIME-Version: 1.0
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com> <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com> <8735mvthk6.ffs@tglx>
 <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com> <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
 <Ybpe/ND+MQq6tqoR@piout.net>
In-Reply-To: <Ybpe/ND+MQq6tqoR@piout.net>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Dec 2021 14:02:12 -0800
Message-ID: <CALAqxLWe13ZghdWphzWZZsRGa+MeAH58syfem6ktDFHF0WG4Dg@mail.gmail.com>
Subject: Re: Time keeping while suspended in the presence of persistent clock drift
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Joel Daniels <jdaniels@sent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 1:32 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 15/12/2021 13:06:30-0800, John Stultz wrote:
> > I'm not really active in this space much anymore, but a few of my
> > (possibly wrongheaded) thoughts:
> >
> > >    [A] On machines with a persistent clock how is userspace supposed
> > >        to be sure what drift to measure? Can it assume that the drift
> > >        of the persistent clock used for sleep time injection is the
> > >        same as the drift of /dev/rtc? This seems dangerous.
> >
> > Yea, there can be multiple RTCs as well.
> >
> > >    [B] Sleep time injection can come from the "persistent clock" or,
> > >        if there is no persistent clock, from an RTC driver. I'd like
> > >        to correct for drift from the perisistant clock but not touch
> > >        the RTC driver sleep time injection mechanism. Is this
> > >        acceptable or do people feel that any drift correction should
> > >        work with both mechanisms in order to ensure a polished
> > >        interface?
> >
> > This dual interface comes from the desire to support both the more
> > atomic/earlier correction we can do w/ the persistent_clock interface
> > while holding the timekeeping lock, while also supporting RTC devices
> > that may sleep when being read, or may have dependencies that aren't
> > ready that early in resume.
> >
> > Admittedly having two separate abstractions here is a bit of a pain,
> > and fixing just one side doesn't make it better.
> >
> > >    [C] Some users may want to correct for drift during suspend-to-RAM
> > >        but during suspend-to-disk they might boot into some other
> > >        operating system which itself sets the CMOS RTC. Hopefully,
> > >        this could be solved from userspace by changing the drift
> > >        correction parameter to 0 just before a suspend-to-disk
> > >        operation.
> >
> > Oof. This feels particularly complex and fragile to try to address.
> >
> > > I suspect that there are other things about which I should also be
> > > worried if only I were less ignorant. That is why I am asking here.
> >
> > Personally, I'm not sure this warrants adding new userland interfaces
> > for. I'd probably lean towards having the RTC framework internally
> > measure and correct for drift, rather than adding an extra knob in
> > userland.
> >
>
> I'd rather lean towards the timekeeping code doing that. The RTC

Heh, touche'!  :)

> subsystem doesn't know which RTC has to be used.

Though the RTC layer *is* the one that tracks which RTC is used, via
the logic in drivers/rtc/class.c, and the timekeeping core already has
adjtimex for timekeeping corrections, so if we're correcting
underlying RTCs it seems such tuning would best be done in the RTC
layer.

Though how the persistent_clock interface ties into such corrections
would be a separate thing.

thanks
-john
