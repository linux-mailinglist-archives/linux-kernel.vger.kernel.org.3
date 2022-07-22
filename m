Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596B557E643
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiGVSIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbiGVSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:07:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7513F97A2F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:07:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d17so6736095lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JB4HSiAwKKWXGdC1Qe/rK/yYL8pNlPccjQ6EOdGe89c=;
        b=zLej6AaohIDG2tWHVINiyFQspJROysk+PBVTTZrkwrxHU3GO0IpJ2dh62tzdmHop8u
         OtAAufLcJAQNSw3qcrmuhfRNIjiRIu6gSedybTQDwLJXd3NL5hjiU9syR+gGQiKiCUm+
         PhhfSFWGXhxMLE31/uVl/qCaNb+edJjp4CWJk+rF8AHD0tfR3aTmEM0pM44a0hrQDt2z
         YDBngBRcYPeoCN0Dv5xuVsHTCLc/ResGScheJRiDDhBYsRZC2cOUrFq1wQmuaDq0O4xi
         E+DXMRTETuOirZ8b0AdB96Vu2s2pH2KukK+7QT4stiM3HQ6SP2n1BTCHfpXUzyRt3m4h
         d/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JB4HSiAwKKWXGdC1Qe/rK/yYL8pNlPccjQ6EOdGe89c=;
        b=A/hrhgh6CSelIzpjYS+TkOuoybAEimNnm5gQ1bMx1ZF06gemTSOFJtrSovYLsPciit
         bEZimX4df2Uhag8IskO+yxbCgb70Cw7qFDElBo2UT1KI6hRzXTpvaT1C8pJP3J/IsTMA
         IYW2rwuyvj2XK45mCXTYhoMlBfZi6GcMfvzDi8plrXO21JBahdgYfiszmWvB3K7KiYnd
         xhJwtZUx8e9cTIcfvzG6GYGd2I0SLRDn4tkS0ebq6H1Xb181ExkvHQuztBjoZ69vkybM
         gWWwGpwzLJ3OfLdCaDLE88n9vSBRv4A82P9UMH4Y5+hTBcmmupZECVB92TOVsr8FKlui
         yTBw==
X-Gm-Message-State: AJIora92i0nOIxsP58iClXcQGxUg8UtDSe5ZKPiD/ECf9O0vNNgdwrKz
        UhMYUjJJothejHbpEsPVkp41lg==
X-Google-Smtp-Source: AGRyM1vmSXeJNzfcFqcPE/ezJ6BwY72bw+BzviY9fFT1PwtIvSt2at5y6IEACVpQJMuNQym8WImkcA==
X-Received: by 2002:a05:6512:3452:b0:486:eff:739c with SMTP id j18-20020a056512345200b004860eff739cmr434508lfr.549.1658513270153;
        Fri, 22 Jul 2022 11:07:50 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id y3-20020a2e9d43000000b0025d83984893sm1205890ljj.68.2022.07.22.11.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:07:49 -0700 (PDT)
Message-ID: <1a0245c3-5659-573a-c74d-c2145a564b76@linaro.org>
Date:   Fri, 22 Jul 2022 20:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] SPI: Ingenic: Add SFC support for Ingenic SoCs.
Content-Language: en-US
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, tudor.ambarus@microchip.com,
        p.yadav@ti.com, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 18:48, 周琰杰 (Zhou Yanjie) wrote:
> Add SFC support for the X1000 SoC, the X1600 SoC, and the X2000 SoC
> from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  drivers/spi/Kconfig           |   9 +
>  drivers/spi/Makefile          |   1 +
>  drivers/spi/spi-ingenic-sfc.c | 662 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 672 insertions(+)
>  create mode 100644 drivers/spi/spi-ingenic-sfc.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3b1044e..1077bd3 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -437,6 +437,15 @@ config SPI_INGENIC
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called spi-ingenic.
>  
> +config SPI_INGENIC_SFC
> +	tristate "Ingenic SoCs SPI Flash Controller"
> +	depends on MACH_INGENIC || COMPILE_TEST
> +	help
> +	  This enables support for the Ingenic SoCs SPI flash controller.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ingenic-sfc.
> +
>  config SPI_INTEL
>  	tristate
>  
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 0f44eb6..f3e42c0 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
>  obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
>  obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
>  obj-$(CONFIG_SPI_INGENIC)		+= spi-ingenic.o
> +obj-$(CONFIG_SPI_INGENIC_SFC)	+= spi-ingenic-sfc.o
>  obj-$(CONFIG_SPI_INTEL)			+= spi-intel.o
>  obj-$(CONFIG_SPI_INTEL_PCI)		+= spi-intel-pci.o
>  obj-$(CONFIG_SPI_INTEL_PLATFORM)	+= spi-intel-platform.o
> diff --git a/drivers/spi/spi-ingenic-sfc.c b/drivers/spi/spi-ingenic-sfc.c
> new file mode 100644
> index 00000000..a565546
> --- /dev/null
> +++ b/drivers/spi/spi-ingenic-sfc.c
> @@ -0,0 +1,662 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Ingenic SoCs SPI Flash Controller Driver
> + * Copyright (c) 2022 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +/* SFC register offsets */
> +#define SFC_REG_GLB						0x0000
> +#define SFC_REG_DEV_CONF				0x0004
> +#define SFC_REG_DEV_STA_EXP				0x0008
> +#define SFC_REG_DEV_STA_RT				0x000c
> +#define SFC_REG_DEV_STA_MSK				0x0010
> +#define SFC_REG_TRAN_CONF(n)			(0x0014 + n * 4)
> +#define SFC_REG_TRAN_CFG0(n)			(0x0014 + n * 4)
> +#define SFC_REG_TRAN_LEN				0x002c
> +#define SFC_REG_DEV_ADDR(n)				(0x0030 + n * 4)
> +#define SFC_REG_DEV_ADDR_PLUS(n)		(0x0048 + n * 4)
> +#define SFC_REG_MEM_ADDR				0x0060
> +#define SFC_REG_TRIG					0x0064
> +#define SFC_REG_SR						0x0068
> +#define SFC_REG_SCR						0x006c
> +#define SFC_REG_INTC					0x0070
> +#define SFC_REG_FSM						0x0074
> +#define SFC_REG_CGE						0x0078
> +#define SFC_REG_TRAN_CFG1(n)			(0x009c + n * 4)
> +#define SFC_REG_DR						0x1000
> +
> +/* bits within the GLB register */
> +#define GLB_TRAN_DIR_MASK				GENMASK(13, 13)
> +#define GLB_TRAN_DIR_WRITE				0x1
> +#define GLB_TRAN_DIR_READ				0x0
> +#define GLB_THRESHOLD_MASK				GENMASK(12, 7)
> +#define GLB_OP_MODE_MASK				GENMASK(6, 6)
> +#define GLB_OP_MODE_DMA					0x1
> +#define GLB_OP_MODE_SLAVE				0x0
> +#define GLB_PHASE_NUM_MASK				GENMASK(5, 3)
> +#define GLB_WP_EN						BIT(2)
> +#define GLB_BURST_MD_MASK				GENMASK(1, 0)
> +#define GLB_BURST_MD_INCR32				0x3
> +#define GLB_BURST_MD_INCR16				0x2
> +#define GLB_BURST_MD_INCR8				0x1
> +#define GLB_BURST_MD_INCR4				0x0
> +
> +/* bits within the DEV_CONF register */
> +#define DEV_CONF_SMP_DELAY_MASK			GENMASK(20, 16)
> +#define DEV_CONF_SMP_DELAY_180DEG		0x4
> +#define DEV_CONF_SMP_DELAY_HALF_CYCLE	0x1
> +#define DEV_CONF_CMD_TYPE_MASK			GENMASK(15, 15)
> +#define DEV_CONF_CMD_TYPE_16BIT			0x1
> +#define DEV_CONF_CMD_TYPE_8BIT			0x0
> +#define DEV_CONF_STA_TYPE_MASK			GENMASK(14, 13)
> +#define DEV_CONF_THOLD_MASK				GENMASK(12, 11)
> +#define DEV_CONF_TSETUP_MASK			GENMASK(10, 9)
> +#define DEV_CONF_TSH_MASK				GENMASK(8, 5)
> +#define DEV_CONF_CPHA					BIT(4)
> +#define DEV_CONF_CPOL					BIT(3)
> +#define DEV_CONF_CE_DL					BIT(2)
> +#define DEV_CONF_HOLD_DL				BIT(1)
> +#define DEV_CONF_WP_DL					BIT(0)
> +
> +/* bits within the TRAN_CONF(n) register */
> +#define TRAN_CONF_TRAN_MODE_MASK		GENMASK(31, 29)
> +#define TRAN_CONF_ADDR_WIDTH_MASK		GENMASK(28, 26)
> +#define TRAN_CONF_POLL_EN				BIT(25)
> +#define TRAN_CONF_CMD_EN				BIT(24)
> +#define TRAN_CONF_PHASE_FORMAT_MASK		GENMASK(23, 23)
> +#define TRAN_CONF_DMY_BITS_MASK			GENMASK(22, 17)
> +#define TRAN_CONF_DATA_EN				BIT(16)
> +#define TRAN_CONF_CMD_MASK				GENMASK(15, 0)
> +
> +/* bits within the TRIG register */
> +#define TRIG_FLUSH						BIT(2)
> +#define TRIG_STOP						BIT(1)
> +#define TRIG_START						BIT(0)
> +
> +/* bits within the SR register */
> +#define SR_FIFO_NUM_MASK				GENMASK(22, 16)
> +#define SR_END							BIT(4)
> +#define SR_TRAN_REQ						BIT(3)
> +#define SR_RECE_REQ						BIT(2)
> +#define SR_OVER							BIT(1)
> +#define SR_UNDER						BIT(0)
> +
> +/* bits within the SCR register */
> +#define SCR_CLR_END						BIT(4)
> +#define SCR_CLR_TREQ					BIT(3)
> +#define SCR_CLR_RREQ					BIT(2)
> +#define SCR_CLR_OVER					BIT(1)
> +#define SCR_CLR_UNDER					BIT(0)
> +
> +/* bits within the INTC register */
> +#define INTC_MASK_END					BIT(4)
> +#define INTC_MASK_TREQ					BIT(3)
> +#define INTC_MASK_RREQ					BIT(2)
> +#define INTC_MASK_OVER					BIT(1)
> +#define INTC_MASK_UNDER					BIT(0)
> +
> +/* bits within the TRAN_CFG1(n) register */
> +#define TRAN_CFG1_TRAN_MODE_MASK		GENMASK(7, 4)
> +
> +#define TRAN_MODE_STANDARD				0
> +#define TRAN_MODE_DUAL_DATA				1
> +#define TRAN_MODE_DUAL_IO				2
> +#define TRAN_MODE_DUAL_FULL				3
> +#define TRAN_MODE_QUAD_DATA				5
> +#define TRAN_MODE_QUAD_IO				6
> +#define TRAN_MODE_QUAD_FULL				7
> +#define TRAN_MODE_OCTAL_DATA			9
> +#define TRAN_MODE_OCTAL_IO				10
> +#define TRAN_MODE_OCTAL_FULL			11
> +
> +#define INGENIC_SFC_FIFO_SIZE			(64 * 4)
> +
> +#define INGENIC_SFC_TRANSFER_TIMEOUT	1000
> +
> +enum ingenic_sfc_version {
> +	ID_X1000,
> +	ID_X1600,
> +	ID_X2000,
> +};
> +
> +struct ingenic_soc_info {
> +	enum ingenic_sfc_version version;
> +

No need for blank line.

> +	unsigned int max_bus_width;
> +

Remove as well.

> +	const u32 tran_mode_mask;
> +};
> +
> +struct ingenic_sfc {
> +	const struct ingenic_soc_info *soc_info;
> +
> +	void __iomem *base;
> +	struct device *dev;
> +	struct clk *clk;
> +	int irq;
> +
> +	struct completion completion;
> +};
> +
> +static irqreturn_t ingenic_sfc_irq_handler(int irq, void *data)
> +{
> +	struct ingenic_sfc *sfc = data;
> +
> +	writel(0x1f, sfc->base + SFC_REG_INTC);
> +
> +	complete(&sfc->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ingenic_sfc_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	uintptr_t addr = (uintptr_t)op->data.buf.in;
> +
> +	if (op->data.nbytes > INGENIC_SFC_FIFO_SIZE && !IS_ALIGNED(addr, 4))
> +		op->data.nbytes = INGENIC_SFC_FIFO_SIZE;
> +
> +	return 0;
> +}
> +
> +static bool ingenic_sfc_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct spi_device *spi = mem->spi;
> +	struct ingenic_sfc *sfc = spi_controller_get_devdata(spi->master);
> +	uintptr_t addr = (uintptr_t)op->data.buf.in;
> +
> +	/* The controller only supports Standard SPI mode, Duall mode, Quad mode and Octal mode. */
> +	if (op->cmd.buswidth > sfc->soc_info->max_bus_width ||
> +		op->addr.buswidth > sfc->soc_info->max_bus_width ||
> +		op->dummy.buswidth > sfc->soc_info->max_bus_width ||
> +		op->data.buswidth > sfc->soc_info->max_bus_width)
> +		return false;
> +
> +	/* Max 32 dummy clock cycles supported */
> +	if (op->dummy.nbytes && op->dummy.nbytes * 8 / op->dummy.buswidth > 32)
> +		return false;
> +
> +	/* Max rx data length, check controller limits and alignment */
> +	if (op->data.dir == SPI_MEM_DATA_IN &&
> +		op->data.nbytes > INGENIC_SFC_FIFO_SIZE && !IS_ALIGNED(addr, 4))
> +		return false;
> +
> +	/* Max 6 bytes address width supported */
> +	if (op->addr.nbytes > 6)
> +		return false;
> +
> +	return spi_mem_default_supports_op(mem, op);
> +}
> +
> +static void ingenic_sfc_set_transfer_mode(struct ingenic_sfc *sfc, const struct spi_mem_op *op)
> +{
> +	int val;
> +
> +	val = readl(sfc->base + (sfc->soc_info->version >= ID_X1600 ?
> +			SFC_REG_TRAN_CFG1(0) : SFC_REG_TRAN_CONF(0)));

This is no really readable.

> +	val &= ~sfc->soc_info->tran_mode_mask;
> +	if (op->cmd.buswidth == 8)
> +		val |= (TRAN_MODE_OCTAL_FULL << (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->cmd.buswidth == 4)
> +		val |= (TRAN_MODE_QUAD_FULL << (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->cmd.buswidth == 2)
> +		val |= (TRAN_MODE_DUAL_FULL << (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->addr.buswidth == 8)
> +		val |= (TRAN_MODE_OCTAL_IO << (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->addr.buswidth == 4)
> +		val |= (TRAN_MODE_QUAD_IO << (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->addr.buswidth == 2)
> +		val |= (TRAN_MODE_DUAL_IO << (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->data.buswidth == 8)
> +		val |= (TRAN_MODE_OCTAL_DATA << (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->data.buswidth == 4)
> +		val |= (TRAN_MODE_QUAD_DATA << (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else if (op->data.buswidth == 2)
> +		val |= (TRAN_MODE_DUAL_DATA << (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	else
> +		val |= (TRAN_MODE_STANDARD << (ffs(sfc->soc_info->tran_mode_mask) - 1)) &
> +				sfc->soc_info->tran_mode_mask;
> +	writel(val, sfc->base + (sfc->soc_info->version >= ID_X1600 ?
> +			SFC_REG_TRAN_CFG1(0) : SFC_REG_TRAN_CONF(0)));

Not readable.

> +}
> +
> +/*
> + * We only need PIO mode to handle the SPI_MEM_NO_DATA transfers,
> + * and the unaligned accesses in SPI_MEM_DATA_IN transfers.
> + */

(...)

> +	sfc->dev = &pdev->dev;
> +
> +	platform_set_drvdata(pdev, sfc);
> +
> +	ret = devm_request_irq(&pdev->dev, sfc->irq, ingenic_sfc_irq_handler, 0,
> +			dev_name(&pdev->dev), sfc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq%d, ret = %d\n", sfc->irq, ret);
> +		goto err_put_master;
> +	}
> +
> +	ctlr->bus_num = -1;
> +	ctlr->num_chipselect = 1;
> +	ctlr->mem_ops = &ingenic_sfc_mem_ops;
> +	ctlr->dev.of_node = pdev->dev.of_node;
> +	ctlr->setup = ingenic_sfc_setup;
> +	ctlr->mode_bits = SPI_CPHA | SPI_CPOL |
> +			SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
> +	if (sfc->soc_info->version >= ID_X2000)
> +		ctlr->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
> +
> +	ret = devm_spi_register_controller(&pdev->dev, ctlr);
> +	if (ret)
> +		goto err_put_master;
> +
> +	return 0;
> +
> +err_put_master:
> +	spi_master_put(ctlr);

What about unpreparing clocks? Is it part of spi_master_put()?

> +
> +	return ret;
> +}
> +
> +static const struct ingenic_soc_info x1000_soc_info = {
> +	.version = ID_X1000,
> +

No need for blank lines after each field.


Best regards,
Krzysztof
