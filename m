Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8770751780F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384083AbiEBU2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiEBU2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:28:14 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC412D;
        Mon,  2 May 2022 13:24:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id m6-20020a05683023a600b0060612720715so3213806ots.10;
        Mon, 02 May 2022 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r94YqMx5ZctK7unoMYrvuw3Flpa+xJ8HQV4BFyvkHjA=;
        b=A2ha8ppwEZtRbANOmJc36UU9WgMmCKwOsl/JaXS3NnekJ0YIbT2XJ3i2NefuRRDsJp
         mtIh4gAahJR94D5N3N+gz4YUlfOg8Cf25yqkO8rjWWdgQlFkp8OdEbMbnYiC8/TwQIbe
         3vVCf22YH+soM/9QvixQAezDauWR62gnaE6Vlv5bODXX+x4ZVk/U1RpL8mtQH2IkGXFh
         0w1Ep5sg5qK5mgMwUjzjq1K2tz9H09oXo4u3HhsaAF1ZjCprMn32qxs+8dJLEi1cYf3J
         v5s9XN8IXRDJpaYlU9bzdi8H2VUEhvFQjFfR7+us6OFW0utwrUfRYk2LrUzm63CLb1MI
         Ennw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r94YqMx5ZctK7unoMYrvuw3Flpa+xJ8HQV4BFyvkHjA=;
        b=5vqwiWLhM6bKj8K6tWUeM8zmi49fLFFy0ctR0WnRIn11CxomWaJdhBxKkgGUvt/2vT
         mAw6O+yAiSOY/mLC3hWByDuBjMSAlPKxkrnWdAUi78WrCAQe74D3G9Sdo3+sqEI7jqSU
         vkLQfGfwV7CetibS6FlSlfI3ihxwxxXANQ1cQruOKCXCvc9XjqYKRs/15tjnK5HbKkTz
         +p/AgUKPSMb8gNwGU5OKm0QCIdNk/85KbbRUwl/H4w/PESUhgyGths4SUkr6SFhT6Uo+
         KPwzMI4pro6zwqeACJO0JaeiQ1ny6uXcKEqKosCDrGsx/2qFB9UswgtuWTO+3j2VO00T
         xPHA==
X-Gm-Message-State: AOAM533P3YmRH9+kET6A0XSbiDZpCpITdT37j+gMT65466QWjFzOLGIL
        QkTtt+I6mGRIfYThgm0astR2krOcYT1lpg==
X-Google-Smtp-Source: ABdhPJzJXYa5/fRgrnyVASb+qWV4MG0ae/aiXN4wkUqtojSduR7g+Od37ICi7neYmWcl/2WFp8iS9g==
X-Received: by 2002:a9d:6447:0:b0:5b2:35ae:7ad6 with SMTP id m7-20020a9d6447000000b005b235ae7ad6mr4719131otl.275.1651523083729;
        Mon, 02 May 2022 13:24:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13-20020a056808028d00b00325cda1ff90sm2710133oic.15.2022.05.02.13.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 13:24:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b6553cc2-034d-8a70-cf9b-b9d244dc3597@roeck-us.net>
Date:   Mon, 2 May 2022 13:24:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] hwmon: acpi_power_meter: convert to
 hwmon_device_register_with_info
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220502124249.682058-1-clabbe@baylibre.com>
 <20220502124249.682058-2-clabbe@baylibre.com>
 <0b154a30-7765-e3ac-9980-0ecc7447d7ad@roeck-us.net> <YnAqDxfTU27USQI+@Red>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YnAqDxfTU27USQI+@Red>
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

On 5/2/22 11:59, LABBE Corentin wrote:
> Le Mon, May 02, 2022 at 06:34:44AM -0700, Guenter Roeck a écrit :
>> On 5/2/22 05:42, Corentin Labbe wrote:
>>> Booting lead to a hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
>>> So let's convert the driver to use hwmon_device_register_with_info().
>>>
>>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>>> ---
>>>    drivers/hwmon/acpi_power_meter.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
>>> index d2545a1be9fc..98293727f980 100644
>>> --- a/drivers/hwmon/acpi_power_meter.c
>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>> @@ -891,7 +891,10 @@ static int acpi_power_meter_add(struct acpi_device *device)
>>>    	if (res)
>>>    		goto exit_free_capability;
>>>    
>>> -	resource->hwmon_dev = hwmon_device_register(&device->dev);
>>> +	resource->hwmon_dev = hwmon_device_register_with_info(&device->dev,
>>> +							      ACPI_POWER_METER_DEVICE_NAME,
>>> +							      NULL, NULL,
>>> +							      NULL);
>>
>> NACK. That isn't a conversion to the new API, it just abuses the fact
>> that the new API has to accept a NULL info pointer for historic reasons.
>>
> 
> Hello
> 
> I am sorry, I found a driver doing it, so I believed it was okay.

Yeah, that is what happens if an API is flexible: It is prone to
abuse, and once the abuse starts others start to abuse it as well
"because that other driver did it".

> Converting seems not to hard but, by using the new API, how can I convert power1_model_number/power1_is_battery attribute ?
> There are the remaining attributes I dont find how to convert.
> 

It is ok to use the pointer to sysfs attribute groups
for non-standard attributes.

Guenter
