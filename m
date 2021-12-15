Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3C476614
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhLOWoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:44:06 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40809 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhLOWoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:44:05 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 795443200993;
        Wed, 15 Dec 2021 17:44:04 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute4.internal (MEProxy); Wed, 15 Dec 2021 17:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=Z7/1T82NiBSfL1mx6xqXOcBRkHJyE4Q
        m2TVOxX3axkw=; b=lHHZd7lBWZS8b/LXM1lLcWBc8qRTd6DV6UrNN9fNfwyUQZC
        ATqNbSpeWAoXN6mTFpspv35BcYPN2kEhgKopgMJS7/4UThXVrx3I2ygj56v72wfN
        bfvx6uWoAieiJszeZH5SRDXS5tGLdlxXCETYq0oV7l2EiB37a7GYRiG9Ni/sGCam
        oNct40Mh3h0eaTFaGAhNx013m/zOHc268sPQvADdfmwSZKnv2mBXRk7HW8pAnrwC
        HbUzL0LxubCks5rdN/4uy+mSHoaQd2S39cMld8Ht0eUm4M0p51nz4pvolCXiHUl8
        iBSp34tbcflFlmNNMoPqseKbGOjaPrZJCUndlbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Z7/1T8
        2NiBSfL1mx6xqXOcBRkHJyE4Qm2TVOxX3axkw=; b=QjpOpJQ1xYOlm9tTzGiSY6
        DLh5gWmp6if8sJ2k9g6+u+CPqjwRi0zQKGnd3cph/LQIERHyRBx8tStnOEHnWUMI
        G1RfY8qWZHuyCo6iN8BStWOGrRzzMaFnQ7GSzhUNq0L7mJxQYM5CGY+QoPK8aOgS
        J4tAQJ4iTvbQv/RSKqZRBuJl3Qqpj3DSGbnEEuGw3eDTwu+ivShCe2Ff3T2+VRwy
        Qs5qE3WO0YYsSPxjW3BvZHzbjw03f4ngoSDxnVPGlNy08QGtYbZPkfP8jgKuqPON
        VO4D/VuVM/EP6dI8qs9VanT94Vd7vHkTI4IYIELOQL2v9iZ1rPSI2jl+p9OUTzuA
        ==
X-ME-Sender: <xms:s2-6YcMxZGiDSkdwnKbbAzWzokuLzIhdrgUuGUi5Bv-Ku3fhDgvs1g>
    <xme:s2-6YS9-GLmltlcDOE9mRQZbZnKqJlGrzUFNnaiv8E17YeCkyPnZSwpi9h2o_rdDo
    BaBUDcdDjvVpoJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledvgdduieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdflohgv
    lhcuffgrnhhivghlshdfuceojhgurghnihgvlhhssehsvghnthdrtghomheqnecuggftrf
    grthhtvghrnhephfduudevveefuddtveefveejleekfeevvdevgfehvdelteehgffgudej
    fffffeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhgurghnihgvlhhssehsvghnthdrtghomh
X-ME-Proxy: <xmx:s2-6YTRMgN1yPDmS5fDJDCt4ih0dO3I67M2tb6JTXxpBEP4XfjU4rA>
    <xmx:s2-6YUuW6jBK1QzueQBlMq-Sv4FlzoOjtlyfOO3USdys_BJrnwQqLw>
    <xmx:s2-6YUckUWrwgiwea16z8QT_k5PptnmBsS0Qt3RdSvCyWWpbIRY4jA>
    <xmx:s2-6YZElAznXxjzTdUoqT5gwRP6yjdl9ceyKUFJQDB8OxmfvlYJyJA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D7DD4AC03DB; Wed, 15 Dec 2021 17:44:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <83deaa79-39eb-4fd7-ad80-9d233fd6fdbb@www.fastmail.com>
In-Reply-To: <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com> <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com> <8735mvthk6.ffs@tglx>
 <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com>
 <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
Date:   Wed, 15 Dec 2021 15:42:05 -0700
From:   "Joel Daniels" <jdaniels@sent.com>
To:     "John Stultz" <john.stultz@linaro.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Stephen Boyd" <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent clock drift
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks for your feedback.

>>    [A] On machines with a persistent clock how is userspace supposed
>>        to be sure what drift to measure? Can it assume that the drift
>>        of the persistent clock used for sleep time injection is the
>>        same as the drift of /dev/rtc? This seems dangerous.
>
> Yea, there can be multiple RTCs as well.
>
>>    [B] Sleep time injection can come from the "persistent clock" or,
>>        if there is no persistent clock, from an RTC driver. I'd like
>>        to correct for drift from the perisistant clock but not touch
>>        the RTC driver sleep time injection mechanism. Is this
>>        acceptable or do people feel that any drift correction should
>>        work with both mechanisms in order to ensure a polished
>>        interface?
>
> This dual interface comes from the desire to support both the more
> atomic/earlier correction we can do w/ the persistent_clock interface
> while holding the timekeeping lock, while also supporting RTC devices
> that may sleep when being read, or may have dependencies that aren't
> ready that early in resume.
> 
> Admittedly having two separate abstractions here is a bit of a pain,
> and fixing just one side doesn't make it better.

Thanks; that makes sense to me. I suppose I ought to have a separate
sleep-time-injection drift correction parameter per RTC? That way the
kernel wouldn't do something silly if somebody hotplugs one RTC while
removing another. The persistent clock is almost always exposed as an
RTC as well, so either I could try to be very clever and make the
persistent clock share the drift correction parameter of its
corresponding RTC or I could just maintain a separate correction for
the persistent clock.

>>    [C] Some users may want to correct for drift during suspend-to-RAM
>>        but during suspend-to-disk they might boot into some other
>>        operating system which itself sets the CMOS RTC. Hopefully,
>>        this could be solved from userspace by changing the drift
>>        correction parameter to 0 just before a suspend-to-disk
>>        operation.
>
> Oof. This feels particularly complex and fragile to try to address.

Yes, I think we should ignore this issue and treat all suspend/resume
cycles identically. People who regularly dual-boot can just not use
the new feature.

> Personally, I'm not sure this warrants adding new userland interfaces
> for. I'd probably lean towards having the RTC framework internally
> measure and correct for drift, rather than adding an extra knob in
> userland.

Measuring RTC drift is hard. The standard PC RTC has only one second
resolution so you have to wait for the "edge" of a tick and measure
drift over an extended period of time. If you have some NTP daemon
slewing your system clock while you try to measure RTC drift then
you will get garbage. If your motherboard gets hot enough then your
RTC will run at a different rate while the machine is on than while
it is off.

I know of three programs that measure RTC drift today:

  # hwclock: you must use it to set the RTC twice, the second time
    with the "--update-drift" argument. The manual suggests waiting
    one day between calls. The drift and offset information is
    stored in /etc/adjtime. On boot "hwclock --hctosys" will use this
    to set the system clock correctly.

  # adjtimex (program not syscall) when run with the "--compare"
    option. It uses a least squares estimate from multiple samples
    which by default are each 10 seconds apart.

  # chrony with the "rtcfile" directive. It tracks the RTC over time
    to measure its offset and drift similarly to how it tracks the
    system clock drift. Tracking information is saved into
      /var/lib/chrony/rtc
    and can be used (via "chronyd -s") to set the system clock
    correctly on next boot.

Any method of measuring the drift is going to need to persist the
drift coefficient to disk so that it can set the system clock
correctly on boot. I think it would be best for the kernel to use this
same coefficient.

> Alternatively I'd go very simple and just put the correction factor in
> a boot argument.

This works for my use case though it won't be useful to a general
distro. Would you have one argument being used regardless of where the
sleep injection was coming from or would you try to tie it to the
persistent clock and/or a specific RTC?
