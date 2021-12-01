Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C5A464BD4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348752AbhLAKou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbhLAKot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:44:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4E8C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 02:41:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso21857014wmr.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ibHT0Tw2kI63la9g5/e7JK0voy9pB0hwBxOsML4cQWY=;
        b=M0xlwYkMfBSDhb1COxiSIw3PukI0zbWBcPI5Lr06ZioqlX127taxVighQ90uy21gaZ
         TzbbNtLfUHjJctXzFMJAsKDqC0wfm/nPNOdYjf/KutokP7fKJxCaioGgRDiSToJJWWXZ
         /9cXUNYtiA0JKmZmMUEsNi0lETQDif8W4FtxHpqEgFzIMOhMAVfJQsP5qegLyQM5oaZ8
         LxwGFEgQDO5Xh3PMizhp9zLOeh9kWIvdLhQaFl6ylrorGQq9l1S7gipy8B7u3hc299hN
         8sVakR2W1Fe9vHUP17IaYkkIvUUKv8YN3c/TlslXRL+r8KH7AeRE8aixBeIghhyG5q3y
         HkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ibHT0Tw2kI63la9g5/e7JK0voy9pB0hwBxOsML4cQWY=;
        b=5GMUXrV21mVOdGfkgpteqI+ygR9428KJrrKCP8I6BFpCAyafqI8Z9QOPmhvWLiW9ex
         LVSMRKzMcpAmWTq9hjIPHA8ovuL6P3MMw1iDp3SmvxLLM5RWNIBxjFRFMyuHYeqFZuPj
         KCS8Q4RxVjYYMQt+OPDbWsXiSM//K/Qb0KJ6v7b8DTee23ZOd0ougVEqqOQzVHS9inQU
         qkFFLvahMbqP8kjicq++PV+7alPVKY/Zf1Q5kqZdUoU9uRezYAaaieDbV/FIrZN3iPUS
         AnY3kSOYg/MpyBFb0o7sjFgmkNqKLH2wOuz3Xet7JjNHu0ncwCKlTSAQHiONxHZGws44
         JzVg==
X-Gm-Message-State: AOAM5320t36pPSGELQouMlJrz62QJoev15MCuIQRrCnGEk3pJFBvY+IN
        6datKmYm8yCULSjQdib5RNgs7Q==
X-Google-Smtp-Source: ABdhPJzcxkjtMoybZu6h0nI9AlFS5ZtL6bj9Td4YIh1MJlCIRbBS8WWcU39uUn2eJZsxwi73jj30sQ==
X-Received: by 2002:a05:600c:35c8:: with SMTP id r8mr5997191wmq.8.1638355287096;
        Wed, 01 Dec 2021 02:41:27 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id o5sm18419836wrx.83.2021.12.01.02.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:41:26 -0800 (PST)
Subject: Re: [PATCH v3 3/5] pinctrl: qcom: Move chip specific functions to
 right files
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1638179932-3353-1-git-send-email-srivasam@codeaurora.org>
 <1638179932-3353-4-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bb08af7e-3b90-2d64-3bb1-f82cc6686184@linaro.org>
Date:   Wed, 1 Dec 2021 10:41:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638179932-3353-4-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/11/2021 09:58, Srinivasa Rao Mandadapu wrote:
> Update lpass lpi pin control driver to accommodate new lpass variant
> SoC specific drivers.
> Move sm8250 SoC specific functions to pinctrl-sm8250-lpass-lpi.c file
> and common declarations to pinctrl-lpass-lpi.h header file.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> ---
>   drivers/pinctrl/qcom/Makefile                   |   1 +
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 251 +-----------------------
>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        | 139 +++++++++++++
>   drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c | 125 ++++++++++++
>   4 files changed, 271 insertions(+), 245 deletions(-)
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
> 
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 7a12e8c..74568cf 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -37,3 +37,4 @@ obj-$(CONFIG_PINCTRL_SM8150) += pinctrl-sm8150.o
>   obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
>   obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
>   obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
> +obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o

This is confusing, either we make new
CONFIG_PINCTRL_SM8250_LPASS_LPI here and use it for 
pinctrl-sm8250-lpass-lpi.o

> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> index 2f19ab4..2641489 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> @@ -4,237 +4,16 @@
>    * Copyright (c) 2020 Linaro Ltd.
>    */
>   
> -#include <linux/bitops.h>
> -#include <linux/bitfield.h>

Looks like some of these are removed without a reason.


>   #include <linux/clk.h>
>   #include <linux/gpio/driver.h>
> -#include <linux/io.h>
> -#include <linux/module.h>
>   #include <linux/of_device.h>
> -#include <linux/of.h>
>   #include <linux/pinctrl/pinconf-generic.h>
>   #include <linux/pinctrl/pinconf.h>
>   #include <linux/pinctrl/pinmux.h>
> -#include <linux/platform_device.h>
> -#include <linux/slab.h>
> -#include <linux/types.h>
>   #include "../core.h"
>   #include "../pinctrl-utils.h"
> +#include "pinctrl-lpass-lpi.h"

...


> -
> -module_platform_driver(lpi_pinctrl_driver);
> -MODULE_DESCRIPTION("QTI LPI GPIO pin control driver");
> -MODULE_LICENSE("GPL");

if you build this as Modules your build would fail without MODULE_LICENSE().


> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> new file mode 100644
> index 0000000..b0afb40
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
> @@ -0,0 +1,139 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020 Linaro Ltd.
> + */
> +#ifndef __PINCTRL_LPASS_LPI_H__
> +#define __PINCTRL_LPASS_LPI_H__
> +
> +#define LPI_SLEW_RATE_CTL_REG	0xa000
> +#define LPI_TLMM_REG_OFFSET		0x1000
> +#define LPI_SLEW_RATE_MAX		0x03
> +#define LPI_SLEW_BITS_SIZE		0x02
> +#define LPI_SLEW_RATE_MASK		GENMASK(1, 0)
> +#define LPI_GPIO_CFG_REG		0x00
> +#define LPI_GPIO_PULL_MASK		GENMASK(1, 0)
> +#define LPI_GPIO_FUNCTION_MASK		GENMASK(5, 2)
> +#define LPI_GPIO_OUT_STRENGTH_MASK	GENMASK(8, 6)
> +#define LPI_GPIO_OE_MASK		BIT(9)
> +#define LPI_GPIO_VALUE_REG		0x04
> +#define LPI_GPIO_VALUE_IN_MASK		BIT(0)
> +#define LPI_GPIO_VALUE_OUT_MASK		BIT(1)
> +
> +#define LPI_GPIO_BIAS_DISABLE		0x0
> +#define LPI_GPIO_PULL_DOWN		0x1
> +#define LPI_GPIO_KEEPER			0x2
> +#define LPI_GPIO_PULL_UP		0x3
> +#define LPI_GPIO_DS_TO_VAL(v)		(v / 2 - 1)
> +#define NO_SLEW				-1
> +
> +#define LPI_FUNCTION(fname)			                \
> +	[LPI_MUX_##fname] = {		                \
> +		.name = #fname,				\
> +		.groups = fname##_groups,               \
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}
> +
> +#define LPI_PINGROUP(id, soff, f1, f2, f3, f4)		\
> +	{						\
> +		.name = "gpio" #id,			\
> +		.pins = gpio##id##_pins,		\
> +		.pin = id,				\
> +		.slew_offset = soff,			\
> +		.npins = ARRAY_SIZE(gpio##id##_pins),	\
> +		.funcs = (int[]){			\
> +			LPI_MUX_gpio,			\
> +			LPI_MUX_##f1,			\
> +			LPI_MUX_##f2,			\
> +			LPI_MUX_##f3,			\
> +			LPI_MUX_##f4,			\
> +		},					\
> +		.nfuncs = 5,				\
> +	}
> +
> +struct lpi_pingroup {
> +	const char *name;
> +	const unsigned int *pins;
> +	unsigned int npins;
> +	unsigned int pin;
> +	/* Bit offset in slew register for SoundWire pins only */
> +	int slew_offset;
> +	unsigned int *funcs;
> +	unsigned int nfuncs;
> +};
> +
> +struct lpi_function {
> +	const char *name;
> +	const char * const *groups;
> +	unsigned int ngroups;
> +};
> +
> +struct lpi_pinctrl_variant_data {
> +	const struct pinctrl_pin_desc *pins;
> +	int npins;
> +	const struct lpi_pingroup *groups;
> +	int ngroups;
> +	const struct lpi_function *functions;
> +	int nfunctions;
> +};
> +
> +#define MAX_LPI_NUM_CLKS	2
> +
> +struct lpi_pinctrl {
> +	struct device *dev;
> +	struct pinctrl_dev *ctrl;
> +	struct gpio_chip chip;
> +	struct pinctrl_desc desc;
> +	char __iomem *tlmm_base;
> +	char __iomem *slew_base;
> +	struct clk_bulk_data clks[MAX_LPI_NUM_CLKS];
> +	struct mutex slew_access_lock;
> +	const struct lpi_pinctrl_variant_data *data;
> +};
> +

 From here
<<<

> +enum lpass_lpi_functions {
> +	LPI_MUX_dmic1_clk,
> +	LPI_MUX_dmic1_data,
> +	LPI_MUX_dmic2_clk,
> +	LPI_MUX_dmic2_data,
> +	LPI_MUX_dmic3_clk,
> +	LPI_MUX_dmic3_data,
> +	LPI_MUX_i2s1_clk,
> +	LPI_MUX_i2s1_data,
> +	LPI_MUX_i2s1_ws,
> +	LPI_MUX_i2s2_clk,
> +	LPI_MUX_i2s2_data,
> +	LPI_MUX_i2s2_ws,
> +	LPI_MUX_qua_mi2s_data,
> +	LPI_MUX_qua_mi2s_sclk,
> +	LPI_MUX_qua_mi2s_ws,
> +	LPI_MUX_swr_rx_clk,
> +	LPI_MUX_swr_rx_data,
> +	LPI_MUX_swr_tx_clk,
> +	LPI_MUX_swr_tx_data,
> +	LPI_MUX_wsa_swr_clk,
> +	LPI_MUX_wsa_swr_data,
> +	LPI_MUX_gpio,
> +	LPI_MUX__,
> +};
> +
> +static const unsigned int gpio0_pins[] = { 0 };
> +static const unsigned int gpio1_pins[] = { 1 };
> +static const unsigned int gpio2_pins[] = { 2 };
> +static const unsigned int gpio3_pins[] = { 3 };
> +static const unsigned int gpio4_pins[] = { 4 };
> +static const unsigned int gpio5_pins[] = { 5 };
> +static const unsigned int gpio6_pins[] = { 6 };
> +static const unsigned int gpio7_pins[] = { 7 };
> +static const unsigned int gpio8_pins[] = { 8 };
> +static const unsigned int gpio9_pins[] = { 9 };
> +static const unsigned int gpio10_pins[] = { 10 };
> +static const unsigned int gpio11_pins[] = { 11 };
> +static const unsigned int gpio12_pins[] = { 12 };
> +static const unsigned int gpio13_pins[] = { 13 };
 >>>
to here are specific to sm8250, so it should not be in header file to 
start with.


> +
> +int lpi_pinctrl_probe(struct platform_device *pdev);
> +int lpi_pinctrl_remove(struct platform_device *pdev);
> +
> +#endif /*__PINCTRL_LPASS_LPI_H__*/
> +
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
> new file mode 100644
> index 0000000..3eba8b3
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*

...

> +
> +static struct platform_driver lpi_pinctrl_driver = {
> +	.driver = {
> +		   .name = "qcom-sm8250-lpass-lpi-pinctrl",
> +		   .of_match_table = lpi_pinctrl_of_match,
> +	},
> +	.probe = lpi_pinctrl_probe,
> +	.remove = lpi_pinctrl_remove,
> +};
> +
> +module_platform_driver(lpi_pinctrl_driver);
> +MODULE_DESCRIPTION("QTI LPI GPIO pin control driver");

may be :
"SM8250 LPI GPIO pin control driver"

--srini
> +MODULE_LICENSE("GPL");
> +
> 
