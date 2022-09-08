Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91B05B22D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiIHPwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIHPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:52:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3B1F6B9C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:52:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o25so2238068wrf.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EBSJBt/4rQeZDrPhVl92JJf+1TNIVaSARc45/lfhD5k=;
        b=kAbENSgl5oBuyAsqN9csM5nPWPbMNDsODznGSODjKr4XRlpAuZL6v+RFXt1qNuv4q0
         qd6k40C8yqN3BLXLyELPOQ33a59jMF3dRBbipe1WZTXnYX/UVEO1JojmosuG1RzDhqyA
         2VUb2KNGDBzAvH3E0vtIoBCt0lOnAYLVcE40i4OLdDGbYnH2ZCrRa8DpxZHQEtrzoDBP
         +GMAdJcTZ6o7MaV4+Edze/0uwd1uwgjBJB9i8iEpiRstBSmfPl5GX2izLnfNI2ciR9VJ
         GELo9Dyb0jeyh8E2xo5xrVGjqwIo/ap54f32M36JJMIOLiW1O2IXqgyfL6pTX049x3h4
         +w/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EBSJBt/4rQeZDrPhVl92JJf+1TNIVaSARc45/lfhD5k=;
        b=Jvhw3469ejWogtV8YJGxn0r0nkC37KjaTlOLlG0V8FjVwNDvyFYk6iitQ7GvmOIWBH
         IvrFZ20pK8YNkw4RwYiIeqq6EgxXiMmMiQZQep4oQBfMC/S89sXBbNHRiUK5mwsBP1y3
         Ts11HILPC1Hesb3TN4tFuoywpQVtx+6n1rEBuz4dHOLjBsKKbQzwMw8jYsQYgvrZADkC
         /8h88BByhIuWjmqcY/UiaFXY5T+0gkTtK3phrulPcMec1VOUZXSHsqdReeX2I823zBop
         5+QpCtUklsbuNSr31hWjuAlLvqaGVqpwimrvNCuXHjF95vmXj9JJ5fhHEQafKwoeeMPN
         6wcg==
X-Gm-Message-State: ACgBeo3KL9wR78BIg0ycLR8fb/zPGE5klSl2h+TPgqn4fk7ZElQgtJTX
        Qp4mgSGfss4SwzzGlAa0K+FW4A==
X-Google-Smtp-Source: AA6agR4HtMD485TQhY3FS7WjuK4l4FWt4RBZAxXc90hNyiyULvd42jHlYtgBPSBjMyr8H+5QGmUwjA==
X-Received: by 2002:adf:f54a:0:b0:228:951a:2949 with SMTP id j10-20020adff54a000000b00228951a2949mr5428850wrp.240.1662652352815;
        Thu, 08 Sep 2022 08:52:32 -0700 (PDT)
Received: from [10.1.4.17] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y8-20020adfe6c8000000b00228de58ae2bsm8665682wrm.12.2022.09.08.08.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:52:31 -0700 (PDT)
Message-ID: <aa4cc3c6-7f1b-28ff-9d05-287287a1eaa3@baylibre.com>
Date:   Thu, 8 Sep 2022 17:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, matthias.bgg@gmail.com
Cc:     rafael@kernel.org, fparent@baylibre.com, amitk@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com,
        Michael Kao <michael.kao@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20220901133950.115122-1-aouledameur@baylibre.com>
 <20220901133950.115122-5-aouledameur@baylibre.com>
 <a5fd6f3e-4795-5953-5fdf-8857051b5e87@linaro.org>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <a5fd6f3e-4795-5953-5fdf-8857051b5e87@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for the review.

On 9/8/22 11:07, Daniel Lezcano wrote:
>
> Hi Amjad,
>
> On 01/09/2022 15:39, Amjad Ouled-Ameur wrote:
>> Provide thermal zone to read thermal sensor in the SoC. We can read 
>> all the
>> thermal sensors value in the SoC by the node /sys/class/thermal/
>>
>> In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
>> on the first read of sensor that often are bogus values.
>> This can avoid following warning on boot:
>>
>>    thermal thermal_zone6: failed to read out thermal zone (-13)
>>
>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> ---
>> Changes in V3:
>> - Use proper types.
>> - Use devm_kmalloc() instead of kmalloc().
>> - Fix tabs and spaces.
>>
>>   drivers/thermal/mtk_thermal.c | 100 ++++++++++++++++++++++++++--------
>>   1 file changed, 76 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/thermal/mtk_thermal.c 
>> b/drivers/thermal/mtk_thermal.c
>> index 088c388da241..5901787c57f5 100644
>> --- a/drivers/thermal/mtk_thermal.c
>> +++ b/drivers/thermal/mtk_thermal.c
>> @@ -259,6 +259,11 @@ enum mtk_thermal_version {
>>     struct mtk_thermal;
>>   +struct mtk_thermal_zone {
>> +    struct mtk_thermal *mt;
>> +    int id;
>> +};
>> +
>>   struct thermal_bank_cfg {
>>       unsigned int num_sensors;
>>       const int *sensors;
>> @@ -709,6 +714,32 @@ static void mtk_thermal_put_bank(struct 
>> mtk_thermal_bank *bank)
>>           mutex_unlock(&mt->lock);
>>   }
>>   +static int _get_sensor_temp(struct mtk_thermal *mt, int id)
>> +{
>> +    u32 raw;
>> +    int temp;
>> +
>> +    const struct mtk_thermal_data *conf = mt->conf;
>> +
>> +    raw = readl(mt->thermal_base + conf->msr[id]);
>> +
>> +    if (mt->conf->version == MTK_THERMAL_V1)
>> +        temp = raw_to_mcelsius_v1(mt, id, raw);
>> +    else
>> +        temp = raw_to_mcelsius_v2(mt, id, raw);
>
> Can you set a callback at init time instead of checking the version at 
> each get_sensor_temp() ?
>
Good idea, will add it in v4.
>> +    /*
>> +     * The first read of a sensor often contains very high bogus
>> +     * temperature value. Filter these out so that the system does
>> +     * not immediately shut down.
>> +     */
>> +
>> +    if (temp > 200000)
>> +        return -EAGAIN;
>> +    else
>> +        return temp;
>> +}
>> +
>>   /**
>>    * mtk_thermal_bank_temperature - get the temperature of a bank
>>    * @bank:    The bank
>> @@ -721,26 +752,9 @@ static int mtk_thermal_bank_temperature(struct 
>> mtk_thermal_bank *bank)
>>       struct mtk_thermal *mt = bank->mt;
>>       const struct mtk_thermal_data *conf = mt->conf;
>>       int i, temp = INT_MIN, max = INT_MIN;
>> -    u32 raw;
>>         for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
>> -        raw = readl(mt->thermal_base + conf->msr[i]);
>> -
>> -        if (mt->conf->version == MTK_THERMAL_V1) {
>> -            temp = raw_to_mcelsius_v1(
>> -                mt, conf->bank_data[bank->id].sensors[i], raw);
>> -        } else {
>> -            temp = raw_to_mcelsius_v2(
>> -                mt, conf->bank_data[bank->id].sensors[i], raw);
>> -        }
>> -
>> -        /*
>> -         * The first read of a sensor often contains very high bogus
>> -         * temperature value. Filter these out so that the system does
>> -         * not immediately shut down.
>> -         */
>> -        if (temp > 200000)
>> -            temp = 0;
>> +        temp = _get_sensor_temp(mt, i);
>>             if (temp > max)
>>               max = temp;
>> @@ -751,7 +765,8 @@ static int mtk_thermal_bank_temperature(struct 
>> mtk_thermal_bank *bank)
>>     static int mtk_read_temp(void *data, int *temperature)
>>   {
>> -    struct mtk_thermal *mt = data;
>> +    struct mtk_thermal_zone *tz = data;
>> +    struct mtk_thermal *mt = tz->mt;
>>       int i;
>>       int tempmax = INT_MIN;
>>   @@ -770,10 +785,28 @@ static int mtk_read_temp(void *data, int 
>> *temperature)
>>       return 0;
>>   }
>>   +static int mtk_read_sensor_temp(void *data, int *temperature)
>> +{
>> +    struct mtk_thermal_zone *tz = data;
>> +    struct mtk_thermal *mt = tz->mt;
>> +    int id = tz->id - 1;
>> +
>> +    if (id < 0)
>> +        return -EACCES;
>> +
>> +    *temperature = _get_sensor_temp(mt, id);
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
>>       .get_temp = mtk_read_temp,
>>   };
>>
>> +static const struct thermal_zone_of_device_ops 
>> mtk_thermal_sensor_ops = {
>> +    .get_temp = mtk_read_sensor_temp,
>> +};
>
> Please respin against linux-next, the thermal_zone_of_device_ops 
> structure does no longer exist. The conversion is trivial, here is a 
> example:
>
> https://lore.kernel.org/all/20220804224349.1926752-21-daniel.lezcano@linexp.org/ 
>
>
Sure, will do.
>
>>   static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>>                     u32 apmixed_phys_base, u32 auxadc_phys_base,
>>                     int ctrl_id)
>> @@ -1072,6 +1105,7 @@ static int mtk_thermal_probe(struct 
>> platform_device *pdev)
>>       u64 auxadc_phys_base, apmixed_phys_base;
>>       struct thermal_zone_device *tzdev;
>>       void __iomem *apmixed_base, *auxadc_base;
>> +    struct mtk_thermal_zone *tz;
>>         mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>>       if (!mt)
>> @@ -1161,11 +1195,29 @@ static int mtk_thermal_probe(struct 
>> platform_device *pdev)
>>         platform_set_drvdata(pdev, mt);
>>   -    tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
>> -                             &mtk_thermal_ops);
>> -    if (IS_ERR(tzdev)) {
>> -        ret = PTR_ERR(tzdev);
>> -        goto err_disable_clk_peri_therm;
>> +    for (i = 0; i < mt->conf->num_sensors + 1; i++) {
>> +        tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
>> +        if (!tz)
>> +            return -ENOMEM;
>> +
>> +        tz->mt = mt;
>> +        tz->id = i;
>> +
>> +        tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i, 
>> tz, (i == 0) ?
>> +                                 &mtk_thermal_ops :
>> +                                 &mtk_thermal_sensor_ops);
>> +
>> +        if (IS_ERR(tzdev)) {
>> +            if (PTR_ERR(tzdev) == -ENODEV) {
>> +                dev_warn(&pdev->dev,
>> +                     "sensor %d not registered in thermal zone in 
>> dt\n", i);
>> +                continue;
>> +            }
>> +            if (PTR_ERR(tzdev) == -EACCES) {
>> +                ret = PTR_ERR(tzdev);
>> +                goto err_disable_clk_peri_therm;
>> +            }
>> +        }
>>       }
>>         ret = devm_thermal_add_hwmon_sysfs(tzdev);
>
>
Regards,

Amjad

