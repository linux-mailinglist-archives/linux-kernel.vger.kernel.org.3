Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA5351385D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349190AbiD1PdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiD1PdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:33:10 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67DFB36A3;
        Thu, 28 Apr 2022 08:29:55 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so5472668fac.7;
        Thu, 28 Apr 2022 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=Pv9usw+O63MO2ATgl81kJeaUNBZyxyMTEuME1k+1RAc=;
        b=dFLZe87VF5pOxbQi2n9CAh9vjWk7uDQU+GBRmKRFkZIEM+2c9yEH4tjxuIVGekH/kf
         xPSr1PeiGuZHpdHrcMy0W577lhI8yyK6idoORqpyJWtGqHx04sYcICQNYv5vObe+hYZV
         Pp0msLAJ/5fgOamq50sKYQQHLFlzkRbyuf08VSionWFuB/OIDOH7eMzefFyhbJ+2+27Y
         lQ5STGTIx9G7+Wxxl/9+BOf83Em3BKo8vikFAxqOpAWG+ijSgBhloNOJn3617UftIPJl
         R1z4aAypqpsp3tSV20yY3ouvSfciX3MPfUXzT3UFRjL5w14e9+LTOJr+HFnnXvj0xWxg
         BPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=Pv9usw+O63MO2ATgl81kJeaUNBZyxyMTEuME1k+1RAc=;
        b=Nb9ZQu/Rff89vWErdXc89W/xe71VbsgfaUVM+Ax6H0+zd+TBqb+VnsGQGnbwJs4teG
         yc+OupzvJqjLPu9KJUawfU+RswnmPL4dAFrxzyrP8dgPcx6/CXBiPUMsTMGiQsfNrRkN
         jj5ZuJ97WOKQy3naTxAxjgR3O5v0gqaofJJFDWiJJTYcEmqUCHcSWF3F9XMdxnBkPmq1
         aQNKARfLArdb42aovaFb+2S14/JtJwIhBqGZQfEhJvP4X14QCaPU0dyhXeoVeJ9rIbaO
         9dmlHci6utCsuY8Pj/h6ZUeOkQAXP7N4lULEvsLIbTWgFr0yaZn7v6zGNOGc6yor8tqi
         zQkA==
X-Gm-Message-State: AOAM530Umel6mzLkAlu6WXkiapKVL0aOprbQxzpRny0lSCA40xgVDFKO
        VWN98j8/S9loB36FEJpXP5tkaoTp3fA=
X-Google-Smtp-Source: ABdhPJzENQqdkEKNdqUIFnwaoNg3ieUzE+pMCIQd5w6fDxD7X+wPG5vGa6KnnyeXOkaMut2Uu6DhNw==
X-Received: by 2002:a05:6870:15ce:b0:e9:894f:d9ce with SMTP id k14-20020a05687015ce00b000e9894fd9cemr3428700oad.121.1651159794992;
        Thu, 28 Apr 2022 08:29:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a14-20020a544e0e000000b002f9c00dc626sm127786oiy.28.2022.04.28.08.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 08:29:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b7a47a91-abb9-5d0a-5f1d-fc15bf582dea@roeck-us.net>
Date:   Thu, 28 Apr 2022 08:29:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220428091603.6838-1-pali@kernel.org>
 <b19ce453-1235-689b-8796-fa6cba35c1f0@roeck-us.net>
 <20220428143210.6cbvik2kmjul3qo5@pali>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: max63xx_wdt: Add support for specifying WDI
 logic via GPIO
In-Reply-To: <20220428143210.6cbvik2kmjul3qo5@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 07:32, Pali Rohár wrote:
> On Thursday 28 April 2022 06:10:56 Guenter Roeck wrote:
>> On 4/28/22 02:16, Pali Rohár wrote:
>>> On some boards is WDI logic of max6370 chip connected via GPIO. So extend
>>> max63xx_wdt driver and DTS schema to allow specifying WDI logic via GPIO.
>>>
>>> Signed-off-by: Pali Rohár <pali@kernel.org>
>>
>> How is that different to just using the gpio watchdog driver ?
> 
> GPIO watchdog driver does not support max6370 memory mapped
> configuration.
> 
> With this change, max6370 can use memory mapped space for watchdog
> configuration and GPIO WDI for pinging.
> 

Ok, that makes sense. Comments below.

Thanks,
Guenter

>> Guenter
>>
>>> ---
>>>    .../bindings/watchdog/maxim,max63xx.yaml      |  4 +++
>>>    drivers/watchdog/max63xx_wdt.c                | 28 +++++++++++++++++++
>>>    2 files changed, 32 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
>>> index ab9641e845db..a97aa0135ef9 100644
>>> --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
>>> +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
>>> @@ -27,6 +27,10 @@ properties:
>>>        description: This is a 1-byte memory-mapped address
>>>        maxItems: 1
>>> +  gpios:
>>> +    description: Optional GPIO used for controlling WDI when WDI bit is not mapped to memory
>>> +    maxItems: 1
>>> +
>>>    required:
>>>      - compatible
>>>      - reg

Devicetree patches needs to be separate.

>>> diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
>>> index 9e1541cfae0d..eaf00c3f06a5 100644
>>> --- a/drivers/watchdog/max63xx_wdt.c
>>> +++ b/drivers/watchdog/max63xx_wdt.c
>>> @@ -27,6 +27,7 @@
>>>    #include <linux/io.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/property.h>
>>> +#include <linux/gpio/consumer.h>
>>>    #define DEFAULT_HEARTBEAT 60
>>>    #define MAX_HEARTBEAT     60
>>> @@ -53,6 +54,9 @@ struct max63xx_wdt {
>>>    	void __iomem *base;
>>>    	spinlock_t lock;
>>> +	/* GPIOs */
>>> +	struct gpio_desc *gpio_wdi;
>>> +
>>>    	/* WDI and WSET bits write access routines */
>>>    	void (*ping)(struct max63xx_wdt *wdt);
>>>    	void (*set)(struct max63xx_wdt *wdt, u8 set);
>>> @@ -158,6 +162,17 @@ static const struct watchdog_info max63xx_wdt_info = {
>>>    	.identity = "max63xx Watchdog",
>>>    };
>>> +static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
>>> +{
>>> +	spin_lock(&wdt->lock);
>>> +
>>> +	gpiod_set_value_cansleep(wdt->gpio_wdi, 1);
>>> +	udelay(1);
>>> +	gpiod_set_value_cansleep(wdt->gpio_wdi, 0);
>>> +
>>> +	spin_unlock(&wdt->lock);
>>> +}
>>> +
>>>    static void max63xx_mmap_ping(struct max63xx_wdt *wdt)
>>>    {
>>>    	u8 val;
>>> @@ -225,6 +240,19 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
>>>    		return -EINVAL;
>>>    	}
>>> +	wdt->gpio_wdi = devm_gpiod_get(dev, NULL, GPIOD_FLAGS_BIT_DIR_OUT);
>>> +	if (IS_ERR(wdt->gpio_wdi) && PTR_ERR(wdt->gpio_wdi) != -ENOENT) {
>>> +		if (PTR_ERR(wdt->gpio_wdi) != -EPROBE_DEFER)
>>> +			dev_err(dev, "unable to request gpio: %ld\n",
>>> +				PTR_ERR(wdt->gpio_wdi));

Please use dev_err_probe().

>>> +		return PTR_ERR(wdt->gpio_wdi);
>>> +	}
>>> +
>>> +	if (!IS_ERR(wdt->gpio_wdi))
>>> +		wdt->ping = max63xx_gpio_ping;
>>> +	else
>>> +		wdt->gpio_wdi = NULL;

Why set gpio_wdi to NULL? It isn't used if the ping function is not set.

>>> +
>>>    	err = max63xx_mmap_init(pdev, wdt);

Doesn't this override the gpio ping function set above ?

>>>    	if (err)
>>>    		return err;
>>

