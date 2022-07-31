Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21B4586064
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiGaSpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGaSpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:45:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD992635
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 11:45:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id p10so7414823wru.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=tvOif7D7GjSlYLteSKiLH6y+AMJJ8XB36nHdth7eJaI=;
        b=ySCIVB22C5KydntWmrTt/vJ+FXw3SCt7Qq0EHU4Wsdg2oo0gWbj6Yxwz8cwyy/4I5K
         HENmHYrPnicHJz+eux7lA0koBsdcES1krsyeu6Rz+rpBZiPHb+TTCTlfP/FVQyqR6qlH
         5OJ6yYriM4M95Hd8HA0AuUQsxGPJ+0hVqFFGfywDb5BY/8pSvl7qolw0J915JkE4QIwO
         fnABpzC687Y+xnV6RlQ4Cg59hcz7RyikQg5/y0fj2bZcBDZUCbQ1gXSTOdOIdEaGoROf
         XhtdFr+Y2uKEu0TfDrNYUt4MEK4yGM5Ls4OYoOkxR0Qq8Z3BQwFArZaBCSHXWUawg5Tt
         IADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tvOif7D7GjSlYLteSKiLH6y+AMJJ8XB36nHdth7eJaI=;
        b=SC8GB9ffq7FUOxX4YnHELfKtBKdsB4hGyFX0bacfpkYhiaRsxVCXFse6UUIU9Tb1cH
         UmMtm3LXIWNaPRNpxmrM2p9M3HgXr2GBNm7vGXrMeaHog2dF3AcidJNJwapY1zrVIbLg
         7XVxgNnpy1gi4V9aVFiqkc3pn8QvXSnD6JvWPnofSnv9ujkWN3jSwtOxdEX4oldkNxPg
         KHgtaM85Gf1AqPPZvySkfrX2mCH+A00AOKXCiPIPBGXLevI5BXMRhCtlY4w2sMyyTbsU
         lTDzo+t9OQ+CnQzLs08lqt9rskMnJPC3Nb6Z4bBlVCnOGqFdFUilVOp3j/pvuHSEF1lZ
         7+xA==
X-Gm-Message-State: ACgBeo19+pFpdxgLdP9tSXNTaXbFYBJdCAx1/F+fyTYFYaDN2ja7hZxi
        d88AZ11iLPJFqObWn7fqlVapbA==
X-Google-Smtp-Source: AA6agR63ZHLK7NohlWD4N34eOOAHK775S7u5BEkmukp5cqJ2trsqg6paOiu8M/xH8+DhuG6l8q2scg==
X-Received: by 2002:a5d:6d0c:0:b0:21f:ba0:ff7f with SMTP id e12-20020a5d6d0c000000b0021f0ba0ff7fmr8841442wrq.76.1659293103468;
        Sun, 31 Jul 2022 11:45:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b04a:b59f:f2d8:e65c? ([2a05:6e02:1041:c10:b04a:b59f:f2d8:e65c])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c2ca100b003a3253b706esm17534135wmc.34.2022.07.31.11.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 11:45:03 -0700 (PDT)
Message-ID: <eee44dc0-9717-9ed0-42b0-713ad9fbe688@linexp.org>
Date:   Sun, 31 Jul 2022 20:45:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 27/32] iio/drivers/sun4i_gpadc: Switch to new of
 thermal API
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        broonie@kernel.org, damien.lemoal@opensource.wdc.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>
References: <20220727210253.3794069-1-daniel.lezcano@linexp.org>
 <20220727210253.3794069-28-daniel.lezcano@linexp.org>
 <20220731131328.7301de32@jic23-huawei>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <20220731131328.7301de32@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2022 14:13, Jonathan Cameron wrote:
> On Wed, 27 Jul 2022 23:02:48 +0200
> Daniel Lezcano <daniel.lezcano@linexp.org> wrote:
>
>> The thermal OF code has a new API allowing to migrate the OF
>> initialization to a simpler approach. The ops are no longer device
>> tree specific and are the generic ones provided by the core code.
>>
>> Convert the ops to the thermal_zone_device_ops format and use the new
>> API to register the thermal zone with these generic ops.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> Whilst making no pretence at having checked what the new calls do, I'm fine with this
> patch affecting the driver in IIO and going through appropriate thermal tree.
>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks for reviewing the patch

