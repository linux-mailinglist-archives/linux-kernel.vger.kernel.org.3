Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587C1518A82
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbiECQ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiECQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:57:13 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE262C110;
        Tue,  3 May 2022 09:53:40 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so8955857oty.3;
        Tue, 03 May 2022 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=zA84vWARKvdZGoHpmEmoay8CyFxLOyVVP3HiM+T2sbI=;
        b=ItRJ32KI75VE8T7AZA/VYalA55l8vdvH2W6aaVZrpfkmjn/yAWta3OnDBGJJUNJHQd
         jN6vb7IFnXo6tb5GL1M7aWCNRsTcQnicfP7WpyahlayjO/YU9M8G8dskmP8lj95UZVw1
         hctc672evZrYBx0UgL2o8T2J3T8Qp52y65y1gTtrm5XtoKw7BLqEa6SEChiTo7vOvBR6
         rOmS7EqK+Is9A0PxCpBzeibY/gr328ZE3zUz9TGGhDsgFIr4IkHqSChIfuI7Nb1PPa1k
         7+sHniY2fQaNhcMTRCmqU0dXyLaC6khbCf/ieYPIqe0HTb+DD66Zcg+DqVSZdOl0Vf/V
         EDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=zA84vWARKvdZGoHpmEmoay8CyFxLOyVVP3HiM+T2sbI=;
        b=CK45Jb/cdEtIlDGw+wE1ZfJFEmo5icf6429J5XnQJj/tepPFxYDbv271tgZb+3nQSb
         5TiG+Qgjj41TAWfFRAG8bmIE0L102LFBgpIvn5u+2B5sVx4iqIwmNGUooHxhO8fzQPw5
         DQ21dIrwjhOaqUs1bgE5dqqge7b9jo0p4m05oD4nqp6ld6iAL5xnvwAJPEg/6I5+7222
         1lg+wjzrOjbIsFn6K9N1IFkfVCSiApdVWemChSwDT2mxxYLGdvDHDStw8ORVG41yYrcU
         qfKI7joiNQJlLoKvPadFW7L8yMmN5cgqaRaFhhOHUKefbToxHgSJzLtOsktYJOy/SB6Z
         ulbw==
X-Gm-Message-State: AOAM533xynR75sLHGMXjZydIJPa47NqMKZz9KAaa+c4borIIrmyoTAgP
        9/vbwbjwrQo1GvOpkC7g14Q+JRCQgaLIoQ==
X-Google-Smtp-Source: ABdhPJxZBHwm+TE77pQeUp1Mgc+316/kXgVxtVccMyjZXMe224WqQG6lXJ68YahH61W3HoZTpozTGQ==
X-Received: by 2002:a9d:129:0:b0:606:1a26:b128 with SMTP id 38-20020a9d0129000000b006061a26b128mr3692590otu.314.1651596819862;
        Tue, 03 May 2022 09:53:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 1-20020a9d0c01000000b006060322127fsm4108965otr.79.2022.05.03.09.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 09:53:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d88523a8-a240-915d-9ae7-54b2277e424a@roeck-us.net>
Date:   Tue, 3 May 2022 09:53:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-3-nick.hawkins@hpe.com>
 <c0262cf4-dfeb-c9a9-bcb2-24af006e6d4d@roeck-us.net>
 <PH0PR84MB1718D28F1846F54DB5766E6D88C09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 3/8] watchdog: hpe-wdt: Introduce HPE GXP Watchdog
In-Reply-To: <PH0PR84MB1718D28F1846F54DB5766E6D88C09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 09:22, Hawkins, Nick wrote:
> On 5/2/22 13:40, nick.hawkins@hpe.com wrote:
>>> +#include <linux/of_address.h>
>>> +#include <linux/of_platform.h>
> 
>> Where are those of_ includes used ?
> 
> They were not used anymore with latest changes. Thank you for pointing this out. I will remember to check in the future for each new commit to double check this.
> 
>>> +#define WDT_MAX_TIMEOUT_MS	655000
> 
>> Shouldn't that be 655350 ?
> 
> Yes it should be. I will correct this.
> 
>>> +static int gxp_wdt_set_timeout(struct watchdog_device *wdd,
>>> +			       unsigned int timeout)
>>> +{
>>> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
>>> +	u32 actual;
>>> +
>>> +	wdd->timeout = timeout;
>>> +	actual = min(timeout, wdd->max_hw_heartbeat_ms / 1000);
>>> +	writew(SECS_TO_WDOG_TICKS(actual), drvdata->base + GXP_WDT_CNT_OFS);
> 
>> First, the accuracy of actual is reduced to 1 second, then SECS_TO_WDOG_TICKS() multiplies the result with 100, meaning the actual accuracy is 10ms. Why not just use 10 ms ?
> 
>> 	actual = min(timeout * 100, wdd->max_hw_heartbeat_ms / 10);
>> 	writew(actual, drvdata->base + GXP_WDT_CNT_OFS);
> 
> I have replaced the mention code with what you recommended above.
> 
>>> +
>>> +static int gxp_restart(struct watchdog_device *wdd, unsigned long action,
>>> +		       void *data)
>>> +{
>>> +	struct gxp_wdt *drvdata = watchdog_get_drvdata(wdd);
>>> +
>>> +	writew(10, drvdata->base + GXP_WDT_CNT_OFS);
> 
>> Doesn't that translate to 100 ms timeout ? Why such a large reboot delay instead of writing 1 ?
> 
> This has been changed to 1.
> 
>>> +	gxp_wdt_enable_reload(drvdata);
>>> +	mdelay(100);
>>> +	return 0;
>>> +}
>>> +
>>> +static int gxp_wdt_probe(struct platform_device *pdev) {
>>> +	struct device *dev = &pdev->dev;
>>> +	struct gxp_wdt *drvdata;
>>> +	int err;
>>> +	u8 val;
>>> +
>>> +	drvdata = devm_kzalloc(dev, sizeof(struct gxp_wdt), GFP_KERNEL);
>>> +	if (!drvdata)
>>> +		return -ENOMEM;
>>> +
>>> +	drvdata->base = (void __iomem *)dev->platform_data;
> 
>> I'd personaly prefer if the address was passed as resource.
> 
> Just to clarify for my understanding are you asking that in the device structure I use the "void *platform_data" to pass "struct *resource"? If I am incorrect here can you elaborate on what you would like to be done? Based on feedback in review for the device tree; the watchdog is being created as a child to the timer. Therefore the conclusion reached was there should not be a gxp-wdt listed in the device tree files. I took this implementation based on what I found in ixp4xx_wdt.c.
> 

One bad deed tends to multiply.

No, I didn't ask to pass a struct resource as platform data.
That would be no different to the current code. Resources
can be added to a platform device using
platform_device_add_resources(), and the platform driver
can then use platform_get_resource() to use it. This
would make it independent of a "private" mechanism.

Thanks,
Guenter
