Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1A52E7B4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347152AbiETIfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbiETIf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:35:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699BB40A22;
        Fri, 20 May 2022 01:35:23 -0700 (PDT)
X-UUID: 07e51fdc60124ace873be9560f264f7d-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:3b110d5e-afd3-4d48-990f-b1997d9f61ee,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:1cc9ede2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 07e51fdc60124ace873be9560f264f7d-20220520
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 948682526; Fri, 20 May 2022 16:35:16 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 16:35:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 16:35:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 16:35:14 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <yassine.oudjana@gmail.com>
CC:     <angelogioacchino.delregno@collabora.com>,
        <bgolaszewski@baylibre.com>, <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <ikjn@chromium.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <tinghan.shen@mediatek.com>, <weiyi.lu@mediatek.com>,
        <wenst@chromium.org>, <y.oudjana@protonmail.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v2 4/4] clk: mediatek: Add drivers for MediaTek MT6735 main clock drivers
Date:   Fri, 20 May 2022 16:35:14 +0800
Message-ID: <20220520083514.27891-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220519142211.458336-5-y.oudjana@protonmail.com>
References: <20220519142211.458336-5-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Yassine,

> Add drivers for MT6735 apmixedsys, topckgen, infracfg and pericfg
> clock and reset controllers. These provide the base clocks on the
> platform, and should be enough to bring up all essential blocks
> including PWRAP, MSDC and peripherals (UART, I2C, SPI).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Dependencies:
> - clk: mediatek: Move to struct clk_hw provider APIs (series)
>   https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/ 
> - Cleanup MediaTek clk reset drivers and support MT8192/MT8195 (series)
>   https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
> - Export required symbols to compile clk drivers as module (single patch)
>   https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/
> - clk: mediatek: Improvements to simple probe/remove and reset controller unregistration
>   https://patchwork.kernel.org/project/linux-clk/cover/20220519134728.456643-1-y.oudjana@protonmail.com/
> 
>  MAINTAINERS                                  |    4 +
>  drivers/clk/mediatek/Kconfig                 |    9 +
>  drivers/clk/mediatek/Makefile                |    1 +
>  drivers/clk/mediatek/clk-mt6735-apmixedsys.c |  235 ++++

...snip...

> +#define APLL2_CON0		0x284
> +#define APLL2_CON1		0x288
> +#define APLL2_CON2		0x28c
> +#define APLL2_PWR_CON0		0x294
> +
> +#define CON0_RST_BAR		BIT(24)
> +
> +static const struct mtk_pll_data apmixedsys_plls[] = {
> +	{
> +		.id = ARMPLL,
> +		.name = "armpll",
> +		.parent_name = "clk26m",
> +
> +		.reg = ARMPLL_CON0,
> +		.pwr_reg = ARMPLL_PWR_CON0,
> +		.en_mask = 0x00000001,
> +
> +		.pd_reg = ARMPLL_CON1,
> +		.pd_shift = 24,
> +
> +		.pcw_reg = ARMPLL_CON1,
> +		.pcw_chg_reg = ARMPLL_CON1,
> +		.pcwbits = 21,
> +
> +		.flags = PLL_AO

Thanks for submitting this patch.

I compare this with drivers/clk/mediatek/clk-mt7986-apmixed.c,
and other clk files are using macros to make the mtk_pll_data array
more readable.

Would you mind following the same style for all c files, please?

e.g.,
	static const struct mtk_pll_data plls[] = {
		PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0x00000001, 0, 32,
				0x0200, 4, 0, 0x0204, 0),
		PLL(CLK_APMIXED_NET2PLL, "net2pll", 0x0210, 0x021C, 0x00000001, 0, 32,
				0x0210, 4, 0, 0x0214, 0),                                           
		...
	};

> +	},
> +	{
> +		.id = MAINPLL,
> +		.name = "mainpll",
> +		.parent_name = "clk26m",
> +
> +		.reg = MAINPLL_CON0,
> +		.pwr_reg = MAINPLL_PWR_CON0,
> +		.en_mask = 0xf0000101,
> +
> +		.pd_reg = MAINPLL_CON1,
> +		.pd_shift = 24,
> +
> +		.pcw_reg = MAINPLL_CON1,
> +		.pcw_chg_reg = MAINPLL_CON1,
> +		.pcwbits = 21,
> +
> +		.flags = HAVE_RST_BAR,
> +		.rst_bar_mask = CON0_RST_BAR
> +	},
> +	{
> +		.id = UNIVPLL,
> +		.name = "univpll",
> +		.parent_name = "clk26m",
> +
> +		.reg = UNIVPLL_CON0,
> +		.pwr_reg = UNIVPLL_PWR_CON0,
> +		.en_mask = 0xfc000001,
> +
> +		.pd_reg = UNIVPLL_CON1,
> +		.pd_shift = 24,
> +
> +		.pcw_reg = UNIVPLL_CON1,
> +		.pcw_chg_reg = UNIVPLL_CON1,
> +		.pcwbits = 21,
> +
> +		.flags = HAVE_RST_BAR,
> +		.rst_bar_mask = CON0_RST_BAR
> +	},
> +	{
> +		.id = MMPLL,
> +		.name = "mmpll",
> +		.parent_name = "clk26m",
> +
> +		.reg = MMPLL_CON0,
> +		.pwr_reg = MMPLL_PWR_CON0,
> +		.en_mask = 0x00000001,
> +
> +		.pd_reg = MMPLL_CON1,
> +		.pd_shift = 24,
> +
> +		.pcw_reg = MMPLL_CON1,
> +		.pcw_chg_reg = MMPLL_CON1,
> +		.pcwbits = 21
> +	},
> +	{
> +		.id = MSDCPLL,
> +		.name = "msdcpll",
> +		.parent_name = "clk26m",
> +
> +		.reg = MSDCPLL_CON0,
> +		.pwr_reg = MSDCPLL_PWR_CON0,
> +		.en_mask = 0x00000001,
> +
> +		.pd_reg = MSDCPLL_CON1,
> +		.pd_shift = 24,
> +
> +		.pcw_reg = MSDCPLL_CON1,
> +		.pcw_chg_reg = MSDCPLL_CON1,
> +		.pcwbits = 21,
> +	},
> +	{
> +		.id = VENCPLL,
> +		.name = "vencpll",
> +		.parent_name = "clk26m",
> +
> +		.reg = VENCPLL_CON0,
> +		.pwr_reg = VENCPLL_PWR_CON0,
> +		.en_mask = 0x00000001,
> +
> +		.pd_reg = VENCPLL_CON1,
> +		.pd_shift = 24,
> +
> +		.pcw_reg = VENCPLL_CON1,
> +		.pcw_chg_reg = VENCPLL_CON1,
> +		.pcwbits = 21,
> +
> +		.flags = HAVE_RST_BAR,
> +		.rst_bar_mask = CON0_RST_BAR
> +	},
> +	{
> +		.id = TVDPLL,
> +		.name = "tvdpll",
> +		.parent_name = "clk26m",
> +
> +		.reg = TVDPLL_CON0,
> +		.pwr_reg = TVDPLL_PWR_CON0,
> +		.en_mask = 0x00000001,
> +
> +		.pd_reg = TVDPLL_CON1,
> +		.pd_shift = 24,
> +
> +		.pcw_reg = TVDPLL_CON1,
> +		.pcw_chg_reg = TVDPLL_CON1,
> +		.pcwbits = 21
> +	},
> +	{
> +		.id = APLL1,
> +		.name = "apll1",
> +		.parent_name = "clk26m",
> +
> +		.reg = APLL1_CON0,
> +		.pwr_reg = APLL1_PWR_CON0,
> +module_platform_driver(clk_mt6735_apmixedsys);
> +
> +MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
> +MODULE_DESCRIPTION("Mediatek MT6735 apmixedsys clock driver");

Would you mind changing all Mediatek to MediaTek?
i.e.,

s/Mediatek/MediaTek/


thanks,
Miles
> +MODULE_LICENSE("GPL");
