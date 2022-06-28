Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFB555D805
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343967AbiF1Ikn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245625AbiF1Ikl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:40:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83B6275D9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:40:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 189so6413429wmz.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Lbg8hiePwmdtMf2MTesLuQh0S2jMkJ7x67kCBoWQYs=;
        b=SEMOuACQA6Q/qb4zYaJeeMbmMF7IcRiJVg8XjLeUCRu6lwKjgSK+F6XnBY0TXROVY+
         YgblATFVUzeZewhX/CvRo3PwPk5IoNrCnFkcpOJsGcTFfNre5QlrWTnW9q6wEVE4YiJO
         JvAnbym9Iru1+wrjQKYeuMxBROiriUeD9Q2XIWc290P+Nh4/0Sh5SVtyS5eI9f7RBsHG
         sH7zcpqYXSfgFyb+uyQ4WigPMs9fhp65KC6K6uF7eTDjLNP9nOEc832aMtsH4VzcvHbZ
         5FirQa8xaZZ7Sr1DIdCjmo98WfcnRsKy4bwO3UAqh6diNmkavuLtGRiwH21HvJ7h/HfH
         zStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Lbg8hiePwmdtMf2MTesLuQh0S2jMkJ7x67kCBoWQYs=;
        b=JjiACbOKQRWgQakBz+YUv2EnXa7NdDXIMhDFgYN/9mjoyRiRLMh8J3yJyj2JMr0wQN
         Z8qSDImN2EyVimBHYqwQ5lTd3UYIg0Jg94mYqBilq3XJy3nLsGP+pQTfeHQsENywOxkF
         BkQNW0La3tmnQYE3EFT2W7lFY51q4rnwsEUZVGa+1xnT//rvuh0yhgAD9bj4zxyOiJ+x
         WTsv+t0kAO3KUg2q3CV6g03KNrATBylHqjsWJ+V0XMwSVre9gIT0bVJ5LaGc1xnaODcx
         jld+KL7pMeTcA6vyB62gV3PMx6xQ/dL/eb2Vsop/TXQGjw/5qRwce1fDOdfgOCyw9NHB
         pFFg==
X-Gm-Message-State: AJIora9MAE0i3EM5+MJhAMDtIXxqso5sLSWZS86bF/kMf9GevJIHOaVk
        S03uhsRwpheNErGiWNbdx7g/BA==
X-Google-Smtp-Source: AGRyM1sYiMX+mQzc6XVbuNuqmR0VfukA/5oXQkaUF29OpnEqJM08oWyRgjHvCHqmSVSo8Qpou5On0Q==
X-Received: by 2002:a05:600c:3553:b0:3a0:519b:4b96 with SMTP id i19-20020a05600c355300b003a0519b4b96mr3067246wmq.61.1656405638275;
        Tue, 28 Jun 2022 01:40:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ay14-20020a5d6f0e000000b0021b91ec8f6esm13037026wrb.67.2022.06.28.01.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:40:37 -0700 (PDT)
Message-ID: <f4b13249-abe8-080f-4d36-24ef67d4fb62@linaro.org>
Date:   Tue, 28 Jun 2022 10:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] thermal/drivers/u8500: Remove the get_trend function
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-3-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220616202537.303655-3-daniel.lezcano@linaro.org>
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


Adding Linus who is missing in the recipient list.


On 16/06/2022 22:25, Daniel Lezcano wrote:
> The get_trend function relies on the interrupt to set the raising or
> dropping trend. However the interpolated temperature is already giving
> the temperature information to the thermal framework which is able to
> deduce the trend.
> 
> Remove the trend code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/db8500_thermal.c | 26 ++++----------------------
>   1 file changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index 21d4d6e6409a..ed40cfd9ab7d 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -53,7 +53,6 @@ static const unsigned long db8500_thermal_points[] = {
>   
>   struct db8500_thermal_zone {
>   	struct thermal_zone_device *tz;
> -	enum thermal_trend trend;
>   	unsigned long interpolated_temp;
>   	unsigned int cur_index;
>   };
> @@ -73,24 +72,12 @@ static int db8500_thermal_get_temp(void *data, int *temp)
>   	return 0;
>   }
>   
> -/* Callback to get temperature changing trend */
> -static int db8500_thermal_get_trend(void *data, int trip, enum thermal_trend *trend)
> -{
> -	struct db8500_thermal_zone *th = data;
> -
> -	*trend = th->trend;
> -
> -	return 0;
> -}
> -
>   static struct thermal_zone_of_device_ops thdev_ops = {
>   	.get_temp = db8500_thermal_get_temp,
> -	.get_trend = db8500_thermal_get_trend,
>   };
>   
>   static void db8500_thermal_update_config(struct db8500_thermal_zone *th,
>   					 unsigned int idx,
> -					 enum thermal_trend trend,
>   					 unsigned long next_low,
>   					 unsigned long next_high)
>   {
> @@ -98,7 +85,6 @@ static void db8500_thermal_update_config(struct db8500_thermal_zone *th,
>   
>   	th->cur_index = idx;
>   	th->interpolated_temp = (next_low + next_high)/2;
> -	th->trend = trend;
>   
>   	/*
>   	 * The PRCMU accept absolute temperatures in celsius so divide
> @@ -127,8 +113,7 @@ static irqreturn_t prcmu_low_irq_handler(int irq, void *irq_data)
>   	}
>   	idx -= 1;
>   
> -	db8500_thermal_update_config(th, idx, THERMAL_TREND_DROPPING,
> -				     next_low, next_high);
> +	db8500_thermal_update_config(th, idx, next_low, next_high);
>   	dev_dbg(&th->tz->device,
>   		"PRCMU set max %ld, min %ld\n", next_high, next_low);
>   
> @@ -149,8 +134,7 @@ static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
>   		next_low = db8500_thermal_points[idx];
>   		idx += 1;
>   
> -		db8500_thermal_update_config(th, idx, THERMAL_TREND_RAISING,
> -					     next_low, next_high);
> +		db8500_thermal_update_config(th, idx, next_low, next_high);
>   
>   		dev_dbg(&th->tz->device,
>   			"PRCMU set max %ld, min %ld\n", next_high, next_low);
> @@ -210,8 +194,7 @@ static int db8500_thermal_probe(struct platform_device *pdev)
>   	dev_info(dev, "thermal zone sensor registered\n");
>   
>   	/* Start measuring at the lowest point */
> -	db8500_thermal_update_config(th, 0, THERMAL_TREND_STABLE,
> -				     PRCMU_DEFAULT_LOW_TEMP,
> +	db8500_thermal_update_config(th, 0, PRCMU_DEFAULT_LOW_TEMP,
>   				     db8500_thermal_points[0]);
>   
>   	platform_set_drvdata(pdev, th);
> @@ -232,8 +215,7 @@ static int db8500_thermal_resume(struct platform_device *pdev)
>   	struct db8500_thermal_zone *th = platform_get_drvdata(pdev);
>   
>   	/* Resume and start measuring at the lowest point */
> -	db8500_thermal_update_config(th, 0, THERMAL_TREND_STABLE,
> -				     PRCMU_DEFAULT_LOW_TEMP,
> +	db8500_thermal_update_config(th, 0, PRCMU_DEFAULT_LOW_TEMP,
>   				     db8500_thermal_points[0]);
>   
>   	return 0;


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
