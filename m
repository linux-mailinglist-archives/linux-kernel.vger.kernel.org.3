Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E496059911D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiHRXUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiHRXUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:20:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C448EB2;
        Thu, 18 Aug 2022 16:20:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso6079143pjk.0;
        Thu, 18 Aug 2022 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=NK3oPYmCQJH4udrs0XzADJ5rLSUEh35MtVHYmSmGTno=;
        b=lAGkEnLjQS0leDi18SdVWZbt4EMrdoENDIqOb4UhJng/iM9TRoriKt93H6nISAyKcm
         QiUraSMQ9sr7WXPoxce46Lrs1Qu73l+H4pKagsleaOPFWpVX8M1DtZTVMcsa+MR6oUek
         ALrsrimm0tnMTf0DsCpLfpxW0FIjVswoH5Smubu+hLcDb83zlvOKbTkVjEI5j5HYFwVr
         U4R+3F6I8UjxJNqFFJTzS9uQ7e0ryjwKTtxM6oKAeyyfW+onn/4s2myQDzlSPPEecyBW
         BLv37g8Hhx2VlWwzmTTLM9Ob/RXAi1385xfaHosIWLDNBh2g4ljB6GNdAZsPMNm0iM0A
         RyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=NK3oPYmCQJH4udrs0XzADJ5rLSUEh35MtVHYmSmGTno=;
        b=2sDu0q3p603eo+aD8IIeOJbiDIo4bGZFbxhEFZ8LasN2EqJhuBVZCyOxzcR2EEc8aH
         Nq9x7EJVRcrpg1r/tPjslJkFsEScfpOmxGM+DhfjI992aL5ZBrvA5+YZMwp5kZqvcD11
         wSAspUHGyRAmKFMp2H6k6QqLpnLpLL31eNMYlSJcLoOBumMVxuf9PzKtfUdqW32DwHYQ
         YzayOwyMM9qBb/5397D71U4tnMi3YSEz5VaEIVRX/c2NOZSxmY8M9xnO0HBwNpiyr3U0
         Z1wFa5r6rE4kb6zFpEnksQFC06bCTca0QqaI+YZUkWWKnjE4yfRAzdw2Vy81Vjx/ovL3
         GdYw==
X-Gm-Message-State: ACgBeo0WhkhfpNy+cNU6Oo032bslLM1xPCK5d0f+MOmqOJUVtUSrgCDX
        GJ9dpbwZRHN/mj1vejRc0jk=
X-Google-Smtp-Source: AA6agR6sQMJACV9ZAATQcATZQhMwp7ovZzSTbbzQlIi8IFzY8wNOszWiFXbPnS2w1AaQRyX5sEKdDA==
X-Received: by 2002:a17:90b:1e49:b0:1f5:1dbf:4c3a with SMTP id pi9-20020a17090b1e4900b001f51dbf4c3amr11186872pjb.232.1660864842822;
        Thu, 18 Aug 2022 16:20:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 2-20020a630c42000000b004129741dd9dsm1812779pgm.51.2022.08.18.16.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:20:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Aug 2022 16:20:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v1 1/3] hwmon: (pwm-fan) Make use of device properties
Message-ID: <20220818232040.GA3505561@roeck-us.net>
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 06:25:15PM +0300, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Add mod_devicetable.h include.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I had another look at this patch. A substantial part of the changes
is because device properties don't support of_property_read_u32_index(),
reworking the code to use device_property_read_u32_array() instead.
Sorry, I don't like it, it results in a substantial number of unnecessary
changes. Device properties should support the equivalent of
of_property_read_u32_index() instead to simplify conversions.

Guenter

> ---
>  drivers/hwmon/Kconfig   |  2 +-
>  drivers/hwmon/pwm-fan.c | 50 +++++++++++++++++++++--------------------
>  2 files changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e70d9614bec2..58912a5c5de8 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1613,7 +1613,7 @@ source "drivers/hwmon/pmbus/Kconfig"
>  
>  config SENSORS_PWM_FAN
>  	tristate "PWM fan"
> -	depends on (PWM && OF) || COMPILE_TEST
> +	depends on PWM || COMPILE_TEST
>  	depends on THERMAL || THERMAL=n
>  	help
>  	  If you say yes here you get support for fans connected to PWM lines.
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 6c08551d8d14..9ce9f2543861 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -9,10 +9,11 @@
>  
>  #include <linux/hwmon.h>
>  #include <linux/interrupt.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> -#include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/pwm.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sysfs.h>
> @@ -25,7 +26,6 @@ struct pwm_fan_tach {
>  	int irq;
>  	atomic_t pulses;
>  	unsigned int rpm;
> -	u8 pulses_per_revolution;
>  };
>  
>  struct pwm_fan_ctx {
> @@ -36,6 +36,7 @@ struct pwm_fan_ctx {
>  
>  	int tach_count;
>  	struct pwm_fan_tach *tachs;
> +	u32 *pulses_per_revolution;
>  	ktime_t sample_start;
>  	struct timer_list rpm_timer;
>  
> @@ -73,7 +74,7 @@ static void sample_timer(struct timer_list *t)
>  			pulses = atomic_read(&tach->pulses);
>  			atomic_sub(pulses, &tach->pulses);
>  			tach->rpm = (unsigned int)(pulses * 1000 * 60) /
> -				(tach->pulses_per_revolution * delta);
> +				(ctx->pulses_per_revolution[i] * delta);
>  		}
>  
>  		ctx->sample_start = ktime_get();
> @@ -229,16 +230,14 @@ static const struct thermal_cooling_device_ops pwm_fan_cooling_ops = {
>  	.set_cur_state = pwm_fan_set_cur_state,
>  };
>  
> -static int pwm_fan_of_get_cooling_data(struct device *dev,
> -				       struct pwm_fan_ctx *ctx)
> +static int pwm_fan_get_cooling_data(struct device *dev, struct pwm_fan_ctx *ctx)
>  {
> -	struct device_node *np = dev->of_node;
>  	int num, i, ret;
>  
> -	if (!of_find_property(np, "cooling-levels", NULL))
> +	if (!device_property_present(dev, "cooling-levels"))
>  		return 0;
>  
> -	ret = of_property_count_u32_elems(np, "cooling-levels");
> +	ret = device_property_count_u32(dev, "cooling-levels");
>  	if (ret <= 0) {
>  		dev_err(dev, "Wrong data!\n");
>  		return ret ? : -EINVAL;
> @@ -250,8 +249,8 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
>  	if (!ctx->pwm_fan_cooling_levels)
>  		return -ENOMEM;
>  
> -	ret = of_property_read_u32_array(np, "cooling-levels",
> -					 ctx->pwm_fan_cooling_levels, num);
> +	ret = device_property_read_u32_array(dev, "cooling-levels",
> +					     ctx->pwm_fan_cooling_levels, num);
>  	if (ret) {
>  		dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
>  		return ret;
> @@ -302,7 +301,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	mutex_init(&ctx->lock);
>  
> -	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
> +	ctx->pwm = devm_pwm_get(dev, NULL);
>  	if (IS_ERR(ctx->pwm))
>  		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
>  
> @@ -370,6 +369,20 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  		if (!fan_channel_config)
>  			return -ENOMEM;
>  		ctx->fan_channel.config = fan_channel_config;
> +
> +		ctx->pulses_per_revolution = devm_kmalloc_array(dev,
> +								ctx->tach_count,
> +								sizeof(*ctx->pulses_per_revolution),
> +								GFP_KERNEL);
> +		if (!ctx->pulses_per_revolution)
> +			return -ENOMEM;
> +
> +		/* Setup default pulses per revolution */
> +		memset32(ctx->pulses_per_revolution, 2, ctx->tach_count);
> +
> +		device_property_read_u32_array(dev, "pulses-per-revolution",
> +					       ctx->pulses_per_revolution,
> +					       ctx->tach_count);
>  	}
>  
>  	channels = devm_kcalloc(dev, channel_count + 1,
> @@ -381,7 +394,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < ctx->tach_count; i++) {
>  		struct pwm_fan_tach *tach = &ctx->tachs[i];
> -		u32 ppr = 2;
>  
>  		tach->irq = platform_get_irq(pdev, i);
>  		if (tach->irq == -EPROBE_DEFER)
> @@ -397,20 +409,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  			}
>  		}
>  
> -		of_property_read_u32_index(dev->of_node,
> -					   "pulses-per-revolution",
> -					   i,
> -					   &ppr);
> -		tach->pulses_per_revolution = ppr;
> -		if (!tach->pulses_per_revolution) {
> -			dev_err(dev, "pulses-per-revolution can't be zero.\n");
> -			return -EINVAL;
> -		}
> -
>  		fan_channel_config[i] = HWMON_F_INPUT;
>  
>  		dev_dbg(dev, "tach%d: irq=%d, pulses_per_revolution=%d\n",
> -			i, tach->irq, tach->pulses_per_revolution);
> +			i, tach->irq, ctx->pulses_per_revolution[i]);
>  	}
>  
>  	if (ctx->tach_count > 0) {
> @@ -430,7 +432,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  		return PTR_ERR(hwmon);
>  	}
>  
> -	ret = pwm_fan_of_get_cooling_data(dev, ctx);
> +	ret = pwm_fan_get_cooling_data(dev, ctx);
>  	if (ret)
>  		return ret;
>  
