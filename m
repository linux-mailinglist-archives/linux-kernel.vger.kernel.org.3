Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558C85640EE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiGBPLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 11:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiGBPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:11:50 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53132BC3F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 08:11:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id B36DE5809B1;
        Sat,  2 Jul 2022 11:11:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 02 Jul 2022 11:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656774706; x=
        1656781906; bh=WlUJqIGfR/wOzO2AjWyOS/FzqIjWHFuWNbbZcRFvDrk=; b=K
        uUk1tXL0awd7O4RX4mxQiHaH4nYvLAKwRwULMTTAbSqhlfGcAT1nXzE4pp10Vjvb
        LddmXJ3xKoqWaY0QG2P68U7MMANQ6CmgZdclJu8w74hcM40uZDAMdSurevqz2gLJ
        FHae/PFSg6B6iiaTBx+6txL9LqVhAePXdocaBIF21Vuc4F1/O7AZY8JbWwQok8iQ
        RdCLb4obPZ2X3N9+uTRg3fmomR8t+UHsomyc07ALDYZi2f9ADte3MMGIRs0wQX59
        bSyjgFbkqrEpeM8ud4BtGa5wST2Wz0GWpxjeP0DOZqirgMztt54SgFRU7bUQRF3Q
        BbkaNZGZ5eP6qYfBP6F6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656774706; x=
        1656781906; bh=WlUJqIGfR/wOzO2AjWyOS/FzqIjWHFuWNbbZcRFvDrk=; b=v
        tFMYBKHBbj+Av+9i5dxazQxSpnv6mEi+7/FCLR+bUStrTfuQjcGpAnSHljUvKzVI
        InugYh02ZH5XYXvHDg0K8+iNGBsczRWsyNRXxZS5LPyC4OVAeU3C4CU2IGUsPLvG
        wewRZ7SYlPyFoaMej0YGQ4t9p2r8/CdbhUTYmn7JWc8EpLbbQ/blwZpZndzTaXw9
        oJsR8rDxmub0jTsB3FSnjo3FPIomRBKDME4k9HoGuz81beJ/V4doCRAu+vMnbA2J
        pTw/oGwHdwFNJPZnUYApSo2FG06pWe5kuA+83vFj/T6ISXcpYEXon+K7Di24kjXn
        jPez0gjJ1xRWMKwqJQcNw==
X-ME-Sender: <xms:MWDAYi3p_aBz3zgjTNv1vCObzI4-tPrPJgOlxD-XNeRb8_Xl2n_x9g>
    <xme:MWDAYlHSDO8LK0svQpe5xr0L4Ta3VxMZCwuPTnuLUFo7ZEujIinP5O85-oelMN0yo
    WhiwHz_3wDN6SCUvQ>
X-ME-Received: <xmr:MWDAYq6qdmVXJ8Q6naw0I8upnUH0adRpYBfGaiX1hQdCb_96Mu5wa0kRen9K9T8EJZHQEEw0yZSEYYuK8PJJXh_eSVlECqYr0DLzxUb2kyIBJow5jI9gjVyBzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfevfhfhkffffgggjggtgfesth
    ejredttdefjeenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghl
    sehshhholhhlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepkeelgefhffduffduie
    dvteeukefgiedtleehjedvkedtveelkefhvddugfetheevnecuffhomhgrihhnpehlihhn
    uhigqdhsuhhngihirdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:MWDAYj1sKlLRU8GpVJTtk_zI-PpbXR6YT80Zu_3Tktn3lcKKxjmj1A>
    <xmx:MWDAYlGozgMs8g6x4s7VQZw8Y3nAyhs75IVeqShTrAvfnZp2_g4WZA>
    <xmx:MWDAYs8MyTPnNJs2kYi0jTHFQ4cLmW6Sf0eSLIINwGMew8VITi2Pzg>
    <xmx:MmDAYglx4HmAyiFAmKvhsKzqHVYtG3EZLLfo7-HlRVbRB0gs5rdzRg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 11:11:44 -0400 (EDT)
Subject: Re: [PATCH v4 12/15] pinctrl: Add AXP192 pin control driver
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, wens@csie.org
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        sre@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, lars@metafoo.de, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, rdunlap@infradead.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-13-aidanmacdonald.0x0@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <37d40cf2-4512-754f-2e44-ee1449bc2e9f@sholland.org>
Date:   Sat, 2 Jul 2022 10:11:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220629143046.213584-13-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/22 9:30 AM, Aidan MacDonald wrote:
> The AXP192 PMIC's GPIO registers are much different from the GPIO
> registers of the AXP20x and AXP813 PMICs supported by the existing
> pinctrl-axp209 driver. It makes more sense to add a new driver for
> the AXP192, rather than add support in the existing axp20x driver.
> 
> The pinctrl-axp192 driver is considerably more flexible in terms of
> register layout and should be able to support other X-Powers PMICs.
> Interrupts and pull down resistor configuration are supported too.

I am planning to implement gpio/pinctrl support for AXP152[1], which is
somewhere between AXP20x and AXP192 in terms of GPIO capability.

Which driver should I add it to? How much work would it be to convert AXP20x
variants to the new driver? And if supporting other X-Powers PMICs is the plan,
would it make sense to convert the existing driver in-place to avoid dealing
with Kconfig migrations?

[1]: https://linux-sunxi.org/AXP152

> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/pinctrl/Kconfig          |  13 +
>  drivers/pinctrl/Makefile         |   1 +
>  drivers/pinctrl/pinctrl-axp192.c | 598 +++++++++++++++++++++++++++++++
>  3 files changed, 612 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-axp192.c
> [...]
> +static int axp192_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin, unsigned long *config)
> +{
> +	enum pin_config_param param = pinconf_to_config_param(*config);
> +	unsigned int arg = 1;
> +	bool pull_down;
> +	int ret;
> +
> +	switch (param) {
> +	case PIN_CONFIG_BIAS_DISABLE:
> +		ret = axp192_pinconf_get_pull_down(pctldev, pin, &pull_down);
> +		if (ret)
> +			return ret;
> +		if (pull_down)
> +			return -EINVAL;
> +		break;
> +
> +	case PIN_CONFIG_BIAS_PULL_DOWN:
> +		ret = axp192_pinconf_get_pull_down(pctldev, pin, &pull_down);
> +		if (ret)
> +			return ret;
> +		if (!pull_down)
> +			return -EINVAL;
> +		break;
> +
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	*config = pinconf_to_config_packed(param, arg);
> +	return 0;
> +}
> +
> +static int axp192_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
> +			      unsigned long *configs, unsigned int num_configs)
> +{
> +	int ret;
> +	unsigned int cfg;
> +
> +	for (cfg = 0; cfg < num_configs; cfg++) {
> +		switch (pinconf_to_config_param(configs[cfg])) {
> +		case PIN_CONFIG_BIAS_DISABLE:
> +			ret = axp192_pinconf_set_pull_down(pctldev, pin, 0);
> +			if (ret)
> +				return ret;
> +			break;
> +
> +		case PIN_CONFIG_BIAS_PULL_DOWN:
> +			ret = axp192_pinconf_set_pull_down(pctldev, pin, 1);
> +			if (ret)
> +				return ret;
> +			break;
> +
> +		default:
> +			return -ENOTSUPP;

The GPIO outputs are always open-drain. It looks like this needs to handle
PIN_CONFIG_DRIVE_OPEN_DRAIN, or gpiolib will try to emulate it.

And I would suggest returning -EINVAL for PIN_CONFIG_DRIVE_PUSH_PULL, but
gpiolib does not check the return value when setting that.

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> [...]
> +
> +static int axp192_pctl_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct axp20x_dev *axp20x = dev_get_drvdata(dev->parent);
> +	struct axp192_pctl *pctl;
> +	struct pinctrl_desc *pctrl_desc;
> +	int ret, i;
> +
> +	pctl = devm_kzalloc(dev, sizeof(*pctl), GFP_KERNEL);
> +	if (!pctl)
> +		return -ENOMEM;
> +
> +	pctl->desc = device_get_match_data(dev);
> +	pctl->regmap = axp20x->regmap;
> +	pctl->regmap_irqc = axp20x->regmap_irqc;
> +	pctl->dev = dev;
> +
> +	pctl->chip.base			= -1;
> +	pctl->chip.can_sleep		= true;
> +	pctl->chip.request		= gpiochip_generic_request;
> +	pctl->chip.free			= gpiochip_generic_free;
> +	pctl->chip.parent		= dev;
> +	pctl->chip.label		= dev_name(dev);
> +	pctl->chip.owner		= THIS_MODULE;
> +	pctl->chip.get			= axp192_gpio_get;
> +	pctl->chip.get_direction	= axp192_gpio_get_direction;
> +	pctl->chip.set			= axp192_gpio_set;
> +	pctl->chip.direction_input	= axp192_gpio_direction_input;
> +	pctl->chip.direction_output	= axp192_gpio_direction_output;
> +	pctl->chip.to_irq		= axp192_gpio_to_irq;
> +	pctl->chip.ngpio		= pctl->desc->npins;
> +
> +	pctl->irqs = devm_kcalloc(dev, pctl->desc->npins, sizeof(int), GFP_KERNEL);
> +	if (!pctl->irqs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < pctl->desc->npins; i++) {
> +		ret = platform_get_irq_byname_optional(pdev, pctl->desc->pins[i].name);
> +		if (ret > 0)
> +			pctl->irqs[i] = ret;
> +	}
> +
> +	platform_set_drvdata(pdev, pctl);
> +
> +	pctrl_desc = devm_kzalloc(dev, sizeof(*pctrl_desc), GFP_KERNEL);
> +	if (!pctrl_desc)
> +		return -ENOMEM;

This can go inside struct axp192_pctl. It does not need a separate allocation.

Regards,
Samuel
