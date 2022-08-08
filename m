Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D717458C4B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbiHHIIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiHHIIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:08:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2D13F72
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 01:07:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id b6so4375479wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 01:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=NNnX/w4KR5toGD9RgVndtRcxDMqXeRdCj55KEFs2Hv8=;
        b=mUVHiWqRa9/+fNjcjlhL3ZIVdEv+oiML2EZseUm4nq22f0fGCfCizZKJnvt3pe2gEO
         L9DQwRjKxKbH/F31ON/1nqMgQnqCtUZYz5NgPAVTWXW187S7lE7Rqb3FSTq39cEs85wW
         RXIuIXUXvJgNMS/Ji53LQNsRUsLHg1/qGI6RTN4+cjH9KK9M/X+t4nU5gnbNAvCePLvr
         +5vPjLCDlLCHx5+JRJe6e1zBxsWXhz2yIFhv2wjNNYGmyD4w+dDajqfrSWuXSjvZnffb
         vvYLzSOsf6TYpLhack8JnD81N3TGvSrAO/wkYwqIsmHdv6KNakq6M0BS65t9BZ2Mm9hz
         i2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=NNnX/w4KR5toGD9RgVndtRcxDMqXeRdCj55KEFs2Hv8=;
        b=MSljmDwJXonH7JS+fZ/WJp3B3nA/DQ3TomWkTt7GHmJLPvUEvlZOyYm9SvKKIhToBY
         Xx73ban69yIbGZHBgSZv+O42IUpANMKhAiJb4Gcz+yARFuSmLcwAUadInScviS1BYC4W
         ZmrQFcv25STlgVvi/MadM5/sXJ1ucxkFfeTkWuL9cD5XNgU4PtdwLz9ax0f5pLYAFGFO
         5F3TuxL3vuiL1QoG8u5cYiFsOL1RVgPGldubyUsolXZBCClSZKIroPx5GEoDMV5Wv0tm
         QZLoEAHI8Rx2f3FBx8TPw2iVmYQU0HMesIwyzdWHzGmlUoRNXQUnJiqgfT54qKf4TRm9
         u5zg==
X-Gm-Message-State: ACgBeo23EUvyLLv+xrVJb5S0u/y9L4sLc8Tr2ydQp2cc3AljPftDK2u3
        WoFr6kVI1AQKNdAEd46ZfEAa1Q==
X-Google-Smtp-Source: AA6agR49AonvRm2M3vcHwa+yWIj4oRnXBmIYvyOUu0KWLI8WrqrV6s1eZRCopBH5PdEBUUx2tgBr1g==
X-Received: by 2002:a05:600c:35ca:b0:3a3:253b:708b with SMTP id r10-20020a05600c35ca00b003a3253b708bmr16975646wmq.86.1659946074166;
        Mon, 08 Aug 2022 01:07:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1832:7d81:d0f6:dc4b? ([2a01:e0a:982:cbb0:1832:7d81:d0f6:dc4b])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b002205b786ab3sm10767511wrt.14.2022.08.08.01.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:07:53 -0700 (PDT)
Message-ID: <bd18d0ea-10b9-4fc6-3f3e-ace336bd796f@baylibre.com>
Date:   Mon, 8 Aug 2022 10:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 13/33] thermal/drivers/amlogic: Switch to new of API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
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
        matthias.bgg@gmail.com, j-keerthy@ti.com,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL DRIVER FOR AMLOGIC SOCS" 
        <linux-amlogic@lists.infradead.org>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-14-daniel.lezcano@linexp.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220804224349.1926752-14-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 00:43, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
> 
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/amlogic_thermal.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index e61b91d14ad1..d30cb791e63c 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -179,12 +179,12 @@ static int amlogic_thermal_disable(struct amlogic_thermal *data)
>   	return 0;
>   }
>   
> -static int amlogic_thermal_get_temp(void *data, int *temp)
> +static int amlogic_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
>   {
>   	unsigned int tval;
> -	struct amlogic_thermal *pdata = data;
> +	struct amlogic_thermal *pdata = tz->devdata;
>   
> -	if (!data)
> +	if (!pdata)
>   		return -EINVAL;
>   
>   	regmap_read(pdata->regmap, TSENSOR_STAT0, &tval);
> @@ -195,7 +195,7 @@ static int amlogic_thermal_get_temp(void *data, int *temp)
>   	return 0;
>   }
>   
> -static const struct thermal_zone_of_device_ops amlogic_thermal_ops = {
> +static const struct thermal_zone_device_ops amlogic_thermal_ops = {
>   	.get_temp	= amlogic_thermal_get_temp,
>   };
>   
> @@ -276,10 +276,10 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
>   		return PTR_ERR(pdata->sec_ao_map);
>   	}
>   
> -	pdata->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev,
> -							  0,
> -							  pdata,
> -							  &amlogic_thermal_ops);
> +	pdata->tzd = devm_thermal_of_zone_register(&pdev->dev,
> +						   0,
> +						   pdata,
> +						   &amlogic_thermal_ops);
>   	if (IS_ERR(pdata->tzd)) {
>   		ret = PTR_ERR(pdata->tzd);
>   		dev_err(dev, "Failed to register tsensor: %d\n", ret);

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
