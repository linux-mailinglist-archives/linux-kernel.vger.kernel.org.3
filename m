Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AECE5A2922
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbiHZOMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiHZOM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:12:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8613780EBB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:12:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay12so963745wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ltPOdgdKPOgNk+QCQTfLV/0eQufbKuZ/Z6D7J07Ijbg=;
        b=Ylk+YjK5vRWW62xLjvKqKh8WyUVgEu8zd2EjP28CyAJOu/KJU9qsWtcOJVtC6jcSf5
         rcKNA58kz8tnPhndOOBnCfqBCGoWH/9L2ZsvhRLaeHRdNZePyxydJGxhkkzG/i2bkvl1
         ETfcyPlTWtwVpRaeprOr5SKdPr83WHsjvUCGh6CKNLd3BPGjtUoHY/dEj1Y9YczMAohG
         IuMfT3QM44GlzDXfJIQwBH35tpM42KBS+nMbIBakgJmCwyEh97nBzFxGThUS+7l27A2f
         sZ0BUx/uWc7MaowR7Md5ewjiR9JfZZCYzqsPlYQzI/2Zd1HtGLX4lOA80STnQMVNH2Yb
         4cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ltPOdgdKPOgNk+QCQTfLV/0eQufbKuZ/Z6D7J07Ijbg=;
        b=aWT2jgLtW11AOTYoni215DIGPQQRJ9SZKwI+e+BMbD+cp8wFRZOj/1kvX4eeacoyn1
         UJuNQI4dBMDtgLuW42OV7wyMLHIj7wrUsKVdGAZIFDUw3aM6R97XDl3ieIJioZkhVqxL
         iS0pkdFhgXf6ow/E/GoIBmY1nCI5UsDlty/CoXuN0eAn7xLv7VAgOUAdiTmNrjwN0neo
         V4WavQ8/VwUBO/qpdVJEo+57L5KqBM6Zd+s8XGkrdzyZrSPPsyhjISq/44RUGb8AuuQ6
         wB2wr9wenrmnr30EgLzRZzYQOfqx4k3TG96+4UPTLsI2SXkFk/gb504Up4oRKYfDV17g
         ntbw==
X-Gm-Message-State: ACgBeo026KuKAo87VkTB8qpvq1EmKbiSKat0NoBA/gIAH3SyoowkIQ8I
        GfjqGPVlosubO5/spZzLmFaBzQ==
X-Google-Smtp-Source: AA6agR74rTXidXuRME3oXuHCtp1ZXLI+aD5krgZxj/g3TEb7Whgmu8sX27kK2BrgnqVjoIn9wfwYdQ==
X-Received: by 2002:a1c:a145:0:b0:3a5:b84b:f746 with SMTP id k66-20020a1ca145000000b003a5b84bf746mr5429572wme.127.1661523142981;
        Fri, 26 Aug 2022 07:12:22 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d4986000000b0021e4829d359sm1918437wrq.39.2022.08.26.07.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 07:12:22 -0700 (PDT)
Message-ID: <cb355b34-f3d2-af63-ad5a-92ea19bf7fcb@baylibre.com>
Date:   Fri, 26 Aug 2022 16:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, fparent@baylibre.com,
        hsinyi@chromium.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, michael.kao@mediatek.com,
        rafael@kernel.org, robh+dt@kernel.org, rui.zhang@intel.com
References: <20220720181854.547881-1-aouledameur@baylibre.com>
 <20220720181854.547881-5-aouledameur@baylibre.com>
 <92540bf4-f2de-0aae-d764-ce6edfda1ab1@wanadoo.fr>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <92540bf4-f2de-0aae-d764-ce6edfda1ab1@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 7/20/22 20:54, Christophe JAILLET wrote:
> Le 20/07/2022 à 20:18, Amjad Ouled-Ameur a écrit :
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
>> Signed-off-by: default avatarMichael Kao 
>> <michael.kao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> Signed-off-by: default avatarHsin-Yi Wang 
>> <hsinyi-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Signed-off-by: Amjad Ouled-Ameur 
>> <aouledameur-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> Tested-by: Amjad Ouled-Ameur 
>> <aouledameur-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> ---
>>   drivers/thermal/mtk_thermal.c | 100 ++++++++++++++++++++++++++--------
>>   1 file changed, 76 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/thermal/mtk_thermal.c 
>> b/drivers/thermal/mtk_thermal.c
>> index 1dc276f8c4f1..79b14ce1a08d 100644
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
>>   +static u32 _get_sensor_temp(struct mtk_thermal *mt, int id)
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
>> +
>> +    /*
>> +     * The first read of a sensor often contains very high bogus
>> +     * temperature value. Filter these out so that the system does
>> +     * not immediately shut down.
>> +     */
>> +
>> +    if (temp > 200000)
>> +        return  -EAGAIN;
>
> This function returns a u32. Is it ok to return -EAGAIN?
>
_get_sensor_temp() should normally return int instead u32, will fix it 
in V3.
> There is also 2 spaces here...
>
>> +    else
>> +        return    temp;
>
> ... and a tab here.
>
will fix them in V3.
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
>
> Is it ok if _get_sensor_temp() returns -EAGAIN?
>
drivers/thermal/thermal_core.c:update_temperature() checks for -EAGAIN 
after

thermal_zone_get_temp() is called, thus, I think it's good to return 
-EAGAIN in

case of failure.

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
>> +        return  -EACCES;
>
> 2 spaces.
>

will fix it in V3.
>> +
>> +    *temperature = _get_sensor_temp(mt, id);
>
> If _get_sensor_temp() returns -EAGAIN, should this be propagated to 
> the caller?
>
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
>>       .get_temp = mtk_read_temp,
>>   };
>>   +static const struct thermal_zone_of_device_ops 
>> mtk_thermal_sensor_ops = {
>> +    .get_temp = mtk_read_sensor_temp,
>> +};
>> +
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
>> +        tz = kmalloc(sizeof(*tz), GFP_KERNEL);
>
> Should this memory allocation be a devm_kmalloc(), or is this memory 
> freed at some point by the framework?
>
> (I don't know the thermal_zone API and the patch has no kfree())
AFAIK, thermal API does not free private data, therefore devm_kmalloc() 
should be used.
>
> CJ
>
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
Thank you Christophe for the review.

Regards,

Amjad

