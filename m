Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3DD465027
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbhLAOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:43:52 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:47184 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbhLAOhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:37:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638369220; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=L+mYpUaBMwz6/WrW+QGdFZ9jT0Yut5tWwzVuyzc8mRI=; b=P2dCbxye2HG4RdOkTQ2+5oDMMehan5hdjmZxAIioZa225U98YXAqnakvqAYRknhQJ+zGnKIO
 ZzWa5ma1EArFu8IpvGGxl5cdlCYhhKw/FuFI4LEsfQzxm53IRxgaPeHYTROTk+82nQ/vNBQq
 e/yXN7fGGEwj23h1rNW9+AAmy6c=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 61a787c3135a8a9d0e444571 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 01 Dec 2021 14:33:38
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0C205C43619; Wed,  1 Dec 2021 14:33:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [10.242.143.72] (unknown [202.46.23.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB82BC4338F;
        Wed,  1 Dec 2021 14:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org AB82BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v3 3/5] pinctrl: qcom: Move chip specific functions to
 right files
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
 <bb08af7e-3b90-2d64-3bb1-f82cc6686184@linaro.org>
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Organization: Qualcomm India Private Limited.
Message-ID: <342898d1-59ef-9104-658d-d992c0126361@codeaurora.org>
Date:   Wed, 1 Dec 2021 20:03:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <bb08af7e-3b90-2d64-3bb1-f82cc6686184@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/1/2021 4:11 PM, Srinivas Kandagatla wrote:
Thanks for your time Srini!!!
>
> On 29/11/2021 09:58, Srinivasa Rao Mandadapu wrote:
>> Update lpass lpi pin control driver to accommodate new lpass variant
>> SoC specific drivers.
>> Move sm8250 SoC specific functions to pinctrl-sm8250-lpass-lpi.c file
>> and common declarations to pinctrl-lpass-lpi.h header file.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
>> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
>> ---
>>   drivers/pinctrl/qcom/Makefile                   |   1 +
>>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 251 
>> +-----------------------
>>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        | 139 +++++++++++++
>>   drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c | 125 ++++++++++++
>>   4 files changed, 271 insertions(+), 245 deletions(-)
>>   create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
>>
>> diff --git a/drivers/pinctrl/qcom/Makefile 
>> b/drivers/pinctrl/qcom/Makefile
>> index 7a12e8c..74568cf 100644
>> --- a/drivers/pinctrl/qcom/Makefile
>> +++ b/drivers/pinctrl/qcom/Makefile
>> @@ -37,3 +37,4 @@ obj-$(CONFIG_PINCTRL_SM8150) += pinctrl-sm8150.o
>>   obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
>>   obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
>>   obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
>> +obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
>
> This is confusing, either we make new
> CONFIG_PINCTRL_SM8250_LPASS_LPI here and use it for 
> pinctrl-sm8250-lpass-lpi.o
Okay. Will add new config macro. Thought of changing it, but worried 
that existing platforms may get disturbed.
>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c 
>> b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> index 2f19ab4..2641489 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> @@ -4,237 +4,16 @@
>>    * Copyright (c) 2020 Linaro Ltd.
>>    */
>>   -#include <linux/bitops.h>
>> -#include <linux/bitfield.h>
>
> Looks like some of these are removed without a reason.
>
Actually, as functions distributed to different files, moved few of them 
to corresponding files,

and observed few of them are not required. could you please suggest on this?

>
>>   #include <linux/clk.h>
>>   #include <linux/gpio/driver.h>
>> -#include <linux/io.h>
>> -#include <linux/module.h>
>>   #include <linux/of_device.h>
>> -#include <linux/of.h>
>>   #include <linux/pinctrl/pinconf-generic.h>
>>   #include <linux/pinctrl/pinconf.h>
>>   #include <linux/pinctrl/pinmux.h>
>> -#include <linux/platform_device.h>
>> -#include <linux/slab.h>
>> -#include <linux/types.h>
>>   #include "../core.h"
>>   #include "../pinctrl-utils.h"
>> +#include "pinctrl-lpass-lpi.h"
>
> ...
>
>
>> -
>> -module_platform_driver(lpi_pinctrl_driver);
>> -MODULE_DESCRIPTION("QTI LPI GPIO pin control driver");
>> -MODULE_LICENSE("GPL");
>
> if you build this as Modules your build would fail without 
> MODULE_LICENSE().
Okay. Will change accordingly.
>
>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h 
>> b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>> new file mode 100644
>> index 0000000..b0afb40
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
>> @@ -0,0 +1,139 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2020 Linaro Ltd.
>> + */
>> +#ifndef __PINCTRL_LPASS_LPI_H__
>> +#define __PINCTRL_LPASS_LPI_H__
>> +
>> +#define LPI_SLEW_RATE_CTL_REG    0xa000
>> +#define LPI_TLMM_REG_OFFSET        0x1000
>> +#define LPI_SLEW_RATE_MAX        0x03
>> +#define LPI_SLEW_BITS_SIZE        0x02
>> +#define LPI_SLEW_RATE_MASK        GENMASK(1, 0)
>> +#define LPI_GPIO_CFG_REG        0x00
>> +#define LPI_GPIO_PULL_MASK        GENMASK(1, 0)
>> +#define LPI_GPIO_FUNCTION_MASK        GENMASK(5, 2)
>> +#define LPI_GPIO_OUT_STRENGTH_MASK    GENMASK(8, 6)
>> +#define LPI_GPIO_OE_MASK        BIT(9)
>> +#define LPI_GPIO_VALUE_REG        0x04
>> +#define LPI_GPIO_VALUE_IN_MASK        BIT(0)
>> +#define LPI_GPIO_VALUE_OUT_MASK        BIT(1)
>> +
>> +#define LPI_GPIO_BIAS_DISABLE        0x0
>> +#define LPI_GPIO_PULL_DOWN        0x1
>> +#define LPI_GPIO_KEEPER            0x2
>> +#define LPI_GPIO_PULL_UP        0x3
>> +#define LPI_GPIO_DS_TO_VAL(v)        (v / 2 - 1)
>> +#define NO_SLEW                -1
>> +
>> +#define LPI_FUNCTION(fname)                            \
>> +    [LPI_MUX_##fname] = {                        \
>> +        .name = #fname,                \
>> +        .groups = fname##_groups,               \
>> +        .ngroups = ARRAY_SIZE(fname##_groups),    \
>> +    }
>> +
>> +#define LPI_PINGROUP(id, soff, f1, f2, f3, f4)        \
>> +    {                        \
>> +        .name = "gpio" #id,            \
>> +        .pins = gpio##id##_pins,        \
>> +        .pin = id,                \
>> +        .slew_offset = soff,            \
>> +        .npins = ARRAY_SIZE(gpio##id##_pins),    \
>> +        .funcs = (int[]){            \
>> +            LPI_MUX_gpio,            \
>> +            LPI_MUX_##f1,            \
>> +            LPI_MUX_##f2,            \
>> +            LPI_MUX_##f3,            \
>> +            LPI_MUX_##f4,            \
>> +        },                    \
>> +        .nfuncs = 5,                \
>> +    }
>> +
>> +struct lpi_pingroup {
>> +    const char *name;
>> +    const unsigned int *pins;
>> +    unsigned int npins;
>> +    unsigned int pin;
>> +    /* Bit offset in slew register for SoundWire pins only */
>> +    int slew_offset;
>> +    unsigned int *funcs;
>> +    unsigned int nfuncs;
>> +};
>> +
>> +struct lpi_function {
>> +    const char *name;
>> +    const char * const *groups;
>> +    unsigned int ngroups;
>> +};
>> +
>> +struct lpi_pinctrl_variant_data {
>> +    const struct pinctrl_pin_desc *pins;
>> +    int npins;
>> +    const struct lpi_pingroup *groups;
>> +    int ngroups;
>> +    const struct lpi_function *functions;
>> +    int nfunctions;
>> +};
>> +
>> +#define MAX_LPI_NUM_CLKS    2
>> +
>> +struct lpi_pinctrl {
>> +    struct device *dev;
>> +    struct pinctrl_dev *ctrl;
>> +    struct gpio_chip chip;
>> +    struct pinctrl_desc desc;
>> +    char __iomem *tlmm_base;
>> +    char __iomem *slew_base;
>> +    struct clk_bulk_data clks[MAX_LPI_NUM_CLKS];
>> +    struct mutex slew_access_lock;
>> +    const struct lpi_pinctrl_variant_data *data;
>> +};
>> +
>
> From here
> <<<
>
>> +enum lpass_lpi_functions {
>> +    LPI_MUX_dmic1_clk,
>> +    LPI_MUX_dmic1_data,
>> +    LPI_MUX_dmic2_clk,
>> +    LPI_MUX_dmic2_data,
>> +    LPI_MUX_dmic3_clk,
>> +    LPI_MUX_dmic3_data,
>> +    LPI_MUX_i2s1_clk,
>> +    LPI_MUX_i2s1_data,
>> +    LPI_MUX_i2s1_ws,
>> +    LPI_MUX_i2s2_clk,
>> +    LPI_MUX_i2s2_data,
>> +    LPI_MUX_i2s2_ws,
>> +    LPI_MUX_qua_mi2s_data,
>> +    LPI_MUX_qua_mi2s_sclk,
>> +    LPI_MUX_qua_mi2s_ws,
>> +    LPI_MUX_swr_rx_clk,
>> +    LPI_MUX_swr_rx_data,
>> +    LPI_MUX_swr_tx_clk,
>> +    LPI_MUX_swr_tx_data,
>> +    LPI_MUX_wsa_swr_clk,
>> +    LPI_MUX_wsa_swr_data,
>> +    LPI_MUX_gpio,
>> +    LPI_MUX__,
>> +};
>> +
>> +static const unsigned int gpio0_pins[] = { 0 };
>> +static const unsigned int gpio1_pins[] = { 1 };
>> +static const unsigned int gpio2_pins[] = { 2 };
>> +static const unsigned int gpio3_pins[] = { 3 };
>> +static const unsigned int gpio4_pins[] = { 4 };
>> +static const unsigned int gpio5_pins[] = { 5 };
>> +static const unsigned int gpio6_pins[] = { 6 };
>> +static const unsigned int gpio7_pins[] = { 7 };
>> +static const unsigned int gpio8_pins[] = { 8 };
>> +static const unsigned int gpio9_pins[] = { 9 };
>> +static const unsigned int gpio10_pins[] = { 10 };
>> +static const unsigned int gpio11_pins[] = { 11 };
>> +static const unsigned int gpio12_pins[] = { 12 };
>> +static const unsigned int gpio13_pins[] = { 13 };
> >>>
> to here are specific to sm8250, so it should not be in header file to 
> start with.

As these are common to all lpass variants.. I feel it's better to keep 
in Header file.

And if new pins comes in later variants, we can add them incrementally, 
and they will not impact existing pin numbers.

I think in upcoming variants number of pins will not decrease.

>
>
>> +
>> +int lpi_pinctrl_probe(struct platform_device *pdev);
>> +int lpi_pinctrl_remove(struct platform_device *pdev);
>> +
>> +#endif /*__PINCTRL_LPASS_LPI_H__*/
>> +
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c 
>> b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
>> new file mode 100644
>> index 0000000..3eba8b3
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
>> @@ -0,0 +1,125 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>
> ...
>
>> +
>> +static struct platform_driver lpi_pinctrl_driver = {
>> +    .driver = {
>> +           .name = "qcom-sm8250-lpass-lpi-pinctrl",
>> +           .of_match_table = lpi_pinctrl_of_match,
>> +    },
>> +    .probe = lpi_pinctrl_probe,
>> +    .remove = lpi_pinctrl_remove,
>> +};
>> +
>> +module_platform_driver(lpi_pinctrl_driver);
>> +MODULE_DESCRIPTION("QTI LPI GPIO pin control driver");
>
> may be :
> "SM8250 LPI GPIO pin control driver"
Okay.. will change accordingly.
>
> --srini
>> +MODULE_LICENSE("GPL");
>> +
>>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

