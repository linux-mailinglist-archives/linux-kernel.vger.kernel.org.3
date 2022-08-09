Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E257858D5BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbiHIIxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241174AbiHIIx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:53:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2842250A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:53:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso5620340wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qG0cMVDpsw3lX4Bn87g1WU9OQnuZ1JiWfH6lXAs1oTo=;
        b=It5aifXBux/SXZQo7kIXTKsrClPnKo4DMK+1FQ+dEW2NQ7mBlQLj8BzfOo0hIKXFkh
         eyaoGE7t0882xNqlruvy03WAT/8RKsccfeoi4O7KGQBtrE/qGe9vT3wvLAM2iGCiBF0G
         18b2/s4Yll+jtdywo11uUbu6CWSiDsauyZ35IUgZy2l6pcqvSEruV68RC43EsMCKR/IQ
         OSJaYUDjqx5+rHJX7jdPt2BKPGCw2vLwiSOhXJ2Ux+lKc2wZfS3zLvcznnVaCJYWqtsd
         pQ5CM4RzhDtX5A7IB68dcsgKDZV7Ze3bLVnrewRh4B/s8R3TFjkLUXJJyyIpMurvgpiU
         oT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qG0cMVDpsw3lX4Bn87g1WU9OQnuZ1JiWfH6lXAs1oTo=;
        b=7guwVmGTW1gOf2zhgj7IIcGjPAAuLZF/aLDr5mkfldpZLJxtqm4ATVeY7iMAU+9JKm
         faiCsLv6q2+08PMp1N8J8sOVV9Cbkqj2cUMcpXBawktyItnk0EgAeMFd7zWbDHFqE00u
         YyTwUwUvQgqzo8JMzEu5HVCauz2K7KSB/j0wlA15Rd1ec3mL8T2HLva4z/fIh09+yiei
         im24wtIwmgbAiis6sMx6oHe0jEAtDUafaYYwfOgs7Af2+f0UvhntX57qLvFA5HvBgjD5
         ciWBoHJ+cpw6DAao9VMZiH9X/i6w4l0z16gT6S6aUKOHZ94ZoTPfbIAyG41EKN6mKSAv
         j1AA==
X-Gm-Message-State: ACgBeo3RiizNdAZxY5/JHag09hOS9GEghEdFNxmt+S7Eyh4wdNewuHxH
        kKmGUNF0H4veqsOv6GKiAZlMmg==
X-Google-Smtp-Source: AA6agR4aU2oT1B0lZOEedWdpfgdQY9s7hYm2Mi9wy+kVRDKtJ7UuWhTFm37jQlnjey0/+bRmcUsfNg==
X-Received: by 2002:a05:600c:2650:b0:3a5:4402:bc2a with SMTP id 16-20020a05600c265000b003a54402bc2amr4476133wmy.108.1660035205589;
        Tue, 09 Aug 2022 01:53:25 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w8-20020a5d6088000000b002185631adf0sm13011623wrt.23.2022.08.09.01.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 01:53:25 -0700 (PDT)
Message-ID: <829788a5-3da4-8638-a587-9e80e2fd3fea@linaro.org>
Date:   Tue, 9 Aug 2022 10:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 00/33] New thermal OF code
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220808102610.GA1969424@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 08/08/2022 12:26, Guenter Roeck wrote:

[ ... ]

>> But I guess even if that is fixed, the driver will not probe due to the
>> missing trip points? Are they now mandatory? Does it mean we'd need to
>> update our device trees? But that will then mean older devices trees
>> don't work anymore.
> 
> It would also mean that all hwmon drivers registering a thermal zone sensor
> would fail to register unless such a thermal zone actually exists. 

Probably missing something but if the thermal zone is not described, the 
hwmon driver won't initialize. And except if I'm wrong, that was already 
the case before these changes, no?

> This
> would make the whole concept of having the hwmon core register thermal
> zone sensors impossible.

No, only the way the thermal OF is implemented changed. No functional 
changes. So AFAICT, you can still create thermal zones with the hwmon.

> I have no idea how this is expected to work now,
> but there is an apparent flaw in the logic. That means I withdraw my
> Acked-by: for the hwmon patches in this series until it is guaranteed
> that hwmon registration does not fail as above if there is no thermal
> zone associated with a sensor.


If the thermal zone creation fails with -ENODEV, then it is no 
considered as an error when creating the hwmon [1]

The function [devm]_thermal_zone_of_sensor_register() checks if there is 
a thermal zone description, if not it bails out with -ENODEV [2]

Otherwise it checks all the thermal zones if the device passed as 
parameter matches a sensor in the thermal zone [3][4]

If there is no match, then it returns -ENODEV which is the default error 
code [5]

My understanding is there is no thermal zone creation if there is no 
description in the device tree for such a device in the thermal zone.

The issue we had here was the confusing error message when -ENODEV 
(before was -EINVAL) is returning while before the code was silently 
continuing without creating the thermal zone.

We are talking here about what is in under CONFIG_THERMAL_OF in the 
hwmon code path. The rest is untouched.

Am I missing something?



[1] 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v5.18/drivers/hwmon/hwmon.c#230

[2] 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v5.18/drivers/thermal/thermal_of.c#499

[3] 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v5.18/drivers/thermal/thermal_of.c#510

[4] 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v5.18/drivers/thermal/thermal_of.c#428

[5] 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux/+/refs/tags/v5.18/drivers/thermal/thermal_of.c#497
-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
