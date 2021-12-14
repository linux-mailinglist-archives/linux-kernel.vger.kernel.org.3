Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289804749E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhLNRn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:43:29 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55265 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233430AbhLNRnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:43:25 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C2C093200E83;
        Tue, 14 Dec 2021 12:43:23 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute4.internal (MEProxy); Tue, 14 Dec 2021 12:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=lUI4Gi4ASSfwRyXUyN14412E/Gij2W/
        GXPTxV2MMlC0=; b=rjkZneXI9Ygkuc1vb63ajZeykogUHN6U8Lq+dSSdCiCTYg+
        GgU+B37NyRv+F3tVMFLG1EslOaKZq6gOnGmObSPqWgr0tmtWMnhrvu/s6S9L6LEU
        2dgbAlEkNq7qhzAh8Th3GGSZsJBElNO6106dazZqOAyZswYtMW9Ms6C3abdc3Exk
        jo7KUWTBM4YF1DzYhe7c2YYApMTlsS0WBnQsS6fz0tAbNdZCX7qRkdLl1iRQ/LnV
        webAGQJ7J23avFeT48Cpzq5neI1O94HD60UTuZQDbdHoqLF37JHJgdWVIh9Cp3nI
        7nI0PHJeE1wqbJiwIDep+5zH7+27osh5WpPsRFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lUI4Gi
        4ASSfwRyXUyN14412E/Gij2W/GXPTxV2MMlC0=; b=ey1P6pDQbaG4PYEeoHw2sH
        zm4eonukVHdH0xgqBR7n1zGPMXntqX5qMp4p0iy+Cs/ga12Ezh8LStH5WBCIH860
        eMIHtKMoTzfs92GnNARwuo2maxSb2BxSTopt7BQSpvNbIh8JaXLEXXvsKvYtM5/7
        1uoGr8ttuRwlrK/i0IHxdBz1oF8iAZc4KbgNlz4A7Cruf539EvF7FXZPWbJQ3D4H
        +WImR6Lv06mByk4C2Gpyif6MwpWb4R3X3S7lPLmU6cyKCSzBVs6LkKmAYKJ4Nlg8
        m2hevZmw/MXKyulzg+HPqdOuB2W9mCsq21TP1ZaSkBWqX5pgCUK/LSRU5vX95jVg
        ==
X-ME-Sender: <xms:ute4YZXumjR5YV-ZlhJwG1MNtUJAoUF5gyf5R6yKayzngGc0txTpNQ>
    <xme:ute4YZmPowfAjy5aF1xsYtb8CWsBSpu3YtZsL-5tkjhJXme3Aqi_YN80FFOAwn8WQ
    qCR__gFAL0tvGTl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledtgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdflohgv
    lhcuffgrnhhivghlshdfuceojhgurghnihgvlhhssehsvghnthdrtghomheqnecuggftrf
    grthhtvghrnhepveetuddvledtuedvveeutefguedtveduieffueekudelgeejlefgjeek
    ueeftddvnecuffhomhgrihhnpehnthhprdhorhhgpdhhihhnuggrfihirdgtohhmpdhmrg
    igihhmihhnthgvghhrrghtvggurdgtohhmpdhgrhgvhiifrghrvgdrtghomhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuggrnhhivghlsh
    esshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:ute4YVbyEzpu8y9GDBGHfkBdP6YQlCsVAeANbO_Cr9tZkWgSb-Av9g>
    <xmx:ute4YcXeYua3hbSdc3r5lKaIVXJ1Kzy1sfhCafwgcGjLPW7mXjG0cQ>
    <xmx:ute4YTmcHVxEgxXO_B7gjg7Eb6KhTCjWAsCwwK0t8fR79O6J-3DHFA>
    <xmx:u9e4YesknDq_qp5fhLXolzdS2JgkS-urU7boPphRZAR1y31gvddg7g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E9CB1AC03DB; Tue, 14 Dec 2021 12:43:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4514-g2bdc19e04f-fm-20211209.002-g2bdc19e0
Mime-Version: 1.0
Message-Id: <2ab24da8-e37d-426a-9500-b7541d21f8a3@www.fastmail.com>
In-Reply-To: <8735mvthk6.ffs@tglx>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com> <87wnkbuuuz.ffs@tglx>
 <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com> <8735mvthk6.ffs@tglx>
Date:   Tue, 14 Dec 2021 10:43:00 -0700
From:   "Joel Daniels" <jdaniels@sent.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "John Stultz" <john.stultz@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, x86@kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent clock drift
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

On Tue, Dec 14, 2021, at 6:57 AM, Thomas Gleixner wrote:
> thanks for making sure that this is really a RTC issue on that machine.

And thank you for taking an interest. I've measured the RTC drift over
a number of days and it is stable at around 3.8 seconds per day (or 44
ppm).

>> The "if" branch does not apply as I have no clock sources flagged as
>> CLOCK_SOURCE_SUSPEND_NONSTOP but the "else if" branch does apply.
>
> Which CPU is in that box?

Intel Celeron N4120. This is a Gemini Lake Refresh (Atom) chip.

The relevant bit from the early_init_intel function
(linux/arch/x86/kernel/cpu/intel.c) is:

    /* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
    if (c->x86 == 6) {
            switch (c->x86_model) {
            case INTEL_FAM6_ATOM_SALTWELL_MID:
            case INTEL_FAM6_ATOM_SALTWELL_TABLET:
            case INTEL_FAM6_ATOM_SILVERMONT_MID:
            case INTEL_FAM6_ATOM_AIRMONT_NP:
                    set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC_S3);
                    break;
            default:
                    break;
            }
    }

> The kernel does not believe. It relies on the accuracy of the CMOS clock
> which is usually pretty good.

The references I have found on CMOS clock accuracy [1, 2, 3, 4]
indicate that a drift of 1 or 2 seconds per day (10 to 20 ppm) is
typical. Hopefully people on linux-rtc can confirm?

If that is correct then my clock, at +44ppm, is an outlier but I
suspect that people with a consistent drift of only 1 second per day
would still benefit from being able to correct for it. Indeed, people
have been using hwclock and /etc/adjtime to correct for CMOS RTC
drift for decades.

> > I would like to provide a way for user space to inform the kernel
> > that the persistent clock drifts so it can make a corresponding
> > adjustment when resuming from a long suspend period.
> >
> > ...
> 
> That needs some thought. The RTC people (cc'ed now) might have opinions
> on that.

I agree that this needs thought. Three issues that I am particularly
worried about:

   [A] On machines with a persistent clock how is userspace supposed
       to be sure what drift to measure? Can it assume that the drift
       of the persistent clock used for sleep time injection is the
       same as the drift of /dev/rtc? This seems dangerous.

   [B] Sleep time injection can come from the "persistent clock" or,
       if there is no persistent clock, from an RTC driver. I'd like
       to correct for drift from the perisistant clock but not touch
       the RTC driver sleep time injection mechanism. Is this
       acceptable or do people feel that any drift correction should
       work with both mechanisms in order to ensure a polished
       interface?
       
   [C] Some users may want to correct for drift during suspend-to-RAM
       but during suspend-to-disk they might boot into some other
       operating system which itself sets the CMOS RTC. Hopefully,
       this could be solved from userspace by changing the drift
       correction parameter to 0 just before a suspend-to-disk
       operation.

I suspect that there are other things about which I should also be
worried if only I were less ignorant. That is why I am asking here.

Thanks,
Joel Daniels

[1] http://www.ntp.org/ntpfaq/NTP-s-trbl-spec.htm#AEN5674 :
    "A PC used a stratum 1 server with PPS had had a hardware fault,
    and it had been powered off for about 18 days. ... when the system
    was rebooted the RTC clock was off by 18 seconds. That would be
    an error of roughly 12 PPM."

[2] https://www.hindawi.com/journals/jcnc/2008/583162/ :
    "In IBM PC compatible computers, the RTC circuit is the Motorola
    146818, with a resolution of approximately one second and a
    significant drift"

[3] https://www.maximintegrated.com/en/design/
            technical-documents/app-notes/5/58.html :
    Tables 1, 2 and 3 list 32.768Khz crystals with typical frequency
    tolerances of around +/- 20ppm at 25 degrees celsius.

[4] https://www.greyware.com/software/domaintime/technical/
            accuracy/pcclocks.asp:
    "The resolution of most PC real-time clocks is one full second,
    and most RTCs drift considerably over time."


