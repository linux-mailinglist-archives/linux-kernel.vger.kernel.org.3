Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168EA4F92CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiDHKUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiDHKU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:20:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51786108185
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:18:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k23so12111956wrd.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ypVnKTCvFVhHLwSfqmnMRpaeXh6eiqAgxqUKwwAPIpE=;
        b=bTTPSn6Y6qHCw3sxTjLwqiCd4/uHNaOwHGWpkV53VVP3ycgFrbZSu+FR/HgCreCRaG
         ku6eWljimgfU1WbyHkaa3ZwKvdVBxBIrI273ueZS1glhSnkdrvQtbvwSI+QgIujDuW5W
         mzyb5LzNaYZcsCea315nxY8BbGiLA1CQsPKgaCJ58+JUwkvYpElB+M4+dqG5FdbLr4qK
         9BO4nIeMLTSvya3yHKvvYZcGh4Viv4A9XkBadyyEte8U5bFzDDCFZl/u4jApwJskp5Xu
         vkgllrBvKCPySKnKc8uabk8KXKxZ2MwhKd2CJb8bh/W9gELElDVLvA7LzDgRmGEESOr0
         EIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ypVnKTCvFVhHLwSfqmnMRpaeXh6eiqAgxqUKwwAPIpE=;
        b=BwzLr4KUnFwxWD76y7swZHdoD1J1qdkKuK/7S317GdhaP8v57wSTJUl6vblS/vIBy4
         /4WKO9KRT49JVKtMInsmGcCRT3fAfGclIBwW/WbgFsuKW35a/WcS8AhrOfG38M/o2qyY
         +OlLSsGJh+LCfLdZ9Y/GdwGff/wQW441t1rtYtqLol0CXR4DFjLK2UY6LbMRj1Bwn8Rw
         Qo4ylvGbciD5OyP6y9ZI1iaDeabt0JSBd4oA5jdAvR8J0fMXIwBcccHJwkgOku42z1eS
         R6Meojhw0cguNW4ETm1zDtNgQ7HdjMeezAUZHDRl0Q4VWEUK2sRyJRjUPwwi3FDeyUFI
         +Ypg==
X-Gm-Message-State: AOAM5310+d0eYKz8DZMbWntFspA9AjZgfdvMAQN1gBhSP0JAECGCzWwo
        oH3b3h7J5MpO43TbzPEIQX+l0w==
X-Google-Smtp-Source: ABdhPJxveQ/dU5ZD2FFxsCWGreU/NilBQDUvltC6QR7nl0cdSczzMs1a4CI8qCmlyZjT3BUUUyYKhQ==
X-Received: by 2002:a5d:6201:0:b0:207:8d91:aaa9 with SMTP id y1-20020a5d6201000000b002078d91aaa9mr4233857wru.262.1649413097670;
        Fri, 08 Apr 2022 03:18:17 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id p7-20020a5d4e07000000b002079a418430sm628749wrt.85.2022.04.08.03.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 03:18:16 -0700 (PDT)
Message-ID: <37c17568-5ca6-c0cd-18fa-7097de2f5015@linaro.org>
Date:   Fri, 8 Apr 2022 11:18:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/2] nvmem: Add Apple eFuse driver
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
References: <20220312165837.40687-1-sven@svenpeter.dev>
 <20220312165837.40687-2-sven@svenpeter.dev>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220312165837.40687-2-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/03/2022 16:58, Sven Peter wrote:
> Apple SoCs contain eFuses used to store factory-programmed data such
> as calibration values for the PCIe or the Type-C PHY. They are organized
> as 32bit values exposed as MMIO.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
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
>   MAINTAINERS                  |  1 +

This does not apply, can you rebase this on top of 5.18-rc1 and send.

Also split the MAINTAINERS change into separate patch

--srini


>   drivers/nvmem/Kconfig        | 12 ++++++
>   drivers/nvmem/Makefile       |  2 +
>   drivers/nvmem/apple-efuses.c | 80 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 95 insertions(+)
>   create mode 100644 drivers/nvmem/apple-efuses.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 24deb0e8f731..a93318a1dda8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1781,6 +1781,7 @@ F:	drivers/i2c/busses/i2c-pasemi-core.c
>   F:	drivers/i2c/busses/i2c-pasemi-platform.c
>   F:	drivers/irqchip/irq-apple-aic.c
>   F:	drivers/mailbox/apple-mailbox.c
> +F:	drivers/nvmem/apple-efuses.c
>   F:	drivers/pinctrl/pinctrl-apple-gpio.c
>   F:	drivers/soc/apple/*
>   F:	drivers/watchdog/apple_wdt.c
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index da414617a54d..bba29d1aec96 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -300,4 +300,16 @@ config NVMEM_BRCM_NVRAM
>   	  This driver provides support for Broadcom's NVRAM that can be accessed
>   	  using I/O mapping.
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
> index dcbbde35b6a8..1a8e54691d3e 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -61,3 +61,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
>   nvmem-rmem-y			:= rmem.o
>   obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
>   nvmem_brcm_nvram-y		:= brcm_nvram.o
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
