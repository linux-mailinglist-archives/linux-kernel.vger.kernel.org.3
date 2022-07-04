Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3753C565ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiGDVTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiGDVTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:19:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2B64D7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 14:19:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z12so5340545wrq.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FKGrspbVUBsoG+EbiXh9vc6L1sI8MIdpxiXWMn2tTck=;
        b=53c3EQNr2zmoWlHUmaol6xcBDhBPh0m9FsNEbojORKaJTU9v3lfj9Ya4gAzj+EUZOG
         UBkAlMnI3fPm4ikczgZ8z+ywM3HmO8j33QMDSrgsA+3Wyy63Mh6JpkNcEkQaXn1I534o
         461GxUaDV2TOpO5YV94ttpv7sHaCumb2Tf15z5aeA63SvsRao7hsiSzGhHrzUEGfzpSH
         Nkg0YrmuLpXg86L7X5Jeg7nlFkmSJLgnftPBgxCreLaU44pLu2nifykvX2tebpCfwBXJ
         FflYktubQYBHirSW60GhQZU26S16+ZcfeR6riiTW2jfbOhgQQ+UhM22YJTxUH2g74T/c
         3RRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FKGrspbVUBsoG+EbiXh9vc6L1sI8MIdpxiXWMn2tTck=;
        b=7jGaoXgUlSyhVYMSo3bouuQY6Ht9+p52Z8Y9MN/YfOrBVnaPpM6Lb/KgGMy7bcyA+v
         gB03WH3cSGHfH+qSQOU7FjbDNJZC4f4ifWruWKWvYQVyLjQBWQoETaa6BCfI3JgjNtaV
         +srMr6ICU8UNjD0PkOB29/hlto7pfqDUuO7KfE8PHJ4iUgOeXVtuxIDDwnDreYXlTDVB
         +azqx6e9pZoOi9EAtrVayk72CdnJEnWVtFQYojrrTZKSOH1J/Dp9azOAUq995L4tYjT6
         M/KpykrTZpA4KUNctrJbWpmr2Ny0MBiF2PrCMu069+EGuQB88wSLPaEeanym3Bwyc7KJ
         vKKw==
X-Gm-Message-State: AJIora+34Po2cSyV0M143TQzH80gWG9aERSXvpZWZ7GFmUXwMQwjJDY4
        sAYgIDAcJRNXMMRa50VpqEauHA==
X-Google-Smtp-Source: AGRyM1vVTmWsCzUPEQCQF8hjxMYnje+1ZGB9O4VfD5OUTcID6lUTF1g+sJIekYbsx64tdGFzhLq56A==
X-Received: by 2002:adf:e0c9:0:b0:21b:8271:2348 with SMTP id m9-20020adfe0c9000000b0021b82712348mr26774460wri.222.1656969555234;
        Mon, 04 Jul 2022 14:19:15 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id y22-20020a1c4b16000000b003a04a47d9c2sm20389596wma.47.2022.07.04.14.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 14:19:14 -0700 (PDT)
Message-ID: <249bf1a9-8491-09e3-3c3f-c4e8a124cb22@linexp.org>
Date:   Mon, 4 Jul 2022 23:19:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 07/12] thermal/core: Rename trips to ntrips
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-8-daniel.lezcano@linexp.org>
 <4ad311e5-62e1-d06b-7c5e-315ed923b5a5@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <4ad311e5-62e1-d06b-7c5e-315ed923b5a5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 10:24, Lukasz Luba wrote:
> 
> 
> On 7/3/22 19:30, Daniel Lezcano wrote:
>> In order to use thermal trips defined in the thermal structure, rename
>> the 'trips' field to 'ntrips' to have the 'trips' field containing the
>> thermal trip points.
>>
>> Cc: Alexandre Bailon <abailon@baylibre.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc; Eduardo Valentin <eduval@amazon.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
>> ---
>>   drivers/thermal/gov_fair_share.c        |  6 +++---
>>   drivers/thermal/gov_power_allocator.c   |  4 ++--
>>   drivers/thermal/tegra/tegra30-tsensor.c |  2 +-
>>   drivers/thermal/thermal_core.c          | 20 ++++++++++----------
>>   drivers/thermal/thermal_helpers.c       |  4 ++--
>>   drivers/thermal/thermal_netlink.c       |  2 +-
>>   drivers/thermal/thermal_sysfs.c         | 22 +++++++++++-----------
>>   include/linux/thermal.h                 |  2 +-
>>   8 files changed, 31 insertions(+), 31 deletions(-)
> 
> 
> [snip]
> 
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 6289b0bb1c97..3a57878a2a6c 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
> 
> Missing updated ne name in comment here:
>   * @trips:      number of trip points the thermal zone supports
> 
> 
>> @@ -165,7 +165,7 @@ struct thermal_zone_device {
>>       struct thermal_attr *trip_hyst_attrs;
>>       enum thermal_device_mode mode;
>>       void *devdata;
>> -    int trips;
>> +    int ntrips;
>>       unsigned long trips_disabled;    /* bitmap for disabled trips */
>>       unsigned long passive_delay_jiffies;
>>       unsigned long polling_delay_jiffies;
> 
> Maybe this is only my bias, but this new name 'ntrips' looks
> like negation in electronics.
> 
> We have examples like: num_cpus, num_pins, num_leds, num_groups,
> num_locks, num_buffers, num_phys, etc...
> 
> Could we have 'num_trips' and follow to this convention here as well?

Sure, I'll do the changes accordingly

