Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E0A4FB7E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344633AbiDKJnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344809AbiDKJnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:43:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E4C35AA4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:41:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r206-20020a1c44d7000000b0038ccb70e239so4159917wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xDR0Oo93RBMr/a7qSFkHAnxdyg/wff1wMpM/g7CP34w=;
        b=gmpvBoMH52aIdLBa/PxVc8cIjE+SH82zUdfbrHBrp/oLN6ipQV04xdDZ32gi7TkYij
         YuqQAXm2crjZ1ntW1FoXCYo/ss0KVodV9aY45i+Ymt3vGcy5lfDqWrZ/fjJvknRx5BT3
         aseK8WVQ+0aALq3NkBXUIxyV+3T702Uimjkdso45GbDEC28a65i2SQQlwn9H8Ydst34k
         rHusuBKSCE9tBxEp5nRB4rjQ5cFVikbzRGIFG1GqrXMXXnr9Pz+vLY2mdnTN7UmxPixy
         Yqxzl5S/gE+qF4g/AfVcQoTMgPEMD96+0QtbqB97VSjcfd25K0fekERlHB148S20c1iV
         tHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xDR0Oo93RBMr/a7qSFkHAnxdyg/wff1wMpM/g7CP34w=;
        b=YyoOpdKY588DPpLvIMeWg5iHkrtgFE8V/4h6Nrh03B7tHOrSZXTNjCYssvau40zAth
         COAi4l9ua6yK4/DvPytED7VU2NsEHo1445KANw5lxuXMK/Wnbm+otpx/gbQsfElaQYMC
         iTkFGcoic9B7+HSKV8AMtcsKyod1fTsJv2sJVXb4R36oYRo7OrFtfKQqaOzTgMoG1JGX
         PDt4VHkuLbWMBkDv8kZCH3BtoQHtHrCQfNmPQ8xp7SAcDHhZX2Dtg3t9WVClrz8oG+ES
         KmFtJltToXmzQogg9XFo5Qee+ZDLcYLnYvXvmp4oT7UtxMa2DemtQg9J2bVQQjG1km/s
         S5yw==
X-Gm-Message-State: AOAM5320ablhncrYP7imxmMhB3oTZxfyEz/NUW9QwXUXtVe6hWCAMv2E
        UW3jQHs/eM9DrWU+jaBdGw9hIQ==
X-Google-Smtp-Source: ABdhPJw23NRGbtN7+13L8/M7UHc6Xq+YEURJVzQPqGaudaX3LlcXQTmHIECgkQ4WgyCkCkvoNRTXAA==
X-Received: by 2002:a1c:7302:0:b0:38c:bb21:faf7 with SMTP id d2-20020a1c7302000000b0038cbb21faf7mr28082521wmb.31.1649670068725;
        Mon, 11 Apr 2022 02:41:08 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id d11-20020a056000186b00b0020799d3d416sm8484092wri.55.2022.04.11.02.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 02:41:07 -0700 (PDT)
Message-ID: <92e94b98-847d-7d3f-4063-96d2d01eff6e@linaro.org>
Date:   Mon, 11 Apr 2022 10:41:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 3/3] nvmem: Add Apple eFuse driver
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowsk <krzysztof.kozlowski@canonical.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220410135414.20606-1-sven@svenpeter.dev>
 <20220410135414.20606-3-sven@svenpeter.dev>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220410135414.20606-3-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2022 14:54, Sven Peter wrote:
> Apple SoCs contain eFuses used to store factory-programmed data such
> as calibration values for the PCIe or the Type-C PHY. They are organized
> as 32bit values exposed as MMIO.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>


Applied all 3,

thanks,
--srini


> ---
> v3 -> v4:
>    - rebased on 5.18-rc1 and split off MAINTAINER changes as requested
>      by Srinivas Kandagatla
> v2 -> v3:
>    - removed .owner = THIS_MODULE again since it's already done by the
>      core as pointed out by Krzysztof Kozlowski
> v1 -> v2:
>    - fixed sparse warning about __iomem by introducing
>      struct apple_efuses_priv as done in other nvmem drivers
>    - make sure the driver actually works as a module by
>      setting .owner to THIS_MODULE and adding MODULE_DEVICE_TABLE
>      pointed out by Joey Gouly
> 
>   drivers/nvmem/Kconfig        | 12 ++++++
>   drivers/nvmem/Makefile       |  2 +
>   drivers/nvmem/apple-efuses.c | 80 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 94 insertions(+)
>   create mode 100644 drivers/nvmem/apple-efuses.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 555aa77a574d..6283e09cc1e9 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -324,4 +324,16 @@ config NVMEM_SUNPLUS_OCOTP
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-sunplus-ocotp.
>   
> +config NVMEM_APPLE_EFUSES
> +	tristate "Apple eFuse support"
> +	depends on ARCH_APPLE || COMPILE_TEST
> +	default ARCH_APPLE
> +	help
> +	  Say y here to enable support for reading eFuses on Apple SoCs
> +	  such as the M1. These are e.g. used to store factory programmed
> +	  calibration data required for the PCIe or the USB-C PHY.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called nvmem-apple-efuses.
> +
>   endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 891958e29d25..00e136a0a123 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -65,3 +65,5 @@ obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
>   nvmem-layerscape-sfp-y		:= layerscape-sfp.o
>   obj-$(CONFIG_NVMEM_SUNPLUS_OCOTP)	+= nvmem_sunplus_ocotp.o
>   nvmem_sunplus_ocotp-y		:= sunplus-ocotp.o
> +obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
> +nvmem-apple-efuses-y 		:= apple-efuses.o
> diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
> new file mode 100644
> index 000000000000..9b7c87102104
> --- /dev/null
> +++ b/drivers/nvmem/apple-efuses.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Apple SoC eFuse driver
> + *
> + * Copyright (C) The Asahi Linux Contributors
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +
> +struct apple_efuses_priv {
> +	void __iomem *fuses;
> +};
> +
> +static int apple_efuses_read(void *context, unsigned int offset, void *val,
> +			     size_t bytes)
> +{
> +	struct apple_efuses_priv *priv = context;
> +	u32 *dst = val;
> +
> +	while (bytes >= sizeof(u32)) {
> +		*dst++ = readl_relaxed(priv->fuses + offset);
> +		bytes -= sizeof(u32);
> +		offset += sizeof(u32);
> +	}
> +
> +	return 0;
> +}
> +
> +static int apple_efuses_probe(struct platform_device *pdev)
> +{
> +	struct apple_efuses_priv *priv;
> +	struct resource *res;
> +	struct nvmem_config config = {
> +		.dev = &pdev->dev,
> +		.read_only = true,
> +		.reg_read = apple_efuses_read,
> +		.stride = sizeof(u32),
> +		.word_size = sizeof(u32),
> +		.name = "apple_efuses_nvmem",
> +		.id = NVMEM_DEVID_AUTO,
> +		.root_only = true,
> +	};
> +
> +	priv = devm_kzalloc(config.dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->fuses = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(priv->fuses))
> +		return PTR_ERR(priv->fuses);
> +
> +	config.priv = priv;
> +	config.size = resource_size(res);
> +
> +	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
> +}
> +
> +static const struct of_device_id apple_efuses_of_match[] = {
> +	{ .compatible = "apple,efuses", },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, apple_efuses_of_match);
> +
> +static struct platform_driver apple_efuses_driver = {
> +	.driver = {
> +		.name = "apple_efuses",
> +		.of_match_table = apple_efuses_of_match,
> +	},
> +	.probe = apple_efuses_probe,
> +};
> +
> +module_platform_driver(apple_efuses_driver);
> +
> +MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> +MODULE_LICENSE("GPL");
