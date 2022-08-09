Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F48358DA65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbiHIOdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiHIOdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:33:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AF718352;
        Tue,  9 Aug 2022 07:33:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r69so4981796pgr.2;
        Tue, 09 Aug 2022 07:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=5Xq/0OiZzCvmhWkkiPnzduUq5EO9SWbMWZthaNtSYn8=;
        b=gXGIhKPqVnqKPdmUIUbCJePl+qNWA1CeUWR8oFzFC7XlhGEITOv2m7QFnQwux6KiAK
         zzSTn9rxQkH6I3dsxBAlPADmf1oWHLdQlkBdd06H6qsUaC/7ValxsFA2YCjg20WuSGqN
         t+g9RE23IfAZhmBfrkyf3GDYNrq+gj358LH3k2fjtJvmdkGKoM/2Estpti/2ZUSIj8WI
         VE2MeKn/JNfIeAhhhJzbh+DdoosxoGU8aIg5J1loTHBZlDIYAwsP0/1mywhBRL9swDLs
         MhCIT5yze1OlH8ujUku6nRTFRSakrO002c6efoqLGvOA5kue1NRTIlZSEj2o3cOGoLi3
         2W9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=5Xq/0OiZzCvmhWkkiPnzduUq5EO9SWbMWZthaNtSYn8=;
        b=aoDJBnTYh7TdfvPgEc3Pgc/tpsS7PCoR03X5YPMvhRhyMgQzj27z+WD21/gs2II0hB
         ghrlDFE9SLMhNAEx3WpoIUMK7Et06m5KrB31b7U7HjIcuq1jYV7PRNKo+VraOrkDJZnp
         DRsJIWPv02RhMfCvRVgJJQyUIdnQOfkTqk6ErFTl56MWisKNURLkGWxyTOtquVXjhLH4
         P9PjmYi0/7eptuTNGC8EhSLDwgiRPutnyTtaSq1fzRLteLqcRwwG6u8ZAo4xiIwzoaJ2
         xjHQ1pn7JTtWCpLu5hqIWzHMzwhmpyN5eKjHjXtDwyRLZKaCdV9Yfs+mI6hfBrjfamdb
         aqNg==
X-Gm-Message-State: ACgBeo3aGpWqy6BUfFiR92GHONZu31IIBaSVBJkIPOrmBK72HyCPgmKo
        ZTaRr0x/yKtXWe4XDrj4UQY=
X-Google-Smtp-Source: AA6agR45uyvXyXdyzQg6Db96ox5UpgucK0vWnHculImEAe3Sn1Ud9/FKFju8bYmMyShZASG/4cmfdQ==
X-Received: by 2002:a63:68c7:0:b0:405:1da9:ab69 with SMTP id d190-20020a6368c7000000b004051da9ab69mr19964222pgc.233.1660055581941;
        Tue, 09 Aug 2022 07:33:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 65-20020a621744000000b0052d36feb7fcsm10525536pfx.198.2022.08.09.07.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 07:32:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6318d099-268b-1bbe-fed8-4f4b356e90cb@roeck-us.net>
Date:   Tue, 9 Aug 2022 07:32:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/33] New thermal OF code
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Walle <michael@walle.cc>
Cc:     daniel.lezcano@linexp.org, abailon@baylibre.com,
        anarsoul@gmail.com, baolin.wang7@gmail.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, digetx@gmail.com,
        f.fainelli@gmail.com, glaroque@baylibre.com,
        hayashi.kunihiko@socionext.com, heiko@sntech.de, j-keerthy@ti.com,
        jonathanh@nvidia.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, matthias.bgg@gmail.com,
        mcoquelin.stm32@gmail.com, mhiramat@kernel.org,
        miquel.raynal@bootlin.com, niklas.soderlund@ragnatech.se,
        rafael@kernel.org, rui.zhang@intel.com, shawnguo@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, tiny.windzz@gmail.com
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220808094216.928018-1-michael@walle.cc>
 <20220808102610.GA1969424@roeck-us.net>
 <829788a5-3da4-8638-a587-9e80e2fd3fea@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <829788a5-3da4-8638-a587-9e80e2fd3fea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 01:53, Daniel Lezcano wrote:
> Hi Guenter,
> 
> On 08/08/2022 12:26, Guenter Roeck wrote:
> 
> [ ... ]
> 
>>> But I guess even if that is fixed, the driver will not probe due to the
>>> missing trip points? Are they now mandatory? Does it mean we'd need to
>>> update our device trees? But that will then mean older devices trees
>>> don't work anymore.
>>
>> It would also mean that all hwmon drivers registering a thermal zone sensor
>> would fail to register unless such a thermal zone actually exists. 
> 
> Probably missing something but if the thermal zone is not described, the hwmon driver won't initialize. And except if I'm wrong, that was already the case before these changes, no?
> 

In the hwmon source (you point to it below):

         if (IS_ERR(tzd)) {
                 if (PTR_ERR(tzd) != -ENODEV)
                         return PTR_ERR(tzd);
                 dev_info(dev, "temp%d_input not attached to any thermal zone\n",
                          index + 1);
                 devm_kfree(dev, tdata);
                 return 0;
         }

That contradicts "if the thermal zone is not described, the hwmon driver won't initialize".
Now I must be missing something, since you mention that yourself below, and your new patch
series fixes the problem, at least AFAICS. Confused.

Guenter

>> This
>> would make the whole concept of having the hwmon core register thermal
>> zone sensors impossible.
> 
> No, only the way the thermal OF is implemented changed. No functional changes. So AFAICT, you can still create thermal zones with the hwmon.
> 
>> I have no idea how this is expected to work now,
>> but there is an apparent flaw in the logic. That means I withdraw my
>> Acked-by: for the hwmon patches in this series until it is guaranteed
>> that hwmon registration does not fail as above if there is no thermal
>> zone associated with a sensor.
> 
> 
> If the thermal zone creation fails with -ENODEV, then it is no considered as an error when creating the hwmon [1]
> 
> The function [devm]_thermal_zone_of_sensor_register() checks if there is a thermal zone description, if not it bails out with -ENODEV [2]
> 
> Otherwise it checks all the thermal zones if the device passed as parameter matches a sensor in the thermal zone [3][4]
> 
> If there is no match, then it returns -ENODEV which is the default error code [5]
> 
> My understanding is there is no thermal zone creation if there is no description in the device tree for such a device in the thermal zone.
> 
> The issue we had here was the confusing error message when -ENODEV (before was -EINVAL) is returning while before the code was silently continuing without creating the thermal zone.
> 
> We are talking here about what is in under CONFIG_THERMAL_OF in the hwmon code path. The rest is untouched.
> 
> Am I missing something?
> 
> 
> 
> [1] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v5.18/drivers/hwmon/hwmon.c#230
> 
> [2] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v5.18/drivers/thermal/thermal_of.c#499
> 
> [3] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v5.18/drivers/thermal/thermal_of.c#510
> 
> [4] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v5.18/drivers/thermal/thermal_of.c#428
> 
> [5] https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v5.18/drivers/thermal/thermal_of.c#497

