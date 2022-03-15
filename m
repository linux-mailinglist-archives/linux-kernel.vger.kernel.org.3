Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F1A4D921A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbiCOBOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344174AbiCOBOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:14:32 -0400
Received: from gateway24.websitewelcome.com (gateway24.websitewelcome.com [192.185.50.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985701E3E6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:13:21 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 1E4EB57F07
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:13:21 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id TvkWnqTr022u3TvkXnSHUA; Mon, 14 Mar 2022 20:13:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DXP5JTjRTZHXHEflX1M4RFaX6Uy10l6RP6cpHIAW9yo=; b=Q+HFwr4+FAAH5TodBobY37uxg0
        SAYyU3K8i+ctOKnEFSyGzdX1k0aN3bEpvabZkw14cfDxiet8znRuqxqV3ycVInzM1ykgyYCTl+VfA
        U2OdirD+YwwoUn2UB+oTXnZpckTIxTijj5E5ZQ1pN30D/7M2a0dHxoVVzKrU2uuTFg/+pL4Xmhfyw
        K62xX1ImZFfUvyUP5uyM7VVtChC3g9b7DzbrSzs7hT8QvxgESs+6+dF4GkBPIzvwJjMYqM3N/enxN
        rJgN7ywMc8IHTUoODoEHLxwOQbBXCNd4cBu8Hd3mQmQzW6kTkhDBVlYQfBsW+OhW1zEhSiU7yF4WY
        fZyHfqpQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54264)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nTvkW-004A0G-Gq; Tue, 15 Mar 2022 01:13:20 +0000
Message-ID: <f313f998-3f5e-51f8-31fe-4214446a6c69@roeck-us.net>
Date:   Mon, 14 Mar 2022 18:13:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Edmond Chung <edmondchung@google.com>,
        Andrew Chant <achant@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
References: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
 <20220314192522.GA3031157@roeck-us.net>
 <CAHk-=wiEhs+4P1TNh2sNnk04D1FFdNThk6XLOMxzkRL72PEXFw@mail.gmail.com>
 <CACjc_5paC=X4znTty8LBtobqBW2nq4mbQYnw_TMgVEFb1A7mhA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 5.17-rc8
In-Reply-To: <CACjc_5paC=X4znTty8LBtobqBW2nq4mbQYnw_TMgVEFb1A7mhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nTvkW-004A0G-Gq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:54264
X-Source-Auth: linux@roeck-us.net
X-Email-Count: 2
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 17:45, Marcelo Roberto Jimenez wrote:
> Hi Linus,
> 
> I am the author of the "gpio: Revert regression..." patch.
> 
> On Mon, Mar 14, 2022 at 5:14 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> [ Adding more people to the cc, since this last change was triggered
>> by earlier changes.
>>
>> On Mon, Mar 14, 2022 at 12:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> Build results:
>>>          total: 155 pass: 155 fail: 0
>>> Qemu test results:
>>>          total: 488 pass: 484 fail: 4
>>
>> Uhhuh. We got all the previous problems sorted out, but a new one instead.
>>
>>> This is a new problem. It bisects to commit fc328a7d1fcc ("gpio: Revert
>>> regression in sysfs-gpio (gpiolib.c)"). The network connection fails
>>> in the affected tests. Reverting the offending commit (ie reverting the
>>> revert) fixes the problem.
>>
>> Hmm. Looking at the changes since 5.16, that commit fc328a7d1fcc looks
>> somewhat suspicious.
>>
>> It claims to "revert" things, but the behavior it reverts goes
>> basically all the way back to v5.7 (with one of the patches going into
>> 5.10).
>>
>> And it clearly breaks things that used to work much more recently (ie
>> this worked in rc7, but it was also the state in every release since
>> 5.10).
>>
>> So unless somebody can find the _real_ issue here, I suspect very
>> strongly that that "fix" that came in last week was just wrong.
>>
>> It is also very non-specific "Some GPIO lines have stopped working"
>> with no pointer to actual reports.
> 
> The original message in which I posted the patch also had a small
> report. I listed the board in which the problem appeared and a small
> test script to show the error, which I have used to bisect the issue.
> 
> The whole thread is here, the test is in the first message:
> https://lore.kernel.org/all/a7fbb773-eb85-ccc7-8bfb-0bfab062ffe1@leemhuis.info/t/
> 
>> LinusW? Thierry? Bartoz? Anybody?
>>
>> Yes, there;s something bad going on here, but we can't randomly "fix"
>> things in an rc8 that have worked for several releases by now.
> 
> The original patch just reverted the patch that introduced the problem
> I found. But if the reversion introduces problems at this point, then
> the sane thing to do is to revert the reversion.
> 
> At a certain point, I tried Thorsten's suggestion to add a gpio-ranges
> property in a way similar to another patch, but the kernel went into
> an EPROBE_DEFER deadlock. Thierry Reding made some comments about this
> in the sequence.
> 
> Following Linus Walleij's suggestion, we are moving the code from the
> sysfs interface to the character device. But in the meantime, we are
> using this "revert patch" in a 5.10.80 kernel, so maybe someone could
> point me to details of the network misbehaviour so that I can also
> check it?
> 

See https://kerneltests.org/builders/qemu-arm-master/builds/2030/steps/qemubuildcommand/logs/stdio
for logs.

There are two problem with your patch:
- The Ethernet interface on imx25's qemu emulation does not come online.
- The mmc does not come online (I just noticed this one)

Looking into the devicetree file, my guess is that the gpio
lines attached to the Ethernet PHY and the sdhci controller
don't report pin status changes. I did not try to confirm this,
though.

Your patch may work for you on top of v5.10.y, but it doesn't
work there for imx25 either.

Guenter
