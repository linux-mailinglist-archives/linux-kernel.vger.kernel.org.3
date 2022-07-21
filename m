Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C3A57CE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiGUOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiGUOxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:53:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A6B2981F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:53:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u19so3254831lfs.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cLo9fM7F+1waINGkNKaUX3n5snX3YK8Uq0FRboZsXyw=;
        b=KdwEzNqwKe7/xPp05UA/JD41rUsNR9gdR6EIXYm1Lu2Qyq27M16YcsDkjo7yK7U35c
         nmfjUAgxn0tHHcTJk5DhqZddD/SE7M1c5XukrO4krlGoJaqBwdF9oT42R+AK5mowEyoA
         Mliz8l6lbNp2ABFYjYbUiGOPbkhmvfh5DAAeZi6nbaeMFSvwrV4QtDCnXUH63fCFaegS
         442vJXtpxj86HGYmhnJkDFuelywiKhh2SRzUFDL7MGIlEGJUh7C6rA7fg2EAM9ER200s
         XTyZW/+zDDHLBpwWLVZpRExOIfCLNIWLOYNVpVUbMz0v327ncQl6d7/UJurckbP/DJR1
         1QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cLo9fM7F+1waINGkNKaUX3n5snX3YK8Uq0FRboZsXyw=;
        b=F/GpuS0Gr41i49ENJBuX3Ex7+xO6++BB5PcD/EhyEi91iHSJtsdDigVEdUYtZuAwOf
         H+UU10VO4PTBw0YPTOGs7pxZLnrcz/kVkpkYO/q3gGk6K8SS905Hyy+YaKH4udQPcGz+
         BupXlIeWdQBtfTvJ/YAiR+IWn+9MkRSxXrcT/xO36Kz9kZzQsas7l446BiDq3vwiwVkn
         NBbtGnmZ5YdKRttcfaIKUm50z3L54W/Sj8GYgCoRessaaFo1txi80k5YOZB4FsyN2JbT
         TAPHlG+Fx6xIa4HEZXZjTBK4fA4rYAB0er4hBVp/xW8jU0ndY8sFF4OyxcDZptZgUXjP
         Fr8Q==
X-Gm-Message-State: AJIora/o/LTmbTTp3gjqMSpnM7JsmMv+WYFzWzpybMNuM+K1ic2oETv+
        QARBggvdCqsxXwgGdRqBdrtRHQ==
X-Google-Smtp-Source: AGRyM1tM7l1nHejhj+ruxIHCF/akXifvLXeu6qiHgvMQ8WFVm7vntLxeuszZhHnthUI6uDvgxhWssA==
X-Received: by 2002:ac2:4ec4:0:b0:48a:7144:c0ce with SMTP id p4-20020ac24ec4000000b0048a7144c0cemr1034831lfr.406.1658415191129;
        Thu, 21 Jul 2022 07:53:11 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id g1-20020a056512118100b004811bf4999csm479112lfr.290.2022.07.21.07.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:53:10 -0700 (PDT)
Message-ID: <66e94a45-d5b8-ead2-ef76-89bb680ca00f@linaro.org>
Date:   Thu, 21 Jul 2022 16:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/5] spi: spi-gxp: Add support for HPE GXP SoCs
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
References: <20220720201158.78068-1-nick.hawkins@hpe.com>
 <20220720201158.78068-2-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720201158.78068-2-nick.hawkins@hpe.com>
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

On 20/07/2022 22:11, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP supports 3 separate SPI interfaces to accommodate the system
> flash, core flash, and other functions. The SPI engine supports variable
> clock frequency, selectable 3-byte or 4-byte addressing and a
> configurable x1, x2, and x4 command/address/data modes. The memory
> buffer for reading and writing ranges between 256 bytes and 8KB. This
> driver supports access to the core flash and bios part.
> 

(...)

> +static int gxp_spifi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct gxp_spi_data *data;
> +	struct spi_controller *ctlr;
> +	struct gxp_spi *spifi;
> +	struct resource *res;
> +	int ret;
> +
> +	data = of_device_get_match_data(&pdev->dev);
> +	if (!data) {
> +		dev_err(&pdev->dev, "of_dev_get_match_data failed\n");

Is it even possible to happen? I don't think so, so definitely not worth
log message.

> +		return -ENOMEM;
> +	}
> +
> +	ctlr = devm_spi_alloc_master(dev, sizeof(*spifi));
> +	if (!ctlr) {
> +		dev_err(&pdev->dev, "spi_alloc_master failed\n");

Aren't you duplicating core messages?

> +		return -ENOMEM;
> +	}
> +
> +	spifi = spi_controller_get_devdata(ctlr);
> +	if (!spifi) {

Is it even possible?

> +		dev_err(&pdev->dev, "spi_controller_get_data failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, spifi);
> +	spifi->data = data;
> +	spifi->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	spifi->reg_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spifi->reg_base))
> +		return PTR_ERR(spifi->reg_base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	spifi->dat_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spifi->dat_base))
> +		return PTR_ERR(spifi->dat_base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +	spifi->dir_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(spifi->dir_base))
> +		return PTR_ERR(spifi->dir_base);
> +
> +	ctlr->mode_bits = data->mode_bits;
> +	ctlr->bus_num = pdev->id;
> +	ctlr->mem_ops = &gxp_spi_mem_ops;
> +	ctlr->setup = gxp_spi_setup;
> +	ctlr->num_chipselect = data->max_cs;
> +	ctlr->dev.of_node = dev->of_node;
> +
> +	ret = devm_spi_register_controller(dev, ctlr);
> +	if (ret) {
> +		dev_err(&pdev->dev, "spi_register_controller failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gxp_spifi_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

It's empty, why do you need it?


Best regards,
Krzysztof
