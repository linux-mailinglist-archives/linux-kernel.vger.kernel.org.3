Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9684CEB8B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 13:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiCFM0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 07:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiCFM0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 07:26:50 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845676BDCE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 04:25:58 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5198C3F1C5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646569557;
        bh=F59/L+mw5wL4Sw8uoAIL7Xh6MYhNksArDry85+EJ/z4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=PHeIs/ac+9eC2hU3sAAJisucySejzgssiooO0vlOSUYHWETYonnTTD9bdf44P34gC
         u2mdvQOdacyPFwwSskKFHhXD3+ScXskStLzYOC+ZPDcTgFqjJS/DbTxtMuJjEf/bhd
         hePl7j8NEQnlPHYD48FaxtAqqYLCH+iq1Kr/0rrC/38XvArU4FXcY2mwsWbChSfd+L
         6zPjdCz/H17Rhs0S+Ru+QUp4NUr7RSiqZVCKDDTp346Yvi8KYPJbqMDFu/8+MRivbP
         mMllNfnEiWxHClW2aljo2PfW6gqkHvMD9wayieSnUEwL+Jj9R4PIfsNv+tRGilQr3x
         voAKtBwjETA6A==
Received: by mail-ed1-f72.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so6835056edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 04:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F59/L+mw5wL4Sw8uoAIL7Xh6MYhNksArDry85+EJ/z4=;
        b=AFweTWCV1STBTrGvnqBGblYptcg5y+egNP3YpeCuBKCd6OE0glK901qyyoSq5Ura84
         7I8NNPzGhgwDZkFi99cB4T0FITGz/PwGRjXm/Dy/C+/acfBJ7zBVvlSjl8dhKd9B+C6E
         qWP6dusoUSbeQg+ey+rz1vjX1WsZo11S0YVs35DH3DtvGs2o86L4PcVz6EPjwpZQeYrn
         z9i/nlRi9jqYmXd0hqZ+JjVnV80FfSvX9P2ZQ6LRIwskGdL+gUAyw3m7+M3Lwqef3fvR
         DyhWg9KPKrqv2y12mD7RQV4g8HmESbcF20tBh/eVMQQ75h+FMF6B1aeYGmOI1LqS0EEU
         i5kg==
X-Gm-Message-State: AOAM532D2sQN1Z18bj9N1m7VnPzy9CQogDkK+Um+8cwDgQflOGw1h2T0
        xCw7Axxy1Wz+en03k8+tpUu2BE6N3/YDc61xaFB5/TjNUEZ7wziphGhb1KXQ1c6csmU+sjX2cyA
        PaHsn0P6kZnnQWxL3zqHmY8LWE2DrMZBNKnusgxY5vg==
X-Received: by 2002:a17:906:fc10:b0:6cd:84e:7248 with SMTP id ov16-20020a170906fc1000b006cd084e7248mr5828489ejb.281.1646569556989;
        Sun, 06 Mar 2022 04:25:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtjGEBqK86psci1L+lbsLAgMQjYw6AEHose62VxcrfITBR0rIq63rYjHniHfZEmpIxnejZuw==
X-Received: by 2002:a17:906:fc10:b0:6cd:84e:7248 with SMTP id ov16-20020a170906fc1000b006cd084e7248mr5828479ejb.281.1646569556757;
        Sun, 06 Mar 2022 04:25:56 -0800 (PST)
Received: from [192.168.0.140] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m26-20020a1709060d9a00b006da81fb9d72sm3767472eji.100.2022.03.06.04.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 04:25:56 -0800 (PST)
Message-ID: <ab2c0a8d-d27b-0c93-c7bc-2c8bf8ee1036@canonical.com>
Date:   Sun, 6 Mar 2022 13:25:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] nvmem: Add Apple eFuse driver
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220306121816.70537-1-sven@svenpeter.dev>
 <20220306121816.70537-2-sven@svenpeter.dev>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220306121816.70537-2-sven@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2022 13:18, Sven Peter wrote:
> Apple SoCs contain eFuses used to store factory-programmed data such
> as calibration values for the PCIe or the Type-C PHY. They are organized
> as 32bit values exposed as MMIO.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
> v1 -> v2:
>   - fixed sparse warning about __iomem by introducing
>     struct apple_efuses_priv as done in other nvmem drivers
>   - make sure the driver actually works as a module by
>     setting .owner to THIS_MODULE and adding MODULE_DEVICE_TABLE
>     pointed out by Joey Gouly
> 
>  MAINTAINERS                  |  1 +
>  drivers/nvmem/Kconfig        | 12 ++++++
>  drivers/nvmem/Makefile       |  2 +
>  drivers/nvmem/apple-efuses.c | 82 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 97 insertions(+)
>  create mode 100644 drivers/nvmem/apple-efuses.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f70d8525cbd4..e3e973a3f651 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1781,6 +1781,7 @@ F:	drivers/i2c/busses/i2c-pasemi-core.c
>  F:	drivers/i2c/busses/i2c-pasemi-platform.c
>  F:	drivers/irqchip/irq-apple-aic.c
>  F:	drivers/mailbox/apple-mailbox.c
> +F:	drivers/nvmem/apple-efuses.c
>  F:	drivers/pinctrl/pinctrl-apple-gpio.c
>  F:	drivers/soc/apple/*
>  F:	drivers/watchdog/apple_wdt.c
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index da414617a54d..bba29d1aec96 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -300,4 +300,16 @@ config NVMEM_BRCM_NVRAM
>  	  This driver provides support for Broadcom's NVRAM that can be accessed
>  	  using I/O mapping.
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
>  endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index dcbbde35b6a8..1a8e54691d3e 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -61,3 +61,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
>  nvmem-rmem-y			:= rmem.o
>  obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
>  nvmem_brcm_nvram-y		:= brcm_nvram.o
> +obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
> +nvmem-apple-efuses-y 		:= apple-efuses.o
> diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
> new file mode 100644
> index 000000000000..dd5576ec5408
> --- /dev/null
> +++ b/drivers/nvmem/apple-efuses.c
> @@ -0,0 +1,82 @@
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
> +		.owner = THIS_MODULE,
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
> +		.owner = THIS_MODULE,

You wrote it also in changelog, but why do you need it? Doesn't core set
it? Coccinelle should complain about this as well.

Best regards,
Krzysztof
