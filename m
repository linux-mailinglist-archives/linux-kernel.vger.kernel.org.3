Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED685593B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346483AbiHOU3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347304AbiHOUWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:22:14 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EDE33A2D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:02:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z12so10072798wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=mu6VIMQHZgu7hW6pnoLsBEY5Z10dgE369agK010Rc84=;
        b=YdFKfQNGHVM61QkiB3IPZDX0xemD9MegWIARaiXMcyMrJUIRQQ34gClP1mCfoYeOqr
         IhjSyQkSZmScv6UvwboH2nUBjj0NW0MEeHwszC4o3K6B1PgApa3tD8cmPntGMzY5/zCJ
         wWBwQ/gpYf2AhwA0ZbOPJ4c0uk1ziO0r/vkMCNIZslb+ChTJQBKjHYzgABsK00Hb5IcO
         50nuuN9gqMSIIcFTledr7Gbw9+NDDdPiVmpMQs6ePBMXBxlK+lw3v3pnNTcsXXL1dTvq
         +nhSQ8YrSzhxfi0qQ2lV9PMYbUx2Y6sequrRQmTd++xzIU23CmYNuDAySzrWnpxUjxmj
         TGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=mu6VIMQHZgu7hW6pnoLsBEY5Z10dgE369agK010Rc84=;
        b=eKTb9f6HOnVeimhTVq0PKz7FO919ENmEywCXwExqXY0ATi5H8mRhbbbi1RGLvYBBm6
         62C7DwpH2qegCIp2fH3tRNkW1kF79rDd+GP17+rpWTdjYtSIYsaNU/8ZJa9UCSbNLx4t
         DgUF6M33NqRoD584sJ2Dm3Yf1uKse6/92XbOvYYqDzne+ZL5FUq/yWB8BxpAJSNEMCCh
         Q/k8KC91qtH78FqJ/dHWsCsX3DZ+92Oc7wFS7GH5Rf7knSKSYUVAoHwgvpJSmAHtCTeT
         iY+Nv7esLavTWKeBEQEA6uD6LPANZr2fFzvwWxp1A0svUhcX6z4WuPjWuupGz+ZllSUd
         bFtA==
X-Gm-Message-State: ACgBeo1Vs0woyDYNuIkg+Ph/VrRS0frd9XnE4ba/VwRdR3aTOL2609iq
        b/BULEELJKD8gx3hew0f10J5n8ahtJUsCQ==
X-Google-Smtp-Source: AA6agR4oN0w6cTpWbsmWpZL8bo4Si3qBVlLe6HqOhimCRoyeTxAPSdKHiWRpfMnic7xMqQTrI8coeg==
X-Received: by 2002:a5d:5965:0:b0:224:f75e:2646 with SMTP id e37-20020a5d5965000000b00224f75e2646mr5769089wri.173.1660590136081;
        Mon, 15 Aug 2022 12:02:16 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z7-20020a05600c0a0700b003a5c2abc412sm11580846wmp.44.2022.08.15.12.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 12:02:15 -0700 (PDT)
Message-ID: <2ab74b1a-7087-cbfc-3f05-92e0eef30ca9@linaro.org>
Date:   Mon, 15 Aug 2022 21:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 00/32] New thermal OF code
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Mark Brown <broonie@kernel.org>,
        damien.lemoal@opensource.wdc.com, Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        mhiramat@kernel.org, Talel Shenhar <talel@amazon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, anarsoul@gmail.com,
        Yangtao Li <tiny.windzz@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        glaroque@baylibre.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Keerthy <j-keerthy@ti.com>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
 <35457e1c-fe6b-2212-9624-70369f04ef0d@linaro.org>
 <CAJZ5v0g5gtQGyLM2C+D5-Y-T_7+GHp4=Ptt7Reh6xgL-D77asQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0g5gtQGyLM2C+D5-Y-T_7+GHp4=Ptt7Reh6xgL-D77asQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

On 28/07/2022 16:37, Rafael J. Wysocki wrote:
> Hi Daniel,
> 
> On Wed, Jul 27, 2022 at 11:46 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> we are close to release v5.19.
>>
>> I want to send a PR this week but it would be nice if this series could
>> be part of it, so the trip point rework we discussed earlier (it is a
>> long series) could be merged more easily for v5.21-rc1 as it will depend
>> on these changes.
>>
>> This series was tested on different platforms, rk3399, broadcom and
>> rcar. The external drivers as ata, touchscreen, regulator, hwmon were
>> acked/reviewed and some other thermal drivers reviewed also. Some others
>> remain without feedback because the maintainer is unresponsive or the
>> driver is orphaned, falling under the thermal framework maintenance
>> umbrella. All the drivers changes are the same.
>>
>> I do believe it does a nice cleanup and consolidation of the OF thermal
>> code and realign it with the core thermal framework.
>>
>> Is it ok to merge the series?
> 
> I would prefer to put it into linux-next for a few days.
> 
> Why don't you send 2 pull requests, one with all of the other material
> you have for 5.20 and another one with this series (it may be on top
> of the first one)?
> 
> I will be able to defer pushing the second one till the second half of
> the merge window.

I setup a branch with the patches and the fixes.

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/v6.0-rc1-2

Is there still time for a PR ?



