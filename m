Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F254F8FCF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiDHHvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiDHHvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:51:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DFC1DF66E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:49:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p189so4922160wmp.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SWpszhyEBEa7rNr2Yt/uZaQzpgwI+84JhC50zBu0zwo=;
        b=C5iJj/Boy7aENXH76q+tpOfcaNGntAIY81YRiAH0SO0XEbTSMGp+0nIY7wak9PT8Ce
         xK2Cgi8uvYVjygdDAl3TZ0D2TOu2fBY9kEsXTQdhEIKG9P1R8NzRr5GTxgssds6BoiPh
         k581K2cVCqaRRcpCc0FTVojbS1DarOPsdx4NUlfH1bYhMX2lWnfE2K2c26Iv0PV9J1ce
         bH89DtLRxetafk7Y3Yc2ZPOiJCdc8svK0Y/0pW6tmwDxP68D0tWvbNWBUgXtPAhIvnDI
         OPVirjFeyBBrn5Yk8Dfby2oOPicOfEfBYsjhnkW7YOUNzpyZoYiYodSHUmUcF/euPCvc
         K0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=SWpszhyEBEa7rNr2Yt/uZaQzpgwI+84JhC50zBu0zwo=;
        b=ZoXNR6KXtgl0elclfgpg3FldIOpxPsTcYj3CeIeDuVHtRYtX7QMOgH79OEPodGJ6JX
         BcjgP5LvbDRThPYvh89ORCAk2Z7H/h5UjVGvYp409PmDSE9zYLpMNMTbrg2Jkj9LxHaF
         2X+U1Yq6FAG6hEPuCbJNP9rMKF7aX5IW0ZT7I1hhsFLrt9Ni2H9IGzd1gi23kmv/xRSY
         F/LvCxWw7sAYy/n8dAL1K0PaRF/kqd0djKaRZhgBaavU//KiMYQcNTbKfFOXVXDlPo+G
         Ak7iMLmqyT1lHbmbFaiRdag0XehhAr/GE83OlE92JFjqU6u44bUBtGDWCApUiXYgJWto
         WdTQ==
X-Gm-Message-State: AOAM533h4yIH/hTXuLxUwZnf5dmgFG2meBpOFLB10hn278dfk2fKpbbM
        RfesMFkdUKSwZydK+idfgQnD3sukoPA+cHEr
X-Google-Smtp-Source: ABdhPJxEUP0kNqnBesTvyWuNSGfhjJhVPnNDnp1rOA+CchP4oe+GBkjWnIcA5Xc7hb7jvlr467WQ9Q==
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id m3-20020a7bcb83000000b0037ebc503c6bmr16133169wmi.67.1649404152364;
        Fri, 08 Apr 2022 00:49:12 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:eacd:ce6:e294:acd1? ([2001:861:44c0:66c0:eacd:ce6:e294:acd1])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm22710462wrb.8.2022.04.08.00.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 00:49:11 -0700 (PDT)
Message-ID: <58e38622-a041-3e5c-3dca-fa95cd5f59be@baylibre.com>
Date:   Fri, 8 Apr 2022 09:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] drm/solomon: Move device info from ssd130x-i2c to the
 core driver
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@kernel.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220407200205.28838-1-javierm@redhat.com>
 <20220407200205.28838-5-javierm@redhat.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220407200205.28838-5-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/04/2022 22:02, Javier Martinez Canillas wrote:
> These are declared in the ssd130x-i2c transport driver but the information
> is not I2C specific and could be used by other SSD130x transport drivers.
> 
> Move them to the ssd130x core driver and just set the OF device entries to
> an ID that could be used to lookup the correct device into from an array.
> 
> While being there, also move the SSD130X_DATA and SSD130X_COMMAND control
> bytes. Since even though are used by the I2C interface, it could also be
> useful for other transport protocols such as SPI.
> 
> Suggested-by: Chen-Yu Tsai <wens@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>   drivers/gpu/drm/solomon/ssd130x-i2c.c | 51 ++++-------------------
>   drivers/gpu/drm/solomon/ssd130x.c     | 60 +++++++++++++++++++++++++--
>   drivers/gpu/drm/solomon/ssd130x.h     | 13 ++++++
>   3 files changed, 78 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/gpu/drm/solomon/ssd130x-i2c.c b/drivers/gpu/drm/solomon/ssd130x-i2c.c
> index a469679548f8..aa6cc2cb54f9 100644
> --- a/drivers/gpu/drm/solomon/ssd130x-i2c.c
> +++ b/drivers/gpu/drm/solomon/ssd130x-i2c.c
> @@ -53,76 +53,43 @@ static void ssd130x_i2c_shutdown(struct i2c_client *client)
>   	ssd130x_shutdown(ssd130x);
>   }
>   
> -static struct ssd130x_deviceinfo ssd130x_sh1106_deviceinfo = {
> -	.default_vcomh = 0x40,
> -	.default_dclk_div = 1,
> -	.default_dclk_frq = 5,
> -	.page_mode_only = 1,
> -};
> -
> -static struct ssd130x_deviceinfo ssd130x_ssd1305_deviceinfo = {
> -	.default_vcomh = 0x34,
> -	.default_dclk_div = 1,
> -	.default_dclk_frq = 7,
> -};
> -
> -static struct ssd130x_deviceinfo ssd130x_ssd1306_deviceinfo = {
> -	.default_vcomh = 0x20,
> -	.default_dclk_div = 1,
> -	.default_dclk_frq = 8,
> -	.need_chargepump = 1,
> -};
> -
> -static struct ssd130x_deviceinfo ssd130x_ssd1307_deviceinfo = {
> -	.default_vcomh = 0x20,
> -	.default_dclk_div = 2,
> -	.default_dclk_frq = 12,
> -	.need_pwm = 1,
> -};
> -
> -static struct ssd130x_deviceinfo ssd130x_ssd1309_deviceinfo = {
> -	.default_vcomh = 0x34,
> -	.default_dclk_div = 1,
> -	.default_dclk_frq = 10,
> -};
> -
>   static const struct of_device_id ssd130x_of_match[] = {
>   	{
>   		.compatible = "sinowealth,sh1106-i2c",
> -		.data = &ssd130x_sh1106_deviceinfo,
> +		.data = SH1106_ID,
>   	},
>   	{
>   		.compatible = "solomon,ssd1305-i2c",
> -		.data = &ssd130x_ssd1305_deviceinfo,
> +		.data = (void *)SSD1305_ID,
>   	},
>   	{
>   		.compatible = "solomon,ssd1306-i2c",
> -		.data = &ssd130x_ssd1306_deviceinfo,
> +		.data = (void *)SSD1306_ID,
>   	},
>   	{
>   		.compatible = "solomon,ssd1307-i2c",
> -		.data = &ssd130x_ssd1307_deviceinfo,
> +		.data = (void *)SSD1307_ID,
>   	},
>   	{
>   		.compatible = "solomon,ssd1309-i2c",
> -		.data = &ssd130x_ssd1309_deviceinfo,
> +		.data = (void *)SSD1309_ID,
>   	},
>   	/* Deprecated but remain for backward compatibility */
>   	{
>   		.compatible = "solomon,ssd1305fb-i2c",
> -		.data = &ssd130x_ssd1305_deviceinfo,
> +		.data = (void *)SSD1305_ID,
>   	},
>   	{
>   		.compatible = "solomon,ssd1306fb-i2c",
> -		.data = &ssd130x_ssd1306_deviceinfo,
> +		.data = (void *)SSD1306_ID,
>   	},
>   	{
>   		.compatible = "solomon,ssd1307fb-i2c",
> -		.data = &ssd130x_ssd1307_deviceinfo,
> +		.data = (void *)SSD1307_ID,
>   	},
>   	{
>   		.compatible = "solomon,ssd1309fb-i2c",
> -		.data = &ssd130x_ssd1309_deviceinfo,
> +		.data = (void *)SSD1309_ID,
>   	},
>   	{ /* sentinel */ }
>   };
> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
> index a7e784518c69..1f00fd3c0023 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -39,11 +39,9 @@
>   #define DRIVER_MAJOR	1
>   #define DRIVER_MINOR	0
>   
> -#define SSD130X_DATA				0x40
> -#define SSD130X_COMMAND				0x80
> -
>   #define SSD130X_PAGE_COL_START_LOW		0x00
>   #define SSD130X_PAGE_COL_START_HIGH		0x10
> +
>   #define SSD130X_SET_ADDRESS_MODE		0x20
>   #define SSD130X_SET_COL_RANGE			0x21
>   #define SSD130X_SET_PAGE_RANGE			0x22
> @@ -94,6 +92,55 @@
>   
>   #define MAX_CONTRAST 255
>   
> +static struct ssd130x_deviceinfo ssd130x_variants[] =  {
> +	{
> +		.default_vcomh = 0x40,
> +		.default_dclk_div = 1,
> +		.default_dclk_frq = 5,
> +		.page_mode_only = 1,
> +	},

Why not [SH1106_ID] = {

and later:

if (variant < NR_SSD130X_VARIANTS)
	ssd130x->device_info = ssd130x_variants[variant];

instead of less efficient ssd13x_variant_to_info ?

> +	{
> +		.variant = SSD1305_ID,
> +		.default_vcomh = 0x34,
> +		.default_dclk_div = 1,
> +		.default_dclk_frq = 7,
> +	},
> +	{
> +		.variant = SSD1306_ID,
> +		.default_vcomh = 0x20,
> +		.default_dclk_div = 1,
> +		.default_dclk_frq = 8,
> +		.need_chargepump = 1,
> +	},
> +	{
> +		.variant = SSD1307_ID,
> +		.default_vcomh = 0x20,
> +		.default_dclk_div = 2,
> +		.default_dclk_frq = 12,
> +		.need_pwm = 1,
> +	},
> +	{
> +		.variant = SSD1309_ID,
> +		.default_vcomh = 0x34,
> +		.default_dclk_div = 1,
> +		.default_dclk_frq = 10,
> +	}
> +};
> +
> +static const struct ssd130x_deviceinfo *ssd13x_variant_to_info(enum ssd130x_variants variant)
> +{
> +	int i;
> +	const struct ssd130x_deviceinfo *info;
> +
> +	for (i = 0; i < ARRAY_SIZE(ssd130x_variants); i++) {
> +		info = &ssd130x_variants[i];
> +		if (info->variant == variant)
> +			return info;
> +	}
> +
> +	return NULL;
> +}
> +
>   static inline struct ssd130x_device *drm_to_ssd130x(struct drm_device *drm)
>   {
>   	return container_of(drm, struct ssd130x_device, drm);
> @@ -846,6 +893,7 @@ static int ssd130x_get_resources(struct ssd130x_device *ssd130x)
>   struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
>   {
>   	struct ssd130x_device *ssd130x;
> +	enum ssd130x_variants variant;
>   	struct backlight_device *bl;
>   	struct drm_device *drm;
>   	int ret;
> @@ -860,7 +908,11 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
>   
>   	ssd130x->dev = dev;
>   	ssd130x->regmap = regmap;
> -	ssd130x->device_info = device_get_match_data(dev);
> +
> +	variant = (enum ssd130x_variants)device_get_match_data(dev);
> +	ssd130x->device_info = ssd13x_variant_to_info(variant);
> +	if (!ssd130x->device_info)
> +		return ERR_PTR(-EINVAL);
>   
>   	if (ssd130x->device_info->page_mode_only)
>   		ssd130x->page_address_mode = 1;
> diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
> index f5b062576fdf..4e0b62a41aa3 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.h
> +++ b/drivers/gpu/drm/solomon/ssd130x.h
> @@ -18,7 +18,20 @@
>   
>   #include <linux/regmap.h>
>   
> +#define SSD130X_DATA				0x40
> +#define SSD130X_COMMAND				0x80
> +
> +enum ssd130x_variants {
> +	SH1106_ID,
> +	SSD1305_ID,
> +	SSD1306_ID,
> +	SSD1307_ID,
> +	SSD1309_ID,
> +	NR_SSD130X_VARIANTS
> +};
> +
>   struct ssd130x_deviceinfo {
> +	enum ssd130x_variants variant;
>   	u32 default_vcomh;
>   	u32 default_dclk_div;
>   	u32 default_dclk_frq;

Neil
