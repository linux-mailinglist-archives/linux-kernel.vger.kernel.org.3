Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5DE5A7C70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiHaLst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiHaLsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:48:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C035CC31D;
        Wed, 31 Aug 2022 04:48:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f24so11138551plr.1;
        Wed, 31 Aug 2022 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=kptEBsuKB5XrQ+zQWfXmJuaA8+ARn4KY6rJu7bkvlfs=;
        b=Bc4bPumDth4o4rU0fJGGxGJydnvEIbHxT6yHZp05HCEyPRA0CuXgjyJlI+KzcjsAMA
         XESBXtZPXJqWDAY/lT+YE4G3ZQIdT8bvOJ13wVGXKlwIq0s8Ke9uVRA9xZkv2g+bZXDc
         0RhXxPV17aWnulpZnu86j97gL17kVqP904ts+icbse00ramgRgDJ9J0E3T4xiKgaEPC+
         /WSrf4tVTNK/tiBnSu5GzbReZinZHL5n9/ZUWLSl3EU6ln/qH/1p0sJqGZdTSoY31NYk
         BEagfJhxMGXAwWOIFwFSsKU7smCeMYuJgPp4XM1Kgvath1WshSU0aZWaUvT7kHuuh4P4
         nuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=kptEBsuKB5XrQ+zQWfXmJuaA8+ARn4KY6rJu7bkvlfs=;
        b=xt0KBjuQ05mev0PmmWfbNX5G06sOIEqZqFTKgW1syxNK3/Vu3m4rNbFokb+EAc0xOV
         Cu4fK7QOgIa6O/VdvCgBonDm1vF8xa5Hmqt/4RL7WqUhhhoWvjPEgwNsIptAUfeHFQuR
         kiTn4te+vAa0x2mkNtRcJuGL7fCKHMvSx/jxaWU6qmBti6Q1HG0ANe++kUTi6VmtxzVT
         D6JqoH0B4Njbewxjy78MjvnTWqVcRzm2zwcqydpFQz5Vsrk4nV2YrOFIkKmA6i+3+A9e
         nxt1KUsD+VHIeickM/fpsln/ih0P+sFWzRvoi3p5RfR8zeNp3g11ysHLxHfnBdOB9M+W
         JITA==
X-Gm-Message-State: ACgBeo37E03F2bmJ8BcM3xxsUAfkzVrryIiMQ1463rY6GJd9cOTTDMar
        Txr6daYpcNswMg6Ft8OBSG4=
X-Google-Smtp-Source: AA6agR6lMZ+r7tMVV/rCdJCevCUh00ygknQbKxtz+rXz6lJE4b/JtmHVrQxoLMq/fRI/IKViEMurQQ==
X-Received: by 2002:a17:90a:4607:b0:1fa:f794:2c0d with SMTP id w7-20020a17090a460700b001faf7942c0dmr3014956pjg.24.1661946524757;
        Wed, 31 Aug 2022 04:48:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a348100b001faa4a6691asm1141654pjb.30.2022.08.31.04.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 04:48:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <71d6d57c-2165-5fe3-515d-9395022921e2@roeck-us.net>
Date:   Wed, 31 Aug 2022 04:48:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     "Farber, Eliav" <farbere@amazon.com>, jdelvare@suse.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, andriy.shevchenko@intel.com
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-3-farbere@amazon.com>
 <cddebb5a-3b83-e89d-db00-9a59ddbd6741@roeck-us.net>
 <84a68eff-be64-71ce-1533-1e228d3da2a4@amazon.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 02/19] hwmon: (mr75203) fix VM sensor allocation when
 "intel, vm-map" not defined
In-Reply-To: <84a68eff-be64-71ce-1533-1e228d3da2a4@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/30/22 22:49, Farber, Eliav wrote:
> On 8/31/2022 8:36 AM, Guenter Roeck wrote:
>> On 8/30/22 12:21, Eliav Farber wrote:
>>> Bug fix - in case "intel,vm-map" is missing in device-tree ,'num' is set
>>> to 0, and no voltage channel infos are allocated.
>>>
>>> Signed-off-by: Eliav Farber <farbere@amazon.com>
>>> ---
>>>   drivers/hwmon/mr75203.c | 28 ++++++++++++----------------
>>>   1 file changed, 12 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/mr75203.c b/drivers/hwmon/mr75203.c
>>> index 046523d47c29..0e29877a1a9c 100644
>>> --- a/drivers/hwmon/mr75203.c
>>> +++ b/drivers/hwmon/mr75203.c
>>> @@ -580,8 +580,6 @@ static int mr75203_probe(struct platform_device *pdev)
>>>       }
>>>
>>>       if (vm_num) {
>>> -             u32 num = vm_num;
>>> -
>>>               ret = pvt_get_regmap(pdev, "vm", pvt);
>>>               if (ret)
>>>                       return ret;
>>> @@ -594,30 +592,28 @@ static int mr75203_probe(struct platform_device *pdev)
>>>               ret = device_property_read_u8_array(dev, "intel,vm-map",
>>> pvt->vm_idx, vm_num);
>>>               if (ret) {
>>> -                     num = 0;
>>> +                     /*
>>> +                      * Incase intel,vm-map property is not defined, we
>>> +                      * assume incremental channel numbers.
>>> +                      */
>>> +                     for (i = 0; i < vm_num; i++)
>>> +                             pvt->vm_idx[i] = i;
>>>               } else {
>>>                       for (i = 0; i < vm_num; i++)
>>>                               if (pvt->vm_idx[i] >= vm_num ||
>>> -                                 pvt->vm_idx[i] == 0xff) {
>>> -                                     num = i;
>>> +                                 pvt->vm_idx[i] == 0xff)
>>>                                       break;
>>
>> So all vm_idx values from 0x00 to 0xfe would be acceptable ?
>> Does the chip really have that many registers (0x200 + 0x40 + 0x200 * 0xfe) ?
>> Is that documented somewhere ? 
> According to the code vm_num is limited to 32 because the mask is
> only 5 bits:
> 
> #define VM_NUM_MSK    GENMASK(20, 16)
> #define VM_NUM_SFT    16
> vm_num = (val & VM_NUM_MSK) >> VM_NUM_SFT;
> 
> In practice according to the data sheet I have:
> 0 <= VM instances <= 8
> 
Sorry, my bad. I misread the patch and thought the first part of
the if statement was removed.

Anyway, what is the difference between specifying an vm_idx value of
0xff and not specifying anything ? Or, in other words, taking the dt
example, the difference between
	intel,vm-map = [03 01 04 ff ff];
and
	intel,vm-map = [03 01 04];

Thanks,
Guenter
