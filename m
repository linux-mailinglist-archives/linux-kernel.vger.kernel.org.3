Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2846C80E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239634AbhLGXSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhLGXSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:18:51 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A855C061574;
        Tue,  7 Dec 2021 15:15:21 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so831349otv.9;
        Tue, 07 Dec 2021 15:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bES/GU9/Gr59OqsaNMJp8pnGLgUSxAf2mbHy46Olebc=;
        b=ID+7HiS1TynVfygEwQgIrK0URpV4ca5jzknz9N6/M30yLi/lux9++xlsf7Wo4C+/3s
         itDNXNSGjbfXTcvgYsODK/qQ7+OdstuYtlRm666wAq6LCYSEGoPSWJbD5TeQ+moZpFPD
         kZChBQ7t5AKNQQLVgxWoRh80EKm36fc1I3waNA3GePej1eTBZUraeIeZVEFuNdYUjxNK
         e5iJ9Mtg15n8y/iStJrZVC6ffkhc59r/57sUuYShLMB063MVeLrxgrtOrFoXvD0Tp2Wc
         eq+5E9Mt28eNovq08ZnIjoqEoc4vPrtQzJy88F7lOY+J/t/ODiyhunVWPiik2mc0vFDU
         trcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bES/GU9/Gr59OqsaNMJp8pnGLgUSxAf2mbHy46Olebc=;
        b=Zo3HzydBVh3me2yxk93ThMhjfqRTEvNWuKItQEpH+/RjSBvSKCJpaQH1wkLCSK1jqK
         C1oxOb++DMT7FTQ14roBFwXq/4tsR7O6YDt3qUFPGkTBtIp2SUXK16c9RIjwIwQ8Mgf5
         4xBJfGQ8iJM5Qyp4P6qMbuxoXOkVo5Q2D4zSiJXOfCE+JYPFy6Xm2IUR61qFmKLFi6vo
         E6yatb4BzQltkm2ZvksQeYKn6MyCQrVg0Gke5G0bNAc6NJC4EVQ7okEAYT5At+bSiZ8t
         ivMQ3RkoxIC7bFzb/dTU36Y/+0Vdz4R78hZL5wI+NH9ifUBrB6Lz/KM7ZObxP14KZf03
         MScQ==
X-Gm-Message-State: AOAM531FdTQzJRjp4p/KA/NBgvxEZnPdTIfIcd7zn78Ptj5bpDpoPcKu
        4IgM1nsHFLnDSYZjwNiAUIPBef2Xd5Q=
X-Google-Smtp-Source: ABdhPJzJ4yb6o16nmblWRj2GOq9gCTslgvafxiZXLRoTUQV4dR37/lYV18MRhYrFIKsJt7hyV8BLCw==
X-Received: by 2002:a9d:1b0:: with SMTP id e45mr36620695ote.23.1638918920222;
        Tue, 07 Dec 2021 15:15:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f12sm179471ote.75.2021.12.07.15.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 15:15:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20211207071521.543-1-zev@bewilderbeest.net>
 <20211207071521.543-2-zev@bewilderbeest.net>
 <20211207175015.GA772416@roeck-us.net>
 <Ya+0YDWIRBQFnEDb@hatter.bewilderbeest.net>
 <f30241ad-f3c4-ee78-22f3-405401615b61@roeck-us.net>
 <Ya/X46owU78iVbSO@hatter.bewilderbeest.net>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus) Add Delta AHE-50DC fan control
 module driver
Message-ID: <abc2e3bc-3806-dbd3-840c-e19154bc0587@roeck-us.net>
Date:   Tue, 7 Dec 2021 15:15:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya/X46owU78iVbSO@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 1:53 PM, Zev Weiss wrote:
> On Tue, Dec 07, 2021 at 11:44:01AM PST, Guenter Roeck wrote:
>> On 12/7/21 11:22 AM, Zev Weiss wrote:
>>> On Tue, Dec 07, 2021 at 09:50:15AM PST, Guenter Roeck wrote:
>>>> On Mon, Dec 06, 2021 at 11:15:20PM -0800, Zev Weiss wrote:
>>>>> This device is an integrated module of the Delta AHE-50DC Open19 power
>>>>> shelf.  For lack of proper documentation, this driver has been developed
>>>>> referencing an existing (GPL) driver that was included in a code release
>>>>> from LinkedIn [1].  It provides four fan speeds, four temperatures, and
>>>>> one voltage reading, as well as a handful of warning and fault
>>>>> indicators.
>>>>>
>>>>> [1] https://github.com/linkedin/o19-bmc-firmware/blob/master/meta-openbmc/meta-linkedin/meta-deltapower/recipes-kernel/fancontrol-mod/files/fancontrol.c
>>>>>
>>>>
>>>> Hmm, that reference isn't really accurate anymore. I think it would be
>>>> better to just say that the device was found to be PMBus compliant.
>>>
>>> Sure, will do.
>>>
>>
>> Makes me wonder: How do you know that the referenced driver is for Delta AHE-50DC ?
> 
> We'd been waiting for the source code for the software it ships with for a while, and were finally provided with that repo; everything I've observed from the factory software is consistent with the code in that driver.  A sampling:
> 

I assume you mean "Delta AHE-50DC" when you refer to "it".

[ ... ]
>> Can you check this with real hardware, by any chance ?
>>
> 
> If you mean running that code on it, yes -- here's the userspace utility that invokes that library routine:
> 
>      root@bmc-oob:~# fan-util.sh
>      fan1 speed: 7860 RPM
>      fan2 speed: 7860 RPM
>      fan3 speed: 7620 RPM
>      fan4 speed: 7560 RPM
>      temperature1: 29.20 C
>      temperature2: 27.80 C
>      temperature3: 28.50 C
>      temperature4: 30.20 C
>      vin_undervolt_fault: no
>      overtemperature_warning: no
>      fan_fault: no
>      fan_warning: no
>      fan_status: ok
> 

That doesn't really tell me anything in the context of the driver you submitted.
Would it be possible to install your driver and provide the output from the
"sensors" command ? It should match the information from the proprietary
driver/tool.

Thanks,
Guenter


