Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2942528415
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbiEPMVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbiEPMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:21:36 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4CBD131;
        Mon, 16 May 2022 05:21:28 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id n24so18319801oie.12;
        Mon, 16 May 2022 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=CcyMGAd9/1/nrpJriv7ncUhfzEf1ScHvMZQfYObpwvE=;
        b=g2DUXy6qsD2CdHMeAsv1xhrChe7ErMle96kke/aIaRKpxIOquj2yfUB32FiKgTjM83
         t5tOhazH/nx8St5nSD/7JRztPm5oW8ykK9M6mxznlilW68CbwNMSF0pcaCGfoRS55jGu
         FsqQcbamE+ix9RsBHYWHS+gAzYe/fS1wBUGj/5JWxD+n7AMQDGqvtiea3XTZHwpe8qeT
         MNd1hGqFIpog6mQ1qReY+ToG+1QdObEmdjsmaMjr1TZ88vZRvRbwgxlytcW+FGfxr6BO
         9gOXxI+Vh4QcFLVlPge/BIeppXAw1j7qx2yVfR7oYoFU9XUCutTSnWiDbQBa+/BSRcxl
         a1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=CcyMGAd9/1/nrpJriv7ncUhfzEf1ScHvMZQfYObpwvE=;
        b=YI2g0+m+8avtgOrAbvgUl1Ncqsace4B+/2EJFo4RuXYm2xBEoGZafutDZrw1TSliBp
         SA2ra1dwas4I/mP6ELiWKrLv03UYIwmospKufraDk8eWvMOnw9NeSb5XRSi9GikIpf1B
         YzJkS41rhL9KfgnxfPJSsFVppTBPUkOO5DYxs9jhYnDLJGyXMG0opmDzJButun3coDzm
         V/LMaEl5WJ1eICzugnXVPGtSQnzCcVEv+j+BfU7yZnhdJ2bIuoWkdBijQKge0ew6Q3mm
         /MyN0CI2y31ZcLR9ZO5quX97pATuZ3laW0q7Yz+1sEZ7tVHFoWW+TOp2+QYUOl+UNPrq
         i2TA==
X-Gm-Message-State: AOAM531rJS2G66ixQtFWByvQ1UncQBeNx/3lZAAxN/5CLG+G4t/FdWzk
        MJIkHIIBEcZ9UDeN20q0CQE=
X-Google-Smtp-Source: ABdhPJzQqa16ntoHnCKJlJaUs1Rg68hKbVxoyrBt+QCmSGoiEOx4hAcxAMzCMrbCeI//MqWfVxmLGw==
X-Received: by 2002:a05:6808:308c:b0:326:77f8:8cb4 with SMTP id bl12-20020a056808308c00b0032677f88cb4mr13187236oib.292.1652703688114;
        Mon, 16 May 2022 05:21:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000e686d1387bsm5560247oab.21.2022.05.16.05.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 05:21:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1747d709-6640-193d-8290-893b1541fae8@roeck-us.net>
Date:   Mon, 16 May 2022 05:21:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
 <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net> <YoFWNAhiDrzpeBU8@Red>
 <9f7d7281-0434-df59-40fa-1f5d8f53356d@roeck-us.net> <YoHtg30ZrhxjVedA@Red>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
In-Reply-To: <YoHtg30ZrhxjVedA@Red>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/22 23:21, LABBE Corentin wrote:
> Le Sun, May 15, 2022 at 05:29:54PM -0700, Guenter Roeck a écrit :
>> On 5/15/22 12:36, LABBE Corentin wrote:
>>> Le Wed, May 11, 2022 at 07:10:29PM -0700, Guenter Roeck a écrit :
>>>> Corentin,
>>>>
>>>> On 5/8/22 23:30, Corentin Labbe wrote:
>>>>> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
>>>>> So let's convert the driver to use hwmon_device_register_with_info().
>>>>>
>>>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>>>> ---
>>>> [ ... ]
>>>>
>>>>> @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>>>>>     		if (res)
>>>>>     			break;
>>>>>     
>>>>> -		remove_attrs(resource);
>>>>> +		remove_domain_devices(resource);
>>>>>     		setup_attrs(resource);
>>>>
>>>> Zhang Rui found an interesting problem with this code:
>>>> It needs a call to sysfs_update_groups(hwmon_dev->groups)
>>>> to update sysfs attribute visibility, probably between
>>>> remove_domain_devices() and setup_attrs().
>>>>
>>>>>     		break;
>>>>>     	case METER_NOTIFY_TRIP:
>>>>> -		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
>>>>> +		hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
>>>>
>>>> ... which makes realize: The notification device should be the hwmon device.
>>>> That would be resource->hwmon_dev, not the acpi device.
>>>>
>>>
>>> Hello
>>>
>>> Since my hardware lacks capabilities testing this, I have emulated it on qemu:
>>> https://github.com/montjoie/qemu/commit/320f2ddacb954ab308ef699f66fca6313f75bc2b
>>>
>>> I have added a custom ACPI _DBX method for triggering some ACPI state change. (like config change, like enabling CAP).
>>>
>>> For testing config change I have tried lot of way:
>>>                   res = read_capabilities(resource);
>>> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>>>    
>>>                   remove_domain_devices(resource);
>>>                   setup_attrs(resource);
>>> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, acpi_power_groups);
>>> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, acpi_power_groups);
>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
>>> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
>>
>> Did you add a debug log here ?
> 
> Yes I added debug log to check what is called.
> 
>>
>> acpi_power_groups would be the wrong parameter for sysfs_update_groups().
>> It would have to be resource->hwmon_dev->groups.
>>
> 
> Even with that, no call to is_visible:
> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>   
>                  remove_domain_devices(resource);
>                  setup_attrs(resource);
> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, resource->hwmon_dev->groups);
> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, resource->hwmon_dev->groups);
> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
>                  break;
> 
> I checked drivers/hwmon/hwmon.c is seems that is_visible is only called by gen_attr/gen_attrs which is only called by __hwmon_create_attrs and then by registers functions.
> So perhaps it explain why it is never called.

Ah yes, you are correct. Sorry, it has been too long ago that I wrote that code.
Effectively that means we'll have to rework the hwmon core to generate attributes
anyway and leave it up to the driver core to call the is_visible function.

Guenter
