Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5F4CF448
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiCGJJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiCGJJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:09:40 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF2E60DA2;
        Mon,  7 Mar 2022 01:08:45 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3B5FB5C031E;
        Mon,  7 Mar 2022 04:08:43 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Mon, 07 Mar 2022 04:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=CuD+6UMoHVIR6oldfnrYz19HAfESfe
        N1v5yLvdZkpkI=; b=HNlRkQNBATVq9XbYKl09SZsmzqhv+DgzkzTZfACXeadb1r
        jJp5ggogTaKrs5JuQKLV4+QUqRcScoJlo0nPYYz07y+/khiNQHVC0EUyOVEWOzt0
        FX1HspPIUl+5rjAu4hMZsJqsT2uTgQTbcEfdORQd7pqVJPdm6JxF4YDNS8mRktyE
        TSITmdatD5x1/jhepkiF/WMt80YtiT5URmjape1KP/T5Xen1iHrtc6iujVyg4seS
        AgkSYfj2I4m3I8isqSUHOs8lBnKnkw529+XdwN6TeojYKkijX/qZHVnAUIggmaAa
        WUUj0gUNtc/4QA7VnfhLA7bOfh4MWSiiY/FVJIxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CuD+6UMoHVIR6oldf
        nrYz19HAfESfeN1v5yLvdZkpkI=; b=GbHVdYZl+iMeTFOcCbuo6ObLlJ22l2DtF
        HxDi+aedjFK4qRHNg+W7RNvauDjN5/uCyEJBsXuQ07CZM/KXpOfpxek/2036uJLM
        K9Jhf6iG7shFa3WxjfjhAiuzSjN8E4Q/tVLJvSM7VnGp94ebxBu0D65VoE1uF8tm
        4R6cLP9xMXYzsTOXe1i0PDDKTCbzM/tw/sGk+Z2b9EHXAHpduoFXmJO8MUkrQxNV
        VydUNmnjhWPlOuTcXsj+mi8OuqgP+FVqTW5RWe/2DwUiymty06ZK3xZPcMK+EC4y
        HGZK6V0qPJU37O8GZ97a/e+agEUMo2W1wnAqksAfOCENUkUPOuu9w==
X-ME-Sender: <xms:msslYh52gPkbK5YEtZ5JrLSvL1th7V6kq459B5ojuK0uNEQFzgNd0A>
    <xme:msslYu5ab9X0T-Vn2Tyi7Odi-6zO3itNjpiCXoull8h0SP9Fg4QSLvEaEYBIngXEo
    9IBuGtfWg7uJrwc3bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddufedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:msslYofj4xrqh8ZaRu7d60UWeZH_FOHMKArpzF35MvKpAsvc5gKGWA>
    <xmx:msslYqKWykj34tZPi26Qu8pudENb6uTNb56LHWIPS-6TxsKvjbNS1A>
    <xmx:msslYlJzM5f5dxuJkdb9J8nxTuxXq5_sARtKWjoyUFjYr_34ejdr3Q>
    <xmx:m8slYqp8PXZePl3TkiLI7NvHgN5mJwJSjQ4MelMp1XreknWvYwZC7g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ACC0A2740108; Mon,  7 Mar 2022 04:08:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4778-g14fba9972e-fm-20220217.001-g14fba997
Mime-Version: 1.0
Message-Id: <9f43d5db-1476-4505-a9de-b862fbaf2685@www.fastmail.com>
In-Reply-To: <ab2c0a8d-d27b-0c93-c7bc-2c8bf8ee1036@canonical.com>
References: <20220306121816.70537-1-sven@svenpeter.dev>
 <20220306121816.70537-2-sven@svenpeter.dev>
 <ab2c0a8d-d27b-0c93-c7bc-2c8bf8ee1036@canonical.com>
Date:   Mon, 07 Mar 2022 10:08:22 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Joey Gouly" <joey.gouly@arm.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvmem: Add Apple eFuse driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, Mar 6, 2022, at 13:25, Krzysztof Kozlowski wrote:
> On 06/03/2022 13:18, Sven Peter wrote:
>> Apple SoCs contain eFuses used to store factory-programmed data such
>> as calibration values for the PCIe or the Type-C PHY. They are organized
>> as 32bit values exposed as MMIO.
>> 
>> Signed-off-by: Sven Peter <sven@svenpeter.dev>
>> ---
>> v1 -> v2:
>>   - fixed sparse warning about __iomem by introducing
>>     struct apple_efuses_priv as done in other nvmem drivers
>>   - make sure the driver actually works as a module by
>>     setting .owner to THIS_MODULE and adding MODULE_DEVICE_TABLE
>>     pointed out by Joey Gouly
>> 
>>  MAINTAINERS                  |  1 +
>>  drivers/nvmem/Kconfig        | 12 ++++++
>>  drivers/nvmem/Makefile       |  2 +
>>  drivers/nvmem/apple-efuses.c | 82 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 97 insertions(+)
>>  create mode 100644 drivers/nvmem/apple-efuses.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index f70d8525cbd4..e3e973a3f651 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1781,6 +1781,7 @@ F:	drivers/i2c/busses/i2c-pasemi-core.c
>>  F:	drivers/i2c/busses/i2c-pasemi-platform.c
>>  F:	drivers/irqchip/irq-apple-aic.c
>>  F:	drivers/mailbox/apple-mailbox.c
>> +F:	drivers/nvmem/apple-efuses.c
>>  F:	drivers/pinctrl/pinctrl-apple-gpio.c
>>  F:	drivers/soc/apple/*
>>  F:	drivers/watchdog/apple_wdt.c
>> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
>> index da414617a54d..bba29d1aec96 100644
>> --- a/drivers/nvmem/Kconfig
>> +++ b/drivers/nvmem/Kconfig
>> @@ -300,4 +300,16 @@ config NVMEM_BRCM_NVRAM
>>  	  This driver provides support for Broadcom's NVRAM that can be accessed
>>  	  using I/O mapping.
>>  
>> +config NVMEM_APPLE_EFUSES
>> +	tristate "Apple eFuse support"
>> +	depends on ARCH_APPLE || COMPILE_TEST
>> +	default ARCH_APPLE
>> +	help
>> +	  Say y here to enable support for reading eFuses on Apple SoCs
>> +	  such as the M1. These are e.g. used to store factory programmed
>> +	  calibration data required for the PCIe or the USB-C PHY.
>> +
>> +	  This driver can also be built as a module. If so, the module will
>> +	  be called nvmem-apple-efuses.
>> +
>>  endif
>> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
>> index dcbbde35b6a8..1a8e54691d3e 100644
>> --- a/drivers/nvmem/Makefile
>> +++ b/drivers/nvmem/Makefile
>> @@ -61,3 +61,5 @@ obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
>>  nvmem-rmem-y			:= rmem.o
>>  obj-$(CONFIG_NVMEM_BRCM_NVRAM)	+= nvmem_brcm_nvram.o
>>  nvmem_brcm_nvram-y		:= brcm_nvram.o
>> +obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
>> +nvmem-apple-efuses-y 		:= apple-efuses.o
>> diff --git a/drivers/nvmem/apple-efuses.c b/drivers/nvmem/apple-efuses.c
>> new file mode 100644
>> index 000000000000..dd5576ec5408
>> --- /dev/null
>> +++ b/drivers/nvmem/apple-efuses.c
>> @@ -0,0 +1,82 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Apple SoC eFuse driver
>> + *
>> + * Copyright (C) The Asahi Linux Contributors
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/nvmem-provider.h>
>> +#include <linux/platform_device.h>
>> +
>> +struct apple_efuses_priv {
>> +	void __iomem *fuses;
>> +};
>> +
>> +static int apple_efuses_read(void *context, unsigned int offset, void *val,
>> +			     size_t bytes)
>> +{
>> +	struct apple_efuses_priv *priv = context;
>> +	u32 *dst = val;
>> +
>> +	while (bytes >= sizeof(u32)) {
>> +		*dst++ = readl_relaxed(priv->fuses + offset);
>> +		bytes -= sizeof(u32);
>> +		offset += sizeof(u32);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int apple_efuses_probe(struct platform_device *pdev)
>> +{
>> +	struct apple_efuses_priv *priv;
>> +	struct resource *res;
>> +	struct nvmem_config config = {
>> +		.dev = &pdev->dev,
>> +		.read_only = true,
>> +		.reg_read = apple_efuses_read,
>> +		.stride = sizeof(u32),
>> +		.word_size = sizeof(u32),
>> +		.name = "apple_efuses_nvmem",
>> +		.id = NVMEM_DEVID_AUTO,
>> +		.owner = THIS_MODULE,
>> +		.root_only = true,
>> +	};
>> +
>> +	priv = devm_kzalloc(config.dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->fuses = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> +	if (IS_ERR(priv->fuses))
>> +		return PTR_ERR(priv->fuses);
>> +
>> +	config.priv = priv;
>> +	config.size = resource_size(res);
>> +
>> +	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
>> +}
>> +
>> +static const struct of_device_id apple_efuses_of_match[] = {
>> +	{ .compatible = "apple,efuses", },
>> +	{}
>> +};
>> +
>> +MODULE_DEVICE_TABLE(of, apple_efuses_of_match);
>> +
>> +static struct platform_driver apple_efuses_driver = {
>> +	.driver = {
>> +		.name = "apple_efuses",
>> +		.of_match_table = apple_efuses_of_match,
>> +		.owner = THIS_MODULE,
>
> You wrote it also in changelog, but why do you need it? Doesn't core set
> it? Coccinelle should complain about this as well.
>

yeah, you're right. I shouldn't have just blindly followed what Hector and Joey
had to do for another subsystem to make reference counting work there.

I just checked again and it's neither required here not in struct nvmem_config
because module_platform_driver -> platform_driver_register ->
__platform_driver_register will set it in struct platform_driver and the
nvmem core will take it from there and set it inside nvmem_config.


thanks,


Sven
