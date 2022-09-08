Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C31C5B1805
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiIHJIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiIHJH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:07:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4DAF7551
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:07:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n17-20020a05600c3b9100b003b3235574dbso830459wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=T2/9xebxzNWMrR2+6F0PLx9EMI9J8CEGmCncRuSsyL8=;
        b=eO7It27k7B/0FNHemvQD+MMLVEn3cKOZgQC9kmQyiqoHCf6+wwQlVXpKES5hVLwTI5
         s4i8Gwlmh6k1epjJ5OnNXpsvMPvbjcTyZZnooQcis2wC/kvWtpCOIn9qGCkCQYFn73mz
         DA0ox9F/MgiiYRUnWyOVxLv4OwAVBdreWrj4RtdwYYadmAFfCcPElUKDmm5bf157mxwL
         dOSXO7KknF7upphS4/Lgm7NDjUBfEKnWYuSiul7c1/Ke0xnOdA5y8xQlEg/wUQDyKJbB
         0P4Dfy2KjKql4iUcjcwT6zL/m3YWhMhhgMl7Yy1t5B3WIeE2SKnGAL7vf7PL1PiyWZjo
         yu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=T2/9xebxzNWMrR2+6F0PLx9EMI9J8CEGmCncRuSsyL8=;
        b=pBKiHE8OSqPR9HBiIRUrWd3XWF4A8tr8Wgsr3ZDUtdO4LL0oY05WPfjpLAk2nVFB3C
         +3A5dEThdnMmyUwIrTNUUgo/B2bYl9J6C7Qa0f4ep8T2j42hc3TF0xRv2SQrc6ji0MaT
         5sNKAML7TAlnEHaycRU8ftQvy+ileTgMG+L+2/1RkhFswfqOUwdOpwm6w6iVih9TPfcC
         NcEIu/louEUHw3xWBOXpn3kcX6rfYs8k/CDwXgcUFNUHehP3+FX1BNo18qywT2wfvS45
         nVKHTH+oc9NWko+DU+bnieZdBEkeifIVUZxE7iwmNwLL5/rnkv6yaSEfpTQUrdl7qQ0s
         urDA==
X-Gm-Message-State: ACgBeo2tT6YBKAFBiAwELsoF0+Y8RSgxIed2EMXxe42w3UW+dDZKGikL
        6VYwIo1JIDkJpOBxpOCDJccUgQ==
X-Google-Smtp-Source: AA6agR5gqEKVSm7XgipK5ek0XMItcGd6Kv+VsWlDrzmuKyixgBo9ogpjC0Vx0PWoSmd1owvmCI7cBQ==
X-Received: by 2002:a7b:cd91:0:b0:3a8:5262:6aa9 with SMTP id y17-20020a7bcd91000000b003a852626aa9mr1466610wmj.143.1662628044375;
        Thu, 08 Sep 2022 02:07:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bz9-20020a056000090900b0022584c82c80sm21014654wrb.19.2022.09.08.02.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 02:07:23 -0700 (PDT)
Message-ID: <a5fd6f3e-4795-5953-5fdf-8857051b5e87@linaro.org>
Date:   Thu, 8 Sep 2022 11:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Michael Kao <michael.kao@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20220901133950.115122-1-aouledameur@baylibre.com>
 <20220901133950.115122-5-aouledameur@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220901133950.115122-5-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Amjad,

On 01/09/2022 15:39, Amjad Ouled-Ameur wrote:
> Provide thermal zone to read thermal sensor in the SoC. We can read all the
> thermal sensors value in the SoC by the node /sys/class/thermal/
> 
> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
> on the first read of sensor that often are bogus values.
> This can avoid following warning on boot:
> 
>    thermal thermal_zone6: failed to read out thermal zone (-13)
> 
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> ---
> Changes in V3:
> - Use proper types.
> - Use devm_kmalloc() instead of kmalloc().
> - Fix tabs and spaces.
> 
>   drivers/thermal/mtk_thermal.c | 100 ++++++++++++++++++++++++++--------
>   1 file changed, 76 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 088c388da241..5901787c57f5 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -259,6 +259,11 @@ enum mtk_thermal_version {
>   
>   struct mtk_thermal;
>   
> +struct mtk_thermal_zone {
> +	struct mtk_thermal *mt;
> +	int id;
> +};
> +
>   struct thermal_bank_cfg {
>   	unsigned int num_sensors;
>   	const int *sensors;
> @@ -709,6 +714,32 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
>   		mutex_unlock(&mt->lock);
>   }
>   
> +static int _get_sensor_temp(struct mtk_thermal *mt, int id)
> +{
> +	u32 raw;
> +	int temp;
> +
> +	const struct mtk_thermal_data *conf = mt->conf;
> +
> +	raw = readl(mt->thermal_base + conf->msr[id]);
> +
> +	if (mt->conf->version == MTK_THERMAL_V1)
> +		temp = raw_to_mcelsius_v1(mt, id, raw);
> +	else
> +		temp = raw_to_mcelsius_v2(mt, id, raw);

Can you set a callback at init time instead of checking the version at 
each get_sensor_temp() ?

> +	/*
> +	 * The first read of a sensor often contains very high bogus
> +	 * temperature value. Filter these out so that the system does
> +	 * not immediately shut down.
> +	 */
> +
> +	if (temp > 200000)
> +		return -EAGAIN;
> +	else
> +		return temp;
> +}
> +
>   /**
>    * mtk_thermal_bank_temperature - get the temperature of a bank
>    * @bank:	The bank
> @@ -721,26 +752,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   	struct mtk_thermal *mt = bank->mt;
>   	const struct mtk_thermal_data *conf = mt->conf;
>   	int i, temp = INT_MIN, max = INT_MIN;
> -	u32 raw;
>   
>   	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> -		raw = readl(mt->thermal_base + conf->msr[i]);
> -
> -		if (mt->conf->version == MTK_THERMAL_V1) {
> -			temp = raw_to_mcelsius_v1(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		} else {
> -			temp = raw_to_mcelsius_v2(
> -				mt, conf->bank_data[bank->id].sensors[i], raw);
> -		}
> -
> -		/*
> -		 * The first read of a sensor often contains very high bogus
> -		 * temperature value. Filter these out so that the system does
> -		 * not immediately shut down.
> -		 */
> -		if (temp > 200000)
> -			temp = 0;
> +		temp = _get_sensor_temp(mt, i);
>   
>   		if (temp > max)
>   			max = temp;
> @@ -751,7 +765,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   
>   static int mtk_read_temp(void *data, int *temperature)
>   {
> -	struct mtk_thermal *mt = data;
> +	struct mtk_thermal_zone *tz = data;
> +	struct mtk_thermal *mt = tz->mt;
>   	int i;
>   	int tempmax = INT_MIN;
>   
> @@ -770,10 +785,28 @@ static int mtk_read_temp(void *data, int *temperature)
>   	return 0;
>   }
>   
> +static int mtk_read_sensor_temp(void *data, int *temperature)
> +{
> +	struct mtk_thermal_zone *tz = data;
> +	struct mtk_thermal *mt = tz->mt;
> +	int id = tz->id - 1;
> +
> +	if (id < 0)
> +		return -EACCES;
> +
> +	*temperature = _get_sensor_temp(mt, id);
> +
> +	return 0;
> +}
> +
>   static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
>   	.get_temp = mtk_read_temp,
>   };
> 
> +static const struct thermal_zone_of_device_ops mtk_thermal_sensor_ops = {
> +	.get_temp = mtk_read_sensor_temp,
> +};

Please respin against linux-next, the thermal_zone_of_device_ops 
structure does no longer exist. The conversion is trivial, here is a 
example:

https://lore.kernel.org/all/20220804224349.1926752-21-daniel.lezcano@linexp.org/


>   static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>   				  u32 apmixed_phys_base, u32 auxadc_phys_base,
>   				  int ctrl_id)
> @@ -1072,6 +1105,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   	u64 auxadc_phys_base, apmixed_phys_base;
>   	struct thermal_zone_device *tzdev;
>   	void __iomem *apmixed_base, *auxadc_base;
> +	struct mtk_thermal_zone *tz;
>   
>   	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>   	if (!mt)
> @@ -1161,11 +1195,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, mt);
>   
> -	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
> -						     &mtk_thermal_ops);
> -	if (IS_ERR(tzdev)) {
> -		ret = PTR_ERR(tzdev);
> -		goto err_disable_clk_peri_therm;
> +	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
> +		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> +		if (!tz)
> +			return -ENOMEM;
> +
> +		tz->mt = mt;
> +		tz->id = i;
> +
> +		tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i, tz, (i == 0) ?
> +							     &mtk_thermal_ops :
> +							     &mtk_thermal_sensor_ops);
> +
> +		if (IS_ERR(tzdev)) {
> +			if (PTR_ERR(tzdev) == -ENODEV) {
> +				dev_warn(&pdev->dev,
> +					 "sensor %d not registered in thermal zone in dt\n", i);
> +				continue;
> +			}
> +			if (PTR_ERR(tzdev) == -EACCES) {
> +				ret = PTR_ERR(tzdev);
> +				goto err_disable_clk_peri_therm;
> +			}
> +		}
>   	}
>   
>   	ret = devm_thermal_add_hwmon_sysfs(tzdev);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
