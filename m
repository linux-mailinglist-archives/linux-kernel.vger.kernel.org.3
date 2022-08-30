Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A635A646F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiH3NNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiH3NNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:13:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A27B6558;
        Tue, 30 Aug 2022 06:13:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j5so7188306plj.5;
        Tue, 30 Aug 2022 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=6yz7pRlaJnk6NjQeiyNZRvPH5BtqOZRYNlWkwSm32ms=;
        b=SJWxB1yDkPp8rqt+0AaDq0hqrjmKwzU69RziJEQIvrDUZsTcL0hv95RSMPWJxvheUw
         0V/rjta0c6G2OK/uczziLaAeblsOFoGqLLCunJNKezRcH/vWWERFwtINtJKF4Q1+wKzB
         GM5VmPP5+xZ5FUtOOh2Tfn9fsW51Ghkei6ubELewuyIVMjsOasVSQR5mgArXY3MBh4q+
         tbnGceFYe3wuubKBX5VP2zp2DqbwpCtmuEM0O71dRzUy9f9qVN3nuEBSrVGjTk1alSjd
         zfEYgO20FXK0qpfOxG5IlV7VPkzocnyeWw9xD7tHzgmXW1sv2Y9ksi/+9LVw0ek6m+/L
         8H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=6yz7pRlaJnk6NjQeiyNZRvPH5BtqOZRYNlWkwSm32ms=;
        b=dvc/Wl6NVGKSyM2/BZjOteai7GVOkrttfsBYV+KEj8lf4s9fsu0bSxBj6xvj7Fvyww
         F4bK95uNWEyCXmld594DzOemizCKwrTINIuxrjxDErf276hQMrEo5JKGMAwZVaQctH/m
         2U5v7O94ieC31OkOYFveuQKMWkGArJFnvDonsa7ygkMT71g/QO2ew1BObZs1ZTQDFlXc
         Vd1hvWRyvwB/OH6/eU4X5NEAYoTrWiFMiAGF86/0xq8D7uepWiGgVrK580Ivp3XgSZE/
         hsBsFZCmQywLeyaEdlM3/q4CxIgEdZIXNDtuHbuIS5knmmn/zNdaLY99MfOs85NXD1xD
         nvRA==
X-Gm-Message-State: ACgBeo2rIWe9ADEA5Wemupab2O1JEcT9DdRzZqdgnPp+gyvoRBQbrZ2u
        mGdHAi4As6RhY4Te+9qMJj1TEWZLVslpTQ==
X-Google-Smtp-Source: AA6agR73k62SQIAVVsTRyHn3x5anVmWWWCjSuzT4nSmMMu3RYAbfUGfRFEXaon0X4NaVh8FppkN+7g==
X-Received: by 2002:a17:902:7783:b0:173:11e6:a580 with SMTP id o3-20020a170902778300b0017311e6a580mr21366778pll.10.1661865210618;
        Tue, 30 Aug 2022 06:13:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k15-20020a62840f000000b0052ddccd7b64sm9357358pfd.205.2022.08.30.06.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:13:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a0b4c8ed-36a0-2693-3199-214c5fcd26e7@roeck-us.net>
Date:   Tue, 30 Aug 2022 06:13:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] rtc: isl12022: add support for temperature sensor
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220830100152.698506-7-linux@rasmusvillemoes.dk>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220830100152.698506-7-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 03:01, Rasmus Villemoes wrote:
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>   drivers/rtc/rtc-isl12022.c | 81 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
> index b295ec92ee17..1bd72f436318 100644
> --- a/drivers/rtc/rtc-isl12022.c
> +++ b/drivers/rtc/rtc-isl12022.c
> @@ -17,6 +17,8 @@
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/regmap.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>   
>   /* ISL register offsets */
>   #define ISL12022_REG_SC		0x00
> @@ -30,6 +32,9 @@
>   #define ISL12022_REG_SR		0x07
>   #define ISL12022_REG_INT	0x08
>   
> +#define ISL12022_REG_BETA	0x0d
> +#define ISL12022_REG_TEMP_L	0x28
> +
>   /* ISL register bits */
>   #define ISL12022_HR_MIL		(1 << 7)	/* military or 24 hour time */
>   
> @@ -38,6 +43,7 @@
>   
>   #define ISL12022_INT_WRTC	(1 << 6)
>   
> +#define ISL12022_BETA_TSE	(1 << 7)
>   
>   static struct i2c_driver isl12022_driver;
>   
> @@ -48,6 +54,79 @@ struct isl12022 {
>   	bool write_enabled;	/* true if write enable is set */
>   };
>   
> +/*
> + * A user-initiated temperature conversion is not started by this function,
> + * so the temperature is updated once every ~60 seconds.
> + */
> +static int isl12022_hwmon_read_temp(struct device *dev, s32 *mC)
> +{
> +	struct isl12022 *isl12022 = dev_get_drvdata(dev);
> +	struct regmap *regmap = isl12022->regmap;
> +	u8 temp_buf[2];
> +	s32 temp;
> +	int ret;
> +
> +	ret = regmap_bulk_read(regmap, ISL12022_REG_TEMP_L,
> +			       temp_buf, sizeof(temp_buf));
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Temperature is represented as a 10-bit number, unit half-Kelvins.
> +	 */
> +	temp = (temp_buf[1] << 8) | temp_buf[0];
> +	temp *= 500;
> +	temp -= 273000;
> +
> +	*mC = temp;
> +
> +	return 0;
> +}
> +
> +static ssize_t
> +isl12022_hwmon_show_temp(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	int ret;
> +	s32 temp;
> +
> +	ret = isl12022_hwmon_read_temp(dev, &temp);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", temp);
> +}
> +static SENSOR_DEVICE_ATTR(temp1_input, 0444, isl12022_hwmon_show_temp,
> +			  NULL, 0);
> +
> +static struct attribute *isl12022_hwmon_attrs[] = {
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(isl12022_hwmon);
> +
> +static void isl12022_hwmon_register(struct device *dev)
> +{
> +	struct isl12022 *isl12022;
> +	struct device *hwmon;
> +	int ret;
> +
> +	if (!IS_REACHABLE(CONFIG_HWMON))
> +		return;
> +
> +	isl12022 = dev_get_drvdata(dev);
> +
> +	ret = regmap_update_bits(isl12022->regmap, ISL12022_REG_BETA,
> +				 ISL12022_BETA_TSE, ISL12022_BETA_TSE);
> +	if (ret) {
> +		dev_warn(dev, "unable to enable temperature sensor\n");
> +		return;
> +	}
> +
> +	hwmon = devm_hwmon_device_register_with_groups(dev, "isl12022", isl12022,
> +						       isl12022_hwmon_groups);

Please use devm_hwmon_device_register_with_info().

Thanks,
Guenter

> +	if (IS_ERR(hwmon))
> +		dev_warn(dev, "unable to register hwmon device: %pe\n", hwmon);
> +}
> +
>   /*
>    * In the routines that deal directly with the isl12022 hardware, we use
>    * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
> @@ -179,6 +258,8 @@ static int isl12022_probe(struct i2c_client *client)
>   		return PTR_ERR(isl12022->regmap);
>   	}
>   
> +	isl12022_hwmon_register(&client->dev);
> +
>   	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
>   	if (IS_ERR(isl12022->rtc))
>   		return PTR_ERR(isl12022->rtc);

