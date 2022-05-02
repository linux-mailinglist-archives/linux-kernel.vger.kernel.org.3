Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB7517869
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387474AbiEBUqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387312AbiEBUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:46:09 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B9C25EE;
        Mon,  2 May 2022 13:42:36 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id r8so16380676oib.5;
        Mon, 02 May 2022 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=NfTVVuJGK7HPWRO8re3dSdZJZsANWobn7xRaMZwdRgs=;
        b=j4Kic+U993VMoJFYYnHWikYxgCDD1/RbjGd+6BXltS4jVaVOMOTp07dm3wIpYljzbO
         MJDr9ozR7CEG1NwFguZSnXbfn+LXPXAvRjZQ+Cce+FuOMNH4MqYpZM1zuQS9clKbnLMz
         gcSKS8hZln7I/UocoVz5OQTfQCafqM9Gq7bF1skD0Up0NijgIff66MIuiZu4uB8y6ych
         LssrBXM0cEBIMt401dTlbQpPXTU4ayofxX1dHPANoJJw656dLzwwfbffutwtHhN2vtOK
         ScHJ+yb3HOVlFlz2NW4z3u25RA9qq26hTrQiwrem9kIEryKfm+HSwgs2WR7aHxMvqFMH
         iuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=NfTVVuJGK7HPWRO8re3dSdZJZsANWobn7xRaMZwdRgs=;
        b=LEBQKF9I0HVGvGUyD9O0gKPAk+8i5AH8gAegaIVdLlHP16mXye3JvfQrdYhv2Vad4w
         pasoXscMqv1m3L7y/Dy6nr0DR2Byg3TAey2GwBtHuTdUXrzr1CSQUeurylfPNqeJNN12
         9PTknIPI0rQ2PwtY82+0/0SZZ6/H/BdBjy6Q/VfnkKSQ9AJZthuPVoeAqcRnqALu2101
         gt4xlSHwAV98hWUY0064nI54cD1GB9eAJnpknYWfh5Lrap1BA5AN5gleOVd+UfuIiMQ1
         m09UAScRL0jMO7XuStu0Th4D1eDB3PCgY5riXHC2blmV0n4RskpbdrCqFs5rOlZgi3ta
         JSDg==
X-Gm-Message-State: AOAM532YgrwgoGQak1zFNV/3Or4y8VYWDhFX8DXap+h3xMejgSJsEBxw
        6PfUYHaPpcF1UGPqAiwehwc=
X-Google-Smtp-Source: ABdhPJxpA+X4fMZKCx608iLQsBUR4RCAPEU9xXqOBTVp+E1w4DKVZyFw0IDt9ETEfzjhPsoCi8PNig==
X-Received: by 2002:a05:6808:1b0e:b0:325:c254:9aef with SMTP id bx14-20020a0568081b0e00b00325c2549aefmr469340oib.164.1651524155607;
        Mon, 02 May 2022 13:42:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w2-20020a056830110200b006060322127esm3245360otq.78.2022.05.02.13.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 13:42:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dabc2be2-36ce-a9d4-8aa5-ae3f2a57f904@roeck-us.net>
Date:   Mon, 2 May 2022 13:42:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, LABBE Corentin <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220502124249.682058-1-clabbe@baylibre.com>
 <20220502124249.682058-2-clabbe@baylibre.com>
 <0b154a30-7765-e3ac-9980-0ecc7447d7ad@roeck-us.net> <YnAqDxfTU27USQI+@Red>
 <1b2bf215-faa1-649d-5ab4-85fc0b907ec2@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
In-Reply-To: <1b2bf215-faa1-649d-5ab4-85fc0b907ec2@gmx.de>
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

On 5/2/22 13:31, Armin Wolf wrote:
> Am 02.05.22 um 20:59 schrieb LABBE Corentin:
> 
>> Le Mon, May 02, 2022 at 06:34:44AM -0700, Guenter Roeck a écrit :
>>> On 5/2/22 05:42, Corentin Labbe wrote:
>>>> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
>>>> So let's convert the driver to use hwmon_device_register_with_info().
>>>>
>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>> ---
>>>>    drivers/hwmon/acpi_power_meter.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
>>>> index d2545a1be9fc..98293727f980 100644
>>>> --- a/drivers/hwmon/acpi_power_meter.c
>>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>>> @@ -891,7 +891,10 @@ static int acpi_power_meter_add(struct acpi_device *device)
>>>>        if (res)
>>>>            goto exit_free_capability;
>>>>
>>>> -    resource->hwmon_dev = hwmon_device_register(&device->dev);
>>>> +    resource->hwmon_dev = hwmon_device_register_with_info(&device->dev,
>>>> +                                  ACPI_POWER_METER_DEVICE_NAME,
>>>> +                                  NULL, NULL,
>>>> +                                  NULL);
>>> NACK. That isn't a conversion to the new API, it just abuses the fact
>>> that the new API has to accept a NULL info pointer for historic reasons.
>>>
>> Hello
>>
>> I am sorry, I found a driver doing it, so I believed it was okay.
>> Converting seems not to hard but, by using the new API, how can I convert power1_model_number/power1_is_battery attribute ?
>> There are the remaining attributes I dont find how to convert.
>>
>> Regards
> 
> Hi,
> 
> for allowing the driver to provide nonstandard attributes, hwmon_device_register_with_info()
> has the argument "extra_groups" which is an pointer to a list of sysfs attribute groups.
> There are some drivers which are using this functionality, maybe you can use them as an
> inspiration.
> 
> Just a question: what is the name of the driver you originally used as an inspiration?
> 

Originally it was for drivers/thermal/thermal_hwmon.c. Now there is also
drivers/platform/mips/cpu_hwmon.c which is clearly an abuse. I may have
missed others.

Guenter
