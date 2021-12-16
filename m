Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9587B4766D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 01:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhLPAKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 19:10:20 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:56389 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231740AbhLPAKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 19:10:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 175DB3200A5F;
        Wed, 15 Dec 2021 19:10:17 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute4.internal (MEProxy); Wed, 15 Dec 2021 19:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=Qtg1f3c8kSXR6noidnv4B3cWILY2r5D
        +AZIQq0oyBlc=; b=ZGmRgQjJ3j5xs21X72ABfh8zS1hKnXZLgWsxHMOD4T/gDao
        YrkhdJn1vEkJ/6K8GO6VcwS28E3xOtzeTkaBr9KeJHDi9W10PKojr9zZUJTHKtUt
        xng8INJxTy6fEeEaqD4nSvl+MlRCxVxvmgJ2ARe7yyuPJDGGxlInNTCj/La8f0Ax
        TFbbqGGv5JuCGm4NZzFhsIoHt9I1sV75sLqRmm/u1iJDKzQ4MXbTd8GRKs8ynTeK
        FiVLjniIGqL73vQVqkRbx+L7gMyr/zDE+PBiC5br9e7AXkLw0uepzuZmAhHZNxPO
        pVDqq33e9ZSjnqeZp3wfmuN4fkVI5c1nGsEc8vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Qtg1f3
        c8kSXR6noidnv4B3cWILY2r5D+AZIQq0oyBlc=; b=NTwxRTH/KE92WnDGpnd2XJ
        pic791p8NHUfoPYA5x7in0hLPAkmbZd8WNNvyEx24xAuZ86DmOtQjOZXlgK5jonY
        m/MChhYantfletU+izUbgDpBt+A+Ld1UEPbukCkHhWMbqI+bdR7VUtPWfk71TPTa
        RUN957cDecZvxZaMzeGVTIcaLfDsM3Fszto5kt2qGYwxFQVUrOmeqzPz1hB93YzH
        T3E/7TYuriEzAljlFbzw4NUWX7HsNoS4RwRNXm/Q4E4AQ5jnd5GL8fLfHdG4qYTU
        HG7mKg68KAkrayckX2VNd4miuqiqIvqCrhrJaC675s12wBdyFyhOwvgm6grZCZTw
        ==
X-ME-Sender: <xms:6YO6YbWxLb_IAw5zKkVCfh-HMHUDM48gFdz8eLjdJtqgQjNwp37Utw>
    <xme:6YO6YTlk74RcQ0cWwVdAYGF2ydRp6kO-eCsJuKflJR-W8p6mSkayj4Hn2NlvkZKap
    _btyaTNTCj7Zzpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleefgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedflfhovghl
    ucffrghnihgvlhhsfdcuoehjuggrnhhivghlshesshgvnhhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhudduveevfedutdevfeevjeelkeefvedvvefghedvleethefggfdujeff
    ffefteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjuggrnhhivghlshesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:6YO6YXY65XdfVF9wiRt3IS1gzGOliOPS3iHygOMWY9Qtmv_4wrqqaw>
    <xmx:6YO6YWVUy3wacRLs3zoxOIxJkg4oiB2WG_C5ITY8VnquFhGnxgZ1tA>
    <xmx:6YO6YVlxxW-IAYXihnvPHK43YMWR8T0rZkMfvx0-Koqjt0C7ljk_eg>
    <xmx:6YO6YYuoLJ8FGiC2ls72PJ55WyeSo8Th9ytqKFDXyTrWrsdEEseX6A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5BF5BAC03DB; Wed, 15 Dec 2021 19:10:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <273e60aa-d25c-4f29-a31a-97ea6c19ad67@www.fastmail.com>
In-Reply-To: <Ybp76D62Le2aEc5R@piout.net>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com> <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com> <8735mvthk6.ffs@tglx>
 <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com>
 <CALAqxLXf6TmOn_jCOv68oop=4On+CN-p_KkN-70BDt9OjQhzUw@mail.gmail.com>
 <83deaa79-39eb-4fd7-ad80-9d233fd6fdbb@www.fastmail.com>
 <CALAqxLX795pURb_aJTEAdq80LGiY=br88A+R3TN3HQh+HtS85Q@mail.gmail.com>
 <Ybp76D62Le2aEc5R@piout.net>
Date:   Wed, 15 Dec 2021 17:09:46 -0700
From:   "Joel Daniels" <jdaniels@sent.com>
To:     "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "John Stultz" <john.stultz@linaro.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Stephen Boyd" <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent clock drift
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Any method of measuring the drift is going to need to persist the
>>> drift coefficient to disk so that it can set the system clock
>>> correctly on boot. I think it would be best for the kernel to use this
>>> same coefficient.
>> 
>> My initial thought was for the rtc class layer to do the estimation
>> internally against the system time (assuming it was NTP corrected) to
>> try establish a close enough correction factor as the system was up
>> and running, but you're right that would be reset on every reboot, and
>> with second granular RTCs accurate error calculations will take awhile
>> (though polling for the second-edge might work well enough, but would
>> be cpu heavy for a background task).
>> 
>> Maybe that's a good enough argument for having an ADJ ioctl added to
>> the rtc chardev?
>> 
>
> Then why not got for the correction software emulation? that would avoid
> duplicating interfaces and we'd avoid to use it on RTCs with hardware
> support.
>

Emulated drift correction would affect the time reported by the RTC
wouldn't it? If I want to get a drift-adjusted time using hwclock
I would need it to use /etc/adjtime to adjust for RTC drift until
boot but then trust the kernel to adjust for RTC drift after boot?

If the software emulation ever wrote back a new value to the RTC then
hwclock would have no chance of working since (during boot) it needs
to know the last time the RTC was set.

>> But it also seems to suggest that if chronyd already has all this
>> logic in userland, maybe having it calculate and call settimeofday()
>> on resume from userland instead of pushing half of that logic into the
>> kernel?
>
> My suggestion would leave the correction calculation to userspace which
> is definitively where it should stay.

So this is what I am setting up now and it kind of works. By the
time a time daemon can do anything the system clock is already several
seconds in the future and other userspace programs may have already
observed this wrong value so calling settimeofday() is dangerous.
Instead I use adjtimex to set the ADJ_TICK parameter in order to slew
the system clock aggressively (30,000 ppm or more) so as to fix the
clock quickly.

I do not like having the system clock running 30,000 ppm too slowly
for a couple of minutes after a resume but I can live with it if you
think an in-kernel solution is not appropriate. The default chrony
config uses a slew rate as large as 83,000 ppm so maybe I am too
nervous about this.

Also, if the time daemon dies (e.g. it gets killed by the OOM killer)
before it has a chance to reset ADJ_TICK then the system clock will
run 30,000 ppm too slowly forever! I'd rather use ADJ_OFFSET_SINGLESHOT
to avoid this but ADJ_OFFSET_SINGLESHOT will slew the clock at only
500 ppm and it will take hours before the time is correct.

>>>> Alternatively I'd go very simple and just put the correction factor in
>>>> a boot argument.
>>>
>>> This works for my use case though it won't be useful to a general
>>> distro. Would you have one argument being used regardless of where the
>>> sleep injection was coming from or would you try to tie it to the
>>> persistent clock and/or a specific RTC?

