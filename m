Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85DD58E8DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 10:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiHJIfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 04:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiHJIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:34:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757FB5A2C0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:34:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l22so16917017wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=bkzHlR+cUvVyHpzLk2ncuYHJ7GeFDJmOxDxvociFius=;
        b=bb8Uer18YD5FkYXGsFH+l17HcWf0wvtMHUuQ40OQ0GDH/3iYV35IU7u3drCYFcDJ+X
         eC+d0EzzWP3dBAef3pp4oOIIcSrl0b9C5KOFPkPNJss6OEmNIh9SLFfw/4cRDutguIvO
         bUA52P58iNkqHhvPCo+d4EWUNugr196hO12CnwkizN6Szd/dFSmCBV4dd6Gcm25AXc0L
         XMx/GoEDkc1knFnDeYBcj6DS3rh3hi8+uFrOCRtfYdYSOSiZIE1VjMTFJKIWQXUUSFF+
         7E/XiO9K/KtE9Ieh741lmY7ZttRjK2tUOCdu4CYZNTvLUzGPZdQM0B7kwg0m/VZhMAzq
         i4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=bkzHlR+cUvVyHpzLk2ncuYHJ7GeFDJmOxDxvociFius=;
        b=wE5y9NUTnBJu0bKSbs2qBwJDE1uUYOAVvRJ0I/5lWuJyElwLGbbyzBAf7LOLlBNChn
         GnPUGuijYswvUJCfUtk8UDXdbRNiVBRVRaWgN3PdlZ/uDQ+j9wJwGwOAToe5H4i0dOhU
         tDzatpWlGLYwZieb3LQq1CNI1K4eexnYdKw94VKcpo32ijCK/xtyTTZZg5QrYK+sN+Wv
         N4NleQHUbrIsh5q/NFl3ygDdMOegyi2seCbzD0EYdDPPQqHR6qG396n9AN1A0s/wY9n5
         /4B/58xk9tBjhaxIH4YZTLVcLUOVH+HDumQJDqIU742M19paXunay1phxAvj9nHP9gbb
         GrrA==
X-Gm-Message-State: ACgBeo3ipqvUcl+egBThzwhy1PEMb96HH9SLP8St4isoGrXr/e7tp9EP
        x6U8ax9GlPLmsHqgQnW3ymxsuw==
X-Google-Smtp-Source: AA6agR6FOObBLF2ZRKKvwD+BJSywE7pEYvvMSqdtOWnXacW0tRqX3vqVzvAqQq0dwRnFGT2e0ee5MQ==
X-Received: by 2002:a5d:5273:0:b0:220:5d3e:c50f with SMTP id l19-20020a5d5273000000b002205d3ec50fmr17189776wrc.291.1660120489914;
        Wed, 10 Aug 2022 01:34:49 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o4-20020a05600c4fc400b003a0375c4f73sm1504248wmq.44.2022.08.10.01.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 01:34:49 -0700 (PDT)
Message-ID: <c7b3c6b3-1384-079c-fe76-dc1eca4f3ab2@linaro.org>
Date:   Wed, 10 Aug 2022 10:34:46 +0200
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
> On Mon, Aug 08, 2022 at 11:42:16AM +0200, Michael Walle wrote:

[ ... ]

> It would also mean that all hwmon drivers registering a thermal zone sensor
> would fail to register unless such a thermal zone actually exists. This
> would make the whole concept of having the hwmon core register thermal
> zone sensors impossible. I have no idea how this is expected to work now,
> but there is an apparent flaw in the logic. That means I withdraw my
> Acked-by: for the hwmon patches in this series until it is guaranteed
> that hwmon registration does not fail as above if there is no thermal
> zone associated with a sensor.

I tried to figure out where we are not in sync and I suspect there is a 
misunderstanding from my side of your initial statement.

I understood you meant the thermal zone can not be created with the 
hwmon if there is no thermal zone description and that was the case before.

But actually, I suspect I misunderstood and you meant if the thermal OF 
registration fails, the hwmon creation fails for the hwmon subsystem, 
and before the changes it was created anyway.

Is that correct ?

If yes, the change -EINVAL --> -ENODEV fixes the issue, shall I consider 
in this case your Acked-by ?

Thanks
   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
