Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0350E550CB1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiFSTGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiFSTGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:06:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA68B84D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:06:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso4717721wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vdFd4qqag3U0e1CfmhgpRXG+dTkFq3oEXT5WIataWB8=;
        b=Wi9LBlUYcEifHMQVviNMwBY2xCtlb5mbgGcl6V2sCp6iRROw0csaxDs8zsraqTHouP
         tNVKs0yMBJu803dqugh7EtShMmPb7mP7ai1MLMguj13LYgHF5d83ChcxyuP0o1lOB8Fg
         7G3d8GNEBE9KBE+OWHgk00GgczRmNVDBan1SNLFlr1thVsm9dqcq+qqDO5nP43+gHllx
         ScZkfc1nqw4j+bg7IzlcTMNquD+56vswbL3OFJNrXEB1XKnhEPCF4ea5pG6QMrsxL7B7
         3uM466jTucVTlo9S6W7+CuKIazu0pO6hgkvWuK/hhYOrfivo7Ciyq+ZcWOLjXfrjVElq
         fa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vdFd4qqag3U0e1CfmhgpRXG+dTkFq3oEXT5WIataWB8=;
        b=7apCItfEoEMgMiDEmgGM1XDE0CHlxk6erRztCOY7x1IMJ1sge4jYAJNTS8MnrEn56M
         Ephz9DJNOzHrjLStPaNjOvGJzxdvVXdmxS4e/zWydaMIQwuq+wIscSXVUqDdB44Q49q8
         a0XpjWtvRYwJG2g/S05mHwt63DK3xXHUMFV47eB14EJgDoQstQBsU+aQjkZiOhh3uXnd
         KjjIt3MJ+tTvhX15FbURbUY6AN6dQe8BNpwz0DUYiixxGDoDWfEcpuJSvgF0/sHiRwZ9
         d7DJfV/q7eKK7YjH+3y6HUXCMbAW3QMtxA9qmUMUjc/CUkWFzjpzxT7my6wu8+ND+lyf
         XHag==
X-Gm-Message-State: AOAM530UwmqrQQnNGp3X03LVoayro0/lJ3drwg6PDt3Jvtuf+o3e4jxF
        yXg3Rmuz9VyCeJ3rH/5u5TEAmg2b5evO2kfU75Y=
X-Google-Smtp-Source: ABdhPJyBi8frreI8Mtw2svQ94TzS9Hz+kHZGT4o6iWlQLjyB38Iq/sKejOwWTiYxORB1ZKzo1UxKJg==
X-Received: by 2002:a05:600c:a41:b0:39c:1512:98bd with SMTP id c1-20020a05600c0a4100b0039c151298bdmr31949219wmq.88.1655665564686;
        Sun, 19 Jun 2022 12:06:04 -0700 (PDT)
Received: from [192.168.2.222] ([51.37.234.167])
        by smtp.gmail.com with ESMTPSA id y12-20020adff6cc000000b0021126891b05sm10721220wrp.61.2022.06.19.12.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 12:06:03 -0700 (PDT)
Message-ID: <f6118ece-3281-df95-4070-4041a0800688@conchuod.ie>
Date:   Sun, 19 Jun 2022 20:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC 4/6] reset: add polarfire soc reset support
Content-Language: en-US
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220619164935.1492823-1-mail@conchuod.ie>
 <20220619164935.1492823-5-mail@conchuod.ie>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220619164935.1492823-5-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
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



On 19/06/2022 17:49, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add support for the resets on Microchip's PolarFire SoC (MPFS).
> Reset control is a single register, wedged in between registers for
> clock control. To fit with existed DT etc, the reset controller is
> created using the aux device framework & set up in the clock driver.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/reset/Kconfig      |   9 +++
>  drivers/reset/Makefile     |   2 +-
>  drivers/reset/reset-mpfs.c | 155 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 165 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/reset/reset-mpfs.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 93c8d07ee328..8f7d7cda690d 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -122,6 +122,15 @@ config RESET_MCHP_SPARX5
>  	help
>  	  This driver supports switch core reset for the Microchip Sparx5 SoC.
>  
> +config RESET_POLARFIRE_SOC
> +	bool "Microchip PolarFire SoC (MPFS) Reset Driver"
> +	depends on AUXILIARY_BUS

(Correctly) According to lkp I screwed this up, needs to depend on
MCHP_CLK_MPFS.

> +	default MCHP_CLK_MPFS
> +	help
> +	  This driver supports switch core reset for the Microchip PolarFire SoC
> +
> +	  CONFIG_RESET_MPFS
> +
>  config RESET_MESON
>  	tristate "Meson Reset Driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index a80a9c4008a7..5fac3a753858 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_RESET_K210) += reset-k210.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
>  obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>  obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
> +obj-$(CONFIG_RESET_POLARFIRE_SOC) += reset-mpfs.o
>  obj-$(CONFIG_RESET_MESON) += reset-meson.o
>  obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
>  obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
> @@ -38,4 +39,3 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
>  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
>  obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
> -
> diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> new file mode 100644
> index 000000000000..6c9c10cd9077
> --- /dev/null
> +++ b/drivers/reset/reset-mpfs.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PolarFire SoC (MPFS) Peripheral Clock Reset Controller
> + *
> + * Author: Conor Dooley <conor.dooley@microchip.com>
> + * Copyright (c) 2022 Microchip Technology Inc. and its subsidiaries.
> + *
> + */
> +#include <linux/auxiliary_bus.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <dt-bindings/clock/microchip,mpfs-clock.h>
> +#include <soc/microchip/mpfs.h>
> +
> +/*
> + * The ENVM reset is the lowest bit in the register & I am using the CLK_FOO
> + * defines in the dt to make things easier to configure - so this is accounting
> + * for the offset of 3 there.
> + */
> +#define MPFS_PERIPH_OFFSET	CLK_ENVM
> +#define MPFS_NUM_RESETS		30u
> +
> +/*
> + * Peripheral clock resets
> + */
> +
> +static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	u32 reg;
> +
> +	reg = mpfs_reset_read(rcdev->dev);
> +	reg |= (1u << id);
> +	mpfs_reset_write(rcdev->dev, reg);
> +
> +	dev_dbg(rcdev->dev,
> +		"Asserting reset for device with REG_SUBBLK_RESET_CR index: %u\n",
> +		id);
> +	return 0;
> +}
> +
> +static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	u32 reg, val;
> +
> +	reg = mpfs_reset_read(rcdev->dev);
> +	val = reg & ~(1u << id);
> +	mpfs_reset_write(rcdev->dev, val);
> +
> +	dev_dbg(rcdev->dev,
> +		"Deasserting device with REG_SUBBLK_RESET_CR index: %u\n",
> +		id);
> +
> +	return 0;
> +}
> +
> +static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	u32 reg = mpfs_reset_read(rcdev->dev);
> +
> +	return (reg & (1u << id));
> +}
> +
> +static int mpfs_reset(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	dev_dbg(rcdev->dev,
> +		"Resetting device with REG_SUBBLK_RESET_CR index: %u\n",
> +		id);
> +
> +	mpfs_assert(rcdev, id);
> +
> +	/* Value is stolen from the rcar reset driver, will need changing after RFC */
> +	udelay(35);
> +
> +	mpfs_deassert(rcdev, id);
> +
> +	return 0;
> +}
> +
> +static const struct reset_control_ops mpfs_reset_ops = {
> +	.reset = mpfs_reset,
> +	.assert = mpfs_assert,
> +	.deassert = mpfs_deassert,
> +	.status = mpfs_status,
> +};
> +
> +static int mpfs_reset_xlate(struct reset_controller_dev *rcdev,
> +			    const struct of_phandle_args *reset_spec)
> +{
> +	unsigned int index = reset_spec->args[0];
> +
> +	/*
> +	 * CLK_RESERVED does not map to a clock, but it does map to a reset,
> +	 * so it has to be accounted for here. It is the reset for the fabric,
> +	 * so if this reset gets called - do not reset it.
> +	 */
> +	if (index == CLK_RESERVED) {
> +		dev_err(rcdev->dev, "Resetting the fabric is not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	if (index < MPFS_PERIPH_OFFSET || index >= (MPFS_PERIPH_OFFSET + rcdev->nr_resets)) {
> +		dev_err(rcdev->dev, "Invalid reset index %u\n", reset_spec->args[0]);
> +		return -EINVAL;
> +	}
> +
> +	return index - MPFS_PERIPH_OFFSET;
> +}
> +
> +static int mpfs_reset_probe(struct auxiliary_device *adev,
> +			    const struct auxiliary_device_id *id)
> +{
> +	struct device *dev = &adev->dev;
> +	struct reset_controller_dev *rcdev;
> +	int ret;
> +
> +	rcdev = devm_kzalloc(dev, sizeof(*rcdev), GFP_KERNEL);
> +	if (!rcdev)
> +		return -ENOMEM;
> +
> +	rcdev->dev = dev;
> +	rcdev->dev->parent = adev->dev.parent;
> +	rcdev->ops = &mpfs_reset_ops;
> +	rcdev->of_node = adev->dev.parent->of_node;
> +	rcdev->of_reset_n_cells = 1;
> +	rcdev->of_xlate = mpfs_reset_xlate;
> +	rcdev->nr_resets = MPFS_NUM_RESETS;
> +
> +	ret = devm_reset_controller_register(dev, rcdev);
> +	if (!ret)
> +		dev_info(dev, "Registered MPFS reset controller\n");
> +
> +	return ret;
> +}
> +
> +static const struct auxiliary_device_id mpfs_reset_ids[] = {
> +	{
> +		.name = "clk_mpfs.reset-mpfs",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, mpfs_reset_ids);
> +
> +static struct auxiliary_driver mpfs_reset_driver = {
> +	.probe		= mpfs_reset_probe,
> +	.id_table	= mpfs_reset_ids,
> +};
> +
> +module_auxiliary_driver(mpfs_reset_driver);
> +
> +MODULE_DESCRIPTION("Microchip PolarFire SoC Reset Driver");
> +MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(MCHP_CLK_MPFS);
