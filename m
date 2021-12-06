Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0719469065
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbhLFGdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbhLFGdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:33:03 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64565C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 22:29:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o13so20095981wrs.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 22:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8i0b0I7+JAN8akfi4yH/EpAwbNd4wK1xiq3g0OxfM/k=;
        b=wUC7JB6oQGyvVX8r8bI/LKwklMbtmNfpC1Gh8cDQofecox9V1fE7MaWuVbBDuRyvB2
         TNwzzYg21IgJLV2/Rtp6BsT8WhgRHDzn+fDHFXljbXwuGkYnyzzqRy6VTDuf1dsfbGft
         yhnSyR8sipZ8USFNvewvZh4vVJEyuorb92PpF+hhVAzKD1YzDOJVDhR35PyDTKOqcWJH
         DTMvtRAZGGTuWXTTT3VEk8UgmrS+spGdDSMO9rdZ9FO/3k0zsN/mMHhaVnRe+fOZ/CzE
         BPAQnjj/R0vA7isQxQuB8xsV24uPOMz07Ey8sIN0wP9OG4GCT8cl32JdWrJ+4G3QLnJF
         X6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8i0b0I7+JAN8akfi4yH/EpAwbNd4wK1xiq3g0OxfM/k=;
        b=Sd8Rwp8IljAfAja1Mp2EnN2CDlu2n6L9+N8gaPNMFoVNEntQrtHVWbE0yqoTyCxxEK
         E+OYf6b1jhN0iKPHw49aPGsVx6MuAhXFCSVMiYsVO7Ujy1/0nHeMmCIxpsfvCS062kcS
         Jvoc3WdmCnon8U5cKX6GmMWdHt6+DOQqAgRWTQ3oJlul9xd2W0YXAtPqV12g4FVzvTu3
         qJXA/TPufmiMwW6W4Vqzxrqz1Qs9TNdnQnbNu1KhtTwsLYeDOzajwRnqDIf7eo1N73K2
         /bnQksdNal2YCooIW0uRTyFzbGULhU6wq9ax89ETKzq2lztoJwBu0wRw7M6EuJ2+HOpW
         Go7g==
X-Gm-Message-State: AOAM532Kx9dtacOxPutP1jzK32G2oDVqvaQR5Mc05Sqb3CydAxfq7qLj
        FRPWXlWyDjt9BeG//9hqPN3ajg==
X-Google-Smtp-Source: ABdhPJw2uNRAq2WyHZXjIaANSn9ebaC7mhqP6jCDTRPs2lvrQIHlTG9w72bjYT6o3FOGXd6jcbdI1g==
X-Received: by 2002:a5d:400e:: with SMTP id n14mr39130399wrp.368.1638772173863;
        Sun, 05 Dec 2021 22:29:33 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:1cec:4235:bb04:b944? ([2a01:e34:ed2f:f020:1cec:4235:bb04:b944])
        by smtp.googlemail.com with ESMTPSA id l8sm13846781wmc.40.2021.12.05.22.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 22:29:33 -0800 (PST)
Subject: Re: Time: new clocksource
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
References: <CAHhAz+jpmksehY4BSH9jJPYuY+jykSHtx9TNiG-gAkq10zaXSQ@mail.gmail.com>
 <fe9dbf81-e060-36ab-b769-215af3d65ba7@linaro.org>
 <CAHhAz+iEQTtfxXB8sNEL4WxFjUZo5LYTo4EVyH0mT2=NH3VaUA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a5192a80-0401-78fd-6fb3-e58a3b5a3923@linaro.org>
Date:   Mon, 6 Dec 2021 07:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHhAz+iEQTtfxXB8sNEL4WxFjUZo5LYTo4EVyH0mT2=NH3VaUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 07:00, Muni Sekhar wrote:
> On Sat, Dec 4, 2021 at 3:18 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> Hi Sekhar,
>>
>> On 03/12/2021 17:50, Muni Sekhar wrote:
>>> Hi All,
>>>
>>> We have a Digital PLL with 64 bit timer counter hardware and the
>>> counter is accessible from the CPU over the PCIe bus.
>>>
>>> Is it possible to add this timer counter hardware as new clocksource
>>> driver? To do this, can someone please point me to the existing
>>> reference source code(or patch) for this task.
>>
>> You can refer to the drivers located in drivers/clocksource
> I don't see the option in menuconfig to build the clocksource driver
> as a loadable kernel module, for example CONFIG_X86_PM_TIMER=m instead
> of CONFIG_X86_PM_TIMER=y.
> So a clocksource driver should always be part of the kernel built-in
> module?

Yes, that is the case today.

> If so, what's the reason for that?

The timer is a component needed at boot time, so a module version does
really not make sense.

So I would return back the question : what is the reason for a module?


>> git annotate on one of the driver can give you the initial commit where
>> recent submissions explain the timer internals.
>>
>>> Suppose if it is possible to add a new clocksource driver for this
>>> hardware then does any userspace get_timestamp* API would get the time
>>> from this new hardware?
>>
>> It should if the timer is selected as the clocksource
>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
> 
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
