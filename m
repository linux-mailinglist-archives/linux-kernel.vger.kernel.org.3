Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C710E535425
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 21:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348860AbiEZTyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 15:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiEZTyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 15:54:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDF49859D
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:54:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so4853476ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tmwNbvKqL71IPMURm6rrBHmYSOm0rciMZ7lSLg0QGx0=;
        b=VtfhGdnn56bL4F8Lu0E+D37tHxCiMQM7ul1bbl7zzmmumXFHnckqfCO+oAmXgcEh0d
         yqZutoO8b8VmHmjz9IM5Vkbi48pRUgFKTrEVzdsMxwxViKowfr+DpNO3pMoUL3Hwluwa
         2NOTqP/ErEIEsMu/Lwr4GaOXK0dmXA/Q4gR4eOiCyleEBt8OYs5f1iBa41Z5dcxb69Je
         BIoJfToNOzOt2GtBiS0Y3p1nkqAXW+yqJib+zu1XjqJDjnhIoH/g/djC+ExT+sk51jIq
         IWj2zIT+uBFBBY+InfjwIPFUMIkbKMEv1cIcsqi16FOHIavdApp1bxwb9Kh1jbMDGKA3
         mucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tmwNbvKqL71IPMURm6rrBHmYSOm0rciMZ7lSLg0QGx0=;
        b=Hr5yZwzWYEGjMMA/MO3Db9munCkCtG7P23RivI3Ikqp+oOTsuFpV/bTZGg8vE5ybaW
         lURmx9WlbvOj+2xcmUr9/KInQV/SwsBuTZJal3PiT4zxHSGNWqXNtYsJWcJzwGP9swU9
         1XgOXQW9kBP+lE88YZnmaePcYYbCWZfwRwiomuE2/7ev+HWw8yuyao7ao7tUmLUQ/8Cn
         uJJwTr7dKidgNDp2e2m/snzk2Wwrv/EFm6Cq0KYhzpXKe0M6lvtQEUaKO06DQQSDaGF/
         befqHbKjyfu/m/0Pi0VnyWW05aHoD4ygkdQ06OvJHfmINU268hTZPNvKw+4hxss5IRcu
         gQlg==
X-Gm-Message-State: AOAM533c3iidA+urIKCc6aZb+XflMcBndBkqoKPMCxCxYn+WfoczG92g
        Iy9p1Rern5euShu1isKefYUDo8uCUYkzSKGp
X-Google-Smtp-Source: ABdhPJxZdL87x0iMf+OgVyYXKEEQZFVzJS43DDXvqbnUnK/Zthe9bi1Sna9ZaeSIT6mtPmF5L4mEmA==
X-Received: by 2002:a17:907:9495:b0:6ff:14df:d2a with SMTP id dm21-20020a170907949500b006ff14df0d2amr8065757ejc.338.1653594882571;
        Thu, 26 May 2022 12:54:42 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k10-20020a17090646ca00b006fed93bf71dsm802130ejs.42.2022.05.26.12.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 12:54:42 -0700 (PDT)
Message-ID: <597de13b-28c8-3341-be11-da51e22304c3@linaro.org>
Date:   Thu, 26 May 2022 21:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] reset: tps380x: Add TPS380x device driver supprt
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20220525142019.3615253-1-m.felsch@pengutronix.de>
 <20220525142019.3615253-2-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220525142019.3615253-2-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2022 16:20, Marco Felsch wrote:
> The TI TPS380x family [1] is a volatage supervisor with a dedicated
> manual reset (mr) line input and a reset output. The chip(s) have a
> build in reset delay, depending on the chip partnumber. This simple
> driver addresses this so the cosumer don't need to care about it.
> 
> [1] https://www.ti.com/product/TPS3801
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/reset/Kconfig         |   8 +++
>  drivers/reset/Makefile        |   1 +
>  drivers/reset/reset-tps380x.c | 130 ++++++++++++++++++++++++++++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 drivers/reset/reset-tps380x.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index e0fc80e041ea..e2eb616af812 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -256,6 +256,14 @@ config RESET_TI_SYSCON
>  	  you wish to use the reset framework for such memory-mapped devices,
>  	  say Y here. Otherwise, say N.
>  
> +config RESET_TI_TPS380X
> +	tristate "TI TPS380x Reset Driver"
> +	select GPIOLIB
> +	help
> +	  This enables the reset driver support for TI TPS380x devices. If
> +	  you wish to use the reset framework for such devices, say Y here.
> +	  Otherwise, say N.
> +
>  config RESET_TN48M_CPLD
>  	tristate "Delta Networks TN48M switch CPLD reset controller"
>  	depends on MFD_TN48M_CPLD || COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index a80a9c4008a7..66399b92b1bb 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_RESET_STARFIVE_JH7100) += reset-starfive-jh7100.o
>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
>  obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
> +obj-$(CONFIG_RESET_TI_TPS380X) += reset-tps380x.o
>  obj-$(CONFIG_RESET_TN48M_CPLD) += reset-tn48m.o
>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
> diff --git a/drivers/reset/reset-tps380x.c b/drivers/reset/reset-tps380x.c
> new file mode 100644
> index 000000000000..fd2c0929ae2d
> --- /dev/null
> +++ b/drivers/reset/reset-tps380x.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * TI TPS380x Supply Voltage Supervisor and Reset Controller Driver
> + *
> + * Copyright (C) 2022 Pengutronix, Marco Felsch <kernel@pengutronix.de>
> + *
> + * Based on Simple Reset Controller Driver
> + *
> + * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/reset-controller.h>
> +
> +struct tps380x_reset {
> +	struct reset_controller_dev	rcdev;
> +	struct gpio_desc		*reset_gpio;
> +	unsigned int			reset_ms;
> +};
> +
> +struct tps380x_reset_devdata {
> +	unsigned int min_reset_ms;
> +	unsigned int typ_reset_ms;
> +	unsigned int max_reset_ms;
> +};
> +
> +static inline
> +struct tps380x_reset *to_tps380x_reset(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct tps380x_reset, rcdev);
> +}
> +
> +static int
> +tps380x_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct tps380x_reset *tps380x = to_tps380x_reset(rcdev);
> +
> +	gpiod_set_value_cansleep(tps380x->reset_gpio, 1);
> +
> +	return 0;
> +}
> +
> +static int
> +tps380x_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	struct tps380x_reset *tps380x = to_tps380x_reset(rcdev);
> +
> +	gpiod_set_value_cansleep(tps380x->reset_gpio, 0);
> +	msleep(tps380x->reset_ms);
> +
> +	return 0;
> +}
> +
> +const struct reset_control_ops reset_tps380x_ops = {

This looks static.


Best regards,
Krzysztof
