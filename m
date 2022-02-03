Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5144A8C79
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 20:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbiBCTdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiBCTd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:33:29 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E0FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 11:33:29 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so6356379pjy.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HA6cR0nEJDsnEGV7RaetJNIMdyMuEqKH+709PhZfTEM=;
        b=X59QHLk2MCZ/rRU+oxC0IDOR+8Ik3wA6oGbIJYWcd4+Sw1Zc3EgOmjAa1HdIN/8WxL
         xgiLxfe02uFZGdE00XxZLAJIlR8vg035g7teKJOKPg6p79oyEh1TvdVgwasdHzaT839v
         GkbvTnvWCFfbRCLGxa0UmPTxux3SOHQk6LZ4n2wt7wZdj64SGut72cOenfO/p4EFBwuX
         9/dpjnVgNCgqKvh7SBiU9XE9JCj70QvObhxXADJ3JBeeODqIAIgje8s5vr1QjIuwyFj6
         jebwCYoHWlKSk2QzyaOD1KNV8dlzgvY+LCwlXppcs1+ExGswZWrKff9v5MK832ZCpTSA
         +g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HA6cR0nEJDsnEGV7RaetJNIMdyMuEqKH+709PhZfTEM=;
        b=giMjg+0FwEoBti8ycUGQWcmYtNKnzs1AV0lvoHxcKc5FDb5IZDJM8QitAKhAywfPAi
         yDIxjJWdDJttehDGLY9fDOyZhfTmrsWq26pJaKDDhPjEGrN0KDnGe7AmLkyq3fcOz4Ri
         GgENa2dWgUpHct6PNA1tGjkKAnscBmGAkILwnLqWa/uWkVL7UKuj/hkx/Db1WeUPZyAI
         xM7S+N3Grl2EU6ki913T8wsjKssaOlnsnHKeCRXVjX/eVZMAhVs8423uPyPPB3h7gI6E
         DrjvcTihzxLn9HpUsuKV9DOgDvyZ0CqMB8NqnYoreKWPuU5pAUAZOkO701fKXTqYulGW
         Naig==
X-Gm-Message-State: AOAM531sZuVuTxhxLQRQPGcXfy9aDMyhHdmiop/Cy/o41D4OXpQ8/hQ1
        G8Os+PBBU2OxcS4t4ODgAF4=
X-Google-Smtp-Source: ABdhPJzX77nVuTx7JfL6dbwmVusLGqFgugAEeb3xPrs5GgivQvdwTHB9qDVu6ZOedgwWgtHEzMFWTA==
X-Received: by 2002:a17:902:ecc2:: with SMTP id a2mr36255795plh.12.1643916809134;
        Thu, 03 Feb 2022 11:33:29 -0800 (PST)
Received: from [10.230.2.160] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id nm14sm10700616pjb.32.2022.02.03.11.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 11:33:28 -0800 (PST)
Message-ID: <06f84f27-973d-1dae-e2c3-3fda4e368331@gmail.com>
Date:   Thu, 3 Feb 2022 11:33:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] Broadcom STB PM PSCI extensions
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220203185221.aw7kayj6qklmh5is@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2022 10:52 AM, Sudeep Holla wrote:
> Correction: it is known as "freeze" rather than "idle" in terms of values
> as per /sys/power/state. Sorry for referring it as "idle" and creating any
> confusion.
> 
> On Thu, Feb 03, 2022 at 09:36:28AM -0800, Florian Fainelli wrote:
>>
>>
>> On 2/3/2022 3:14 AM, Sudeep Holla wrote:
>>> On Fri, Jan 21, 2022 at 07:54:17PM -0800, Florian Fainelli wrote:
>>>> Hi all,
>>>>
>>>> This patch series contains the Broadcom STB PSCI extensions which adds
>>>> some additional functions on top of the existing standard PSCI interface
>>>> which is the reason for having the driver implement a custom
>>>> suspend_ops.
>>>>
>>>> These platforms have traditionally supported a mode that is akin to
>>>> ACPI's S2 with the CPU in WFI and all of the chip being clock gated
>>>> which is entered with "echo standby > /sys/power/state". Additional a
>>>> true suspend to DRAM as defined in ACPI by S3 is implemented with "echo
>>>> mem > /sys/power/state".
>>>
>>> How different is the above "standby" state compare to the standard "idle"
>>> (a.k.a suspend-to-idle which is different from system-to-ram/S3) ?
>>
>> There are a few differences:
>>
>> - s2idle does not power gate the secondary CPUs
>>
> 
> Not sure what you mean by that ? S2I takes CPUs to deepest idle state.
> If you want shallower states, one possible option is the disable deeper
> states from the userspace.

What I mean is that we do not get to call PSCI CPU_OFF here so the CPUs 
are idle, but not power gated. Those CPUs do not have any other idle 
state other than WFI because the HW designers sort of forgot or rather 
did not know that wiring up the ARM GIC power controller back to the 
power gating logic of the CPU was a good idea.

> 
>> - s2idle requires the use of in-band interrupts for wake-up
>>
> 
> I am not sure if that is true. S2I behaves very similar to S2R except it
> has low wake latency as all secondaries CPUs are not hotplugged out.

OK, the fact that secondary CPUs are not hot-plugged could be remedied 
by doing this ahead of entering s2idle by user-space so this is not a 
valid argument from me anymore.

> 
>> The reasons for implementing "standby" are largely two fold:
>>
>> - we need to achieve decent power savings (typically below 0.5W for the
>> whole system while allowing Wake-on-WLAN, GPIO, RTC, infrared, etc.)
>>
> 
> I fail to understand how that is a problem from S2I. It is probably worth
> checking if there are any unnecessary IRQF_NO_SUSPEND users. Check section
> IRQF_NO_SUSPEND and enable_irq_wake() in [1]. I don't see any issues other
> wise in terms of unnecessary/spurious wakeup by in-band(to be precise
> no-wake up) interrupts.

I don't think your hyperlink referenced by [1] was provided, but my 
quick testing with:

echo s2idle > /sys/power/mem_sleep
echo mem > /sys/power/state

appears to work to some extent when I use peripherals that can generate 
in-band interrupts.

It looks like we have s2idle_ops that allows a platform to override some 
of the operations before/after entering s2idle, however the actual 
s2idle idle loop is still within the kernel, so we will not call into 
the ARM Trusted Firmware and engage the power management state machine.

This means that there will not be any of the clock gating that only the 
hardware state machine is capable of performing, the DRAM controller as 
a result will not enter self refresh power down, and in addition the 
side band wake-up interrupts will not be activate because the interrupt 
controller that aggregates them only outputs to the ARM GIC when the 
state machine has been engaged.

Essentially, what we need for our systems is a controlled system entry 
with semantics similar if not identical to that of S2R but with a 
shallower state that does not cut the power to 90% of the SoC (unlike 
S2R) such that we have a quicker suspend and resume latency. Years ago 
when we only had MIPS-based and 32-bit ARM SoCs, we did come up with 
using "standby" (see drivers/soc/bcm/brcmstb/pm/*) and we naturally 
mapped that when we switched over to ARMv8 capable devices.

> 
>> - we have a security subsystem that requires the CPUs to be either power
>> gated or idle in order the hardware state machine that lets the system enter
>> such a state and allows the out of band interrupts from being wake-up
>> sources
>>
> 
> It should work unless I have completely misunderstood how S2I works.
> 
>>> Suspend to idle takes all the CPUs to lowest possible power state instead
>>> of cpu-hotplug in S2R. Also I assume some userspace has to identify when
>>> to enter "standby" vs "mem" right ? I am trying to see how addition of
>>> "idle" changes that(if it does). Sorry for too many questions.
>>>
>>
>> Right that user-space in our case is either custom (like RDK, or completely
>> custom), or is Android. For Android it looks like we are carrying a patch
>> that makes "mem" de-generate into "standby" but this is largely because we
>> had historically problems with "mem" that are being addressed (completely
>> orthogonal).
>>
> 
> Thanks for the info.
> 
>> I did not consider it as a viable option at the time, but if we were to
>> implement "standby" in drivers/firmware/psci/psci.c would that be somewhat
>> acceptable?
>>
> 
> We have been pointing anyone needing standby so far to S2I and so far no one
> has shouted that it doesn't suffice. Let me know what is missing.
> 

-- 
Florian
