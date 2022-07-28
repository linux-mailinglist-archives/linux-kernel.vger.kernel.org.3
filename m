Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E278258403D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiG1NoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiG1NoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:44:15 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA50761D48
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:44:13 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e11so2019570ljl.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t3snUb/RB7GBK47suv0EVR2ZsOaRly5GONJO77oiuQg=;
        b=sOfaZgsXdyu9YFFlp0fBAF2zTWC0nkR9f1upJND4qGEPvrIrLVegHEtcimHFcC9AGq
         prtZcg30BThzrAdiXdKEkUpRniIlN96f9mAQHH7S+CtLKp+3fTUZSPlD611eQ2dtYPjR
         YqiMQUjkRHEf04LzZ3ppP6nOtWAGMc2bT8RjQ/hyE7z92pAwqHUhynHwvZZNtP4KbouY
         eceF+JDX0LoKRTtVK45Nwa4hAEhH/SEhaMDggMzfvU4kS+8AyKVNwNkLJElivl4nSrZE
         TmqN96xweMiMzHG2Ydb14z1yTvzz3i2DMY+wiFAizX7sPBHqBoMkScO6+hRyMgBmlRvl
         OhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t3snUb/RB7GBK47suv0EVR2ZsOaRly5GONJO77oiuQg=;
        b=pPhg/uifeFOHSKFs0GcDRf1iULvcsNAJP580GRnXUaunKX8rVaxmOrGI/PX06Of3EY
         GKgC8Mt5uLQuxCoYg9sR0jY5/AB3CRom4KER+Mv8lH2NVwoLMhBK9lixwyFJwKmW8ktn
         pDLfkDdw1tq+xF60QKUz172UgtvbsLR/0BiXCJF5bIMZkjKXne8c2rfzLFX3eC+ZPOfw
         iWDATSUo2fqfYzXLxX+GLgQ/C/PGa2+DKysxRmaDET+T9s8ZB03BEI8yTKiJZplZu6L7
         /p3MdbineQE95iHjaSgJqfvRZBkEzeDAD2Dumg8aFQ9q1yY+hJK0wfWJeQstNA97OydP
         Bb3Q==
X-Gm-Message-State: AJIora9DKtgwQ3LFmm7MOonpZpVCfrCOcgJLUHW4Ob8g6dXfgmVPW7TL
        sqS5EA6UK74OrIVOawSZK3sMAQ==
X-Google-Smtp-Source: AGRyM1uZFOldfIslMBj3ijO/FI232ybFsJuneomS8qRe2mSt04mZInbLVyYT4ft2fJRvZF6pDwVzIA==
X-Received: by 2002:a05:651c:1993:b0:25e:2766:924 with SMTP id bx19-20020a05651c199300b0025e27660924mr2108589ljb.231.1659015852086;
        Thu, 28 Jul 2022 06:44:12 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9f57000000b0025de9a05176sm149221ljk.111.2022.07.28.06.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:44:11 -0700 (PDT)
Message-ID: <5f728a46-d222-a734-ce69-5adb695fb374@linaro.org>
Date:   Thu, 28 Jul 2022 15:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] iio: time: capture-tiecap: capture driver support
 for ECAP
Content-Language: en-US
To:     Julien Panis <jpanis@baylibre.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com
References: <20220728125212.76728-1-jpanis@baylibre.com>
 <20220728125212.76728-3-jpanis@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220728125212.76728-3-jpanis@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 14:52, Julien Panis wrote:
> ECAP hardware on AM62x SoC supports capture feature. It can be used
> to timestamp events (falling/rising edges) detected on signal input pin.
> 
> This commit adds capture driver support for ECAP hardware on AM62x SoC.
> 
> In the ECAP hardware, capture pin can also be configured to be in

Thank you for your patch. There is something to discuss/improve.

(...)

> +static int ecap_iio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ecap_iio_dev *ecap_dev;
> +	struct iio_dev *indio_dev;
> +	void __iomem *mmio_base;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*ecap_dev));
> +	if (IS_ERR(indio_dev)) {
> +		dev_err(dev, "failed to allocate memory for iio device\n");

Do not print messages, which core takes care of.

> +		return PTR_ERR(indio_dev);
> +	}
> +
> +	ecap_dev = iio_priv(indio_dev);
> +
> +	ecap_dev->clk = devm_clk_get(dev, "fck");
> +	if (IS_ERR(ecap_dev->clk)) {
> +		dev_err(dev, "failed to get clock\n");
> +		return PTR_ERR(ecap_dev->clk);
> +	}
> +
> +	ret = clk_prepare_enable(ecap_dev->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, ecap_iio_clk_disable, ecap_dev->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to add clock disable action\n");
> +		return ret;
> +	}
> +
> +	ecap_dev->clk_rate = clk_get_rate(ecap_dev->clk);
> +	if (!ecap_dev->clk_rate) {
> +		dev_err(dev, "failed to get clock rate\n");
> +		return -EINVAL;
> +	}
> +
> +	if (prescaler > ECAP_PS_MAX_VAL) {
> +		prescaler = ECAP_PS_MAX_VAL;
> +		dev_warn(dev, "prescaler out of range, forced to %d\n", prescaler);
> +	}
> +
> +	mmio_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio_base)) {
> +		dev_err(dev, "failed to remap io\n");

No need for msg.

> +		return PTR_ERR(mmio_base);
> +	}
> +
> +	ecap_dev->regmap = regmap_init_mmio(dev, mmio_base, &ecap_iio_regmap_config);
> +	if (IS_ERR(ecap_dev->regmap)) {
> +		dev_err(dev, "failed to init regmap\n");
> +		return PTR_ERR(ecap_dev->regmap);
> +	}
> +
> +	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL,
> +					 "ecap-iio-%p", mmio_base);
> +	indio_dev->info = &ecap_iio_info;
> +	indio_dev->channels = ecap_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ecap_iio_channels);
> +	indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> +
> +	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev, NULL, NULL);
> +	if (ret) {
> +		dev_err(dev, "failed to setup iio buffer\n");
> +		return ret;
> +	}
> +
> +	ret = platform_get_irq(pdev, 0);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get irq\n");
> +		return ret;
> +	}
> +
> +	ret = devm_request_irq(dev, ret, ecap_iio_isr, 0, pdev->name, indio_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		return ret;
> +	}

Best regards,
Krzysztof
