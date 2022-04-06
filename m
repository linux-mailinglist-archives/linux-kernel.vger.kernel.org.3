Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE21D4F60D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiDFOPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiDFOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:14:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE64581F91
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:15:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bq8so3194211ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HN/hF2T3o28nadQ/y5E5FRCAcOOGpgeMQA27qzydwpk=;
        b=MMkvKuoQYytHazFBhOjpMZjxYYrtKeORw+InYDqcKGeVymCLGqtah92z4+ZMSzGe+G
         ByUKULQY/X790HdqbYC02VUOeRPdFLvPn72GkQINU8/NXh7wf+sEnQR5P8KjVDX10J/0
         HSo0Hi+x2Yo9MWjxv/OaOLT+CqwIWbn46iIWJJPzXt62NayMr/CFO11vxCTwciz2g7HK
         cwPOWIY9pcrWeXISMIiuglYFC9RCv7reuqsSxPqnB+C5T/EWo8wJnF7O3ZXIfxRK0t1H
         guCc+6pPY+VlLuiKVlSvMWkGoDkRXMfq6wJ8Uwiy11zrYRJ+0y2QDqkyN3sKtKmnG8Fe
         sJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HN/hF2T3o28nadQ/y5E5FRCAcOOGpgeMQA27qzydwpk=;
        b=m2RXWDPhdHOnvHOGlkZnS+cHWBVc0DcLk5eLUcBfzlLmMLVnKTb4cFHfYAsX4XL3q3
         gN10mOfvtheB3vy3k8filnCrpir+wH4AbeiEtqoZYO+uJY1g71kTToQng+Po7xyA9kWj
         D/gypT2Fui7QWCsmomva/0yE8bIEzN1/dcIo5lvRAILp7rr/2I95LL52tg4O3/+g36hS
         v+PjFq78G5q2XwboNeIZ2kFj/iPiA686cOtLQniF2d/pUeiV0CkrClugtsIZ4CR4071o
         kJwuaNAQw8mLmSm8M3V4emtPBhWOgBvC12mGAFX1Lly1GPDaXG+pHEHGlrDAxjRk5RUW
         m+Fg==
X-Gm-Message-State: AOAM530V1je+5yyxfWZ2ZAYfirN8eaVaU128UX9R73ymYH9zRUhQPr+t
        vSBF8pKGxqr9ZZ+YMm6Tbk67LCbGuwyLuwYk
X-Google-Smtp-Source: ABdhPJwP2X65GMx2JGHx74yiRVoSvObt6GnPixnyHYFkcaqt58Yv47hkGnTFGA/62d/3gvFpIh0Xnw==
X-Received: by 2002:a17:906:6a02:b0:6d7:cda:2cf7 with SMTP id qw2-20020a1709066a0200b006d70cda2cf7mr7292595ejc.53.1649240150485;
        Wed, 06 Apr 2022 03:15:50 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j17-20020a05640211d100b00419357a2647sm7949702edw.25.2022.04.06.03.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 03:15:49 -0700 (PDT)
Message-ID: <4ad9e733-7d8b-a73b-c59e-d9b6d5e58498@linaro.org>
Date:   Wed, 6 Apr 2022 12:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] extcon: ptn5150: add usb role class support
Content-Language: en-US
To:     Li Jun <jun.li@nxp.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org, frank.li@nxp.com, xu.yang_2@nxp.com
References: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1649238142-27564-1-git-send-email-jun.li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 11:42, Li Jun wrote:
> Add support of usb role class consumer to do role switch.

Please mention also why you are doing this.

> 
> Signed-off-by: Li Jun <jun.li@nxp.com>
> ---
>  drivers/extcon/Kconfig          |  1 +
>  drivers/extcon/extcon-ptn5150.c | 39 +++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 0d42e49105dd..9828ade787a8 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -132,6 +132,7 @@ config EXTCON_PTN5150
>  	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
>  	depends on I2C && (GPIOLIB || COMPILE_TEST)
>  	select REGMAP_I2C
> +	select USB_ROLE_SWITCH

You do not need to select it. Driver will work without role switch,
won't it? If it works, then probably it should be just imply.

>  	help
>  	  Say Y here to enable support for USB peripheral and USB host
>  	  detection by NXP PTN5150 CC (Configuration Channel) logic chip.
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 5b9a3cf8df26..821b0f390308 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/extcon-provider.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/usb/role.h>
>  
>  /* PTN5150 registers */
>  #define PTN5150_REG_DEVICE_ID			0x01
> @@ -52,6 +53,7 @@ struct ptn5150_info {
>  	int irq;
>  	struct work_struct irq_work;
>  	struct mutex mutex;
> +	struct usb_role_switch *role_sw;
>  };
>  
>  /* List of detectable cables */
> @@ -85,6 +87,12 @@ static void ptn5150_check_state(struct ptn5150_info *info)
>  		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, false);
>  		gpiod_set_value_cansleep(info->vbus_gpiod, 0);
>  		extcon_set_state_sync(info->edev, EXTCON_USB, true);
> +
> +		ret = usb_role_switch_set_role(info->role_sw, USB_ROLE_DEVICE);
> +		if (ret)
> +			dev_err(info->dev, "failed to set device role: %d\n",
> +				ret);
> +
>  		break;
>  	case PTN5150_UFP_ATTACHED:
>  		extcon_set_state_sync(info->edev, EXTCON_USB, false);
> @@ -95,6 +103,12 @@ static void ptn5150_check_state(struct ptn5150_info *info)
>  			gpiod_set_value_cansleep(info->vbus_gpiod, 1);
>  
>  		extcon_set_state_sync(info->edev, EXTCON_USB_HOST, true);
> +
> +		ret = usb_role_switch_set_role(info->role_sw, USB_ROLE_HOST);
> +		if (ret)
> +			dev_err(info->dev, "failed to set host role: %d\n",
> +				ret);
> +


Instead of having usb_role_switch_set_role() in two places, how about:
1. setting local variable to USB_ROLE_HOST/USB_ROLE_NONE
2. return on default
3. one call to usb_role_switch_set_role() outside of the case?

Should create less code.

>  		break;
>  	default:
>  		break;
> @@ -133,6 +147,13 @@ static void ptn5150_irq_work(struct work_struct *work)
>  			extcon_set_state_sync(info->edev,
>  					EXTCON_USB, false);
>  			gpiod_set_value_cansleep(info->vbus_gpiod, 0);
> +
> +			ret = usb_role_switch_set_role(info->role_sw,
> +						       USB_ROLE_NONE);
> +			if (ret)
> +				dev_err(info->dev,
> +					"failed to set none role: %d\n",
> +					ret);
>  		}
>  	}
>  
> @@ -194,6 +215,14 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
>  	return 0;
>  }
>  
> +static void ptn5150_put_role_sw(void *data)
> +{
> +	struct ptn5150_info *info = data;
> +
> +	cancel_work_sync(&info->irq_work);

This looks independent and should be executed always - even if getting
role_sw in probe does not succeed.

> +	usb_role_switch_put(info->role_sw);
> +}
> +



Best regards,
Krzysztof
