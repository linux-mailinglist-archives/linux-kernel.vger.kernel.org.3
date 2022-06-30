Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37998561780
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiF3KRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiF3KRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:17:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA74506F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:17:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q9so26551652wrd.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=c96BIX1fdQoWXVeifIQLvlY9hToa+J8OCLgj66YDpdo=;
        b=hxR+0DYQzyBeod/6ISMQjw069iwdQP3G6dVo1DQlk4ba7JW7UYZ4O7TE6g9NajuItk
         p3wuOz4zRGR8CEq/BpalWRVErG0Y0rXGB+22+MVcT5ULiz7KSnNs22YiWKIaBM09kKMw
         sWlX53ypI0udUXY1yWQEOk32myTSzVneVpmWoBk+l5yc3vElFTUYu8bO9acQI1+lAHZW
         bHVpgFKSqoXIV+r1jsFOT9efDvWH4IfzT98msNbV6dcn0bgI0Hv97aY925yneWBdby5T
         6D3frZSyzVLgKQqc86S4j5d0/xodXxI7e8MI049fagc4OBu4uHWmk5vEbZOg1JtZkyJi
         CYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c96BIX1fdQoWXVeifIQLvlY9hToa+J8OCLgj66YDpdo=;
        b=g2Ji3SmQSEctvrdTGivwynF9y4bx9T5kMZcZDq0Mztwjx8oX1Gqa567/hU/56ndllC
         nBfYW0/OiYX4GUag0lHbMfyd6fXGQZaERiBfpBJOq7I/VRr1q8pCX10Qt/GcCwSiVyDX
         TaSIMXUQGmyBL8QFF7UnUSQK+NXvJRnaL9iBW8P/XbAtDJpj1o6tX8BYPFLUo1uENu/J
         QVKf3sjKshYW3JqROfkM/N0yr17f/kaqAF0glYLi87z+ks3AkrWBWV1yi9ryCud4lfmc
         fUt2d3LHeKqSzEbxP+lOLppQU6soVhb2A08b+ieFfmoLotS7Mzw9IdaI5aIZjew/tJpD
         Jimw==
X-Gm-Message-State: AJIora/yrcmsmMojSknJozY+t4BZYHIJCtkmdOl4Uh5dLS8dDdY5+8V0
        iL9738ktb7SjiIadCdmLrPUO0Q==
X-Google-Smtp-Source: AGRyM1sbvmqN9/tkpqOkQ+1clLVa6+kww2xKsNUSTqdo01t1OTCv0ffjXeaKZcHNWk59VZfg9riTNA==
X-Received: by 2002:a5d:5a84:0:b0:21b:92c7:a7f with SMTP id bp4-20020a5d5a84000000b0021b92c70a7fmr8055287wrb.586.1656584252619;
        Thu, 30 Jun 2022 03:17:32 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k42-20020a05600c1caa00b003a04722d745sm2184242wms.23.2022.06.30.03.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 03:17:32 -0700 (PDT)
Message-ID: <1d9ed3ac-289f-88ea-ad08-0031e9bde1bb@linaro.org>
Date:   Thu, 30 Jun 2022 12:17:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] thermal/drivers/tegra: Remove get_trend function
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-2-daniel.lezcano@linaro.org>
 <b4adef64-cc2c-14ab-b16d-3f8c27f3834b@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <b4adef64-cc2c-14ab-b16d-3f8c27f3834b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2022 22:05, Dmitry Osipenko wrote:
> On 6/16/22 23:25, Daniel Lezcano wrote:
>> The get_trend function does already what the generic framework does.
>>
>> Remove it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>>   static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
>>   {
>>   	u32 r;
>> @@ -716,7 +685,6 @@ static int tegra_thermctl_set_trips(void *data, int lo, int hi)
>>   static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
>>   	.get_temp = tegra_thermctl_get_temp,
>>   	.set_trip_temp = tegra_thermctl_set_trip_temp,
>> -	.get_trend = tegra_thermctl_get_trend,
>>   	.set_trips = tegra_thermctl_set_trips,
>>   };
>>   
> 
> Guenter fixed the LM90 driver problem. There are other regressions in
> the latest -next which complicate testing, but I can't see any problems
> from the thermal side.
> 
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Great! Thanks for taking the time to test


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
