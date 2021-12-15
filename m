Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFA2476525
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhLOWF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:05:28 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:43553 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230022AbhLOWFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:05:25 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id ADBCD32009BE;
        Wed, 15 Dec 2021 17:05:24 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute4.internal (MEProxy); Wed, 15 Dec 2021 17:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=x5hu5MYDQc14RaVRAzF1rHpkEmrbtsN
        tHo/R9IbG4dY=; b=buCN3+iHwDA+XsNihFPZD7EHIim6P8Cg8qLKuSZxC/GcpoL
        Cu8nqyuQ78yVsiB+OmH9Pq+RKoFCk5t5Mwzqv8S4ldxwCTTDjyC+Egvn6buhC6tR
        JonSxWaKVgrQwGMG4L3gzKYu9coOjj1P9vYJNftXZLF9Dp8RajV2z7YOSxyXAZb1
        fsyymJYDyqu7ujyWRTggjW1weylbXbwGkRIBgnCEh6PrBAge7PYf/xeEmuc5XY4m
        ULHAQR0zIhXfBHhp2RcvIaO8IwdZYnvOWq/VofabTS5og+zK8Pdxlk9XwDBbGhC9
        A73Ae8P6/7IK4c34vw5nvaT3n6qzgwJNpQLq0nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=x5hu5M
        YDQc14RaVRAzF1rHpkEmrbtsNtHo/R9IbG4dY=; b=XQ6oymljsvEk3wsWZalUlm
        vFViRA+XW416un/kq9eAW5uAHp7+Pa4cO/VFgW63a2pvJ7h6YHZnb3zcQHBLhiUa
        BxCLubfyoQsIrlVBiGDnfYB4F/WFQLLL81h3928xlQizJiy7LH0uRD7Cu7uKqnM4
        HzAfFy+4LI1YBwXDwb7iScRRFr7STWUfwXR8rucGybIFx+ouvXjoOTXdpJDgpPr0
        hLTzqnAVRzC7+SgL9xkX8d9SZwUOoMUGXiQ+vtl/u74UVIh375tiv6+92rqLyQtt
        ab03QE+TM0WB3Kjv95mOjDGNGiYjVUPInYVKZhpENdv5XZfHRpdk5vapKZeAjRhQ
        ==
X-ME-Sender: <xms:o2a6Yb85Al-C80kXzll9li9Bj6YrsyGg4FQN64DlQarcXHnGATRVaQ>
    <xme:o2a6YXtM3pkuQLLcGVn_P_K9HvQBPKQoZVIkXkh_gPGJ6Bj9pE3nzyAyjqRfXfDbD
    N8KHgwUKuLOpiSy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledvgdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdflohgv
    lhcuffgrnhhivghlshdfuceojhgurghnihgvlhhssehsvghnthdrtghomheqnecuggftrf
    grthhtvghrnhephfduudevveefuddtveefveejleekfeevvdevgfehvdelteehgffgudej
    fffffeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhgurghnihgvlhhssehsvghnthdrtghomh
X-ME-Proxy: <xmx:o2a6YZBqIV8b6uKzxt5XElV-vfL1UwiMB7D91W3Ka2p31vlmLKMoiQ>
    <xmx:o2a6YXcrm-hsGYeAQ3Vstf6I0PIDyoZAMygBQz48u_tmNyUQwVn0aQ>
    <xmx:o2a6YQMwFvMr2R4iWSu-4CbmZDRhAV5jdG-S7Ojrl8I5QfYMnlhpvA>
    <xmx:pGa6Yf1yoxzj-A5DQ2i3xspYe6yPY7-9KFn2htbJetnq1O-HXZELgw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5BC59AC0DD1; Wed, 15 Dec 2021 17:05:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <5fb8b880-8fea-4e53-a00c-994bf4890f8a@www.fastmail.com>
In-Reply-To: <YbphWpMl7W0Qzs+d@piout.net>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com> <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com> <8735mvthk6.ffs@tglx>
 <YbphWpMl7W0Qzs+d@piout.net>
Date:   Wed, 15 Dec 2021 15:05:01 -0700
From:   "Joel Daniels" <jdaniels@sent.com>
To:     "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     "John Stultz" <john.stultz@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent clock drift
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> > I would like to provide a way for user space to inform the kernel
>> > that the persistent clock drifts so it can make a corresponding
>> > adjustment when resuming from a long suspend period.
>> >
>> > In my use case it would be enough for me to set this parameter on
>> > boot. In use cases with continuous network access, NTP daemons
>> > could be enhanced to periodically update this parameter with the
>> > daemon's best estimate of the persistent clock drift.
>> 
>> That needs some thought. The RTC people (cc'ed now) might have opionions
>> on that.
>> 
>
> The RTC subsystem already has two interfaces to correct the drift of an
> RTC. However, this is currently limited to RTC that have hardware
> support for this feature. I guess we could had software emulation of the
> feature to be able to correct for any RTCs  but this will raise many
> design questions, like how often the correction has to happen, what to
> do with RTC that have a counter that doesn't reset when setting their
> time, etc...
>
> I guess this would be able to solve your particular issue has you will
> need a mechanism to handle when you overshoot the regular correction
> timer.
>
> However, everything falls down once the machine is turned off, making
> the whole effort moot...

Today two mechanism are regularly used to correct for rtc drift while
the machine is powered off: the hwclock program and chronyd with the
"-s" option. They both rely on the RTC running at the same rate when
the machine is on or off. So I agree with you that trying to emulate
hardware RTC drift correction in software is not going to work well.
