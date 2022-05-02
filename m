Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582E2517AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiEBXt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiEBXsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:48:03 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CEE32046;
        Mon,  2 May 2022 16:44:18 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id l16so9492283oil.6;
        Mon, 02 May 2022 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MTteb5sMoZQoMYDC0F86+T8JJmRGlnCtTb7EX41wdAE=;
        b=bTKEVOi1LgUTsWANRXrxnTNJ3igDHbHVa6Pw6YgqbT50XukoLf45SgTavaDAAadHXH
         CF90ocCXfiD5yXMz0IRQYjfuEFdmKJFGix2SCeOJrG6wH7kFw/Apceft0tTckE6X2Hip
         +ccIMoUdTDDv+cxuiYqSy849+qx8aHrv4DexO0wxm+C4AH27j/Ha96BSrvhYRL7SV3kb
         PFBkOuBIEPErT2h/3s0JzgAs85Yh0WDLt7N3FANC+DMYZw68iry4EshsTdB6eNiaYJ3f
         Q1dZxopqI/Z3uk9+MShISuvj6z70ugF9jTAZxpMqwew3YYeG2mvBZxgjQHdzivafL02x
         PgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MTteb5sMoZQoMYDC0F86+T8JJmRGlnCtTb7EX41wdAE=;
        b=yJ5uL2H3eBIVlD2xyd3P/dSZOkKPwj+mwwRz96bErNSvgV2m5m6YFDNMMebdj2DgxS
         86uTyM/8P3Aprxl+l79t93luWgWZiMgSBXNGzGU8bSTgpuu2yCtVfMqRw6mIpdRISFs8
         J6f/6UGZNPnjFuDcCxzYqSkeuHg9RR3CYhEbG1mR+ZfQMVf1t2zq4t9FZzz0o6yvMyoK
         +hWe0vsn8Joj+ZcSZyi6TIvmMbHP9aJvbsqyn0B0YJsOJRtjxiSYic3igubRnkcpwdrq
         kJDth6PegMTNoMbQ7AcUt+RD4RDU9O60phRN7bckv9wGt6zkDWvMBYtMezTJo+rwKtL+
         a2hg==
X-Gm-Message-State: AOAM531KBKnftTazlOfAxx5eDrjUXEhkrucAITNwxfC84rhdzXoPd7+h
        MFRIo3x66/2c6WwaVZ2AxCI=
X-Google-Smtp-Source: ABdhPJzIwi2s9JFo/Xccrd150mB92nsm7xNAmRDeYenkL1WhAjpnvJ+Co11DNfrol85R4RG8c1JQjw==
X-Received: by 2002:a05:6808:124b:b0:2da:38f0:945f with SMTP id o11-20020a056808124b00b002da38f0945fmr725099oiv.171.1651535054959;
        Mon, 02 May 2022 16:44:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w10-20020a056830060a00b0060603221253sm3412819oti.35.2022.05.02.16.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 16:43:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <367acd5f-9130-f071-7146-21212b578043@roeck-us.net>
Date:   Mon, 2 May 2022 16:43:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, LABBE Corentin <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220502124249.682058-1-clabbe@baylibre.com>
 <20220502124249.682058-2-clabbe@baylibre.com>
 <0b154a30-7765-e3ac-9980-0ecc7447d7ad@roeck-us.net> <YnAqDxfTU27USQI+@Red>
 <1b2bf215-faa1-649d-5ab4-85fc0b907ec2@gmx.de>
 <dabc2be2-36ce-a9d4-8aa5-ae3f2a57f904@roeck-us.net>
 <72cce35f-a227-cd18-17f0-00eee350bcf4@gmx.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <72cce35f-a227-cd18-17f0-00eee350bcf4@gmx.de>
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

On 5/2/22 14:00, Armin Wolf wrote:
> Am 02.05.22 um 22:42 schrieb Guenter Roeck:
>> On 5/2/22 13:31, Armin Wolf wrote:
>>> Am 02.05.22 um 20:59 schrieb LABBE Corentin:
>>>
>>>> Le Mon, May 02, 2022 at 06:34:44AM -0700, Guenter Roeck a écrit :
>>>>> On 5/2/22 05:42, Corentin Labbe wrote:
>>>>>> Booting lead to a hwmon_device_register() is deprecated. Please
>>>>>> convert the driver to use hwmon_device_register_with_info().
>>>>>> So let's convert the driver to use hwmon_device_register_with_info().
>>>>>>
>>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>>> ---
>>>>>>    drivers/hwmon/acpi_power_meter.c | 5 ++++-
>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/hwmon/acpi_power_meter.c
>>>>>> b/drivers/hwmon/acpi_power_meter.c
>>>>>> index d2545a1be9fc..98293727f980 100644
>>>>>> --- a/drivers/hwmon/acpi_power_meter.c
>>>>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>>>>> @@ -891,7 +891,10 @@ static int acpi_power_meter_add(struct
>>>>>> acpi_device *device)
>>>>>>        if (res)
>>>>>>            goto exit_free_capability;
>>>>>>
>>>>>> -    resource->hwmon_dev = hwmon_device_register(&device->dev);
>>>>>> +    resource->hwmon_dev =
>>>>>> hwmon_device_register_with_info(&device->dev,
>>>>>> + ACPI_POWER_METER_DEVICE_NAME,
>>>>>> +                                  NULL, NULL,
>>>>>> +                                  NULL);
>>>>> NACK. That isn't a conversion to the new API, it just abuses the fact
>>>>> that the new API has to accept a NULL info pointer for historic
>>>>> reasons.
>>>>>
>>>> Hello
>>>>
>>>> I am sorry, I found a driver doing it, so I believed it was okay.
>>>> Converting seems not to hard but, by using the new API, how can I
>>>> convert power1_model_number/power1_is_battery attribute ?
>>>> There are the remaining attributes I dont find how to convert.
>>>>
>>>> Regards
>>>
>>> Hi,
>>>
>>> for allowing the driver to provide nonstandard attributes,
>>> hwmon_device_register_with_info()
>>> has the argument "extra_groups" which is an pointer to a list of
>>> sysfs attribute groups.
>>> There are some drivers which are using this functionality, maybe you
>>> can use them as an
>>> inspiration.
>>>
>>> Just a question: what is the name of the driver you originally used
>>> as an inspiration?
>>>
>>
>> Originally it was for drivers/thermal/thermal_hwmon.c. Now there is also
>> drivers/platform/mips/cpu_hwmon.c which is clearly an abuse. I may have
>> missed others.
>>
>> Guenter
> Should we notify the maintainers of cpu_hwmon.c about that?
> This could potentially prevent such incidents from happening again.
> 

I am more inclined to create a special API for thermal, call it from
the thermal code, and issue a warning with backtrace if anyone else
calls hwmon_device_register_with_info() with NULL info pointer.
And explain all that in detail in the API documentation.

Guenter
