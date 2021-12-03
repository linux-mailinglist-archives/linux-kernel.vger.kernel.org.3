Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3C2467F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354132AbhLCVnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLCVnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:43:01 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B84C061751;
        Fri,  3 Dec 2021 13:39:36 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t19so8386563oij.1;
        Fri, 03 Dec 2021 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZyNCIgbiIUOsipewSvB8dSHnTmGN087PJADPNaEzhY0=;
        b=S7F9W7eDO6jsIw3246StQzBS+HGkMuuEuUoNVdlPPKe8Ja3zbROrmY7tJeOpNf5pKm
         LWOJPqNg1mC25OgMfI5BhwokJoUpRJoAwGQfentShI0NMgZuWZwx1ePj7Gayxd4ISJLK
         tNsHYf/Qi3ND6pc46PGHvxd1CcSjRdm2BNTfm6Vk6xtwRLir+949wxzSQd4u2rAgLKaJ
         27qs7a1XVaqrM1cDEvWcH1ODGxwAKsbAPPLJSjdwKl0NuE1D6wu2z51Ezu57WV4uEj8K
         pMh6fRwthx+tkY6VnRrvBHjZXIDbbqHL1Qk+4fRD502zYKw/muhhHiH5vrjelJB/f9kk
         3Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZyNCIgbiIUOsipewSvB8dSHnTmGN087PJADPNaEzhY0=;
        b=5ScrDPQ4UkPV0WcXdPMuoXV/dK0Drq5zRBcP/Dkf4u6VnXbg//wwUSQRCCTYi0R+xG
         DzwMPX+sdQyU4dv8LYuF1bPAqf6tVWAghKQruz6ajJ4/43JuGI/MMmAk7Hp1Kd8agCf0
         QOxsZ5nit+vRurcRkVgya/sK+cLkY6NJw6JRVvc2qivTOQyPSAtBuTpATZRw/KDL6eG4
         PasI+bl/c64Ef3yenUq0i2L+hplX68QrYijEoOsuvCh61ljS7kG2oOGoQ0qg6aQ4O4oM
         jbMzo2fiu4I2EVfjgPTIN1TP/IdMCgtDzYO4fRaJux/V+luyq8aEXkkm/g/+yp4Ddgf7
         b35g==
X-Gm-Message-State: AOAM5332J8nvwJCa3EPGfjGXos2wQ6cENwbM9mi8GYE7BvRGYfXjCcIA
        zeguZ38MyujIH1qrRIEECVraZycHy5M=
X-Google-Smtp-Source: ABdhPJwK2AaO9PxR5ndkWa/sJyuxW6vQyapK7lFhRRL6gQ+wQVkhDWzh/ALnOAWSd4619q3h970Cbw==
X-Received: by 2002:a05:6808:2324:: with SMTP id bn36mr11712695oib.131.1638567575896;
        Fri, 03 Dec 2021 13:39:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n22sm802920oop.29.2021.12.03.13.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 13:39:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 1/2] watchdog: Add watchdog driver for Sunplus SP7021
To:     =?UTF-8?B?eHQuaHVb6IOh5YWI6Z+sXQ==?= <xt.hu@cqplus1.com>
Cc:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
References: <20211112105952.216280-1-xt.hu@cqplus1.com>
 <20211124104149.361019-1-xt.hu@cqplus1.com>
 <20211124104149.361019-2-xt.hu@cqplus1.com>
 <20211124142522.GA3939252@roeck-us.net>
 <0024d27919c04c84a3f13ecba86a3c70@cqplus1.com>
 <f69d663a-982b-5876-08c9-b1a4f35e8098@roeck-us.net>
 <8604284aa38d4ab6bc263d4881107e13@cqplus1.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <de9665a9-5fe0-7f57-d281-1b11455f7016@roeck-us.net>
Date:   Fri, 3 Dec 2021 13:39:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8604284aa38d4ab6bc263d4881107e13@cqplus1.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/21 11:57 PM, xt.hu[胡先韬] wrote:
> 
>> -----Original Message-----
>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
>> Sent: Thursday, November 25, 2021 12:26 PM
>> To: xt.hu[胡先韬] <xt.hu@cqplus1.com>
>> Cc: wim@linux-watchdog.org; p.zabel@pengutronix.de; linux-kernel@vger.kernel.org;
>> linux-watchdog@vger.kernel.org; robh+dt@kernel.org; devicetree@vger.kernel.org; Wells Lu 呂芳騰
>> <wells.lu@sunplus.com>; qinjian[覃健] <qinjian@cqplus1.com>
>> Subject: Re: [PATCH v2 1/2] watchdog: Add watchdog driver for Sunplus SP7021
>>
>> On 11/24/21 6:42 PM, xt.hu[胡先韬] wrote:
>>> Hi
>>> 	Thanks for your review. I explain this in detail below the comment.
>>>
>>> Best Regards,
>>> Xiantao
>>>> -----Original Message-----
>>>> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
>>>> Sent: Wednesday, November 24, 2021 10:25 PM
>>>> To: xt.hu[胡先韬] <xt.hu@cqplus1.com>
>>>> Cc: wim@linux-watchdog.org; p.zabel@pengutronix.de; linux-kernel@vger.kernel.org;
>>>> linux-watchdog@vger.kernel.org; robh+dt@kernel.org; devicetree@vger.kernel.org; Wells Lu 呂芳
>> 騰
>>>> <wells.lu@sunplus.com>; qinjian[覃健] <qinjian@cqplus1.com>
>>>> Subject: Re: [PATCH v2 1/2] watchdog: Add watchdog driver for Sunplus SP7021
>>>>
>>>> On Wed, Nov 24, 2021 at 06:41:48PM +0800, Xiantao Hu wrote:
>>>>> Sunplus SP7021 requires watchdog timer support.
>>>>> Add watchdog driver to enable this.
>>>>>
>>>>> Signed-off-by: Xiantao Hu <xt.hu@cqplus1.com>
>>>>> ---
>>>>> +
>>>>> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
>>>>> +	if (IS_ERR(priv->base))
>>>>> +		return PTR_ERR(priv->base);
>>>>> +
>>>>> +	/* The registers accessed here shared by multiple drivers. */
>>>>> +	wdt_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>>>
>>>> This is unusual. Why would other drivers access WDT_CTRL and WDT_CNT registers, and how is it
>>>> ensured that the other drivers do not interfer with the accesses by this driver ?
>>>>
>>>> Normally such a resource would be shared through a parent driver with appropriate access functions
>> to
>>>> ensure that accesses are synchronized.
>>>>
>>>
>>> The register used by this driver consists of two parts. The first part which contains WDT_CTRL and
>> WDT_CNT
>>> registers is exclusive by watchdog.
>>> In specially, the second part is belong to a multifunctional register group which control IP and bus.
>> Refer to
>>> register manual below:
>>> -------------------------------------------------------------------------------------------------------------------------------------------------
>>> MO1_STC_WDG_RST_EN	4	RW		STC Watchdog Timeout Trigger System Reset Enable
>>> 									0: STC watchdog 2 timeout will not trigger system
>> reset(default)
>>> 									1: STC watchdog 2 timeout will trigger system reset
>>> MO1_RI_WDG_RST_EN		1	RW		RBUS Watchdog Timeout Trigger System Reset Enable
>>> 									0: RBUS watchdog timeout will not trigger system
>> reset(default)
>>> 									1: RBUS watchdog timeout will trigger system reset
>>> MO1_TIMER_STAND_BY_EN	0	RW		Timer Standby Mode Enable
>>> 									0: Disable (default)
>>> 									1: Enable Active high to enter timer standby mode,
>>> 											default not in standby mode
>>> -------------------------------------------------------------------------------------------------------------------------------------------------
>>> You can see that in addition to the bits for watchdog there are bit fields for other modules.
>>> I use this register bit4 and bit1. Default value is 0 that watchdog internal interrupt signal can't trigger
>> system
>>> and RBUS reset. I need set 1 when watchdog probe. Early I implement the operation in
>>> arch/arm/mach-sunplus/sp7021.c and configure by macro. But in arch/arm64, directory mach-XXX is
>> removed.
>>> So I solve in this way. Any better way?
>>>
>> If the register at 0x9C000274 is accessed by other drivers, accesses
>> to it must be protected against each other to avoid race conditions.
>> How to do that would be up to you.
>>
> Hi Guenter,
> 
>  From the perspective of software, 0x9C000274 is only accessed during
> driver probe. If the driver is build-in and only one core is running at kernel
> startup. There is no competition.
> The only possibility of an error is to compile the driver into a module. In this
> case, the register at 0x9C000274 offer MASK_BITS[31:16] which write valid
> bit for each LSB 16 bits. Refer to the define in driver:
> #define MASK_SET(mask)		((mask) | (mask << 16))
> Even if both drivers access the register at the same time, the instructions are
> executed in order on the RBUS. So as long as the same bit in the same register
> is not accessed at the same time, no error will occur.
> 

This is inherently risky and racy. I am sure there is a better way to solve this
without risking race conditions, but I don't have time to analyze it further.
The above rationale needs to be added in detail to the driver as comments,
including references to all other drivers accessing the same register or
memory space.

Guenter
