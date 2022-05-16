Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A8252833C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240780AbiEPLaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiEPLaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:30:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D482CDE8E;
        Mon, 16 May 2022 04:30:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f2so13070233wrc.0;
        Mon, 16 May 2022 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UzxYG8EYrSidJbF+xds/+14ZSC+FApfqG0naR2N3Uwk=;
        b=G9hab1G8XmxCvbiyiukXetfEaEcli+Kfc2LK6EmBZjqzntvp7FCGApIl3WmtMG06pq
         qaXB4lNElDE5MDh8CrbJcD6M/FYav0BefzI+i//0BHmzDC/013wX6jhTiaBjXJ0gPhyI
         HctKjjjTT2eOXwFqEpcvpDfsrIoSJvfpK6PioFvKXmYxHwv2EQrrOnNnEdwevMlJCVDm
         GCAfEqarojBqQOzdK1KQ7qj1MrJTTqs+P0Yr0CjTEbhoDpSC3TQXjTSvj9xcDrBu/U0k
         WlnJEAdr0VL1khAa63mZ14L2d0eNrYi28AytzI0z4rbe1Jui5aalJxbOwdeZfg+zvma1
         zRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UzxYG8EYrSidJbF+xds/+14ZSC+FApfqG0naR2N3Uwk=;
        b=PYO1vxw+jSuZKTOQgp+Pv54Iv+zTS4XBODbUVkzrkQZxSzGkFIw+ncBh7MqOFjTMl1
         SqM66lb21uyB42xHL/SBpeDwMfyQl2ZzFADExpJX3N4S0Eb48R9aRF46XQCArAzPQvpH
         TzqdgctCtDSuGygljRz8SSKnwvevNUds/H4x3hqcz6k3TJrdcv59G18x3C1g4aIc4xSI
         TGAMf+JHlIGBz4iLuyn6TpflRrGRtgzBDguk1fLu2PP2gQLE50O1jPCU7CjnPZgm2hbJ
         0nhoTm7dqfhjz4VX//n7vmBuABbZegfSOxWmVbOLEN4JIkx45gzHK5xkAjs2yFrGsjjN
         bIcg==
X-Gm-Message-State: AOAM533HBcggkjttp6c4gY6x6PTgAhwxGH/o+z8GMrIyV7zHl1LvW0mK
        yFgRpEhglI5I8I0w7Fzqd7I=
X-Google-Smtp-Source: ABdhPJwgvMh7moE+Olm+uesaZXDLnhlY/+G0Gsc8kqYdwSzLBt9wy1Ly1e95caoZ7DZS4Dz70/1v9Q==
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id c18-20020adffb12000000b0020c79b2a200mr14099716wrr.617.1652700611995;
        Mon, 16 May 2022 04:30:11 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r3-20020adfbb03000000b0020d12936563sm111223wrg.108.2022.05.16.04.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 04:30:11 -0700 (PDT)
Message-ID: <8177c547-2a38-691b-0a32-bc7e6ba1e2ed@gmail.com>
Date:   Mon, 16 May 2022 13:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/5] clk: mediatek: Add MediaTek Helio X10 MT6795 clock
 drivers
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de, y.oudjana@protonmail.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com>
 <20220513165050.500831-6-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220513165050.500831-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/05/2022 18:50, AngeloGioacchino Del Regno wrote:
> Add the clock drivers for the entire clock tree of MediaTek Helio X10
> MT6795, including system clocks (apmixedsys, infracfg, pericfg, topckgen)
> and multimedia clocks (mmsys, mfg, vdecsys, vencsys).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thanks a lot for taking care of this!
I just wonder if we couldn't build most of the clock drivers as modules like 
done for the mt6779. It would help us to keep the kernel image smaller.

Regards,
Matthias

> ---
>   drivers/clk/mediatek/Kconfig                 |  37 ++
>   drivers/clk/mediatek/Makefile                |   6 +
>   drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 154 +++++
>   drivers/clk/mediatek/clk-mt6795-infracfg.c   | 145 +++++
>   drivers/clk/mediatek/clk-mt6795-mfg.c        |  47 ++
>   drivers/clk/mediatek/clk-mt6795-mm.c         | 103 ++++
>   drivers/clk/mediatek/clk-mt6795-pericfg.c    | 157 +++++
>   drivers/clk/mediatek/clk-mt6795-topckgen.c   | 607 +++++++++++++++++++
>   drivers/clk/mediatek/clk-mt6795-vdecsys.c    |  52 ++
>   drivers/clk/mediatek/clk-mt6795-vencsys.c    |  46 ++
>   10 files changed, 1354 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index d5936cfb3bee..9a96ef71ce0b 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -259,6 +259,43 @@ config COMMON_CLK_MT6779_AUDSYS
>   	help
>   	  This driver supports Mediatek MT6779 audsys clocks.
>   
> +config COMMON_CLK_MT6795
> +	bool "Clock driver for MediaTek MT6795"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select COMMON_CLK_MEDIATEK
> +	default ARCH_MEDIATEK
> +	help
> +	  This driver supports MediaTek MT6795 basic clocks and clocks
> +	  required for various peripherals found on MediaTek.
> +
> +config COMMON_CLK_MT6795_MFGCFG
> +	bool "Clock driver for MediaTek MT6795 mfgcfg"
> +	depends on COMMON_CLK_MT6795
> +	default COMMON_CLK_MT6795
> +	help
> +	  This driver supports MediaTek MT6795 mfgcfg clocks.
> +
> +config COMMON_CLK_MT6795_MMSYS
> +       bool "Clock driver for MediaTek MT6795 mmsys"
> +       depends on COMMON_CLK_MT6795
> +	default COMMON_CLK_MT6795
> +       help
> +         This driver supports MediaTek MT6795 mmsys clocks.
> +
> +config COMMON_CLK_MT6795_VDECSYS
> +	bool "Clock driver for MediaTek MT6795 VDECSYS"
> +	depends on COMMON_CLK_MT6795
> +	default COMMON_CLK_MT6795
> +	help
> +	  This driver supports MediaTek MT6795 vdecsys clocks.
> +
> +config COMMON_CLK_MT6795_VENCSYS
> +	bool "Clock driver for MediaTek MT6795 VENCSYS"
> +	depends on COMMON_CLK_MT6795
> +	default COMMON_CLK_MT6795
> +	help
> +	  This driver supports MediaTek MT6795 vencsys clocks.
> +
>   config COMMON_CLK_MT6797
>   	bool "Clock driver for MediaTek MT6797"
>   	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index caf2ce93d666..57f0bf90e934 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -17,6 +17,12 @@ obj-$(CONFIG_COMMON_CLK_MT6779_VDECSYS) += clk-mt6779-vdec.o
>   obj-$(CONFIG_COMMON_CLK_MT6779_VENCSYS) += clk-mt6779-venc.o
>   obj-$(CONFIG_COMMON_CLK_MT6779_MFGCFG) += clk-mt6779-mfg.o
>   obj-$(CONFIG_COMMON_CLK_MT6779_AUDSYS) += clk-mt6779-aud.o
> +obj-$(CONFIG_COMMON_CLK_MT6795) += clk-mt6795-apmixedsys.o clk-mt6795-infracfg.o \
> +				   clk-mt6795-pericfg.o clk-mt6795-topckgen.o
> +obj-$(CONFIG_COMMON_CLK_MT6795_MFGCFG) += clk-mt6795-mfg.o
> +obj-$(CONFIG_COMMON_CLK_MT6795_MMSYS) += clk-mt6795-mm.o
> +obj-$(CONFIG_COMMON_CLK_MT6795_VDECSYS) += clk-mt6795-vdecsys.o
> +obj-$(CONFIG_COMMON_CLK_MT6795_VENCSYS) += clk-mt6795-vencsys.o
>   obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
>   obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
>   obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
> diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> new file mode 100644
> index 000000000000..c0f818c46b88
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mt6795-clk.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
> +
> +#define REG_REF2USB		0x8
> +#define REG_AP_PLL_CON7		0x1c
> + #define MD1_MTCMOS_OFF		BIT(0)
> + #define MD1_MEM_OFF		BIT(1)
> + #define MD1_CLK_OFF		BIT(4)
> + #define MD1_ISO_OFF		BIT(8)
> +
> +#define MT6795_PLL_FMAX		(3000UL * MHZ)
> +#define MT6795_CON0_EN		BIT(0)
> +#define MT6795_CON0_RST_BAR	BIT(24)
> +
> +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
> +	    _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift) {	\
> +		.id = _id,						\
> +		.name = _name,						\
> +		.reg = _reg,						\
> +		.pwr_reg = _pwr_reg,					\
> +		.en_mask = MT6795_CON0_EN | _en_mask,			\
> +		.flags = _flags,					\
> +		.rst_bar_mask = MT6795_CON0_RST_BAR,			\
> +		.fmax = MT6795_PLL_FMAX,				\
> +		.pcwbits = _pcwbits,					\
> +		.pd_reg = _pd_reg,					\
> +		.pd_shift = _pd_shift,					\
> +		.tuner_reg = _tuner_reg,				\
> +		.pcw_reg = _pcw_reg,					\
> +		.pcw_shift = _pcw_shift,				\
> +		.div_table = NULL,					\
> +		.pll_en_bit = 0,					\
> +	}
> +
> +static const struct mtk_pll_data plls[] = {
> +	PLL(CLK_APMIXED_ARMCA53PLL, "armca53pll", 0x200, 0x20c, 0, PLL_AO,
> +	    21, 0x204, 24, 0x0, 0x204, 0),
> +	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000101, HAVE_RST_BAR,
> +	    21, 0x220, 4, 0x0, 0x224, 0),
> +	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000101, HAVE_RST_BAR,
> +	    7, 0x230, 4, 0x0, 0x234, 14),
> +	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0, 0, 21, 0x244, 24, 0x0, 0x244, 0),
> +	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x250, 0x25c, 0, 0, 21, 0x250, 4, 0x0, 0x254, 0),
> +	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x260, 0x26c, 0, 0, 21, 0x260, 4, 0x0, 0x264, 0),
> +	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x270, 0x27c, 0, 0, 21, 0x270, 4, 0x0, 0x274, 0),
> +	PLL(CLK_APMIXED_MPLL, "mpll", 0x280, 0x28c, 0, 0, 21, 0x280, 4, 0x0, 0x284, 0),
> +	PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x290, 0x29c, 0, 0, 21, 0x290, 4, 0x0, 0x294, 0),
> +	PLL(CLK_APMIXED_APLL1, "apll1", 0x2a0, 0x2b0, 0, 0, 31, 0x2a0, 4, 0x2a8, 0x2a4, 0),
> +	PLL(CLK_APMIXED_APLL2, "apll2", 0x2b4, 0x2c4, 0, 0, 31, 0x2b4, 4, 0x2bc, 0x2b8, 0),
> +};
> +
> +static void clk_mt6795_apmixed_setup_md1(void __iomem *base)
> +{
> +	void __iomem *reg = base + REG_AP_PLL_CON7;
> +
> +	/* Turn on MD1 internal clock */
> +	writel(readl(reg) & ~MD1_CLK_OFF, reg);
> +
> +	/* Unlock MD1's MTCMOS power path */
> +	writel(readl(reg) & ~MD1_MTCMOS_OFF, reg);
> +
> +	/* Turn on ISO */
> +	writel(readl(reg) & ~MD1_ISO_OFF, reg);
> +
> +	/* Turn on memory */
> +	writel(readl(reg) & ~MD1_MEM_OFF, reg);
> +}
> +
> +static const struct of_device_id of_match_clk_mt6795_apmixed[] = {
> +	{ .compatible = "mediatek,mt6795-apmixedsys" },
> +	{ /* sentinel */ }
> +};
> +
> +static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	void __iomem *base;
> +	struct clk_hw *hw;
> +	int ret;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> +	if (ret)
> +		goto free_clk_data;
> +
> +	hw = mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base + REG_REF2USB);
> +	if (IS_ERR(hw)) {
> +		ret = PTR_ERR(hw);
> +		dev_err(dev, "Failed to register ref2usb_tx: %d\n", ret);
> +		goto unregister_plls;
> +	}
> +	clk_data->hws[CLK_APMIXED_REF2USB_TX] = hw;
> +
> +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (ret) {
> +		dev_err(dev, "Cannot register clock provider: %d\n", ret);
> +		goto unregister_ref2usb;
> +	}
> +
> +	/* Setup MD1 to avoid random crashes */
> +	dev_dbg(dev, "Performing initial setup for MD1\n");
> +	clk_mt6795_apmixed_setup_md1(base);
> +
> +	return 0;
> +
> +unregister_ref2usb:
> +	clk_hw_unregister(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
> +unregister_plls:
> +	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
> +free_clk_data:
> +	mtk_free_clk_data(clk_data);
> +	return ret;
> +}
> +
> +static int clk_mt6795_apmixed_remove(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	clk_hw_unregister(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
> +	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver clk_mt6795_apmixed_drv = {
> +	.probe = clk_mt6795_apmixed_probe,
> +	.remove = clk_mt6795_apmixed_remove,
> +	.driver = {
> +		.name = "clk-mt6795-apmixed",
> +		.of_match_table = of_match_clk_mt6795_apmixed,
> +	},
> +};
> +builtin_platform_driver(clk_mt6795_apmixed_drv);
> diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
> new file mode 100644
> index 000000000000..17f033209b18
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mt6795-clk.h>
> +#include <dt-bindings/reset/mt6795-resets.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk-cpumux.h"
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "reset.h"
> +
> +#define GATE_ICG(_id, _name, _parent, _shift)			\
> +		GATE_MTK(_id, _name, _parent, &infra_cg_regs,	\
> +			 _shift, &mtk_clk_gate_ops_no_setclr)
> +
> +static const struct mtk_gate_regs infra_cg_regs = {
> +	.set_ofs = 0x0040,
> +	.clr_ofs = 0x0044,
> +	.sta_ofs = 0x0048,
> +};
> +
> +static const char * const ca53_c0_parents[] = {
> +	"clk26m",
> +	"armca53pll",
> +	"mainpll",
> +	"univpll"
> +};
> +
> +static const char * const ca53_c1_parents[] = {
> +	"clk26m",
> +	"armca53pll",
> +	"mainpll",
> +	"univpll"
> +};
> +
> +static const struct mtk_composite cpu_muxes[] = {
> +	MUX(CLK_INFRA_CA53_C0_SEL, "infra_ca53_c0_sel", ca53_c0_parents, 0x00, 0, 2),
> +	MUX(CLK_INFRA_CA53_C1_SEL, "infra_ca53_c1_sel", ca53_c1_parents, 0x00, 2, 2),
> +};
> +
> +static const struct mtk_gate infra_gates[] = {
> +	GATE_ICG(CLK_INFRA_DBGCLK, "infra_dbgclk", "axi_sel", 0),
> +	GATE_ICG(CLK_INFRA_SMI, "infra_smi", "mm_sel", 1),
> +	GATE_ICG(CLK_INFRA_AUDIO, "infra_audio", "aud_intbus_sel", 5),
> +	GATE_ICG(CLK_INFRA_GCE, "infra_gce", "axi_sel", 6),
> +	GATE_ICG(CLK_INFRA_L2C_SRAM, "infra_l2c_sram", "axi_sel", 7),
> +	GATE_ICG(CLK_INFRA_M4U, "infra_m4u", "mem_sel", 8),
> +	GATE_ICG(CLK_INFRA_MD1MCU, "infra_md1mcu", "clk26m", 9),
> +	GATE_ICG(CLK_INFRA_MD1BUS, "infra_md1bus", "axi_sel", 10),
> +	GATE_ICG(CLK_INFRA_MD1DBB, "infra_dbb", "axi_sel", 11),
> +	GATE_ICG(CLK_INFRA_DEVICE_APC, "infra_devapc", "clk26m", 12),
> +	GATE_ICG(CLK_INFRA_TRNG, "infra_trng", "axi_sel", 13),
> +	GATE_ICG(CLK_INFRA_MD1LTE, "infra_md1lte", "axi_sel", 14),
> +	GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "cpum_ck", 15),
> +	GATE_ICG(CLK_INFRA_KP, "infra_kp", "axi_sel", 16),
> +};
> +
> +static u16 infra_ao_rst_ofs[] = { 0x30 };
> +
> +static u16 infra_ao_idx_map[] = {
> +	[MT6795_INFRA_SCPSYS_RST]    = 5,
> +	[MT6795_INFRA_PMIC_WRAP_RST] = 7,
> +};
> +
> +static const struct mtk_clk_rst_desc clk_rst_desc = {
> +	.version = MTK_RST_SET_CLR,
> +	.rst_bank_ofs = infra_ao_rst_ofs,
> +	.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
> +	.rst_idx_map = infra_ao_idx_map,
> +	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
> +};
> +
> +static const struct of_device_id of_match_clk_mt6795_infracfg[] = {
> +	{ .compatible = "mediatek,mt6795-infracfg" },
> +	{ /* sentinel */ }
> +};
> +
> +static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	void __iomem *base;
> +	int ret;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	ret = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
> +	if (ret)
> +		goto free_clk_data;
> +
> +	ret = mtk_clk_register_gates(node, infra_gates, ARRAY_SIZE(infra_gates), clk_data);
> +	if (ret)
> +		goto free_clk_data;
> +
> +	ret = mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
> +	if (ret)
> +		goto unregister_gates;
> +
> +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (ret)
> +		goto unregister_cpumuxes;
> +
> +	return 0;
> +
> +unregister_cpumuxes:
> +	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
> +unregister_gates:
> +	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), clk_data);
> +free_clk_data:
> +	mtk_free_clk_data(clk_data);
> +	return ret;
> +}
> +
> +static int clk_mt6795_infracfg_remove(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
> +	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver clk_mt6795_infracfg_drv = {
> +	.probe = clk_mt6795_infracfg_probe,
> +	.remove = clk_mt6795_infracfg_remove,
> +	.driver = {
> +		.name = "clk-mt6795-infracfg",
> +		.of_match_table = of_match_clk_mt6795_infracfg,
> +	},
> +};
> +builtin_platform_driver(clk_mt6795_infracfg_drv);
> diff --git a/drivers/clk/mediatek/clk-mt6795-mfg.c b/drivers/clk/mediatek/clk-mt6795-mfg.c
> new file mode 100644
> index 000000000000..8629d4d0154f
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6795-mfg.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mt6795-clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +static const struct mtk_gate_regs mfg_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x8,
> +	.sta_ofs = 0x0,
> +};
> +
> +#define GATE_MFG(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +static const struct mtk_gate mfg_clks[] = {
> +	GATE_MFG(CLK_MFG_BAXI, "mfg_baxi", "axi_mfg_in_sel", 0),
> +	GATE_MFG(CLK_MFG_BMEM, "mfg_bmem", "mem_mfg_in_sel", 1),
> +	GATE_MFG(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel", 2),
> +	GATE_MFG(CLK_MFG_B26M, "mfg_b26m", "clk26m", 3),
> +};
> +
> +static const struct mtk_clk_desc mfg_desc = {
> +	.clks = mfg_clks,
> +	.num_clks = ARRAY_SIZE(mfg_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt6795_mfg[] = {
> +	{ .compatible = "mediatek,mt6795-mfgcfg", .data = &mfg_desc },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt6795_mfg_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
> +	.driver = {
> +		.name = "clk-mt6795-mfg",
> +		.of_match_table = of_match_clk_mt6795_mfg,
> +	},
> +};
> +builtin_platform_driver(clk_mt6795_mfg_drv);
> diff --git a/drivers/clk/mediatek/clk-mt6795-mm.c b/drivers/clk/mediatek/clk-mt6795-mm.c
> new file mode 100644
> index 000000000000..dd6e66e94a4a
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6795-mm.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mt6795-clk.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +#define GATE_MM0(_id, _name, _parent, _shift)	\
> +	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +#define GATE_MM1(_id, _name, _parent, _shift)	\
> +	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
> +
> +static const struct mtk_gate_regs mm0_cg_regs = {
> +	.set_ofs = 0x0104,
> +	.clr_ofs = 0x0108,
> +	.sta_ofs = 0x0100,
> +};
> +
> +static const struct mtk_gate_regs mm1_cg_regs = {
> +	.set_ofs = 0x0114,
> +	.clr_ofs = 0x0118,
> +	.sta_ofs = 0x0110,
> +};
> +
> +static const struct mtk_gate mm_gates[] = {
> +	/* MM0 */
> +	GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 0),
> +	GATE_MM0(CLK_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 1),
> +	GATE_MM0(CLK_MM_CAM_MDP, "mm_cam_mdp", "mm_sel", 2),
> +	GATE_MM0(CLK_MM_MDP_RDMA0, "mm_mdp_rdma0", "mm_sel", 3),
> +	GATE_MM0(CLK_MM_MDP_RDMA1, "mm_mdp_rdma1", "mm_sel", 4),
> +	GATE_MM0(CLK_MM_MDP_RSZ0, "mm_mdp_rsz0", "mm_sel", 5),
> +	GATE_MM0(CLK_MM_MDP_RSZ1, "mm_mdp_rsz1", "mm_sel", 6),
> +	GATE_MM0(CLK_MM_MDP_RSZ2, "mm_mdp_rsz2", "mm_sel", 7),
> +	GATE_MM0(CLK_MM_MDP_TDSHP0, "mm_mdp_tdshp0", "mm_sel", 8),
> +	GATE_MM0(CLK_MM_MDP_TDSHP1, "mm_mdp_tdshp1", "mm_sel", 9),
> +	GATE_MM0(CLK_MM_MDP_CROP, "mm_mdp_crop", "mm_sel", 10),
> +	GATE_MM0(CLK_MM_MDP_WDMA, "mm_mdp_wdma", "mm_sel", 11),
> +	GATE_MM0(CLK_MM_MDP_WROT0, "mm_mdp_wrot0", "mm_sel", 12),
> +	GATE_MM0(CLK_MM_MDP_WROT1, "mm_mdp_wrot1", "mm_sel", 13),
> +	GATE_MM0(CLK_MM_FAKE_ENG, "mm_fake_eng", "mm_sel", 14),
> +	GATE_MM0(CLK_MM_MUTEX_32K, "mm_mutex_32k", "clk32k", 15),
> +	GATE_MM0(CLK_MM_DISP_OVL0, "mm_disp_ovl0", "mm_sel", 16),
> +	GATE_MM0(CLK_MM_DISP_OVL1, "mm_disp_ovl1", "mm_sel", 17),
> +	GATE_MM0(CLK_MM_DISP_RDMA0, "mm_disp_rdma0", "mm_sel", 18),
> +	GATE_MM0(CLK_MM_DISP_RDMA1, "mm_disp_rdma1", "mm_sel", 19),
> +	GATE_MM0(CLK_MM_DISP_RDMA2, "mm_disp_rdma2", "mm_sel", 20),
> +	GATE_MM0(CLK_MM_DISP_WDMA0, "mm_disp_wdma0", "mm_sel", 21),
> +	GATE_MM0(CLK_MM_DISP_WDMA1, "mm_disp_wdma1", "mm_sel", 22),
> +	GATE_MM0(CLK_MM_DISP_COLOR0, "mm_disp_color0", "mm_sel", 23),
> +	GATE_MM0(CLK_MM_DISP_COLOR1, "mm_disp_color1", "mm_sel", 24),
> +	GATE_MM0(CLK_MM_DISP_AAL, "mm_disp_aal", "mm_sel", 25),
> +	GATE_MM0(CLK_MM_DISP_GAMMA, "mm_disp_gamma", "mm_sel", 26),
> +	GATE_MM0(CLK_MM_DISP_UFOE, "mm_disp_ufoe", "mm_sel", 27),
> +	GATE_MM0(CLK_MM_DISP_SPLIT0, "mm_disp_split0", "mm_sel", 28),
> +	GATE_MM0(CLK_MM_DISP_SPLIT1, "mm_disp_split1", "mm_sel", 29),
> +	GATE_MM0(CLK_MM_DISP_MERGE, "mm_disp_merge", "mm_sel", 30),
> +	GATE_MM0(CLK_MM_DISP_OD, "mm_disp_od", "mm_sel", 31),
> +
> +	/* MM1 */
> +	GATE_MM1(CLK_MM_DISP_PWM0MM, "mm_disp_pwm0mm", "mm_sel", 0),
> +	GATE_MM1(CLK_MM_DISP_PWM026M, "mm_disp_pwm026m", "pwm_sel", 1),
> +	GATE_MM1(CLK_MM_DISP_PWM1MM, "mm_disp_pwm1mm", "mm_sel", 2),
> +	GATE_MM1(CLK_MM_DISP_PWM126M, "mm_disp_pwm126m", "pwm_sel", 3),
> +	GATE_MM1(CLK_MM_DSI0_ENGINE, "mm_dsi0_engine", "mm_sel", 4),
> +	GATE_MM1(CLK_MM_DSI0_DIGITAL, "mm_dsi0_digital", "dsi0_dig", 5),
> +	GATE_MM1(CLK_MM_DSI1_ENGINE, "mm_dsi1_engine", "mm_sel", 6),
> +	GATE_MM1(CLK_MM_DSI1_DIGITAL, "mm_dsi1_digital", "dsi1_dig", 7),
> +	GATE_MM1(CLK_MM_DPI_PIXEL, "mm_dpi_pixel", "dpi0_sel", 8),
> +	GATE_MM1(CLK_MM_DPI_ENGINE, "mm_dpi_engine", "mm_sel", 9),
> +};
> +
> +static int clk_mt6795_mm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->parent->of_node;
> +	struct clk_hw_onecell_data *clk_data;
> +	int ret;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	ret = mtk_clk_register_gates(node, mm_gates, ARRAY_SIZE(mm_gates), clk_data);
> +	if (ret)
> +		return ret;
> +
> +	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +}
> +
> +static struct platform_driver clk_mt6795_mm_drv = {
> +	.driver = {
> +		.name = "clk-mt6795-mm",
> +	},
> +	.probe = clk_mt6795_mm_probe,
> +};
> +builtin_platform_driver(clk_mt6795_mm_drv);
> diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
> new file mode 100644
> index 000000000000..499cca11b3d7
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mt6795-clk.h>
> +#include <dt-bindings/reset/mt6795-resets.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "reset.h"
> +
> +#define GATE_PERI(_id, _name, _parent, _shift)			\
> +		GATE_MTK(_id, _name, _parent, &peri_cg_regs,	\
> +			 _shift, &mtk_clk_gate_ops_setclr)
> +
> +static DEFINE_SPINLOCK(mt6795_peri_clk_lock);
> +
> +static const struct mtk_gate_regs peri_cg_regs = {
> +	.set_ofs = 0x0008,
> +	.clr_ofs = 0x0010,
> +	.sta_ofs = 0x0018,
> +};
> +
> +static const char * const uart_ck_sel_parents[] = {
> +	"clk26m",
> +	"uart_sel",
> +};
> +
> +static const struct mtk_composite peri_clks[] = {
> +	MUX(CLK_PERI_UART0_SEL, "uart0_ck_sel", uart_ck_sel_parents, 0x40c, 0, 1),
> +	MUX(CLK_PERI_UART1_SEL, "uart1_ck_sel", uart_ck_sel_parents, 0x40c, 1, 1),
> +	MUX(CLK_PERI_UART2_SEL, "uart2_ck_sel", uart_ck_sel_parents, 0x40c, 2, 1),
> +	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
> +};
> +
> +static const struct mtk_gate peri_gates[] = {
> +	GATE_PERI(CLK_PERI_NFI, "peri_nfi", "axi_sel", 0),
> +	GATE_PERI(CLK_PERI_THERM, "peri_therm", "axi_sel", 1),
> +	GATE_PERI(CLK_PERI_PWM1, "peri_pwm1", "axi_sel", 2),
> +	GATE_PERI(CLK_PERI_PWM2, "peri_pwm2", "axi_sel", 3),
> +	GATE_PERI(CLK_PERI_PWM3, "peri_pwm3", "axi_sel", 4),
> +	GATE_PERI(CLK_PERI_PWM4, "peri_pwm4", "axi_sel", 5),
> +	GATE_PERI(CLK_PERI_PWM5, "peri_pwm5", "axi_sel", 6),
> +	GATE_PERI(CLK_PERI_PWM6, "peri_pwm6", "axi_sel", 7),
> +	GATE_PERI(CLK_PERI_PWM7, "peri_pwm7", "axi_sel", 8),
> +	GATE_PERI(CLK_PERI_PWM, "peri_pwm", "axi_sel", 9),
> +	GATE_PERI(CLK_PERI_USB0, "peri_usb0", "usb30_sel", 10),
> +	GATE_PERI(CLK_PERI_USB1, "peri_usb1", "usb20_sel", 11),
> +	GATE_PERI(CLK_PERI_AP_DMA, "peri_ap_dma", "axi_sel", 12),
> +	GATE_PERI(CLK_PERI_MSDC30_0, "peri_msdc30_0", "msdc50_0_sel", 13),
> +	GATE_PERI(CLK_PERI_MSDC30_1, "peri_msdc30_1", "msdc30_1_sel", 14),
> +	GATE_PERI(CLK_PERI_MSDC30_2, "peri_msdc30_2", "msdc30_2_sel", 15),
> +	GATE_PERI(CLK_PERI_MSDC30_3, "peri_msdc30_3", "msdc30_3_sel", 16),
> +	GATE_PERI(CLK_PERI_NLI_ARB, "peri_nli_arb", "axi_sel", 17),
> +	GATE_PERI(CLK_PERI_IRDA, "peri_irda", "irda_sel", 18),
> +	GATE_PERI(CLK_PERI_UART0, "peri_uart0", "axi_sel", 19),
> +	GATE_PERI(CLK_PERI_UART1, "peri_uart1", "axi_sel", 20),
> +	GATE_PERI(CLK_PERI_UART2, "peri_uart2", "axi_sel", 21),
> +	GATE_PERI(CLK_PERI_UART3, "peri_uart3", "axi_sel", 22),
> +	GATE_PERI(CLK_PERI_I2C0, "peri_i2c0", "axi_sel", 23),
> +	GATE_PERI(CLK_PERI_I2C1, "peri_i2c1", "axi_sel", 24),
> +	GATE_PERI(CLK_PERI_I2C2, "peri_i2c2", "axi_sel", 25),
> +	GATE_PERI(CLK_PERI_I2C3, "peri_i2c3", "axi_sel", 26),
> +	GATE_PERI(CLK_PERI_I2C4, "peri_i2c4", "axi_sel", 27),
> +	GATE_PERI(CLK_PERI_AUXADC, "peri_auxadc", "clk26m", 28),
> +	GATE_PERI(CLK_PERI_SPI0, "peri_spi0", "spi_sel", 29),
> +};
> +
> +static u16 peri_rst_ofs[] = { 0x0 };
> +
> +static u16 peri_idx_map[] = {
> +	[MT6795_PERI_NFI_SW_RST]   = 14,
> +	[MT6795_PERI_THERM_SW_RST] = 16,
> +	[MT6795_PERI_MSDC1_SW_RST] = 20,
> +};
> +
> +static const struct mtk_clk_rst_desc clk_rst_desc = {
> +	.version = MTK_RST_SIMPLE,
> +	.rst_bank_ofs = peri_rst_ofs,
> +	.rst_bank_nr = ARRAY_SIZE(peri_rst_ofs),
> +	.rst_idx_map = peri_idx_map,
> +	.rst_idx_map_nr = ARRAY_SIZE(peri_idx_map),
> +};
> +
> +static const struct of_device_id of_match_clk_mt6795_pericfg[] = {
> +	{ .compatible = "mediatek,mt6795-pericfg" },
> +	{ /* sentinel */ }
> +};
> +
> +static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	void __iomem *base;
> +	int ret;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	ret = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
> +	if (ret)
> +		goto free_clk_data;
> +
> +	ret = mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates), clk_data);
> +	if (ret)
> +		goto free_clk_data;
> +
> +	ret = mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
> +					  &mt6795_peri_clk_lock, clk_data);
> +	if (ret)
> +		goto unregister_gates;
> +
> +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (ret)
> +		goto unregister_composites;
> +
> +	return 0;
> +
> +unregister_composites:
> +	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
> +unregister_gates:
> +	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
> +free_clk_data:
> +	mtk_free_clk_data(clk_data);
> +	return ret;
> +}
> +
> +static int clk_mt6795_pericfg_remove(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
> +	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver clk_mt6795_pericfg_drv = {
> +	.probe = clk_mt6795_pericfg_probe,
> +	.remove = clk_mt6795_pericfg_remove,
> +	.driver = {
> +		.name = "clk-mt6795-pericfg",
> +		.of_match_table = of_match_clk_mt6795_pericfg,
> +	},
> +};
> +builtin_platform_driver(clk_mt6795_pericfg_drv);
> diff --git a/drivers/clk/mediatek/clk-mt6795-topckgen.c b/drivers/clk/mediatek/clk-mt6795-topckgen.c
> new file mode 100644
> index 000000000000..7298934b6f0b
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6795-topckgen.c
> @@ -0,0 +1,607 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mt6795-clk.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-mux.h"
> +
> +/*
> + * For some clocks, we don't care what their actual rates are. And these
> + * clocks may change their rate on different products or different scenarios.
> + * So we model these clocks' rate as 0, to denote it's not an actual rate.
> + */
> +#define DUMMY_RATE	0
> +
> +#define TOP_MUX_GATE_NOSR(_id, _name, _parents, _reg, _shift, _width, _gate, _flags) \
> +		MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _reg,		\
> +			(_reg + 0x4), (_reg + 0x8), _shift, _width,		\
> +			_gate, 0, -1, _flags)
> +
> +#define TOP_MUX_GATE(_id, _name, _parents, _reg, _shift, _width, _gate, _flags)	\
> +		TOP_MUX_GATE_NOSR(_id, _name, _parents, _reg, _shift, _width,	\
> +				  _gate, CLK_SET_RATE_PARENT | _flags)
> +
> +static DEFINE_SPINLOCK(mt6795_top_clk_lock);
> +
> +static const char * const aud_1_parents[] = {
> +	"clk26m",
> +	"apll1_ck",
> +	"univpll2_d4",
> +	"univpll2_d8"
> +};
> +
> +static const char * const aud_2_parents[] = {
> +	"clk26m",
> +	"apll2_ck",
> +	"univpll2_d4",
> +	"univpll2_d8"
> +};
> +
> +static const char * const aud_intbus_parents[] = {
> +	"clk26m",
> +	"syspll1_d4",
> +	"syspll4_d2",
> +	"univpll3_d2",
> +	"univpll2_d8",
> +	"dmpll_d4",
> +	"dmpll_d8"
> +};
> +
> +static const char * const audio_parents[] = {
> +	"clk26m",
> +	"syspll3_d4",
> +	"syspll4_d4",
> +	"syspll1_d16"
> +};
> +
> +static const char * const axi_mfg_in_parents[] = {
> +	"clk26m",
> +	"axi_sel",
> +	"dmpll_d2"
> +};
> +
> +static const char * const axi_parents[] = {
> +	"clk26m",
> +	"syspll1_d2",
> +	"syspll_d5",
> +	"syspll1_d4",
> +	"univpll_d5",
> +	"univpll2_d2",
> +	"dmpll_d2",
> +	"dmpll_d4"
> +};
> +
> +static const char * const camtg_parents[] = {
> +	"clk26m",
> +	"univpll_d26",
> +	"univpll2_d2",
> +	"syspll3_d2",
> +	"syspll3_d4",
> +	"univpll1_d4",
> +	"dmpll_d8"
> +};
> +
> +static const char * const cci400_parents[] = {
> +	"clk26m",
> +	"vencpll_ck",
> +	"clk26m",
> +	"clk26m",
> +	"univpll_d2",
> +	"syspll_d2",
> +	"msdcpll_ck",
> +	"dmpll_ck"
> +};
> +
> +static const char * const ddrphycfg_parents[] = {
> +	"clk26m",
> +	"syspll1_d8"
> +};
> +
> +static const char * const dpi0_parents[] = {
> +	"clk26m",
> +	"tvdpll_d2",
> +	"tvdpll_d4",
> +	"clk26m",
> +	"clk26m",
> +	"tvdpll_d8",
> +	"tvdpll_d16"
> +};
> +
> +static const char * const i2s0_m_ck_parents[] = {
> +	"apll1_div1",
> +	"apll2_div1"
> +};
> +
> +static const char * const i2s1_m_ck_parents[] = {
> +	"apll1_div2",
> +	"apll2_div2"
> +};
> +
> +static const char * const i2s2_m_ck_parents[] = {
> +	"apll1_div3",
> +	"apll2_div3"
> +};
> +
> +static const char * const i2s3_m_ck_parents[] = {
> +	"apll1_div4",
> +	"apll2_div4"
> +};
> +
> +static const char * const i2s3_b_ck_parents[] = {
> +	"apll1_div5",
> +	"apll2_div5"
> +};
> +
> +static const char * const irda_parents[] = {
> +	"clk26m",
> +	"univpll2_d4",
> +	"syspll2_d4",
> +	"dmpll_d8",
> +};
> +
> +static const char * const mem_mfg_in_parents[] = {
> +	"clk26m",
> +	"mmpll_ck",
> +	"dmpll_ck"
> +};
> +
> +static const char * const mem_parents[] = {
> +	"clk26m",
> +	"dmpll_ck"
> +};
> +
> +static const char * const mfg_parents[] = {
> +	"clk26m",
> +	"mmpll_ck",
> +	"dmpll_ck",
> +	"clk26m",
> +	"clk26m",
> +	"clk26m",
> +	"clk26m",
> +	"clk26m",
> +	"clk26m",
> +	"syspll_d3",
> +	"syspll1_d2",
> +	"syspll_d5",
> +	"univpll_d3",
> +	"univpll1_d2",
> +	"univpll_d5",
> +	"univpll2_d2"
> +};
> +
> +static const char * const mm_parents[] = {
> +	"clk26m",
> +	"vencpll_d2",
> +	"syspll_d3",
> +	"syspll1_d2",
> +	"syspll_d5",
> +	"syspll1_d4",
> +	"univpll1_d2",
> +	"univpll2_d2",
> +	"dmpll_d2"
> +};
> +
> +static const char * const mjc_parents[] = {
> +	"clk26m",
> +	"univpll_d3",
> +	"vcodecpll_ck",
> +	"tvdpll_445p5m",
> +	"vencpll_d2",
> +	"syspll_d3",
> +	"univpll1_d2",
> +	"syspll_d5",
> +	"syspll1_d2",
> +	"univpll_d5",
> +	"univpll2_d2",
> +	"dmpll_ck"
> +};
> +
> +static const char * const msdc50_0_h_parents[] = {
> +	"clk26m",
> +	"syspll1_d2",
> +	"syspll2_d2",
> +	"syspll4_d2",
> +	"univpll_d5",
> +	"univpll1_d4"
> +};
> +
> +static const char * const msdc50_0_parents[] = {
> +	"clk26m",
> +	"msdcpll_ck",
> +	"msdcpll_d2",
> +	"univpll1_d4",
> +	"syspll2_d2",
> +	"syspll_d7",
> +	"msdcpll_d4",
> +	"vencpll_d4",
> +	"tvdpll_ck",
> +	"univpll_d2",
> +	"univpll1_d2",
> +	"mmpll_ck"
> +};
> +
> +static const char * const msdc30_1_parents[] = {
> +	"clk26m",
> +	"univpll2_d2",
> +	"msdcpll_d4",
> +	"univpll1_d4",
> +	"syspll2_d2",
> +	"syspll_d7",
> +	"univpll_d7",
> +	"vencpll_d4"
> +};
> +
> +static const char * const msdc30_2_parents[] = {
> +	"clk26m",
> +	"univpll2_d2",
> +	"msdcpll_d4",
> +	"univpll1_d4",
> +	"syspll2_d2",
> +	"syspll_d7",
> +	"univpll_d7",
> +	"vencpll_d2"
> +};
> +
> +static const char * const msdc30_3_parents[] = {
> +	"clk26m",
> +	"univpll2_d2",
> +	"msdcpll_d4",
> +	"univpll1_d4",
> +	"syspll2_d2",
> +	"syspll_d7",
> +	"univpll_d7",
> +	"vencpll_d4"
> +};
> +
> +static const char * const pmicspi_parents[] = {
> +	"clk26m",
> +	"syspll1_d8",
> +	"syspll3_d4",
> +	"syspll1_d16",
> +	"univpll3_d4",
> +	"univpll_d26",
> +	"dmpll_d8",
> +	"dmpll_d16"
> +};
> +
> +static const char * const pwm_parents[] = {
> +	"clk26m",
> +	"univpll2_d4",
> +	"univpll3_d2",
> +	"univpll1_d4"
> +};
> +
> +static const char * const scam_parents[] = {
> +	"clk26m",
> +	"syspll3_d2",
> +	"univpll2_d4",
> +	"dmpll_d4"
> +};
> +
> +static const char * const scp_parents[] = {
> +	"clk26m",
> +	"syspll1_d2",
> +	"univpll_d5",
> +	"syspll_d5",
> +	"dmpll_d2",
> +	"dmpll_d4"
> +};
> +
> +static const char * const spi_parents[] = {
> +	"clk26m",
> +	"syspll3_d2",
> +	"syspll1_d4",
> +	"syspll4_d2",
> +	"univpll3_d2",
> +	"univpll2_d4",
> +	"univpll1_d8"
> +};
> +
> +static const char * const uart_parents[] = {
> +	"clk26m",
> +	"univpll2_d8"
> +};
> +
> +static const char * const usb20_parents[] = {
> +	"clk26m",
> +	"univpll1_d8",
> +	"univpll3_d4"
> +};
> +
> +static const char * const usb30_parents[] = {
> +	"clk26m",
> +	"univpll3_d2",
> +	"usb_syspll_125m",
> +	"univpll2_d4"
> +};
> +
> +static const char * const vdec_parents[] = {
> +	"clk26m",
> +	"vcodecpll_ck",
> +	"tvdpll_445p5m",
> +	"univpll_d3",
> +	"vencpll_d2",
> +	"syspll_d3",
> +	"univpll1_d2",
> +	"mmpll_d2",
> +	"dmpll_d2",
> +	"dmpll_d4"
> +};
> +
> +static const char * const venc_parents[] = {
> +	"clk26m",
> +	"vcodecpll_ck",
> +	"tvdpll_445p5m",
> +	"univpll_d3",
> +	"vencpll_d2",
> +	"syspll_d3",
> +	"univpll1_d2",
> +	"univpll2_d2",
> +	"dmpll_d2",
> +	"dmpll_d4"
> +};
> +
> +static const struct mtk_fixed_clk fixed_clks[] = {
> +	FIXED_CLK(CLK_TOP_ADSYS_26M, "adsys_26m", "clk26m", 26 * MHZ),
> +	FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", DUMMY_RATE),
> +	FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
> +	FIXED_CLK(CLK_TOP_DSI0_DIG, "dsi0_dig", "clk26m", DUMMY_RATE),
> +	FIXED_CLK(CLK_TOP_DSI1_DIG, "dsi1_dig", "clk26m", DUMMY_RATE),
> +};
> +
> +static const struct mtk_fixed_factor top_divs[] = {
> +	FACTOR(CLK_TOP_ARMCA53PLL_754M, "armca53pll_754m", "clk26m", 1, 2),
> +	FACTOR(CLK_TOP_ARMCA53PLL_502M, "armca53pll_502m", "clk26m", 1, 3),
> +
> +	FACTOR(CLK_TOP_MAIN_H546M, "main_h546m", "mainpll", 1, 2),
> +	FACTOR(CLK_TOP_MAIN_H364M, "main_h364m", "mainpll", 1, 3),
> +	FACTOR(CLK_TOP_MAIN_H218P4M, "main_h218p4m", "mainpll", 1, 5),
> +	FACTOR(CLK_TOP_MAIN_H156M, "main_h156m", "mainpll", 1, 7),
> +
> +	FACTOR(CLK_TOP_TVDPLL_445P5M, "tvdpll_445p5m", "tvdpll", 1, 4),
> +	FACTOR(CLK_TOP_TVDPLL_594M, "tvdpll_594m", "tvdpll", 1, 3),
> +
> +	FACTOR(CLK_TOP_UNIV_624M, "univ_624m", "univpll", 1, 2),
> +	FACTOR(CLK_TOP_UNIV_416M, "univ_416m", "univpll", 1, 3),
> +	FACTOR(CLK_TOP_UNIV_249P6M, "univ_249p6m", "univpll", 1, 5),
> +	FACTOR(CLK_TOP_UNIV_178P3M, "univ_178p3m", "univpll", 1, 7),
> +	FACTOR(CLK_TOP_UNIV_48M, "univ_48m", "univpll", 1, 26),
> +
> +	FACTOR(CLK_TOP_CLKRTC_EXT, "clkrtc_ext", "clk32k", 1, 1),
> +	FACTOR(CLK_TOP_CLKRTC_INT, "clkrtc_int", "clk26m", 1, 793),
> +	FACTOR(CLK_TOP_FPC, "fpc_ck", "clk26m", 1, 1),
> +
> +	FACTOR(CLK_TOP_HDMITXPLL_D2, "hdmitxpll_d2", "clk26m", 1, 2),
> +	FACTOR(CLK_TOP_HDMITXPLL_D3, "hdmitxpll_d3", "clk26m", 1, 3),
> +
> +	FACTOR(CLK_TOP_ARMCA53PLL_D2, "armca53pll_d2", "clk26m", 1, 1),
> +	FACTOR(CLK_TOP_ARMCA53PLL_D3, "armca53pll_d3", "clk26m", 1, 1),
> +
> +	FACTOR(CLK_TOP_APLL1, "apll1_ck", "apll1", 1, 1),
> +	FACTOR(CLK_TOP_APLL2, "apll2_ck", "apll2", 1, 1),
> +
> +	FACTOR(CLK_TOP_DMPLL, "dmpll_ck", "clkph_mck_o", 1, 1),
> +	FACTOR(CLK_TOP_DMPLL_D2, "dmpll_d2", "clkph_mck_o", 1, 2),
> +	FACTOR(CLK_TOP_DMPLL_D4, "dmpll_d4", "clkph_mck_o", 1, 4),
> +	FACTOR(CLK_TOP_DMPLL_D8, "dmpll_d8", "clkph_mck_o", 1, 8),
> +	FACTOR(CLK_TOP_DMPLL_D16, "dmpll_d16", "clkph_mck_o", 1, 16),
> +
> +	FACTOR(CLK_TOP_MMPLL, "mmpll_ck", "mmpll", 1, 1),
> +	FACTOR(CLK_TOP_MMPLL_D2, "mmpll_d2", "mmpll", 1, 2),
> +
> +	FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", "msdcpll", 1, 1),
> +	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
> +	FACTOR(CLK_TOP_MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1, 4),
> +	FACTOR(CLK_TOP_MSDCPLL2, "msdcpll2_ck", "msdcpll2", 1, 1),
> +	FACTOR(CLK_TOP_MSDCPLL2_D2, "msdcpll2_d2", "msdcpll2", 1, 2),
> +	FACTOR(CLK_TOP_MSDCPLL2_D4, "msdcpll2_d4", "msdcpll2", 1, 4),
> +
> +	FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2", "main_h546m", 1, 1),
> +	FACTOR(CLK_TOP_SYSPLL1_D2, "syspll1_d2", "main_h546m", 1, 2),
> +	FACTOR(CLK_TOP_SYSPLL1_D4, "syspll1_d4", "main_h546m", 1, 4),
> +	FACTOR(CLK_TOP_SYSPLL1_D8, "syspll1_d8", "main_h546m", 1, 8),
> +	FACTOR(CLK_TOP_SYSPLL1_D16, "syspll1_d16", "main_h546m", 1, 16),
> +	FACTOR(CLK_TOP_SYSPLL_D3, "syspll_d3", "main_h364m", 1, 1),
> +	FACTOR(CLK_TOP_SYSPLL2_D2, "syspll2_d2", "main_h364m", 1, 2),
> +	FACTOR(CLK_TOP_SYSPLL2_D4, "syspll2_d4", "main_h364m", 1, 4),
> +	FACTOR(CLK_TOP_SYSPLL_D5, "syspll_d5", "main_h218p4m", 1, 1),
> +	FACTOR(CLK_TOP_SYSPLL3_D2, "syspll3_d2", "main_h218p4m", 1, 2),
> +	FACTOR(CLK_TOP_SYSPLL3_D4, "syspll3_d4", "main_h218p4m", 1, 4),
> +	FACTOR(CLK_TOP_SYSPLL_D7, "syspll_d7", "main_h156m", 1, 1),
> +	FACTOR(CLK_TOP_SYSPLL4_D2, "syspll4_d2", "main_h156m", 1, 2),
> +	FACTOR(CLK_TOP_SYSPLL4_D4, "syspll4_d4", "main_h156m", 1, 4),
> +
> +	FACTOR(CLK_TOP_TVDPLL, "tvdpll_ck", "tvdpll_594m", 1, 1),
> +	FACTOR(CLK_TOP_TVDPLL_D2, "tvdpll_d2", "tvdpll_594m", 1, 2),
> +	FACTOR(CLK_TOP_TVDPLL_D4, "tvdpll_d4", "tvdpll_594m", 1, 4),
> +	FACTOR(CLK_TOP_TVDPLL_D8, "tvdpll_d8", "tvdpll_594m", 1, 8),
> +	FACTOR(CLK_TOP_TVDPLL_D16, "tvdpll_d16", "tvdpll_594m", 1, 16),
> +
> +	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univ_624m", 1, 1),
> +	FACTOR(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", "univ_624m", 1, 2),
> +	FACTOR(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", "univ_624m", 1, 4),
> +	FACTOR(CLK_TOP_UNIVPLL1_D8, "univpll1_d8", "univ_624m", 1, 8),
> +	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univ_416m", 1, 1),
> +	FACTOR(CLK_TOP_UNIVPLL2_D2, "univpll2_d2", "univ_416m", 1, 2),
> +	FACTOR(CLK_TOP_UNIVPLL2_D4, "univpll2_d4", "univ_416m", 1, 4),
> +	FACTOR(CLK_TOP_UNIVPLL2_D8, "univpll2_d8", "univ_416m", 1, 8),
> +	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univ_249p6m", 1, 1),
> +	FACTOR(CLK_TOP_UNIVPLL3_D2, "univpll3_d2", "univ_249p6m", 1, 2),
> +	FACTOR(CLK_TOP_UNIVPLL3_D4, "univpll3_d4", "univ_249p6m", 1, 4),
> +	FACTOR(CLK_TOP_UNIVPLL3_D8, "univpll3_d8", "univ_249p6m", 1, 8),
> +	FACTOR(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univ_178p3m", 1, 1),
> +	FACTOR(CLK_TOP_UNIVPLL_D26, "univpll_d26", "univ_48m", 1, 1),
> +	FACTOR(CLK_TOP_UNIVPLL_D52, "univpll_d52", "univ_48m", 1, 2),
> +
> +	FACTOR(CLK_TOP_VCODECPLL, "vcodecpll_ck", "vcodecpll", 1, 3),
> +	FACTOR(CLK_TOP_VCODECPLL_370P5, "vcodecpll_370p5", "vcodecpll", 1, 4),
> +
> +	FACTOR(CLK_TOP_VENCPLL, "vencpll_ck", "vencpll", 1, 1),
> +	FACTOR(CLK_TOP_VENCPLL_D2, "vencpll_d2", "vencpll", 1, 2),
> +	FACTOR(CLK_TOP_VENCPLL_D4, "vencpll_d4", "vencpll", 1, 4),
> +};
> +
> +static const struct mtk_mux top_muxes[] = {
> +	/* CLK_CFG_0 */
> +	TOP_MUX_GATE_NOSR(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
> +			  0x40, 0, 3, 7, CLK_IS_CRITICAL),
> +	TOP_MUX_GATE_NOSR(CLK_TOP_MEM_SEL, "mem_sel", mem_parents,
> +			  0x40, 8, 1, 15, CLK_IS_CRITICAL),
> +	TOP_MUX_GATE(CLK_TOP_DDRPHYCFG_SEL, "ddrphycfg_sel", ddrphycfg_parents,
> +		     0x40, 16, 1, 23, CLK_IS_CRITICAL),
> +	TOP_MUX_GATE(CLK_TOP_MM_SEL, "mm_sel", mm_parents, 0x40, 24, 3, 31, 0),
> +	/* CLK_CFG_1 */
> +	TOP_MUX_GATE(CLK_TOP_PWM_SEL, "pwm_sel", pwm_parents, 0x50, 0, 2, 7, 0),
> +	TOP_MUX_GATE(CLK_TOP_VDEC_SEL, "vdec_sel", vdec_parents, 0x50, 8, 4, 15, 0),
> +	TOP_MUX_GATE(CLK_TOP_VENC_SEL, "venc_sel", venc_parents, 0x50, 16, 4, 23, 0),
> +	TOP_MUX_GATE(CLK_TOP_MFG_SEL, "mfg_sel", mfg_parents, 0x50, 24, 4, 31, 0),
> +	/* CLK_CFG_2 */
> +	TOP_MUX_GATE(CLK_TOP_CAMTG_SEL, "camtg_sel", camtg_parents, 0x60, 0, 3, 7, 0),
> +	TOP_MUX_GATE(CLK_TOP_UART_SEL, "uart_sel", uart_parents, 0x60, 8, 1, 15, 0),
> +	TOP_MUX_GATE(CLK_TOP_SPI_SEL, "spi_sel", spi_parents, 0x60, 16, 3, 23, 0),
> +	TOP_MUX_GATE(CLK_TOP_USB20_SEL, "usb20_sel", usb20_parents, 0x60, 24, 2, 31, 0),
> +	/* CLK_CFG_3 */
> +	TOP_MUX_GATE(CLK_TOP_USB30_SEL, "usb30_sel", usb30_parents, 0x70, 0, 2, 7, 0),
> +	TOP_MUX_GATE(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel", msdc50_0_h_parents,
> +		     0x70, 8, 3, 15, 0),
> +	TOP_MUX_GATE(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_parents, 0x70, 16, 4, 23, 0),
> +	TOP_MUX_GATE(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_parents, 0x70, 24, 3, 31, 0),
> +	/* CLK_CFG_4 */
> +	TOP_MUX_GATE(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel", msdc30_2_parents, 0x80, 0, 3, 7, 0),
> +	TOP_MUX_GATE(CLK_TOP_MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_parents, 0x80, 8, 3, 15, 0),
> +	TOP_MUX_GATE(CLK_TOP_AUDIO_SEL, "audio_sel", audio_parents, 0x80, 16, 2, 23, 0),
> +	TOP_MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, "aud_intbus_sel", aud_intbus_parents,
> +		     0x80, 24, 3, 31, 0),
> +	/* CLK_CFG_5 */
> +	TOP_MUX_GATE(CLK_TOP_PMICSPI_SEL, "pmicspi_sel", pmicspi_parents, 0x90, 0, 3, 5, 0),
> +	TOP_MUX_GATE(CLK_TOP_SCP_SEL, "scp_sel", scp_parents, 0x90, 8, 3, 15, 0),
> +	TOP_MUX_GATE(CLK_TOP_MJC_SEL, "mjc_sel", mjc_parents, 0x90, 24, 4, 31, 0),
> +	/* CLK_CFG_6 */
> +	/*
> +	 * The dpi0_sel clock should not propagate rate changes to its parent
> +	 * clock so the dpi driver can have full control over PLL and divider.
> +	 */
> +	TOP_MUX_GATE_NOSR(CLK_TOP_DPI0_SEL, "dpi0_sel", dpi0_parents, 0xa0, 0, 3, 7, 0),
> +	TOP_MUX_GATE(CLK_TOP_IRDA_SEL, "irda_sel", irda_parents, 0xa0, 8, 2, 15, 0),
> +	TOP_MUX_GATE(CLK_TOP_CCI400_SEL, "cci400_sel", cci400_parents,
> +		     0xa0, 16, 3, 23, CLK_IS_CRITICAL),
> +	TOP_MUX_GATE(CLK_TOP_AUD_1_SEL, "aud_1_sel", aud_1_parents, 0xa0, 24, 2, 31, 0),
> +	/* CLK_CFG_7 */
> +	TOP_MUX_GATE(CLK_TOP_AUD_2_SEL, "aud_2_sel", aud_2_parents, 0xb0, 0, 2, 7, 0),
> +	TOP_MUX_GATE(CLK_TOP_MEM_MFG_IN_SEL, "mem_mfg_in_sel", mem_mfg_in_parents,
> +		     0xb0, 8, 2, 15, 0),
> +	TOP_MUX_GATE(CLK_TOP_AXI_MFG_IN_SEL, "axi_mfg_in_sel", axi_mfg_in_parents,
> +		     0xb0, 16, 2, 23, 0),
> +	TOP_MUX_GATE(CLK_TOP_SCAM_SEL, "scam_sel", scam_parents, 0xb0, 24, 2, 31, 0),
> +};
> +
> +static struct mtk_composite top_aud_divs[] = {
> +	MUX(CLK_TOP_I2S0_M_SEL, "i2s0_m_ck_sel", i2s0_m_ck_parents, 0x120, 4, 1),
> +	MUX(CLK_TOP_I2S1_M_SEL, "i2s1_m_ck_sel", i2s1_m_ck_parents, 0x120, 5, 1),
> +	MUX(CLK_TOP_I2S2_M_SEL, "i2s2_m_ck_sel", i2s2_m_ck_parents, 0x120, 6, 1),
> +	MUX(CLK_TOP_I2S3_M_SEL, "i2s3_m_ck_sel", i2s3_m_ck_parents, 0x120, 7, 1),
> +	MUX(CLK_TOP_I2S3_B_SEL, "i2s3_b_ck_sel", i2s3_b_ck_parents, 0x120, 8, 1),
> +
> +	DIV_GATE(CLK_TOP_APLL1_DIV0, "apll1_div0", "aud_1_sel", 0x12c, 8, 0x120, 4, 24),
> +	DIV_GATE(CLK_TOP_APLL1_DIV1, "apll1_div1", "aud_1_sel", 0x12c, 9, 0x124, 8, 0),
> +	DIV_GATE(CLK_TOP_APLL1_DIV2, "apll1_div2", "aud_1_sel", 0x12c, 10, 0x124, 8, 8),
> +	DIV_GATE(CLK_TOP_APLL1_DIV3, "apll1_div3", "aud_1_sel", 0x12c, 11, 0x124, 8, 16),
> +	DIV_GATE(CLK_TOP_APLL1_DIV4, "apll1_div4", "aud_1_sel", 0x12c, 12, 0x124, 8, 24),
> +	DIV_GATE(CLK_TOP_APLL1_DIV5, "apll1_div5", "apll1_div4", 0x12c, 13, 0x12c, 4, 0),
> +
> +	DIV_GATE(CLK_TOP_APLL2_DIV0, "apll2_div0", "aud_2_sel", 0x12c, 16, 0x120, 4, 28),
> +	DIV_GATE(CLK_TOP_APLL2_DIV1, "apll2_div1", "aud_2_sel", 0x12c, 17, 0x128, 8, 0),
> +	DIV_GATE(CLK_TOP_APLL2_DIV2, "apll2_div2", "aud_2_sel", 0x12c, 18, 0x128, 8, 8),
> +	DIV_GATE(CLK_TOP_APLL2_DIV3, "apll2_div3", "aud_2_sel", 0x12c, 19, 0x128, 8, 16),
> +	DIV_GATE(CLK_TOP_APLL2_DIV4, "apll2_div4", "aud_2_sel", 0x12c, 20, 0x128, 8, 24),
> +	DIV_GATE(CLK_TOP_APLL2_DIV5, "apll2_div5", "apll2_div4", 0x12c, 21, 0x12c, 4, 4),
> +};
> +
> +
> +static const struct of_device_id of_match_clk_mt6795_topckgen[] = {
> +	{ .compatible = "mediatek,mt6795-topckgen" },
> +	{ /* sentinel */ }
> +};
> +
> +static int clk_mt6795_topckgen_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	void __iomem *base;
> +	int ret;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	ret = mtk_clk_register_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
> +	if (ret)
> +		goto free_clk_data;
> +
> +	ret = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
> +	if (ret)
> +		goto unregister_fixed_clks;
> +
> +	ret = mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
> +				     &mt6795_top_clk_lock, clk_data);
> +	if (ret)
> +		goto unregister_factors;
> +
> +	ret = mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs), base,
> +					  &mt6795_top_clk_lock, clk_data);
> +	if (ret)
> +		goto unregister_muxes;
> +
> +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (ret)
> +		goto unregister_composites;
> +
> +	return 0;
> +
> +unregister_composites:
> +	mtk_clk_unregister_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs), clk_data);
> +unregister_muxes:
> +	mtk_clk_unregister_muxes(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
> +unregister_factors:
> +	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
> +unregister_fixed_clks:
> +	mtk_clk_unregister_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
> +free_clk_data:
> +	mtk_free_clk_data(clk_data);
> +	return ret;
> +}
> +
> +static int clk_mt6795_topckgen_remove(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs), clk_data);
> +	mtk_clk_unregister_muxes(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
> +	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
> +	mtk_clk_unregister_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver clk_mt6795_topckgen_drv = {
> +	.probe = clk_mt6795_topckgen_probe,
> +	.remove = clk_mt6795_topckgen_remove,
> +	.driver = {
> +		.name = "clk-mt6795-topckgen",
> +		.of_match_table = of_match_clk_mt6795_topckgen,
> +	},
> +};
> +builtin_platform_driver(clk_mt6795_topckgen_drv);
> diff --git a/drivers/clk/mediatek/clk-mt6795-vdecsys.c b/drivers/clk/mediatek/clk-mt6795-vdecsys.c
> new file mode 100644
> index 000000000000..011cc17adc0e
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6795-vdecsys.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mt6795-clk.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +#define GATE_VDEC(_id, _name, _parent, _regs)			\
> +		GATE_MTK(_id, _name, _parent, _regs, 0,		\
> +			 &mtk_clk_gate_ops_setclr_inv)
> +
> +static const struct mtk_gate_regs vdec0_cg_regs = {
> +	.set_ofs = 0x0000,
> +	.clr_ofs = 0x0004,
> +	.sta_ofs = 0x0000,
> +};
> +
> +static const struct mtk_gate_regs vdec1_cg_regs = {
> +	.set_ofs = 0x0008,
> +	.clr_ofs = 0x000c,
> +	.sta_ofs = 0x0008,
> +};
> +
> +static const struct mtk_gate vdec_clks[] = {
> +	GATE_VDEC(CLK_VDEC_CKEN, "vdec_cken", "vdec_sel", &vdec0_cg_regs),
> +	GATE_VDEC(CLK_VDEC_LARB_CKEN, "vdec_larb_cken", "mm_sel", &vdec1_cg_regs),
> +};
> +
> +static const struct mtk_clk_desc vdec_desc = {
> +	.clks = vdec_clks,
> +	.num_clks = ARRAY_SIZE(vdec_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt6795_vdecsys[] = {
> +	{ .compatible = "mediatek,mt6795-vdecsys", .data = &vdec_desc },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt6795_vdecsys_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
> +	.driver = {
> +		.name = "clk-mt6795-vdecsys",
> +		.of_match_table = of_match_clk_mt6795_vdecsys,
> +	},
> +};
> +builtin_platform_driver(clk_mt6795_vdecsys_drv);
> diff --git a/drivers/clk/mediatek/clk-mt6795-vencsys.c b/drivers/clk/mediatek/clk-mt6795-vencsys.c
> new file mode 100644
> index 000000000000..e875b42fb86f
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt6795-vencsys.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mt6795-clk.h>
> +#include <linux/platform_device.h>
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +
> +static const struct mtk_gate_regs venc_cg_regs = {
> +	.set_ofs = 0x4,
> +	.clr_ofs = 0x8,
> +	.sta_ofs = 0x0,
> +};
> +
> +#define GATE_VENC(_id, _name, _parent, _shift)			\
> +	GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
> +
> +static const struct mtk_gate venc_clks[] = {
> +	GATE_VENC(CLK_VENC_LARB, "venc_larb", "venc_sel", 0),
> +	GATE_VENC(CLK_VENC_VENC, "venc_venc", "venc_sel", 4),
> +	GATE_VENC(CLK_VENC_JPGENC, "venc_jpgenc", "venc_sel", 8),
> +	GATE_VENC(CLK_VENC_JPGDEC, "venc_jpgdec", "venc_sel", 12),
> +};
> +
> +static const struct mtk_clk_desc venc_desc = {
> +	.clks = venc_clks,
> +	.num_clks = ARRAY_SIZE(venc_clks),
> +};
> +
> +static const struct of_device_id of_match_clk_mt6795_venc[] = {
> +	{ .compatible = "mediatek,mt6795-vencsys", .data = &venc_desc },
> +	{ /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt6795_venc_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
> +	.driver = {
> +		.name = "clk-mt6795-venc",
> +		.of_match_table = of_match_clk_mt6795_venc,
> +	},
> +};
> +builtin_platform_driver(clk_mt6795_venc_drv);
