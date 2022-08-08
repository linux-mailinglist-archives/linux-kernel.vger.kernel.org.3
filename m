Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A49058CF8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbiHHVRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiHHVRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:17:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A061AF3A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 14:17:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a11so5380197wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=xT3U7Fcq666IjZnpP4Hd9cAsdG9vkr6FYDlzUI0n/OE=;
        b=ECongWXKH2gwPuWgmxYdr6guRMPl4jAF8wszWyuDEt5/3rpg1VhdodvEh3b0QBJjMu
         jGuXiG3uAJrZY2JzewgWe+wqpjTOPR5nMCDJUoBHV71Wu31SoMOUZSGcUU+V/BgGTuoy
         iVb6OREEZ4TfbdQdQqMHPScwgu2CXEsFtz4WSM90RaGHcMVscynjwcqz6Pyx/I7NK/TI
         zT/kzTU86DoKMKXH5cCVDZiAL1O5h6QNpKCMMH9MPqLwM/TjTMEnWa0yh1zmJ4LaADHI
         kzYBPFYPlmtlKKcbEVAmF6tKXgF52bwvvAz7j8ELzRCOEsd+XYWyWY7oGbauIVyZh6Hv
         UCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xT3U7Fcq666IjZnpP4Hd9cAsdG9vkr6FYDlzUI0n/OE=;
        b=hnFWNCl8G58qdEMZx1Y14fD/I0VUbkb1UUC6tep2cUXDkK0xmsY5ko/0SyE/IVAbvL
         nICp0jBxaMGRuUEkITH2QVCRS0ysf9U6EXckr+3pOgH4A7ZQcOAFa2jZnnmVhHd09a8q
         lA6G8kwxh8+VtaPGTphk3+48GgdOUEQpZ2k+JaC5WTblcf0D+UuTtUHQUSOJUqBlDcdi
         o7/9FwNFpi7dP3VFClHlrlM0sZwY6lzqxaFy3uZVWV7UIBc+BqqE3MGcapZ7p9+MZgqg
         NZQYTTZsIma2JEQ4pCjgnOnJvR7+1zr2sOu3bL473QZI6dQNBbt+DetoBfLPus/o9sC6
         p1Xg==
X-Gm-Message-State: ACgBeo0FHA6Wf74ZGkGynPHy3RCbLpBAu2lCfbSpYxH1la0KfiuM+ydO
        J8tb4zOk3CJM661sQpwSk7nPUg==
X-Google-Smtp-Source: AA6agR4jZ2+M0qSdbkYF7IST0XVTX3X/Zm/eeDM106HX5oBGSVSsAfRVMOsrJ4HYtT1spomRLZEnUg==
X-Received: by 2002:a05:600c:1ca0:b0:3a5:3703:2a97 with SMTP id k32-20020a05600c1ca000b003a537032a97mr6409480wms.23.1659993461134;
        Mon, 08 Aug 2022 14:17:41 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o6-20020a05600c4fc600b003a32490c95dsm20358062wmq.35.2022.08.08.14.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 14:17:39 -0700 (PDT)
Message-ID: <fb14ae2a-9702-1041-ae84-34d37835e839@linaro.org>
Date:   Mon, 8 Aug 2022 23:17:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] thermal/of: Return -ENODEV instead of -EINVAL if
 registration fails
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     rafael@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220808180915.446053-1-daniel.lezcano@linaro.org>
 <20220808180915.446053-2-daniel.lezcano@linaro.org>
 <f8008f05-4e4d-e21f-2e40-e234930ee86e@roeck-us.net>
 <d676c6533e11ac357a8aaca4ba216b6d@walle.cc>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <d676c6533e11ac357a8aaca4ba216b6d@walle.cc>
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

On 08/08/2022 21:05, Michael Walle wrote:
> Am 2022-08-08 20:35, schrieb Guenter Roeck:
>> On 8/8/22 11:09, Daniel Lezcano wrote:
>>> The previous version of the OF code was returning -ENODEV if no
>>> thermal zones description was found or if the lookup of the sensor in
>>> the thermal zones was not found.
>>>
>>> The backend drivers are expecting this return value as an information
>>> about skipping the sensor initialization and considered as normal.
>>>
>>> Fix the return value by replacing -EINVAL by -ENODEV
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>   drivers/thermal/thermal_of.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>>> index 368eb58e97cf..4210c18ef7b2 100644
>>> --- a/drivers/thermal/thermal_of.c
>>> +++ b/drivers/thermal/thermal_of.c
>>> @@ -329,7 +329,7 @@ static struct device_node 
>>> *of_thermal_zone_find(struct device_node *sensor, int
>>>       np = of_find_node_by_name(NULL, "thermal-zones");
>>>       if (!np) {
>>>           pr_err("Unable to find thermal zones description\n");
>>
>> I really don't like that error message: People will see it (and complain)
>> whenever a sensor registers and there is no thermal zone, even though 
>> that
>> is perfectly normal (see description above).
> 
> I can second that, and there actually two error messages:
> 
> [    6.156983] thermal_sys: Unable to find thermal zones description
> [    6.163125] thermal_sys: Failed to find thermal zone for hwmon id=0

Yeah, I can check:

np = of_thermal_zone_find(sensor, id);

And print the error if PTR_ERR(np) != ENODEV, otherwise silently return.


> On the sl28 board with the qoriq_thermal driver:
> [    1.917940] thermal_sys: Failed to find thermal zone for tmu id=2
> [    1.929231] thermal_sys: Failed to find thermal zone for tmu id=3
> [    1.940519] thermal_sys: Failed to find thermal zone for tmu id=4
> [    1.951814] thermal_sys: Failed to find thermal zone for tmu id=5
> [    1.963109] thermal_sys: Failed to find thermal zone for tmu id=6
> [    1.974399] thermal_sys: Failed to find thermal zone for tmu id=7
> [    1.985690] thermal_sys: Failed to find thermal zone for tmu id=8
> [    1.996980] thermal_sys: Failed to find thermal zone for tmu id=9
> [    2.008274] thermal_sys: Failed to find thermal zone for tmu id=10
> [    2.019656] thermal_sys: Failed to find thermal zone for tmu id=11
> [    2.031037] thermal_sys: Failed to find thermal zone for tmu id=12
> [    2.048942] thermal_sys: Failed to find thermal zone for tmu id=13
> [    2.060320] thermal_sys: Failed to find thermal zone for tmu id=14
> [    2.071700] thermal_sys: Failed to find thermal zone for tmu id=15
> 
> Btw. the driver seems to always register 16 sensors regardless how
> many the actual hardware has (or rather: are described in the DT).

Yes, it may be nicer to rely on the compatible string to figure out the 
sensors of the platform and call with full knowledge the registering 
function. But anyway ...


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
