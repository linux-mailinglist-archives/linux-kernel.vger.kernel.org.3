Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2150C588B71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiHCLoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiHCLoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:44:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE41E8A;
        Wed,  3 Aug 2022 04:44:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l19so1824127wms.1;
        Wed, 03 Aug 2022 04:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=LUgPmzfFrSU+sgyYZ7FLrRfFna9TgeCoupYf3hfmbVM=;
        b=I5iSeXD2E2HuW+RNmn6sqrIRZoU+oUnjHcoBMjjcK4Fg829T1o0xuSuO8J8DhWV7ED
         vEEgRzHzWk8Hf5b0vVxS0E+I/ioiSjXGxTdpFo84jTNaNHHkTLBbMNXwkUbAFukospM1
         f2ra3pCkANb2SQe17MGW1JGk3eLcjLZh6ORaMEWvR0Sdv+6uztD+KE6v+j2u34NNWqDk
         WzmS8bf3SUBYUpN/flrHKDDvUrEuXDKgajCogUm/R+jn6rLi5bYgl6TEVHQmLlEI5Le/
         Iz0cY1QqZlAcGiCkmE6Da3h8OW+kzCLhXHoQ0vZuCoMp/Xq/ZjO5LGpCcadpFevI8Dej
         KXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LUgPmzfFrSU+sgyYZ7FLrRfFna9TgeCoupYf3hfmbVM=;
        b=C6FLilupqZG6VVWbgjX48ZG9Pld6ROa2CO3peRFQVSBVtyxRmBjjjH4Uc4HZUdyfmj
         Yi1Oafg+/9uwP0vYB8RZ8KI8Q89jOT92MPWt+1IrRwfjchaA+Qmsle34swkdmvNpbzm8
         SCEcHrYxzEcw9H+MPkfc4LyNNbrZymqYLsAZs6Wry7gCa+ZSBv/UvB3syIyBT4digNzr
         9DjVST/nrrWcvIL5T/cgE5DyVAasravWbL+X7Iy1GOxjN/kMASylNMGeTdww3SHbhbvC
         4ZozLqVXja2JxNjPqiTpfrmxJDxmITKu74sYkmC6VPEPxosgAuwbCB0gVKdyoVvMYZIJ
         CIzw==
X-Gm-Message-State: ACgBeo0mRh6PUdiE4+JtEHbaru7ul3w7TamSwi3/xG3Qs/mfus7P4qh0
        P+S9WfhlnNYTWzH+r9MVAvAt/YczCqMgqw==
X-Google-Smtp-Source: AA6agR7Vug208ac1x5wt34gy+nfQqrOWgxntapVKh5V13+9AI/VPo4Tyuie4HoKDtGIXcWNmktMXzw==
X-Received: by 2002:a05:600c:34c9:b0:3a4:f1d7:edbd with SMTP id d9-20020a05600c34c900b003a4f1d7edbdmr2569978wmq.128.1659527050494;
        Wed, 03 Aug 2022 04:44:10 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b003a2eacc8179sm2307934wms.27.2022.08.03.04.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 04:44:09 -0700 (PDT)
Message-ID: <cb74e4d0-8170-0837-fa43-d269a8db4d90@gmail.com>
Date:   Wed, 3 Aug 2022 13:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/1] leds: mt6360: Get rid of custom
 led_init_default_state_get()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gene Chen <gene_chen@richtek.com>, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>
References: <20220802212532.7091-1-andriy.shevchenko@linux.intel.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220802212532.7091-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2022 23:25, Andy Shevchenko wrote:
> LED core provides a helper to parse default state from firmware node.
> Use it instead of custom implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/leds/flash/leds-mt6360.c | 38 +++++---------------------------
>   1 file changed, 6 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/leds/flash/leds-mt6360.c b/drivers/leds/flash/leds-mt6360.c
> index e1066a52d2d2..1af6c5898343 100644
> --- a/drivers/leds/flash/leds-mt6360.c
> +++ b/drivers/leds/flash/leds-mt6360.c
> @@ -71,10 +71,6 @@ enum {
>   #define MT6360_STRBTO_STEPUS		32000
>   #define MT6360_STRBTO_MAXUS		2432000
>   
> -#define STATE_OFF			0
> -#define STATE_KEEP			1
> -#define STATE_ON			2
> -
>   struct mt6360_led {
>   	union {
>   		struct led_classdev isnk;
> @@ -84,7 +80,7 @@ struct mt6360_led {
>   	struct v4l2_flash *v4l2_flash;
>   	struct mt6360_priv *priv;
>   	u32 led_no;
> -	u32 default_state;
> +	enum led_default_state default_state;
>   };
>   
>   struct mt6360_priv {
> @@ -405,10 +401,10 @@ static int mt6360_isnk_init_default_state(struct mt6360_led *led)
>   		level = LED_OFF;
>   
>   	switch (led->default_state) {
> -	case STATE_ON:
> +	case LEDS_DEFSTATE_ON:
>   		led->isnk.brightness = led->isnk.max_brightness;
>   		break;
> -	case STATE_KEEP:
> +	case LEDS_DEFSTATE_KEEP:
>   		led->isnk.brightness = min(level, led->isnk.max_brightness);
>   		break;
>   	default:
> @@ -443,10 +439,10 @@ static int mt6360_flash_init_default_state(struct mt6360_led *led)
>   		level = LED_OFF;
>   
>   	switch (led->default_state) {
> -	case STATE_ON:
> +	case LEDS_DEFSTATE_ON:
>   		flash->led_cdev.brightness = flash->led_cdev.max_brightness;
>   		break;
> -	case STATE_KEEP:
> +	case LEDS_DEFSTATE_KEEP:
>   		flash->led_cdev.brightness =
>   			min(level, flash->led_cdev.max_brightness);
>   		break;
> @@ -760,25 +756,6 @@ static int mt6360_init_flash_properties(struct mt6360_led *led,
>   	return 0;
>   }
>   
> -static int mt6360_init_common_properties(struct mt6360_led *led,
> -					 struct led_init_data *init_data)
> -{
> -	const char *const states[] = { "off", "keep", "on" };
> -	const char *str;
> -	int ret;
> -
> -	if (!fwnode_property_read_string(init_data->fwnode,
> -					 "default-state", &str)) {
> -		ret = match_string(states, ARRAY_SIZE(states), str);
> -		if (ret < 0)
> -			ret = STATE_OFF;
> -
> -		led->default_state = ret;
> -	}
> -
> -	return 0;
> -}
> -
>   static void mt6360_v4l2_flash_release(struct mt6360_priv *priv)
>   {
>   	int i;
> @@ -852,10 +829,7 @@ static int mt6360_led_probe(struct platform_device *pdev)
>   
>   		led->led_no = reg;
>   		led->priv = priv;
> -
> -		ret = mt6360_init_common_properties(led, &init_data);
> -		if (ret)
> -			goto out_flash_release;
> +		led->default_state = led_init_default_state_get(child);
>   
>   		if (reg == MT6360_VIRTUAL_MULTICOLOR ||
>   		    reg <= MT6360_LED_ISNKML)
