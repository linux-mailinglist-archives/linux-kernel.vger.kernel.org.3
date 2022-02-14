Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E94B4E09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350820AbiBNLYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:24:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350838AbiBNLXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:23:19 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D21400B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:58:59 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so5607221wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mivF3ekCKstELbAjwclXaYaNa1EngP36z3pQawfN/Ww=;
        b=JbsWgFcHUSVRaavjY38WJUtjsTOkJ/Fgtev1kqvA9SwrNt92it6Fe9uFNbIuSwX7uh
         8K1UvNYPSTax58CZxNIt0NZpR2UkdGpv3lD3CLAyCawqnZ9Hv2MDN2nlrw/Q4Y3BwpkY
         dF26NMhEvsOK5utsQGMQg0vnYhS/PqaI60JhoPNDniQpEUX5GDCeY00WJfYWaJnVT39H
         GlMG2Rw2SkJCxvN1ezcfH6iWyMpiZBL8ZspYsW2jrByKYBqNddmRjEQvnzrn3MRH1PJK
         LO1JsdaPyuN7W9FOTapP4lYFdtW1rkaf/QPz7HLVo2inGSlhgvve1jSNF7vXwJir72Cb
         TDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mivF3ekCKstELbAjwclXaYaNa1EngP36z3pQawfN/Ww=;
        b=KLJQq6Ikbk9v2cZ9numyopWGAYGzkPXIlIT1mYttR3O0hIqfH4BrKbXVQx6P4I2ydg
         fQ7Li7JiAfK+x3DAHDs19Ud3ZIlYx5fwA5daKFMIetz/K0b1SKmR+E3xr2ZoaISkL57Z
         qYu8PQzh8oI+Gb3gYQIgDfOBrf9CL/7DxyzKQiR5/iGsi8YbaqgowECce3DXLUGtCVae
         Dw4zl3E8ZiblP36oLTtdNmGp6DyUGEmtjUdqgXSi0KH+rjSwhGRlLXSdZKFW/nMM5WzC
         W1S4VGtg1I36kobUlwExHa3O0cg+godFHGW+S+VBwwhXttBMTZyyKveXrp7Mzm9pUkzo
         wu6Q==
X-Gm-Message-State: AOAM531k/5dYZaG6wjaxiKUFx+WQAZM3PS8N5tEjM5jprYfc5ks7Y9EA
        cWKTNrOPjGO03000xMW5s1xZTQ==
X-Google-Smtp-Source: ABdhPJwHV2UfTyzufi4WYxi4Lo4jKcDclD2KpFx+9zNpnE6mUVUXIlC2sr5hve8icJGE4+rvu2IZjA==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr11158806wrd.207.1644836337628;
        Mon, 14 Feb 2022 02:58:57 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id f18sm2453499wmg.21.2022.02.14.02.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 02:58:57 -0800 (PST)
Message-ID: <8e718e04-5abe-0cb9-c8db-384f3604ad2a@linaro.org>
Date:   Mon, 14 Feb 2022 10:58:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 2/3] nvmem: add driver for Layerscape SFP (Security
 Fuse Processor)
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
References: <20220127163728.3650648-1-michael@walle.cc>
 <20220127163728.3650648-3-michael@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220127163728.3650648-3-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/01/2022 16:37, Michael Walle wrote:
> Add support for the Security Fuse Processor found on Layerscape SoCs.
> This driver implements basic read access.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
minor comments below.


> ---
>   drivers/nvmem/Kconfig          | 12 +++++
>   drivers/nvmem/Makefile         |  2 +
>   drivers/nvmem/layerscape-sfp.c | 91 ++++++++++++++++++++++++++++++++++
>   3 files changed, 105 insertions(+)
>   create mode 100644 drivers/nvmem/layerscape-sfp.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 94dd60b2654e..63792082e476 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -307,4 +307,16 @@ config NVMEM_BRCM_NVRAM
>   	  This driver provides support for Broadcom's NVRAM that can be accessed
>   	  using I/O mapping.
>   
> +config NVMEM_LAYERSCAPE_SFP
> +	tristate "Layerscape SFP (Security Fuse Processor) support"
> +	depends on ARCH_LAYERSCAPE || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver provides support to read the eFuses on Freescale
> +	  Layerscape SoC's. For example, the vendor provides a per part
> +	  unique ID there.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called layerscape-sfp.
> +
>   endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 4e6d877fdfaf..914358fcdb37 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -62,3 +62,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
>   nvmem-rmem-y			:= rmem.o
>   obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
>   nvmem_brcm_nvram-y		:= brcm_nvram.o
> +obj-$(CONFIG_NVMEM_LAYERSCAPE_SFP)	+= nvmem-layerscape-sfp.o
> +nvmem-layerscape-sfp-y		:= layerscape-sfp.o
> diff --git a/drivers/nvmem/layerscape-sfp.c b/drivers/nvmem/layerscape-sfp.c
> new file mode 100644
> index 000000000000..4aa94e03d8d1
> --- /dev/null
> +++ b/drivers/nvmem/layerscape-sfp.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Layerscape SFP driver
> + *
> + * Copyright (c) 2022 Michael Walle <michael@walle.cc>
> + *
> + */
> +
> +#include <linux/clk.h>

is this required?

> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>

Same here.

> +
> +#define LAYERSCAPE_SFP_OTP_OFFSET	0x0200
> +
> +struct layerscape_sfp_priv {
> +	void __iomem *base;
> +};
> +
> +struct layerscape_sfp_data {
> +	int size;
> +};
> +
> +static int layerscape_sfp_read(void *context, unsigned int offset, void *val,
> +			size_t bytes)

incorrect indention here.
> +{
> +	struct layerscape_sfp_priv *priv = context;
> +
> +	memcpy_fromio(val, priv->base + LAYERSCAPE_SFP_OTP_OFFSET + offset, bytes);
> +
> +	return 0;
> +}
> +
> +static struct nvmem_config layerscape_sfp_nvmem_config = {
> +	.name = "fsl-sfp",
> +	.reg_read = layerscape_sfp_read,
> +};
> +
> +static int layerscape_sfp_probe(struct platform_device *pdev)
> +{
> +	const struct layerscape_sfp_data *data;
> +	struct layerscape_sfp_priv *priv;
> +	struct nvmem_device *nvmem;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> + > +	data = device_get_match_data(&pdev->dev);
> +
> +	layerscape_sfp_nvmem_config.size = data->size;
> +	layerscape_sfp_nvmem_config.dev = &pdev->dev;
> +	layerscape_sfp_nvmem_config.priv = priv;
> +
> +	nvmem = devm_nvmem_register(&pdev->dev, &layerscape_sfp_nvmem_config);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static const struct layerscape_sfp_data ls1028a_data = {
> +	.size = 0x88,
> +};
> +
> +static const struct of_device_id layerscape_sfp_dt_ids[] = {
> +	{ .compatible = "fsl,ls1028a-sfp", .data = &ls1028a_data },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, layerscape_sfp_dt_ids);
> +
> +static struct platform_driver layerscape_sfp_driver = {
> +	.probe	= layerscape_sfp_probe,
> +	.driver = {
> +		.name	= "layerscape_sfp",
> +		.of_match_table = layerscape_sfp_dt_ids,
> +	},
> +};
> +module_platform_driver(layerscape_sfp_driver);
> +
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_DESCRIPTION("Layerscape Security Fuse Processor driver");
> +MODULE_LICENSE("GPL v2");
Just MODULE_LICENSE("GPL") should be good here.

--srini

