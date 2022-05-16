Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19027527B01
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 02:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiEPAaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 20:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiEPAaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 20:30:02 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922311147;
        Sun, 15 May 2022 17:29:58 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f18e6ff0f6so3648331fac.11;
        Sun, 15 May 2022 17:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Anv85llJI9BfL0c8oyae7fOpj22kTXiuTtEZdPvqM9E=;
        b=oPHjCxCXUN5tk9k6FFCj1MgW9VN67S+/LAqb4sEFOToBdtaSye74WmszOFAsl6kPuj
         iM+Z/49GXKyLM7UA029gpUmNp6AWSGOHs8iYvIFsYZMoqM9PHG4ipLglydxsEISd+4Fu
         5tnn1/ilRg6YqtMgBqzPD2KGFjc3DTSsuCO+9ey3QKI6JhUzDFt4mquHwHXLK0Fa+pP0
         GDyqM6LxolCvyNKjIZdO1HYSOyaqn0zwKhu4zCmxSSaYUNGtX7MRWDCdyspNamSZVr7q
         mFUB8IeG4VfAHbgi0YjqaY1f5UOjGBLOuDzeGcHRo3YRrYeAe1GBqjqs3j+b7quanWqo
         9k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Anv85llJI9BfL0c8oyae7fOpj22kTXiuTtEZdPvqM9E=;
        b=1QiqqVPvGiUrGcXRWn/YFuDm+ml7IFEsUCjAey1fVwIKvpdDj3bKvG2iC3IdCqvGpX
         z9DhrUR2Waf+ecjqoSIa7gQBkbYSTuKJ7Izne+dQehrMPqiI3T+y7xJzdoxYD72ZhXt5
         rFMBx2SDL68rQEIM7geEq4AFUw2V3P8kcEDuOfWu0x3ZcZaE1ExDIh7ePrqi/GA6lS4p
         RmgTYiN+t1QM61UWdaX0er53VPsbkYymyl2X8E05Drx6y4W6thOnRZFWH/kM3mNDJb22
         Dh4db7I7UwD6Dh0oZ38Xk2y1lwWfIx2Cfgpr+5Pla40efM+sB/mO+fH0dsVOje/84feV
         KCmw==
X-Gm-Message-State: AOAM530Y1/T0jjhetYjIyVAEKYjnubzZG9kyfyV8/B1ND5YuQS1tY8RL
        yxQkXV6C1a/RVTaa1GbtIqg=
X-Google-Smtp-Source: ABdhPJxhw+5HTmji9mR+eYpwZFW7k8B9sss7Ikbd0eWU/ow/m118V7+RPRSqr6zGwBg036EEFWK28A==
X-Received: by 2002:a05:6870:5887:b0:f1:555f:7e72 with SMTP id be7-20020a056870588700b000f1555f7e72mr6691337oab.109.1652660997673;
        Sun, 15 May 2022 17:29:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r16-20020a056830081000b006060322127esm3476907ots.78.2022.05.15.17.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 17:29:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9f7d7281-0434-df59-40fa-1f5d8f53356d@roeck-us.net>
Date:   Sun, 15 May 2022 17:29:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>
References: <20220509063010.3878134-1-clabbe@baylibre.com>
 <20220509063010.3878134-3-clabbe@baylibre.com>
 <e5f6c712-efed-2126-de2b-9a0d09150e7b@roeck-us.net> <YoFWNAhiDrzpeBU8@Red>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YoFWNAhiDrzpeBU8@Red>
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

On 5/15/22 12:36, LABBE Corentin wrote:
> Le Wed, May 11, 2022 at 07:10:29PM -0700, Guenter Roeck a écrit :
>> Corentin,
>>
>> On 5/8/22 23:30, Corentin Labbe wrote:
>>> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
>>> So let's convert the driver to use hwmon_device_register_with_info().
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>> ---
>> [ ... ]
>>
>>> @@ -836,20 +740,20 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>>>    		if (res)
>>>    			break;
>>>    
>>> -		remove_attrs(resource);
>>> +		remove_domain_devices(resource);
>>>    		setup_attrs(resource);
>>
>> Zhang Rui found an interesting problem with this code:
>> It needs a call to sysfs_update_groups(hwmon_dev->groups)
>> to update sysfs attribute visibility, probably between
>> remove_domain_devices() and setup_attrs().
>>
>>>    		break;
>>>    	case METER_NOTIFY_TRIP:
>>> -		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
>>> +		hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
>>
>> ... which makes realize: The notification device should be the hwmon device.
>> That would be resource->hwmon_dev, not the acpi device.
>>
> 
> Hello
> 
> Since my hardware lacks capabilities testing this, I have emulated it on qemu:
> https://github.com/montjoie/qemu/commit/320f2ddacb954ab308ef699f66fca6313f75bc2b
> 
> I have added a custom ACPI _DBX method for triggering some ACPI state change. (like config change, like enabling CAP).
> 
> For testing config change I have tried lot of way:
>                  res = read_capabilities(resource);
> @@ -742,18 +758,22 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
>   
>                  remove_domain_devices(resource);
>                  setup_attrs(resource);
> +               res = sysfs_update_groups(&resource->hwmon_dev->kobj, acpi_power_groups);
> +               res = sysfs_update_groups(&resource->acpi_dev->dev.kobj, acpi_power_groups);
> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);

Did you add a debug log here ?

acpi_power_groups would be the wrong parameter for sysfs_update_groups().
It would have to be resource->hwmon_dev->groups.

Guenter

>                  break;
>          case METER_NOTIFY_TRIP:
> -               hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average, 0);
> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average, 0);
>                  break;
>          case METER_NOTIFY_CAP:
> -               hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_cap, 0);
> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_cap, 0);
>                  break;
>          case METER_NOTIFY_INTERVAL:
> -               hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_average_interval, 0);
> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_average_interval, 0);
>                  break;
>          case METER_NOTIFY_CAPPING:
> -               hwmon_notify_event(&device->dev, hwmon_power, hwmon_power_alarm, 0);
> +               res = hwmon_notify_event(resource->hwmon_dev, hwmon_power, hwmon_power_alarm, 0);
>                  dev_info(&device->dev, "Capping in progress.\n");
>                  break;
>          default:
> 
> But nothing force visibility to be rerun.
> 
> Any idea on how to force visibility to be re-run ?

