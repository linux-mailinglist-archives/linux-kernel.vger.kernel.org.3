Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE3F4DA024
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350094AbiCOQfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiCOQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:35:37 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F16550059;
        Tue, 15 Mar 2022 09:34:23 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g7so1218011wrb.4;
        Tue, 15 Mar 2022 09:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tyUnuXIDfilf67oqdDzi7HyRYDor5UNbV5JcMlFjM9Y=;
        b=XpNS+OXKY0dknfWFfc40jBwuVKUvfnGKAqQFkSxlUFKYvWgjc4rfXLs8OQg3iEmuWK
         S9iCy3wdXkD+T/zpclR/eYEDalGrdw+ohSRT5+0XRSlOi7qLjJYagj2dCcUKXxBe4t6a
         I9VKbXJ2Zb0YWETulir4L0gljF6xjvrW5eRVZzbd1iWV2Xq9RW+dIKkMH4aq1idL8jxA
         dVT5rYkYy5q7eiSFA08eGzCTtCdS7shfenLy0cInyd1mzmIoCSGP9J5KTzwXWt6NKW2n
         U5A+qesjL2nXt3p2lJWJzRhoGKvSCdOFyphuJO4NQHTVR92P7dwR8dQ6zBcUa0Lp63Au
         W/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tyUnuXIDfilf67oqdDzi7HyRYDor5UNbV5JcMlFjM9Y=;
        b=pMgzcvpD6Wxkw6bBBLTbYaDBz8g1R+ZTmCXLZIsqLIFu+RAMfHOv4iH+wIpPj4KV3N
         bpxelVXWJrpry/Jimj7GFDNo3dvkeT43Yh80bLzJbEJ2JMmf9KH2YaXRG6DcTMT9msEA
         68RvayD+Xu2AoMQhNFPqZ+8sDDydyGLgDttPnAa+FnWj3LYijd6eFVRo8W9ifn/s//Wy
         sPS7/DbcKNf+FKp08nP8wpx0KF1r0bcCsEyKAbvd5xGm6/LSjOFtmTuM3xxbnNRmt/y9
         3GMKI++6q6+VRXUk6pm4OHvqfzKWMLpO5ST9LmxBh1Q0ztaJX9fJTmCjnLGYjAxytswM
         i4kw==
X-Gm-Message-State: AOAM5326rihSeDu1S3mhok3DPSpAfBumHg1Gr2OHy9UEODRIZsgrsITm
        ZyYmKsl8qPt1EDmv0FEEGpE=
X-Google-Smtp-Source: ABdhPJw3y6LK2ci5/PRTL2tmbjIWEOtt2zXlZ36eZDUGb7j30QgeQ5PZ2RowTNYsXrBLtQ91ef3FKQ==
X-Received: by 2002:a5d:5987:0:b0:203:a4a6:c496 with SMTP id n7-20020a5d5987000000b00203a4a6c496mr12168651wri.205.1647362061583;
        Tue, 15 Mar 2022 09:34:21 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d64cc000000b00203da79ca2fsm825522wri.97.2022.03.15.09.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 09:34:20 -0700 (PDT)
Message-ID: <5ef446ee-f7b4-e8df-93fc-fc7ec9cd816a@gmail.com>
Date:   Tue, 15 Mar 2022 17:34:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 2/6] clk: en7523: Add clock driver for Airoha EN7523
 SoC
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>, soc@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220314084409.84394-1-nbd@nbd.name>
 <20220314084409.84394-3-nbd@nbd.name>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220314084409.84394-3-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/03/2022 09:44, Felix Fietkau wrote:
> This driver only registers fixed rate clocks, since the clocks are fully
> initialized by the boot loader and should not be changed later, according
> to Airoha.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/clk/Kconfig      |   9 +
>   drivers/clk/Makefile     |   1 +
>   drivers/clk/clk-en7523.c | 351 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 361 insertions(+)
>   create mode 100644 drivers/clk/clk-en7523.c
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index ad4256d54361..4765e4c6f2a1 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -200,6 +200,15 @@ config COMMON_CLK_CS2000_CP
>   	help
>   	  If you say yes here you get support for the CS2000 clock multiplier.
>   
> +config COMMON_CLK_EN7523
> +	bool "Clock driver for Airoha EN7523 SoC system clocks"
> +	depends on OF
> +	depends on ARCH_AIROHA || COMPILE_TEST
> +	default ARCH_AIROHA
> +	help
> +	  This driver provides the fixed clocks and gates present on Airoha
> +	  ARM silicon.
> +
>   config COMMON_CLK_FSL_FLEXSPI
>   	tristate "Clock driver for FlexSPI on Layerscape SoCs"
>   	depends on ARCH_LAYERSCAPE || COMPILE_TEST
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 16e588630472..da8dd3ab304f 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
>   obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
>   obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
>   obj-$(CONFIG_ARCH_SPARX5)		+= clk-sparx5.o
> +obj-$(CONFIG_COMMON_CLK_EN7523)		+= clk-en7523.o
>   obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+= clk-fixed-mmio.o
>   obj-$(CONFIG_COMMON_CLK_FSL_FLEXSPI)	+= clk-fsl-flexspi.o
>   obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
> diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> new file mode 100644
> index 000000000000..076a70c2e173
> --- /dev/null
> +++ b/drivers/clk/clk-en7523.c
> @@ -0,0 +1,351 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/delay.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <dt-bindings/clock/en7523-clk.h>
> +
> +#define REG_PCI_CONTROL			0x88
> +#define   REG_PCI_CONTROL_PERSTOUT	BIT(29)
> +#define   REG_PCI_CONTROL_PERSTOUT1	BIT(26)
> +#define   REG_PCI_CONTROL_REFCLK_EN1	BIT(22)
> +#define REG_GSW_CLK_DIV_SEL		0x1b4
> +#define REG_EMI_CLK_DIV_SEL		0x1b8
> +#define REG_BUS_CLK_DIV_SEL		0x1bc
> +#define REG_SPI_CLK_DIV_SEL		0x1c4
> +#define REG_SPI_CLK_FREQ_SEL		0x1c8
> +#define REG_NPU_CLK_DIV_SEL		0x1fc
> +#define REG_CRYPTO_CLKSRC		0x200
> +#define REG_RESET_CONTROL		0x834
> +#define   REG_RESET_CONTROL_PCIEHB	BIT(29)
> +#define   REG_RESET_CONTROL_PCIE1	BIT(27)
> +#define   REG_RESET_CONTROL_PCIE2	BIT(26)
> +
> +struct en_clk_desc {
> +	int id;
> +	const char *name;
> +	u32 base_reg;
> +	u8 base_bits;
> +	u8 base_shift;
> +	union {
> +		const unsigned int *base_values;
> +		unsigned int base_value;
> +	};
> +	size_t n_base_values;
> +
> +	u16 div_reg;
> +	u8 div_bits;
> +	u8 div_shift;
> +	u16 div_val0;
> +	u8 div_step;
> +};
> +
> +struct en_clk_gate {
> +	void __iomem *base;
> +	struct clk_hw hw;
> +};
> +
> +static const u32 gsw_base[] = { 400000000, 500000000 };
> +static const u32 emi_base[] = { 333000000, 400000000 };
> +static const u32 bus_base[] = { 500000000, 540000000 };
> +static const u32 slic_base[] = { 100000000, 3125000 };
> +static const u32 npu_base[] = { 333000000, 400000000, 500000000 };
> +
> +static const struct en_clk_desc en7523_base_clks[] = {
> +	{
> +		.id = EN7523_CLK_GSW,
> +		.name = "gsw",
> +
> +		.base_reg = REG_GSW_CLK_DIV_SEL,
> +		.base_bits = 1,
> +		.base_shift = 8,
> +		.base_values = gsw_base,
> +		.n_base_values = ARRAY_SIZE(gsw_base),
> +
> +		.div_bits = 3,
> +		.div_shift = 0,
> +		.div_step = 1,
> +	}, {
> +		.id = EN7523_CLK_EMI,
> +		.name = "emi",
> +
> +		.base_reg = REG_EMI_CLK_DIV_SEL,
> +		.base_bits = 1,
> +		.base_shift = 8,
> +		.base_values = emi_base,
> +		.n_base_values = ARRAY_SIZE(emi_base),
> +
> +		.div_bits = 3,
> +		.div_shift = 0,
> +		.div_step = 1,
> +	}, {
> +		.id = EN7523_CLK_BUS,
> +		.name = "bus",
> +
> +		.base_reg = REG_BUS_CLK_DIV_SEL,
> +		.base_bits = 1,
> +		.base_shift = 8,
> +		.base_values = bus_base,
> +		.n_base_values = ARRAY_SIZE(bus_base),
> +
> +		.div_bits = 3,
> +		.div_shift = 0,
> +		.div_step = 1,
> +	}, {
> +		.id = EN7523_CLK_SLIC,
> +		.name = "slic",
> +
> +		.base_reg = REG_SPI_CLK_FREQ_SEL,
> +		.base_bits = 1,
> +		.base_shift = 0,
> +		.base_values = slic_base,
> +		.n_base_values = ARRAY_SIZE(slic_base),
> +
> +		.div_reg = REG_SPI_CLK_DIV_SEL,
> +		.div_bits = 5,
> +		.div_shift = 24,
> +		.div_val0 = 20,
> +		.div_step = 2,
> +	}, {
> +		.id = EN7523_CLK_SPI,
> +		.name = "spi",
> +
> +		.base_reg = REG_SPI_CLK_DIV_SEL,
> +
> +		.base_value = 400000000,
> +
> +		.div_bits = 5,
> +		.div_shift = 8,
> +		.div_val0 = 40,
> +		.div_step = 2,
> +	}, {
> +		.id = EN7523_CLK_NPU,
> +		.name = "npu",
> +
> +		.base_reg = REG_NPU_CLK_DIV_SEL,
> +		.base_bits = 2,
> +		.base_shift = 8,
> +		.base_values = npu_base,
> +		.n_base_values = ARRAY_SIZE(npu_base),
> +
> +		.div_bits = 3,
> +		.div_shift = 0,
> +		.div_step = 1,
> +	}, {
> +		.id = EN7523_CLK_CRYPTO,
> +		.name = "crypto",
> +
> +		.base_reg = REG_CRYPTO_CLKSRC,
> +		.base_bits = 1,
> +		.base_shift = 8,
> +		.base_values = emi_base,
> +		.n_base_values = ARRAY_SIZE(emi_base),
> +	}
> +};
> +
> +static const struct of_device_id of_match_clk_en7523[] = {
> +	{ .compatible = "airoha,en7523-scu", },
> +	{ /* sentinel */ }
> +};
> +
> +static unsigned int en7523_get_base_rate(void __iomem *base, unsigned int i)
> +{
> +	const struct en_clk_desc *desc = &en7523_base_clks[i];
> +	u32 val;
> +
> +	if (!desc->base_bits)
> +		return desc->base_value;
> +
> +	val = readl(base + desc->base_reg);
> +	val >>= desc->base_shift;
> +	val &= (1 << desc->base_bits) - 1;
> +
> +	if (val >= desc->n_base_values)
> +		return 0;
> +
> +	return desc->base_values[val];
> +}
> +
> +static u32 en7523_get_div(void __iomem *base, int i)
> +{
> +	const struct en_clk_desc *desc = &en7523_base_clks[i];
> +	u32 reg, val;
> +
> +	if (!desc->div_bits)
> +		return 1;
> +
> +	reg = desc->div_reg ? desc->div_reg : desc->base_reg;
> +	val = readl(base + reg);
> +	val >>= desc->div_shift;
> +	val &= (1 << desc->div_bits) - 1;
> +
> +	if (!val && desc->div_val0)
> +		return desc->div_val0;
> +
> +	return (val + 1) * desc->div_step;
> +}
> +
> +static int en7523_pci_is_enabled(struct clk_hw *hw)
> +{
> +	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
> +
> +	return !!(readl(cg->base + REG_PCI_CONTROL) & REG_PCI_CONTROL_REFCLK_EN1);
> +}
> +
> +static int en7523_pci_prepare(struct clk_hw *hw)
> +{
> +	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
> +	void __iomem *np_base = cg->base;
> +	u32 val, mask;
> +
> +	/* Need to pull device low before reset */
> +	val = readl(np_base + REG_PCI_CONTROL);
> +	val &= ~(REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT);
> +	writel(val, np_base + REG_PCI_CONTROL);
> +	usleep_range(1000, 2000);
> +
> +	/* Enable PCIe port 1 */
> +	val |= REG_PCI_CONTROL_REFCLK_EN1;
> +	writel(val, np_base + REG_PCI_CONTROL);
> +	usleep_range(1000, 2000);
> +
> +	/* Reset to default */
> +	val = readl(np_base + REG_RESET_CONTROL);
> +	mask = REG_RESET_CONTROL_PCIE1 | REG_RESET_CONTROL_PCIE2 |
> +	       REG_RESET_CONTROL_PCIEHB;
> +	writel(val & ~mask, np_base + REG_RESET_CONTROL);
> +	usleep_range(1000, 2000);
> +	writel(val | mask, np_base + REG_RESET_CONTROL);
> +	msleep(100);
> +	writel(val & ~mask, np_base + REG_RESET_CONTROL);
> +	usleep_range(5000, 10000);
> +
> +	/* Release device */
> +	mask = REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT;
> +	val = readl(np_base + REG_PCI_CONTROL);
> +	writel(val & ~mask, np_base + REG_PCI_CONTROL);
> +	usleep_range(1000, 2000);
> +	writel(val | mask, np_base + REG_PCI_CONTROL);
> +	msleep(250);
> +
> +	return 0;
> +}
> +
> +static void en7523_pci_unprepare(struct clk_hw *hw)
> +{
> +	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
> +	void __iomem *np_base = cg->base;
> +	u32 val;
> +
> +	val = readl(np_base + REG_PCI_CONTROL);
> +	val &= ~REG_PCI_CONTROL_REFCLK_EN1;
> +	writel(val, np_base + REG_PCI_CONTROL);
> +}
> +
> +static struct clk_hw *en7523_register_pcie_clk(struct device *dev,
> +					       void __iomem *np_base)
> +{
> +	static const struct clk_ops pcie_gate_ops = {
> +		.is_enabled = en7523_pci_is_enabled,
> +		.prepare = en7523_pci_prepare,
> +		.unprepare = en7523_pci_unprepare,
> +	};
> +	struct clk_init_data init = {
> +		.name = "pcie",
> +		.ops = &pcie_gate_ops,
> +	};
> +	struct en_clk_gate *cg;
> +
> +	cg = devm_kzalloc(dev, sizeof(*cg), GFP_KERNEL);
> +	if (!cg)
> +		return NULL;
> +
> +	cg->base = np_base;
> +	cg->hw.init = &init;
> +	en7523_pci_unprepare(&cg->hw);
> +
> +	if (clk_hw_register(dev, &cg->hw))
> +		return NULL;
> +
> +	return &cg->hw;
> +}
> +
> +static void en7523_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
> +				   void __iomem *base, void __iomem *np_base)
> +{
> +	struct clk_hw *hw;
> +	u32 rate;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(en7523_base_clks); i++) {
> +		const struct en_clk_desc *desc = &en7523_base_clks[i];
> +
> +		rate = en7523_get_base_rate(base, i);
> +		rate /= en7523_get_div(base, i);
> +
> +		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
> +		if (IS_ERR(hw)) {
> +			pr_err("Failed to register clk %s: %ld\n",
> +			       desc->name, PTR_ERR(hw));
> +			continue;
> +		}
> +
> +		clk_data->hws[desc->id] = hw;
> +	}
> +
> +	hw = en7523_register_pcie_clk(dev, np_base);
> +	clk_data->hws[EN7523_CLK_PCIE] = hw;
> +
> +	clk_data->num = EN7523_NUM_CLOCKS;
> +}
> +
> +static int en7523_clk_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_hw_onecell_data *clk_data;
> +	void __iomem *base, *np_base;
> +	int r;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	np_base = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(base))
> +		return PTR_ERR(np_base);
> +
> +	clk_data = devm_kzalloc(&pdev->dev,
> +				struct_size(clk_data, hws, EN7523_NUM_CLOCKS),
> +				GFP_KERNEL);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	en7523_register_clocks(&pdev->dev, clk_data, base, np_base);
> +
> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (r)
> +		dev_err(&pdev->dev,
> +			"could not register clock provider: %s: %d\n",
> +			pdev->name, r);
> +
> +	return r;
> +}
> +
> +static struct platform_driver clk_en7523_drv = {
> +	.probe = en7523_clk_probe,
> +	.driver = {
> +		.name = "clk-en7523",
> +		.of_match_table = of_match_clk_en7523,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +static int __init clk_en7523_init(void)
> +{
> +	return platform_driver_register(&clk_en7523_drv);
> +}
> +
> +arch_initcall(clk_en7523_init);
