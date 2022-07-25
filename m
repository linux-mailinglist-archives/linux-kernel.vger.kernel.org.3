Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F758062E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiGYVJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiGYVJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:09:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4087023BDF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:09:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m17so17378715wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g6vKqwcDorJnFDkLzImjodXLaiwTUKwPPEi2tmiVDTI=;
        b=hEcGrGkHeC0ej+nkTzc4RixqUra1HE+XtbKCMVhqy/GifLdqA0KWYwOhJlnu/fm4fO
         ls8A8gJJMcBK9UVj+no5qPBdVHVDECGXesaJ2vgjewzAEuFRWDauWrbIkoZ/M1G2GB3l
         9p5hh36+LEauR4i1PO46+bbtvT0NGVROX1upS22nlPPwOafkDeCZDzfoG6ad+RoX0ZWY
         443cY1XLJBMnwqK9fnMjQDe57LlICF6VBuMmQLEXQJ1OFu7YCh6J1Bx/8XWcAA6nvkxk
         kV9V7s2kJyOhNcmJu/YzOuYP0kQNkQ6Un5aX6wPVY4Hs9LRhIN7iOp4UdkAapvhSSGDp
         /VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g6vKqwcDorJnFDkLzImjodXLaiwTUKwPPEi2tmiVDTI=;
        b=aWj4UyFr2bdRzHoqfVO/9Q/EczVN+WYHe8mFRJD7kCPEjL8Vl6JWwU/PovmnIiedN9
         f1kmYCA1wpionWssAdXMIqt5ZjjPrawdPigqGIQc5njBeX+3KqVJx77qIkO8vL4ZEMrr
         bvvCRsSwpfpG/73FGFRdXV0bHCnNyePCAyYdhAqKVSIIk3YblISFipx0tdKKO7qon5i2
         npL354Vmm+eiBT5h4jaHbgm+nOLjPwze6HjQw5aa95TTw6zes9MoJD/QGtLxDCsYpngz
         185dIIGnkyfgYchKAE3mWx2xC07iUuKiZe++Cnzsm7YE5IYHOB7s08ciQlh3N/aAk1Uj
         I9Dg==
X-Gm-Message-State: AJIora8I4GhjK3wVxd90/V6mQu/ZQxj8McoJhE/Z4ATQJB55WGcvpZH+
        3nANen0jylbp8asr6Iu9eOgIYA==
X-Google-Smtp-Source: AGRyM1udi1a3P7ONOJajQ7XKx00GcnNxC9sX/S4Q3xHcqtjDA4bb76X6+JQDFo5gbjVYqKpzDSGUGg==
X-Received: by 2002:a5d:5a12:0:b0:21e:8327:7e03 with SMTP id bq18-20020a5d5a12000000b0021e83277e03mr5634195wrb.567.1658783356790;
        Mon, 25 Jul 2022 14:09:16 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1780:8e54:dd38:6668? ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d5147000000b0021e83cb98cbsm5219573wrt.106.2022.07.25.14.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 14:09:16 -0700 (PDT)
Message-ID: <f0e4e6de-6b55-aeaf-d059-b1b2d1a2bd9c@linexp.org>
Date:   Mon, 25 Jul 2022 23:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 17/33] thermal/drivers/rcar: Switch to new of API
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com, khilman@baylibre.com,
        abailon@baylibre.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-18-daniel.lezcano@linexp.org>
 <YtZ1IExNlsYaJkC9@oden.dyn.berto.se>
 <18ade2d0-ebda-0526-71f3-65a0b2685068@linexp.org>
 <Yt2W5UCXaB3Memzg@oden.dyn.berto.se>
 <e2a56ac3-057c-2b17-7bde-7e860a86807d@linexp.org>
 <Yt3KDSO248WebZ/w@oden.dyn.berto.se> <Yt3Vmt/AAzqzDzBF@oden.dyn.berto.se>
 <28e915c2-4871-b648-f5ac-78d6ecb32768@linaro.org>
 <Yt5yjAAT3y4YSgl1@oden.dyn.berto.se>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <Yt5yjAAT3y4YSgl1@oden.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 12:38, Niklas Söderlund wrote:
> Hi Daniel,
> 
> On 2022-07-25 12:00:30 +0200, Daniel Lezcano wrote:
>>
>> Hi Niklas,
>>
>> On 25/07/2022 01:28, Niklas Söderlund wrote:
>>> Hi (again) Daniel,
>>>
>>> I figured it out, the thermal zone is disabled after this change. For
>>> both rcar sensors with the new API thermal_zone_device_enable() is never
>>> called.
>>>
>>> In the old API the zone is enabled in the call chain of
>>> devm_thermal_zone_of_sensor_register(). While after this change the zone
>>> is not enabled by the core when calling thermal_zone_device_enable().
>>>
>>> If I add a call to thermal_zone_device_enable() together with the new
>>> API everything works as before. But I'm not sure if the correct solution
>>> is to add a call to thermal_zone_device_enable() in the sensor drivers
>>> or in the call chain of the new API?
>>>
>>> On 2022-07-25 00:39:10 +0200, Niklas Söderlund wrote:
>>>> Hi Daniel,
>>>>
>>>> I tested your branch, unfortunately with the same result for
>>>> rcar_gen3_thermal. Manipulation of emul_temp file do not trigger
>>>> actions.
>>
>> Thanks for investigating, I updated the branch. Does it fix the issue ?
> 
> I tested the branch with the head [1] and it restores the expected
> operation for both rcar_gen3_thermal and rcar_thermal sensors.
> 
> Thanks for the fix, with this change I'm happy with this new API.
> 
> 1. commit e9b792a531c10756 ("thermal/of: Remove old OF code")

Thanks !!

