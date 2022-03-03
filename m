Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453164CBE13
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiCCMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiCCMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:44:11 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE81FFFBB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:43:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id i11so8271641lfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=qVKE1XoWgBPXcn3sF2lp7cnUjcJzDVSHPtD5PNmNwPU=;
        b=AAf2s05Z5HcB5p1BcVzAejQDgfjQuLBFkVHjVDsiXDGJwIFUMmDDtfhb3aVPtGgiuH
         Rfy5Bf51qDqHWf7X5eadh+LGLzROgCSx667c0odvBYSJ1hqTURTS0ZC3JZ2LNTBNXyh0
         1KJDzk0wo6Q0EcqzoQtQ0GCohKax6cytdPnhtsL9vVad85OBC0iJ2auuL31Eg6rPiwjo
         R8GYnvY+6ZM7H7NPtTWqRRQDr0uGLZLBTW6ILdjldjY45CBwN0Kv2HBIoP8cEpNiWIUM
         svGdciJvvEduhrcHbY9fZn4tB0HMmNnYptqzUBMMkyN7h3nHj8t4Z+IA63LTEqSMRwGk
         FaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=qVKE1XoWgBPXcn3sF2lp7cnUjcJzDVSHPtD5PNmNwPU=;
        b=GP430LcQyWaAEqH5hn0GIOejflHBWUNHPHTEx7yJsXRzdSREKJL2f0ML5Fsvsl49Y1
         Dow4NbO2NO5DAqwRXahojYFtKJmgiU9ZA+Imy7Gkb4qPPPeGIGADe/Y2SKHp0OngR1a4
         tOy1/+9F9QjmsYShbFVE99iO+moreuvswYEhDrHkt3AppKvv06MmFuCR8cQdK04ogF7I
         0DJJhltB9sNZ1SLk/Sfy3ZjV4vtA2OVeBcPnrtXNwmtYw1RU3jpfHiNSMl/tBBcc14eD
         hkUwQz2hByA+e/4XmkIvmlUbaPcVD13CPa2So81mB13oAl0HcEm2VpHPwUDqhpvu7xUf
         +5Vg==
X-Gm-Message-State: AOAM533NYwZDy6W/vyY7miuvQV0w9M7fprNoIf0NxT0IA8mSMpN1B0TT
        VCIyjuTSXAq+Np+MPvb5kDg=
X-Google-Smtp-Source: ABdhPJyA6AP3m6ac4cSxIA6CR3lLMFcXaYSfM3C1TFju4DSb0OAHEBI23phbA/qaCXIbH/IJcKwoPw==
X-Received: by 2002:ac2:5dd7:0:b0:442:c0aa:ddc0 with SMTP id x23-20020ac25dd7000000b00442c0aaddc0mr21107306lfq.628.1646311404034;
        Thu, 03 Mar 2022 04:43:24 -0800 (PST)
Received: from ?IPV6:2001:14ba:16ee:fa00::5? (dc73szyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::5])
        by smtp.gmail.com with ESMTPSA id b15-20020ac2562f000000b004437f2667bfsm407795lff.308.2022.03.03.04.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 04:43:23 -0800 (PST)
Message-ID: <abdc4d16-b2b4-6343-39d6-9bc48e8be43b@gmail.com>
Date:   Thu, 3 Mar 2022 14:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Code Kipper <codekipper@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
References: <CACRpkdZmax=QpwnfgOJOR-5P3wTyKegaDn=VvhVOYz_AChc7bw@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: Question on expiring HRtimer in-kernel
In-Reply-To: <CACRpkdZmax=QpwnfgOJOR-5P3wTyKegaDn=VvhVOYz_AChc7bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 3/1/22 14:19, Linus Walleij wrote:
> I have a problem with a premature expiring HRtimer.
> 
> The HRtimer hrtimer_set_expires_range() is used in two places in
> the upstream kernel:
> kernel/futex/core.c
> drivers/power/supply/ab8500_chargalg.c
> 
> Now I am testing the code in the latter, and it has seen some
> bitrot since merged in 2012. Maybe it was correct at one point.
> The timer is started like this:
> 
>      hrtimer_init(&di->safety_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
> (...)
>      hrtimer_set_expires_range(&di->safety_timer,
>          ktime_set(timer_expiration * ONE_HOUR_IN_SECONDS, 0),
>          ktime_set(FIVE_MINUTES_IN_SECONDS, 0));
>      hrtimer_start_expires(&di->safety_timer, HRTIMER_MODE_REL);
> 
> What the author wanted to achieve is a very definitive callback in one
> hour relative to now +/- 5 min, and that is one hour later in the
> physical world,
> as this deals with battery charging.
> 
> However sometimes this fires almost immediately rather than in an hour.
> 
> My first thought is to pass HRTIMER_MODE_REL also to init as
> hrtimer_set_expires_range() could make things happen immediately
> if we have ABS set, but this is all just intuitive.
> 
> Any hints? Better ways to create a definitive event in one hour?
> 

_a lot_ of water has been flowing in the Oulu river since I last touched 
on any code like this. Unfortunately I can't go back to my old code as 
it was left in proprietary world. So no promises I am at all helpful here ;)

In any case, I remember few cases where I hit nasty issues because I 
used CLOCK_REALTIME - which (AFAIR) is subject to the time adjustments. 
NTP, GPS-time and so on can make the time tick in a strange way :) I 
guess you would have noticed if time was set when timer did expire.

Anyways, I guess the battery charging should rather be tied CLOCK_MONOTONIC.

No guarantees though - please ignore me if I make no sense. Oh, 
actually, please don't - please correct me instead :)


-- Matti
