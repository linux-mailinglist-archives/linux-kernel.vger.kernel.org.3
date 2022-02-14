Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AE74B599A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357360AbiBNSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:13:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiBNSNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:13:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5149255
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:13:03 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso18105764pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yv0kyPBlUI7x2x4ZmpYRM2oynqiN1YdvwOx2uT47xE0=;
        b=muN6r8s/yaxLLW13Sr20enoDXZBpQWbYV239HJCiY3LkZUuywGM4GD3+WKHX0NKsRt
         dWMv18BDiygaIgdMcAgVNX9Atcnn22pe/lG6I6DdkVKkBEQZVUuNYdgADCcg9kaBZXu0
         gDHGt5x9sdV9yz+Kjqms1xTMDPJiuzoXhhokYW4tWbX7WmbJY+HCIBMcS9YFHN+anfMX
         K/E/HpPQBEHxXEgGmubS1piO10LgrtnZNxrmikuraprfCpwVnwYcj5TqwWFj9oToVHhx
         UXPL6PpmeoFTcDCUeto7+R6ZPXUPJB5mCVh+dciICtRdx0YZNWsRethd56GEy6fRpXcr
         DVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yv0kyPBlUI7x2x4ZmpYRM2oynqiN1YdvwOx2uT47xE0=;
        b=oM9eW336JzxxVK1dSKu7yrweBrSqD6GEKU87dXZKL40w/mfhP0zHzpsqI9L68WxGGy
         sHB6KubXBlZDiMTjLKEKkqM1VQzhusQbGg0l+aeUJJsIWziXO0p4yQ2mSSt0wb//mTwo
         +z6yM22xvWLp81xyveGGOKxQn0ETXDQKR0cCs9fY0deiDNPz96Zie0ywJGXxnhv4fKP/
         LTx2h246e+YQit5i7lSeUPQs/j/ayVaegiD+g2sdTvfmB1kDViVEqx27aEzFzOL4x3sP
         r6j7I6BHhcYYySY46fvdg6XuPGudXW6KuyvWDGg1lLbxiOH11tIuxP7y/nq5JnSb8Htd
         8QXw==
X-Gm-Message-State: AOAM532lrOpX5mzmGiL5FZQQ6bHR+8lHKGjU3O0NLzPm0J28+4qROdZP
        jXONh1Ybn90ZwnDIeKZwvIYLybs0XXg=
X-Google-Smtp-Source: ABdhPJyhV/k4uo4YaF+TqLOB5MYLItb/uyobaZg/U0XNwkySdqb5HFLgZuHE7SYtHh7L/c+mlUcgeQ==
X-Received: by 2002:a17:902:e747:: with SMTP id p7mr959240plf.61.1644862381897;
        Mon, 14 Feb 2022 10:13:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id iy13sm14489322pjb.51.2022.02.14.10.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 10:13:01 -0800 (PST)
Subject: Re: [PATCH 0/4] Broadcom STB PM PSCI extensions
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
 <20220203111435.e3eblv47ljkwkvwf@bogus>
 <34938793-cecc-2ad8-a4eb-81bb278ce9b5@gmail.com>
 <20220203185221.aw7kayj6qklmh5is@bogus>
 <06f84f27-973d-1dae-e2c3-3fda4e368331@gmail.com>
 <20220207162734.nt55nflwqstkej3p@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7c58b2c8-5ed8-4d2b-14cf-15dba8d672d9@gmail.com>
Date:   Mon, 14 Feb 2022 10:12:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220207162734.nt55nflwqstkej3p@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 8:27 AM, Sudeep Holla wrote:
> On Thu, Feb 03, 2022 at 11:33:26AM -0800, Florian Fainelli wrote:
>>
>>
>> On 2/3/2022 10:52 AM, Sudeep Holla wrote:
>>> Correction: it is known as "freeze" rather than "idle" in terms of values
>>> as per /sys/power/state. Sorry for referring it as "idle" and creating any
>>> confusion.
>>>
>>> On Thu, Feb 03, 2022 at 09:36:28AM -0800, Florian Fainelli wrote:
>>>>
>>>>
>>>> On 2/3/2022 3:14 AM, Sudeep Holla wrote:
>>>>> On Fri, Jan 21, 2022 at 07:54:17PM -0800, Florian Fainelli wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> This patch series contains the Broadcom STB PSCI extensions which adds
>>>>>> some additional functions on top of the existing standard PSCI interface
>>>>>> which is the reason for having the driver implement a custom
>>>>>> suspend_ops.
>>>>>>
>>>>>> These platforms have traditionally supported a mode that is akin to
>>>>>> ACPI's S2 with the CPU in WFI and all of the chip being clock gated
>>>>>> which is entered with "echo standby > /sys/power/state". Additional a
>>>>>> true suspend to DRAM as defined in ACPI by S3 is implemented with "echo
>>>>>> mem > /sys/power/state".
>>>>>
>>>>> How different is the above "standby" state compare to the standard "idle"
>>>>> (a.k.a suspend-to-idle which is different from system-to-ram/S3) ?
>>>>
>>>> There are a few differences:
>>>>
>>>> - s2idle does not power gate the secondary CPUs
>>>>
>>>
>>> Not sure what you mean by that ? S2I takes CPUs to deepest idle state.
>>> If you want shallower states, one possible option is the disable deeper
>>> states from the userspace.
>>
>> What I mean is that we do not get to call PSCI CPU_OFF here so the CPUs are
>> idle, but not power gated. Those CPUs do not have any other idle state other
>> than WFI because the HW designers sort of forgot or rather did not know that
>> wiring up the ARM GIC power controller back to the power gating logic of the
>> CPU was a good idea.
>>
> 
> Nice 😄
> 
>>>
>>>> - s2idle requires the use of in-band interrupts for wake-up
>>>>
>>>
>>> I am not sure if that is true. S2I behaves very similar to S2R except it
>>> has low wake latency as all secondaries CPUs are not hotplugged out.
>>
>> OK, the fact that secondary CPUs are not hot-plugged could be remedied by
>> doing this ahead of entering s2idle by user-space so this is not a valid
>> argument from me anymore.
>>
> 
> Fair enough.
> 
>>>
>>>> The reasons for implementing "standby" are largely two fold:
>>>>
>>>> - we need to achieve decent power savings (typically below 0.5W for the
>>>> whole system while allowing Wake-on-WLAN, GPIO, RTC, infrared, etc.)
>>>>
>>>
>>> I fail to understand how that is a problem from S2I. It is probably worth
>>> checking if there are any unnecessary IRQF_NO_SUSPEND users. Check section
>>> IRQF_NO_SUSPEND and enable_irq_wake() in [1]. I don't see any issues other
>>> wise in terms of unnecessary/spurious wakeup by in-band(to be precise
>>> no-wake up) interrupts.
>>
>> I don't think your hyperlink referenced by [1] was provided, but my quick
>> testing with:
>>
> 
> Yikes, I meant to refer Documentation/power/suspend-and-interrupts.rst
> 
>> echo s2idle > /sys/power/mem_sleep
>> echo mem > /sys/power/state
>>
>> appears to work to some extent when I use peripherals that can generate
>> in-band interrupts.
>>
>> It looks like we have s2idle_ops that allows a platform to override some of
>> the operations before/after entering s2idle, however the actual s2idle idle
>> loop is still within the kernel, so we will not call into the ARM Trusted
>> Firmware and engage the power management state machine.
>>
> 
> Correct.
> 
>> This means that there will not be any of the clock gating that only the
>> hardware state machine is capable of performing, the DRAM controller as a
>> result will not enter self refresh power down, and in addition the side band
>> wake-up interrupts will not be activate because the interrupt controller
>> that aggregates them only outputs to the ARM GIC when the state machine has
>> been engaged.
>>
> 
> One possible solution IIUC the issue is to add this as additional CPU Idle
> state disabled most of the time. Enable them from user-space just prior to
> calling freeze/s2idle, so that PSCI CPU_SUSPEND is called with right param
> to indicate this is deepest idle state(in your case just WFI) + DRAM self
> refresh/retention mode. Also TF-A can take care to enable the side band
> interrupts before entering the state.

Not knowing how to enable a disabled idle state from user-space, and
ensure that it does not race with cpuidle somehow choosing to enter that
state, I have all sorts of concerns about such interactions but can see
how this could be made to work. In fact, I am wondering if we had not
better off work around our broken HW and always advertise that state,
and just let cpuidle pick that "deep" idle state resulting in powering
down secondary core(s). In TF-A we would have to ensure that we save all
of the SPIs affine to that particular core, and probably re-configure
the PPIs and SGIs to be made secure such that TF-A can "trap" them and
wake-up the core that was just powered off.

It sounds like for your suggested approach plus requesting to enter
s2idle, we need to start trapping WFI at ELx into EL3 such that TF-A has
a chance of observing that all CPU cores are powered down and/or idle
and then can engage our power management state machine hardware to clock
gate the system and mux in the out of band interrupts. Unless the boot
CPU's default idle state has to either be modified, or we have to
advertise an additional "deeper" idle state that involves calling into
TF-A with PSCI CPU_SUSPEND, too?

What I really like about our approach other than it has been proven to
work over the past 10 years, is that it fits well with Linux system
suspend path via suspend_ops, with each layer taking care of defining
its points of no return etc. We know how to debug it, and it is not
opportunistic unlike cpuidle, which makes it easier to control. From a
non technical point of view, it is also the devil people are used to,
and no matter how we shape it, there will be resistance to change.

> 
> Do you see any issue with this approach ? I am trying to find ways to avoid
> deviating from standard PSCI.

Re-reading the PSCI specification and the SYSTEM_SUSPEND specifically it
does sound like ACPI S2 was taken into account but that lead to
SYSTEM_SUSPEND not allowing to differentiate between these two states on
the premise that "In practice, operating systems use only one suspend to
RAM state, so this is not seen as a limitation". It would have been nice
to leave provision for defining both instead of not.

I am sympathetic to avoid divergence of both interpretation and
implementation of the PSCI specification and its reference
implementation in Linux. So I can see a few paths forward:

- have me try what you suggested, which will take me weeks because I
have a TODO list long like my arm (and my arms are really long),
assuming that this even works for our use cases

- work with you to amend the PSCI specification such that we can
differentiate between an entry into S2 or S3 by defining which state we
want to enter, but I assume we will get lots of resistance here?
-- 
Florian
