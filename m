Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6057D604
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiGUVbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUVbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:31:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E05A9284C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:31:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so1499988wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A2h9OhkusgdirRF83rSBWXog+SzGCnXMH7foJlVkPkI=;
        b=JkJtha8Q2/QgMtGxqubVcYBGwAwK5MfVfg+dnrP+G34k60Y3xjhLiLCVxgbQniWy4Y
         ocsjnl8z9s9QsjZVQko3FBqVSAxR9tl/UvLHtD50LANWvDTMv0fqNKkrwhBil8Ld8kF/
         trfDsuYTokVvwwiHci+z1Uvf+wWamd9IvCW8GagRbkBXgN0pVZFt/eWRqmBDMBkVWQ1j
         WfzKQutEmleLjzitVEocUMUogbiT52AxPrGFkH3YicXcgYSzZQrySONQ2S6ISkodGPF/
         CI3cxHY2QOgj+hf0RVAGaK7xdJeCrdU4rTbha6mPJGDAx9EgQrbxhr5WVA9nlhwLvJXH
         0SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A2h9OhkusgdirRF83rSBWXog+SzGCnXMH7foJlVkPkI=;
        b=AIdRwhjNKBQT92EjXPptrn0DXy5OavTpNecMjuvDB6n6QNhJuW0FlcBOVzBv2CD52M
         6giy7957BJYAgCObMjODO3pfCYGH8cDjECXB9KzLS50OHdfd+PHIioitggj00MF6WEri
         s1kI3UKbdwi+jzdn1u6EHMPsCijIsALvq1edYWkSU/Tx02yTm64z9fz1w8cjR99x6/92
         LDz7CSeFO2nQ2SIyKLVqB7ayfmwB2HqMtnSiduM11E2KvwfJ2IndwhF5iOrHVgYAOhPP
         qbvdbTiROCXrHEoaGHuTUsUjJZsQWBwBITCJV6JeEE66W3bRkj+RtZvn3cnFUHy9Eeoq
         IiZA==
X-Gm-Message-State: AJIora9kGjzFVbKDQw/hMsorTVh8vl6oT2i0XduuJiue0aYNprPc2v0W
        GxFeNVHA+6gvz1udS44m8Eqrow==
X-Google-Smtp-Source: AGRyM1sahWrxiJgQ9tceO4ZjUSOjwMwFzVxE2R0QwgXfmYhHOg40BEjLOlS+DR7sz5exkFUmi5rmhw==
X-Received: by 2002:a05:600c:224c:b0:3a3:17b7:a229 with SMTP id a12-20020a05600c224c00b003a317b7a229mr10050746wmm.1.1658439089920;
        Thu, 21 Jul 2022 14:31:29 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a2a9:428c:224b:c919? ([2a05:6e02:1041:c10:a2a9:428c:224b:c919])
        by smtp.gmail.com with ESMTPSA id co30-20020a0560000a1e00b0021e434c7867sm3475455wrb.36.2022.07.21.14.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 14:31:29 -0700 (PDT)
Message-ID: <c75d5dca-17d5-6542-b0aa-46ed036567c7@linexp.org>
Date:   Thu, 21 Jul 2022 23:31:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 10/12] thermal/of: Store the trips in the thermal zone
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
 <20220710123512.1714714-12-daniel.lezcano@linexp.org>
 <CAJZ5v0hJNUm1kyF7XdK1EiLNg6DmihBMbrZZsxgOjvi-xq3=cQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <CAJZ5v0hJNUm1kyF7XdK1EiLNg6DmihBMbrZZsxgOjvi-xq3=cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 20:24, Rafael J. Wysocki wrote:
> On Sun, Jul 10, 2022 at 2:35 PM Daniel Lezcano
> <daniel.lezcano@linexp.org> wrote:
>> As the thermal zone contains the trip point, we can store them
>> directly when registering the thermal zone. That will allow another
>> step forward to remove the duplicate thermal zone structure we find in
>> the thermal_of code.
>>
>> Cc: Alexandre Bailon <abailon@baylibre.com>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
>> ---
>>   drivers/thermal/thermal_of.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index 19243c57b3f4..e187461dd396 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -1119,11 +1119,9 @@ int __init of_parse_thermal_zones(void)
>>                  tzp->slope = tz->slope;
>>                  tzp->offset = tz->offset;
>>
>> -               zone = thermal_zone_device_register(child->name, tz->ntrips,
>> -                                                   mask, tz,
>> -                                                   ops, tzp,
>> -                                                   tz->passive_delay,
>> -                                                   tz->polling_delay);
>> +               zone = thermal_zone_device_register_with_trips(child->name, tz->trips, tz->ntrips,
>> +                                                              mask, tz, ops, tzp, tz->passive_delay,
>> +                                                              tz->polling_delay);
>>                  if (IS_ERR(zone)) {
>>                          pr_err("Failed to build %pOFn zone %ld\n", child,
>>                                 PTR_ERR(zone));
>> --
> IMO it would be less confusing if this was merged with the patch
> introducing thermal_zone_device_register_with_trips().

You suggest to merge 8,9 and 10, right ?

