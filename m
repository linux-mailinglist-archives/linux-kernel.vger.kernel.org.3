Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B05834F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiG0Vqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiG0Vqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:46:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2076D11A15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:46:47 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bn9so15298989wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=UTHZkBIfqAgIp5xumlVxOeLSGIH91cdX6GZplKLYQO8=;
        b=XaMELtTEl2/+EBlpmcO+FCMl8LyKZrNarWP7+WX1b4Z8rQ0uJ1zwlMe/iCJGvoHrlU
         5UZslR8zHtMlNCxcNYBbuRntJaMnbXix8TR4wpbbok4ltv+i7yE9B+zWN+UE1Mzj2ISN
         NH6m8hae7dvdGvVKj20E/Jw/FZwcLstA/9Um7ydc/DzFzJyueSfg3K5vYfOexkkH/qWh
         WjGTLkY/CFL6P2R6onq9HMjnQmqcgg6KfKLkKNaEce2DYJBYPJbqetP3LDPjJXooWeX9
         4BDT55tkvVpZc6K16RssjLXN6gEp7p/yunQ9S75cBBwm7+li+YN9QbvIASbj9P0dIJdT
         pR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=UTHZkBIfqAgIp5xumlVxOeLSGIH91cdX6GZplKLYQO8=;
        b=4ZkfWNuRegXDOgA1zgDyQcSPLkYYTggdp87MwrdiY0NjLftMkiGrqIvn4jV/cJ5bcb
         FPK/7mPBEpI8vxApPb60oQf9+DUXOWPx4GetEnIK8EPkONYHLihsfdln2X+njQc8VX9n
         OT5SFNjVZI/t/OMDss5Qk0tJswuWtUmg68/z08A2JYsxnMveyA4lrR56z1056Nu9dgyn
         LQuv3r5ALGWChN9kxbZWPOqTnpOHClVZGiizu/dlaSG0hlAbrazWjqAgFRUKmtZbLFnY
         I5RXpkOHBJ+K/Wqn/Aj7ABPojBGEzBS69xAl8n3Ivqb5E+2ZPBGJK7BXSnyat1TVqpIp
         kIIg==
X-Gm-Message-State: AJIora8MNZ8mzGzTGh4WW3+7telcU9y+rkbbdJ/Yf2YVtqDkKSishrrD
        npYZpk3IV2LSQw1dp/sLdyrxpA==
X-Google-Smtp-Source: AGRyM1sZ9yePoQBzc4injbkypZJk6RZCVufm3T6+Ak8mfMnUjts9ApeGMa7CLZcQz3tzooSl4xLs1Q==
X-Received: by 2002:adf:d083:0:b0:21e:9888:1c56 with SMTP id y3-20020adfd083000000b0021e98881c56mr8273594wrh.544.1658958405596;
        Wed, 27 Jul 2022 14:46:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0? ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.googlemail.com with ESMTPSA id q6-20020adff946000000b002185631adf0sm18023579wrr.23.2022.07.27.14.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 14:46:45 -0700 (PDT)
Message-ID: <35457e1c-fe6b-2212-9624-70369f04ef0d@linaro.org>
Date:   Wed, 27 Jul 2022 23:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 00/32] New thermal OF code
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com, broonie@kernel.org,
        damien.lemoal@opensource.wdc.com, heiko@sntech.de,
        hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
        talel@amazon.com, thierry.reding@gmail.com, digetx@gmail.com,
        jonathanh@nvidia.com, anarsoul@gmail.com, tiny.windzz@gmail.com,
        baolin.wang7@gmail.com, f.fainelli@gmail.com,
        bjorn.andersson@linaro.org, mcoquelin.stm32@gmail.com,
        glaroque@baylibre.com, miquel.raynal@bootlin.com,
        shawnguo@kernel.org, niklas.soderlund@ragnatech.se,
        matthias.bgg@gmail.com, j-keerthy@ti.com
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

we are close to release v5.19.

I want to send a PR this week but it would be nice if this series could 
be part of it, so the trip point rework we discussed earlier (it is a 
long series) could be merged more easily for v5.21-rc1 as it will depend 
on these changes.

This series was tested on different platforms, rk3399, broadcom and 
rcar. The external drivers as ata, touchscreen, regulator, hwmon were 
acked/reviewed and some other thermal drivers reviewed also. Some others 
remain without feedback because the maintainer is unresponsive or the 
driver is orphaned, falling under the thermal framework maintenance 
umbrella. All the drivers changes are the same.

I do believe it does a nice cleanup and consolidation of the OF thermal 
code and realign it with the core thermal framework.

Is it ok to merge the series?


On 27/07/2022 23:02, Daniel Lezcano wrote:
> The following changes are depending on:
> 
>   - 20220722200007.1839356-1-daniel.lezcano@linexp.org
> 
> which are present in the thermal/linux-next branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next
> 
> The series introduces a new thermal OF code. The patch description gives
> a detailed explanation of the changes. Basically we write new OF parsing
> functions, we migrate all the users of the old thermal OF API to the new
> one and then we finish by removing the old OF code.
> 
> That is the second step to rework the thermal OF code. More patches will
> come after that to remove the duplication of the trip definitions in the
> different drivers which will result in more code duplication removed and
> consolidation of the core thermal framework.
> 
> Thanks for those who tested the series on their platform and
> investigated the regression with the disabled by default thermal zones.
> 
> Changelog:
>   v3:
>     - Rebased on the right branch as reported by Niklas Söderlund
>     - Collected more tags
>   v2:
>     - Changed the code in the register thermal zone function to prevent
>       the 'const' annotation being removed in the different drivers
>     - Collected the tags and adding Cc for more context
>     - Changed the first line patch description to comply to the 'input'
>       subsystem format
>     - Give a more detailed description in the changelog for the drivers
>     - Remove pointless calls to unregister as the devm version is used
>       instead
>     - Moved dummy functions from one patch to another to prevent git
>       bisecting issue when THERMAL_OF=n
>     - Fixed thermal zone disabled by default
> 
> Daniel Lezcano (32):
>    thermal/of: Rework the thermal device tree initialization
>    thermal/of: Make new code and old code co-exist
>    thermal/drivers/rockchip: Switch to new of API
>    thermal/drivers/uniphier: Switch to new of API
>    thermal/drivers/generic-adc: Switch to new of API
>    thermal/drivers/mmio: Switch to new of API
>    thermal/drivers/tegra: Switch to new of API
>    thermal/drivers/sun8i: Switch to new of API
>    thermal/drivers/sprd: Switch to new of API
>    thermal/drivers/broadcom: Switch to new of API
>    thermal/drivers/qcom: Switch to new of API
>    thermal/drivers/st: Switch to new of API
>    thermal/drivers/amlogic: Switch to new of API
>    thermal/drivers/armada: Switch to new of API
>    thermal/drivers/db8500: Switch to new of API
>    thermal/drivers/imx: Switch to new of API
>    thermal/drivers/rcar: Switch to new of API
>    thermal/drivers/rzg2l: Switch to new of API
>    thermal/drivers/qoriq: Switch to new of API
>    thermal/drivers/mtk: Switch to new of API
>    thermal/drivers/banggap: Switch to new of API
>    thermal/drivers/maxim: Switch to new of API
>    thermal/drivers/hisilicon: Switch to new of API
>    thermal/drivers/ti-soc: Switch to new of API
>    ata/drivers/ahci_imx: Switch to new of thermal API
>    hwmon/drivers: Switch to new of thermal API
>    iio/drivers/sun4i_gpadc: Switch to new of thermal API
>    Input: sun4i-ts - switch to new of thermal API
>    regulator/drivers/max8976: Switch to new of thermal API
>    thermal/drivers/samsung: Switch to new of thermal API
>    thermal/core: Move set_trip_temp ops to the sysfs code
>    thermal/of: Remove old OF code
> 
>   drivers/ata/ahci_imx.c                        |   15 +-
>   drivers/hwmon/hwmon.c                         |   14 +-
>   drivers/hwmon/scpi-hwmon.c                    |   14 +-
>   drivers/iio/adc/sun4i-gpadc-iio.c             |   12 +-
>   drivers/input/touchscreen/sun4i-ts.c          |   10 +-
>   drivers/regulator/max8973-regulator.c         |   10 +-
>   drivers/thermal/amlogic_thermal.c             |   16 +-
>   drivers/thermal/armada_thermal.c              |   12 +-
>   drivers/thermal/broadcom/bcm2711_thermal.c    |   14 +-
>   drivers/thermal/broadcom/bcm2835_thermal.c    |   14 +-
>   drivers/thermal/broadcom/brcmstb_thermal.c    |   20 +-
>   drivers/thermal/broadcom/ns-thermal.c         |   50 +-
>   drivers/thermal/broadcom/sr-thermal.c         |   16 +-
>   drivers/thermal/db8500_thermal.c              |    8 +-
>   drivers/thermal/hisi_thermal.c                |   14 +-
>   drivers/thermal/imx8mm_thermal.c              |   14 +-
>   drivers/thermal/imx_sc_thermal.c              |   14 +-
>   drivers/thermal/k3_bandgap.c                  |   12 +-
>   drivers/thermal/k3_j72xx_bandgap.c            |   12 +-
>   drivers/thermal/max77620_thermal.c            |    8 +-
>   drivers/thermal/mtk_thermal.c                 |   10 +-
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c      |   19 +-
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c   |   12 +-
>   drivers/thermal/qcom/tsens.c                  |   16 +-
>   drivers/thermal/qoriq_thermal.c               |   12 +-
>   drivers/thermal/rcar_gen3_thermal.c           |   16 +-
>   drivers/thermal/rcar_thermal.c                |   13 +-
>   drivers/thermal/rockchip_thermal.c            |   14 +-
>   drivers/thermal/rzg2l_thermal.c               |   10 +-
>   drivers/thermal/samsung/exynos_tmu.c          |   24 +-
>   drivers/thermal/sprd_thermal.c                |   18 +-
>   drivers/thermal/st/stm_thermal.c              |   16 +-
>   drivers/thermal/sun8i_thermal.c               |   14 +-
>   drivers/thermal/tegra/soctherm.c              |   21 +-
>   drivers/thermal/tegra/tegra-bpmp-thermal.c    |   19 +-
>   drivers/thermal/tegra/tegra30-tsensor.c       |   12 +-
>   drivers/thermal/thermal-generic-adc.c         |   10 +-
>   drivers/thermal/thermal_core.c                |    6 -
>   drivers/thermal/thermal_core.h                |    2 -
>   drivers/thermal/thermal_mmio.c                |   17 +-
>   drivers/thermal/thermal_of.c                  | 1140 ++++++-----------
>   drivers/thermal/thermal_sysfs.c               |    5 +-
>   .../ti-soc-thermal/ti-thermal-common.c        |   16 +-
>   drivers/thermal/uniphier_thermal.c            |   10 +-
>   include/linux/thermal.h                       |   89 +-
>   45 files changed, 709 insertions(+), 1131 deletions(-)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
