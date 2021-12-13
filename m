Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3617A472D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbhLMNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:40:10 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42443 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232611AbhLMNkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:40:09 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 01C335C00F3;
        Mon, 13 Dec 2021 08:40:09 -0500 (EST)
Received: from imap43 ([10.202.2.93])
  by compute4.internal (MEProxy); Mon, 13 Dec 2021 08:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=lbc5UZr7tH6Pgd7IiLV05OaIFbn04y5
        ShvVV3yNPYuk=; b=RPl+yprR53VAi1O8ev/goesND/5OnpTUqBINcPMD3nl7VHx
        8T1gWVwTEA9+7fe3FvfYU4vpsRGIBSynJxvFPG2yIPbRAKep6nLQFFb638AgIZ97
        ly/fhlRN9EDoynXDDJOAkhaw/978Thmrdl1W4OBhqQTm7jJlProzUasiv/FqN9KN
        KBhSk4JA2DubJ9e5QQVItH9wlRUb9Y0EbuLqp719KvvTWaJTqEICPhb9gLF/WOXo
        tg0dxuKI/QrVk1eF7d9LVAppd5WD6zRCDU+iSUVndAHu9ax54e98RUANdVmPY2dn
        JOAKBeDudyxMNo3Bu4SdoXQY+ToNauOdhaTtF2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lbc5UZ
        r7tH6Pgd7IiLV05OaIFbn04y5ShvVV3yNPYuk=; b=ZRs3oo6Bd4wGzf+sGaJViG
        7b/NZjJYcTYrgJyAW81Awlu2oMLHis+esPeyWUYhKtA22i2bjaBhp7KIudln15MJ
        quxWIhyVD8f3JfD6dU54SkhTa+kHq9kz9txVpBDZh/IAzsgy8Log9id2+mrL/9TL
        Z5tKfs6V0Q9pDg/htSfiTgjkI+L0FvyYXRObtzXfPhMgGP8CT43ifHsDF6zxoBmd
        cvTsJdyM7pR5gmu0EhW1N/QShbufNEDUGEeADxLPAb1MqNZ5Ga5QAopMcRnLBAJk
        kRotkVe1FYR52YFE/kW0UwN+97+TpfdBwxG7+Nbd/ciNg2wze/8Zwjby8QuTxIpQ
        ==
X-ME-Sender: <xms:OE23Yar5FouGatmey_IIHFFfC_OrM20t6gJB7IKE9Eol9XZPgUH7Ew>
    <xme:OE23YYolxbn1za-J8VCZd5ZXYvRAoL_mPSqRpRjTc6X9y5MxIQ6sEVcSPGNaT7zRw
    oUEClf14hZr8yMX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkeekgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedflfhovghl
    ucffrghnihgvlhhsfdcuoehjuggrnhhivghlshesshgvnhhtrdgtohhmqeenucggtffrrg
    htthgvrhhnpedujefguddtvefhiedtieehvdfhtdehfeelgfdtffduudeiffdttdegkeff
    hffffeenucffohhmrghinheptghlohhuughflhgrrhgvrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgurghnihgvlhhssehsvghn
    thdrtghomh
X-ME-Proxy: <xmx:OE23YfNPQ3ekLINtvMYiBsnBH3pxf4zkOTbD6Mt349fjQiCd_PiXow>
    <xmx:OE23YZ7IZPTKEpePYQrlAkkG7-CdnPmPCnC7bgOXuIGeu55EDUdPew>
    <xmx:OE23YZ4jE81qUrDP2iBj36uJbuaS5QWc--jPkQvqO8lcHUt74JDctA>
    <xmx:OE23YbQJxVX0UCwKmkd9OrVWRpFXZp9X7FpZ3EwX95H8WjsxrSdB6w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CDFE9AC03DB; Mon, 13 Dec 2021 08:40:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4514-g2bdc19e04f-fm-20211209.002-g2bdc19e0
Mime-Version: 1.0
Message-Id: <4bb238e1-e8fa-44e6-9f5e-d047d1d4a892@www.fastmail.com>
In-Reply-To: <87wnkbuuuz.ffs@tglx>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com> <87wnkbuuuz.ffs@tglx>
Date:   Mon, 13 Dec 2021 06:39:43 -0700
From:   "Joel Daniels" <jdaniels@sent.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "John Stultz" <john.stultz@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent clock drift
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sat, 11 Dec 2021 14:36 +0100, Thomas Gleixner wrote:
> Can you please verify that the problem persists with NTP enabled and
> synchronized?

Yes, I just verified that the problem still exists while
synchronized to NTP. Specifically, I connected the machine to the
internet and launched chrony with:

    $ sudo chronyd -d -L 0

using this /etc/chrony.conf:

    server time.cloudflare.com iburst
    driftfile /var/lib/chrony/drift
    maxslewrate 500
    rtcsync

I waited for chrony to stabilize:

    $ chronyc tracking && echo && chronyc sources
    [...]
    Ref time (UTC)  : Sun Dec 12 00:18:00 2021
    System time     : 0.000099906 seconds slow of NTP time
    [...]
    Frequency       : 2.096 ppm fast
    Residual freq   : -0.041 ppm
    Skew            : 0.985 ppm
    [...]

    MS Name/IP address         Stratum Poll Reach LastRx Last sample               
    ====================================================================
    ^* time.cloudflare.com           3   6   377    26   -282us[ -424us]

    $ sntp -K/dev/null time.cloudflare.com
    [...]
    2021-12-11 17:18:57.339207 (+0700) +0.001868 +/- 0.012247 [...]

Then I suspended the computer. I woke it 37 hours later and my system
clock was ahead by ~6 seconds:

    $ sntp -K/dev/null time.cloudflare.com
    [...]
    2021-12-13 06:24:28.425752 (+0700) -5.767757 +/- 3.856178 [...]

Chrony, of course, started to slew away the error and at the current
rate my system time will be correct in about 3 hours:

    $ chronyc tracking && echo && chronyc sources
    [...]
    Ref time (UTC)  : Mon Dec 13 13:30:52 2021
    System time     : 5.597892284 seconds fast of NTP time
    [...]
    Frequency       : 2.252 ppm fast
    Residual freq   : +0.603 ppm
    Skew            : 4.259 ppm
    [...]

    MS Name/IP address         Stratum Poll Reach LastRx Last sample               
    ====================================================================
    ^* time.cloudflare.com           3   6   377    15    +80us[ +197us]

This behavior is expected from my reading of the timekeeping_resume
function (kernel/time/timekeeping.c). Specifically these lines:

    read_persistent_clock64(&ts_new);
    
    ...
    
    cycle_now = tk_clock_read(&tk->tkr_mono);
    nsec = clocksource_stop_suspend_timing(clock, cycle_now);
    if (nsec > 0) {
            ts_delta = ns_to_timespec64(nsec);
            inject_sleeptime = true;
    } else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
            ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
            inject_sleeptime = true;
    }
    
    if (inject_sleeptime) {
            suspend_timing_needed = false;
            __timekeeping_inject_sleeptime(tk, &ts_delta);
    }

The "if" branch does not apply as I have no clock sources flagged as
CLOCK_SOURCE_SUSPEND_NONSTOP but the "else if" branch does apply.

The kernel seems to believe that the time spent sleeping is exactly
the difference of two calls to read_persistent_clock64 with no option
to adjust for persistent clock drift.

I would like to provide a way for user space to inform the kernel
that the persistent clock drifts so it can make a corresponding
adjustment when resuming from a long suspend period.

In my use case it would be enough for me to set this parameter on
boot. In use cases with continuous network access, NTP daemons
could be enhanced to periodically update this parameter with the
daemon's best estimate of the persistent clock drift.

Regards,
Joel
