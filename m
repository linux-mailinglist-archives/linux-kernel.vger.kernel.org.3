Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB335517BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiECCGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiECCGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:06:12 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BF03A737;
        Mon,  2 May 2022 19:02:41 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id s11-20020a4ab54b000000b0035f0178dfcfso527814ooo.7;
        Mon, 02 May 2022 19:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=GKaIcGp0RhRVxVeOdR17/W0HUq1CPb0cE7q5ZqqYxaM=;
        b=hkKItu6aecIhk/NoClNIjIXfNHvcfpFH3nuqsFRGYrP3YdsirumZ2LzJ9PNh7NVIGZ
         VOoIIumKjYVnqK4QXH2epsyXRaDaciIfoH3u/+6O/IkrjlvtLowF5cV8G+7az/aDjXBc
         v2pXcxkJjDUBdgM9V6HSQRZPiBZK0damBwQTohOvHM1k0pKMATy5/B+bpT4NjnGcz8+i
         BinW7941XVl1w9G+BMfWoWwrUWINPDYO5KfEn1IFsQMQaXGRyL4vl/PjunXgT7Dru+0L
         KmBFKsdN5OJ+encck6pPFGutZuvGmDhxFmdVd3B/WpCDIjoQISSRJKmvRmxZ20GJ9Cx/
         4Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=GKaIcGp0RhRVxVeOdR17/W0HUq1CPb0cE7q5ZqqYxaM=;
        b=lTleMH45+l7ZPXVmVvH7FJlPJHkQqp5IUwLk/lo6G8hNus0nvM/6k+awA9leZ3E34T
         bjp4dKuee61jK3PpdL0Ff4F0yQ+bLXedL4TOjrwj2K3oJ0EgAh8CFkyTO1GPX1bVITgB
         u/1MkE+w5+7DLDzPgfOxnjgoGxRo0Tm8iysUIVkDwgosk46eS1d2ur+OXdIf7O97h8F3
         2KOyIB+btZT9B1tYrB1OtP3yG7anQhH4ozraaDUgMb829P1QqO3NBXBXFkOFryd0nyPN
         omgBtWgwWUIYTBuBNrVeYW0UVDCiqEVNXSP2aTvnzqyy+PnJVElnQuvb9sK8GrYaWqaD
         b5mg==
X-Gm-Message-State: AOAM531Sl6SvIqs18nW7Vr2bmI669rzTqcRPUfnoCvjiHdlyWvLF+WaH
        L/+BTGgfR19U6nGsAbX5fRI=
X-Google-Smtp-Source: ABdhPJxaK6/fEsYQoxwG2euqp3NppH7nBXY7mGfszjaFfrhxufHTKgE1HNVh1sbsvF4hLjdsisEEmA==
X-Received: by 2002:a4a:2cd3:0:b0:35e:99e3:a497 with SMTP id o202-20020a4a2cd3000000b0035e99e3a497mr5071598ooo.86.1651543360153;
        Mon, 02 May 2022 19:02:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 95-20020a9d0668000000b0060626a8e5a4sm1090211otn.74.2022.05.02.19.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 19:02:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4aabfd63-18e2-65c5-d1c2-d7600afc1c40@roeck-us.net>
Date:   Mon, 2 May 2022 19:02:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Icenowy Zheng <icenowy@aosc.io>
Cc:     Ruslan Zalata <rz@fabmicro.ru>, Jean Delvare <jdelvare@suse.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <20220502110010.q7vvdkdpaiz5acjl@houat>
 <7433B295-D896-4BF8-87DF-87EB89D7A550@aosc.io>
 <20220502112112.3ne7zy4b6gggxzoo@houat>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
In-Reply-To: <20220502112112.3ne7zy4b6gggxzoo@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 04:21, Maxime Ripard wrote:
> On Mon, May 02, 2022 at 07:15:01PM +0800, Icenowy Zheng wrote:
>>
>>
>> 于 2022年5月2日 GMT+08:00 下午7:00:10, Maxime Ripard <maxime@cerno.tech> 写到:
>>> Hi,
>>>
>>> On Thu, Apr 28, 2022 at 09:09:03PM +0000, Ruslan Zalata wrote:
>>>> Some Allwinner SoCs like A13, A20 or T2 are equipped with two-channel
>>>> low rate (6 bit) ADC that is often used for extra keys. There's a driver
>>>> for that already implementing standard input device, but it has these
>>>> limitations: 1) it cannot be used for general ADC data equisition, and
>>>> 2) it uses only one LRADC channel of two available.
>>>>
>>>> This driver provides basic hwmon interface to both channels of LRADC on
>>>> such Allwinner SoCs.
>>>>
>>>> Signed-off-by: Ruslan Zalata <rz@fabmicro.ru>
>>>> ---
>>>>   MAINTAINERS                       |   6 +
>>>>   drivers/hwmon/Kconfig             |  13 ++
>>>>   drivers/hwmon/Makefile            |   1 +
>>>>   drivers/hwmon/sun4i-lradc-hwmon.c | 280 ++++++++++++++++++++++++++++++
>>>>   4 files changed, 300 insertions(+)
>>>>   create mode 100644 drivers/hwmon/sun4i-lradc-hwmon.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 5e8c2f61176..d9c71e94133 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -18861,6 +18861,12 @@ S:	Maintained
>>>>   F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
>>>>   F:	drivers/input/keyboard/sun4i-lradc-keys.c
>>>>   
>>>> +SUN4I LOW RES ADC HWMON DRIVER
>>>> +M:	Ruslan Zalata <rz@fabmicro.ru>
>>>> +L:	linux-hwmon@vger.kernel.org
>>>> +S:	Maintained
>>>> +F:	drivers/hwmon/sun4i-lradc-hwmon.c
>>>> +
>>>>   SUNDANCE NETWORK DRIVER
>>>>   M:	Denis Kirjanov <kda@linux-powerpc.org>
>>>>   L:	netdev@vger.kernel.org
>>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>>> index 68a8a27ab3b..86776488a81 100644
>>>> --- a/drivers/hwmon/Kconfig
>>>> +++ b/drivers/hwmon/Kconfig
>>>> @@ -1691,6 +1691,19 @@ config SENSORS_SIS5595
>>>>   	  This driver can also be built as a module. If so, the module
>>>>   	  will be called sis5595.
>>>>   
>>>> +config SENSORS_SUN4I_LRADC
>>>> +	tristate "Allwinner A13/A20 LRADC hwmon"
>>>> +	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
>>>> +	help
>>>> +	  Say y here to support the LRADC found in Allwinner A13/A20 SoCs.
>>>> +	  Both channels are supported.
>>>> +
>>>> +	  This driver can also be built as module. If so, the module
>>>> +	  will be called sun4i-lradc-hwmon.
>>>> +
>>>> +	  This option is not compatible with KEYBOARD_SUN4I_LRADC, one
>>>> +	  of these must be used at a time.
>>>
>>> How do you plan on enforcing that?
>>>
>>> I guess a better path forward would be to either register an hwmon
>>> device in the original driver, or convert that driver to iio and use
>>> iio-hwmon.
>>
>> I think this driver should be use IIO, and then try to probe an IIO input
>> if possible.
> 
> It's been a while, but if I remember well we couldn't use IIO for that
> driver because it's not generating interrupts all the time but only when
> it goes over a given threshold:
> 
> https://lore.kernel.org/all/52C5E9F1.9010700@redhat.com/
> 
> I'm not sure if it's still relevant, so we might just need to add an
> hwmon driver to the existing driver
> 

So now we have conflicting claims that the hwmon driver would need
to implement continuous interrupts because the chip otherwise doesn't
continuously measure ADC input, and that implementing an IIO driver
isn't possible or doesn't make sense because the chip would not support
generating continuous interrupts. Which one is it ? Am I missing something ?

Guenter
