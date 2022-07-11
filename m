Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE3570013
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiGKLTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiGKLSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:18:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C4D23BC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:42:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so7984280lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4QBRJvxfseZP/GEMFAKFD2cSumF9kaMS829yxVnCjIU=;
        b=kSNvJFyvbyNW4zR+Dm4tF7QqQdfuqItCLjbNcbogU70biRPZYjGvn1OFETlLlTI/Iw
         +uIUwmF5ICn24fOKEdQwisatQVYfwsMzj+wu61S+1olIK0sfdW528zmebCc8QF4oRyRd
         p1uWPddboxciGyBPsT2kiv8ChM+5G0EHh6oDyuzM4NhoGqGA1Z9l9WuoSuHCzjhkENKJ
         DBkrtWtFAFrruy6OyHFO75wDl6opWwmG0wxyOaaf2zc528DOmbSubM1yE/u56f6RwVyT
         pZc/I9YNe2Am9RZYVSoKESIk4bKvqONwucsIuJ4RV7BTQnGLLMwqnQG+l4mVmYyuj4KJ
         qErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4QBRJvxfseZP/GEMFAKFD2cSumF9kaMS829yxVnCjIU=;
        b=JPPoCnFwETxNyQUumxnDOQRC+bEMjCZZQjnm/bQnAxd4fua22FGnuqUQlBFq3tV3nv
         iX5Bj1JUwmLdebndckRiMqBiSEGbnncKJN3x0IK8hppFPgkneo3+vqqyFe0IAEnXojww
         4OJRgToI9N2Z9Bn3eu7MEi+2QTlHSYiSU9GxDWliGqJ45EZqGkndFg0kSMeYQD3b8182
         uviDyxM6wqFWxcSzI2kyV5j0H10GoeVcTJ7gdtRFLcG11BjgNsndumwjBF56suOlgs5w
         Fhcd5hemg63DbQPAzNrlyU1b0KD8FHrf77iJedloUWirzI1uC1NsMWYTLOGOmUjB55cH
         u10A==
X-Gm-Message-State: AJIora/asdN+FEN/uI0DrZm8xPlTSqmsvnrD9KwwNXETpIM5AZcyd27f
        zzdcdSLBTFqMrZVJvcuqO2N0RQ==
X-Google-Smtp-Source: AGRyM1uCOe3mr76NIxQeaEgiqmyu9nGkImm03wxDQOMBkUBd3iUukEak4Y7cE/KQBa5f1A3NbiW5lA==
X-Received: by 2002:a05:6512:1683:b0:47f:78ca:8ac5 with SMTP id bu3-20020a056512168300b0047f78ca8ac5mr11189229lfb.663.1657536120707;
        Mon, 11 Jul 2022 03:42:00 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id s23-20020a056512203700b00489c59819ebsm1477789lfs.66.2022.07.11.03.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:42:00 -0700 (PDT)
Message-ID: <90c85105-b9f4-e7cb-fa93-17127b3b369d@linaro.org>
Date:   Mon, 11 Jul 2022 12:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 31/33] thermal/drivers/samsung: Switch to new of
 thermal API
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, khilman@baylibre.com, abailon@baylibre.com,
        amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-32-daniel.lezcano@linexp.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220710212423.681301-32-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2022 23:24, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach.
> 
> Use this new API.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index f4ab4c5b4b62..2bd7b3b57b28 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -650,9 +650,9 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
>  	writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
>  }
>  
> -static int exynos_get_temp(void *p, int *temp)
> +static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
>  {
> -	struct exynos_tmu_data *data = p;
> +	struct exynos_tmu_data *data = tz->devdata;
>  	int value, ret = 0;
>  
>  	if (!data || !data->tmu_read)
> @@ -728,9 +728,9 @@ static void exynos4412_tmu_set_emulation(struct exynos_tmu_data *data,
>  	writel(val, data->base + emul_con);
>  }
>  
> -static int exynos_tmu_set_emulation(void *drv_data, int temp)
> +static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
>  {
> -	struct exynos_tmu_data *data = drv_data;
> +	struct exynos_tmu_data *data = tz->devdata;
>  	int ret = -EINVAL;
>  
>  	if (data->soc == SOC_ARCH_EXYNOS4210)
> @@ -750,7 +750,7 @@ static int exynos_tmu_set_emulation(void *drv_data, int temp)
>  }
>  #else
>  #define exynos4412_tmu_set_emulation NULL
> -static int exynos_tmu_set_emulation(void *drv_data, int temp)
> +static int exynos_tmu_set_emulation(struct thermal_zone *tz, int temp)
>  	{ return -EINVAL; }
>  #endif /* CONFIG_THERMAL_EMULATION */
>  
> @@ -997,7 +997,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct thermal_zone_of_device_ops exynos_sensor_ops = {
> +static struct thermal_zone_device_ops exynos_sensor_ops = {
>  	.get_temp = exynos_get_temp,
>  	.set_emul_temp = exynos_tmu_set_emulation,
>  };
> @@ -1091,8 +1091,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  	 * data->tzd must be registered before calling exynos_tmu_initialize(),
>  	 * requesting irq and calling exynos_tmu_control().
>  	 */
> -	data->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
> -						    &exynos_sensor_ops);
> +	data->tzd = devm_thermal_of_zone_register(&pdev->dev, 0, data,
> +						  &exynos_sensor_ops);
>  	if (IS_ERR(data->tzd)) {
>  		ret = PTR_ERR(data->tzd);
>  		if (ret != -EPROBE_DEFER)
> @@ -1118,7 +1118,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_thermal:
> -	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
> +	thermal_of_zone_unregister(data->tzd);

You use now devm, so this should not be needed.

>  err_sclk:
>  	clk_disable_unprepare(data->sclk);
>  err_clk:
> @@ -1138,7 +1138,7 @@ static int exynos_tmu_remove(struct platform_device *pdev)
>  	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>  	struct thermal_zone_device *tzd = data->tzd;
>  
> -	thermal_zone_of_sensor_unregister(&pdev->dev, tzd);
> +	thermal_of_zone_unregister(tzd);

This as well.



Best regards,
Krzysztof
