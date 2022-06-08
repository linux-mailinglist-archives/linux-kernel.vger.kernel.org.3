Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB907542845
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiFHHqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiFHHi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:38:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19EC20E51D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:05:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h19so25842861edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=vDAg7S7CLadJKFThkv78KBFq9JEWVoDrYZeGQAzsD5c=;
        b=iEmsI3iUtwrJDESbXNbCVS2pUxkNtUVmUfQTeKINMxqEx9+dO8MgfeNX6LY1kUam7f
         cntuD8lEmom+Vxn+cF5KKvTT6GbcuWzgvy82rpWRg59hsYzICrjsjLJlo/3y2ORtNMhU
         aSQp3ENcnczs4XzL9kjgd30EVe+X35NjJjQP5Nvqxrnx1+ulByongC9Muxr1VIbBBsnb
         93b+Jpgul3GeXutgiAtwGxgH+Fl7o4EAaf/pa2lYkJdTrukWDRXpkAmMsF533e+BkZ2b
         3bpCiEeowpBBiwJzWvEZg/RD4K05wKa4jWY7xyfG2NRAmnr7wG+trJi4jJeJgYfYBxHx
         NLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=vDAg7S7CLadJKFThkv78KBFq9JEWVoDrYZeGQAzsD5c=;
        b=bAPr32CL75opE+mX70+lyfmx4dm8hZvTNlvxPKL5LOnMQU7XVPYB0D7lxGUWYS87+c
         8JH9YBVlBwIR5xeNh8Pv90FCvMWmdGkmVPJOtrHXNonSt/n/7taSb+U2tPDqAU8cxvoA
         PuzIWnHuAA2u9uoi1y3Zbxo814np31Ne2aEEQD2jb3l5T4fNFGtcG2l80xILaPGDySn4
         AFBigjmkyH6mAiM/InWqQ532DaExyPXPOoAkY7eSVycc8qTTdAK5p2wXboxj10nbdJhM
         o/iq9HBDgquB+DbQ9Hz8bGZpvx+sRP/5FbO97Fi8TCyP5q17A1CLdGwmuDNLdHT9HbsS
         RhMQ==
X-Gm-Message-State: AOAM533Z3rPr6QL7l7QePurQecuyeZZCKVDWZgFP9mBecD6wEtwJqDG6
        4NqWkLYx1VjTATPRskkJSlvdULAEcTmPfQ==
X-Google-Smtp-Source: ABdhPJwl/bFoFqYf0T0M49mkcsr9UXbwPzcWabsJFz0mVIhs2N73IbjO2w/q2c+39Uzq77VaTd4e9w==
X-Received: by 2002:a05:6402:35d0:b0:42e:1a76:67ae with SMTP id z16-20020a05640235d000b0042e1a7667aemr34054145edc.311.1654671918491;
        Wed, 08 Jun 2022 00:05:18 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l4-20020a170906644400b006feb047502bsm8710249ejn.151.2022.06.08.00.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 00:05:17 -0700 (PDT)
Message-ID: <912e86a9-63cf-9d22-2259-193e7212ad7b@linaro.org>
Date:   Wed, 8 Jun 2022 09:05:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] input: misc: rt5120: Add power key support
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     cy_huang <u0084500@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <1654581161-12349-1-git-send-email-u0084500@gmail.com>
 <1654581161-12349-5-git-send-email-u0084500@gmail.com>
 <b37a1a32-056e-cb25-f53a-3028a4d90ece@linaro.org>
In-Reply-To: <b37a1a32-056e-cb25-f53a-3028a4d90ece@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 09:03, Krzysztof Kozlowski wrote:
> On 07/06/2022 07:52, cy_huang wrote:
>> From: ChiYuan Huang <cy_huang@richtek.com>
>>
>> Add RT5120 PMIC power key support.
>>
>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>> ---
>>  drivers/input/misc/Kconfig         |   9 +++
>>  drivers/input/misc/Makefile        |   1 +
>>  drivers/input/misc/rt5120-pwrkey.c | 115 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 125 insertions(+)
>>  create mode 100644 drivers/input/misc/rt5120-pwrkey.c
>>
>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>> index dd5227c..9c0d814 100644
>> --- a/drivers/input/misc/Kconfig
>> +++ b/drivers/input/misc/Kconfig
>> @@ -881,6 +881,15 @@ config INPUT_SC27XX_VIBRA
>>  	  To compile this driver as a module, choose M here. The module will
>>  	  be called sc27xx_vibra.
>>  
>> +config INPUT_RT5120_PWRKEY
>> +	tristate "RT5120 PMIC power key support"
>> +	depends on MFD_RT5120
>> +	help
>> +	  This enables support for RT5120 PMIC power key driver.
>> +
>> +	  To compile this driver as a module, choose M here. the module will
>> +	  be called rt5120-pwerkey.
>> +
>>  config INPUT_STPMIC1_ONKEY
>>  	tristate "STPMIC1 PMIC Onkey support"
>>  	depends on MFD_STPMIC1
>> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
>> index b92c53a..164ea20 100644
>> --- a/drivers/input/misc/Makefile
>> +++ b/drivers/input/misc/Makefile
>> @@ -68,6 +68,7 @@ obj-$(CONFIG_INPUT_RAVE_SP_PWRBUTTON)	+= rave-sp-pwrbutton.o
>>  obj-$(CONFIG_INPUT_RB532_BUTTON)	+= rb532_button.o
>>  obj-$(CONFIG_INPUT_REGULATOR_HAPTIC)	+= regulator-haptic.o
>>  obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+= retu-pwrbutton.o
>> +obj-$(CONFIG_INPUT_RT5120_PWRKEY)	+= rt5120-pwrkey.o
>>  obj-$(CONFIG_INPUT_AXP20X_PEK)		+= axp20x-pek.o
>>  obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
>>  obj-$(CONFIG_INPUT_RK805_PWRKEY)	+= rk805-pwrkey.o
>> diff --git a/drivers/input/misc/rt5120-pwrkey.c b/drivers/input/misc/rt5120-pwrkey.c
>> new file mode 100644
>> index 00000000..42bd2f3
>> --- /dev/null
>> +++ b/drivers/input/misc/rt5120-pwrkey.c
>> @@ -0,0 +1,115 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +#include <linux/bits.h>
>> +#include <linux/input.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#define RT5120_REG_INTSTAT	0x1E
>> +#define RT5120_PWRKEYSTAT_MASK	BIT(7)
>> +
>> +struct rt5120_priv {
>> +	struct regmap *regmap;
>> +	struct input_dev *input;
>> +	int press_irq;
>> +	int release_irq;
>> +};
>> +
>> +static irqreturn_t rt5120_pwrkey_handler(int irq, void *devid)
>> +{
>> +	struct rt5120_priv *priv = devid;
>> +	unsigned int stat;
>> +	bool is_pressed;
>> +	int ret;
>> +
>> +	ret = regmap_read(priv->regmap, RT5120_REG_INTSTAT, &stat);
>> +	if (ret)
>> +		return IRQ_NONE;
>> +
>> +	is_pressed = !(stat & RT5120_PWRKEYSTAT_MASK);
>> +
>> +	if ((is_pressed && irq == priv->press_irq) ||
>> +	    (!is_pressed  && irq == priv->release_irq)) {
>> +		input_report_key(priv->input, KEY_POWER, is_pressed);
>> +		input_sync(priv->input);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int rt5120_pwrkey_probe(struct platform_device *pdev)
>> +{
>> +	struct rt5120_priv *priv;
>> +	int ret;
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	if (!priv->regmap) {
>> +		dev_err(&pdev->dev, "Failed to init regmap\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	priv->press_irq = platform_get_irq_byname(pdev, "pwrkey-press");
>> +	if (priv->press_irq < 0)
>> +		return priv->press_irq;
>> +
>> +	priv->release_irq = platform_get_irq_byname(pdev, "pwrkey-release");
>> +	if (priv->release_irq < 0)
>> +		return priv->release_irq;
> 
> Not described in the bindings. All properties need to be documented.

Hm, it seems it is coming from the parent device, dynamically, so looks ok.


Best regards,
Krzysztof
