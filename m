Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFB555A53A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiFYAH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiFYAH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:07:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1355EAE;
        Fri, 24 Jun 2022 17:07:54 -0700 (PDT)
X-UUID: cef0bde0206e4c2e9490ca53b9f60f0c-20220625
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:f41f7e5b-b7fa-4302-a08d-21553d5a2f9b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:22
X-CID-INFO: VERSION:1.1.6,REQID:f41f7e5b-b7fa-4302-a08d-21553d5a2f9b,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:22
X-CID-META: VersionHash:b14ad71,CLOUDID:a28784d8-850a-491d-a127-60d9309b2b3e,C
        OID:IGNORED,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,IP:ni
        l,URL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: cef0bde0206e4c2e9490ca53b9f60f0c-20220625
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2042925076; Sat, 25 Jun 2022 08:07:49 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 25 Jun 2022 08:07:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 25 Jun 2022 08:07:47 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <bgolaszewski@baylibre.com>, <chun-jie.chen@mediatek.com>,
        <ck.hu@mediatek.com>, <devicetree@vger.kernel.org>,
        <fparent@baylibre.com>, <ikjn@chromium.org>,
        <jason-jh.lin@mediatek.com>, <kernel@collabora.com>,
        <konrad.dybcio@somainline.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <marijn.suijten@somainline.org>, <martin.botka@somainline.org>,
        <matthias.bgg@gmail.com>, <miles.chen@mediatek.com>,
        <mturquette@baylibre.com>, <p.zabel@pengutronix.de>,
        <paul.bouchara@somainline.org>, <phone-devel@vger.kernel.org>,
        <rex-bc.chen@mediatek.com>, <robh+dt@kernel.org>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <tinghan.shen@mediatek.com>, <weiyi.lu@mediatek.com>,
        <wenst@chromium.org>, <y.oudjana@protonmail.com>,
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v3 7/7] clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers
Date:   Sat, 25 Jun 2022 08:07:47 +0800
Message-ID: <20220625000747.12582-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220624093525.243077-8-angelogioacchino.delregno@collabora.com>
References: <20220624093525.243077-8-angelogioacchino.delregno@collabora.com>
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

Hi Angelo,

> Add the clock drivers for the entire clock tree of MediaTek Helio X10
> MT6795, including system clocks (apmixedsys, infracfg, pericfg, topckgen)
> and multimedia clocks (mmsys, mfg, vdecsys, vencsys).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  drivers/clk/mediatek/Kconfig                 |  37 ++
>  drivers/clk/mediatek/Makefile                |   6 +
>  drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 157 +++++
>  drivers/clk/mediatek/clk-mt6795-infracfg.c   | 148 +++++
>  drivers/clk/mediatek/clk-mt6795-mfg.c        |  50 ++
>  drivers/clk/mediatek/clk-mt6795-mm.c         | 106 ++++
>  drivers/clk/mediatek/clk-mt6795-pericfg.c    | 160 +++++
>  drivers/clk/mediatek/clk-mt6795-topckgen.c   | 610 +++++++++++++++++++
>  drivers/clk/mediatek/clk-mt6795-vdecsys.c    |  55 ++
>  drivers/clk/mediatek/clk-mt6795-vencsys.c    |  50 ++
>  10 files changed, 1379 insertions(+)
>  create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
>  create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
>  create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
>  create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
>  create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
>  create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
>  create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
>  create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index d5936cfb3bee..da8142dff3c3 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -259,6 +259,43 @@ config COMMON_CLK_MT6779_AUDSYS
>  	help
>  	  This driver supports Mediatek MT6779 audsys clocks.
>  
> +config COMMON_CLK_MT6795
> +	tristate "Clock driver for MediaTek MT6795"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select COMMON_CLK_MEDIATEK
> +	default ARCH_MEDIATEK
> +	help
> +	  This driver supports MediaTek MT6795 basic clocks and clocks
> +	  required for various peripherals found on MediaTek.
> +
> +config COMMON_CLK_MT6795_MFGCFG
> +	tristate "Clock driver for MediaTek MT6795 mfgcfg"
> +	depends on COMMON_CLK_MT6795
> +	default COMMON_CLK_MT6795
> +	help
> +	  This driver supports MediaTek MT6795 mfgcfg clocks.
> +
> +config COMMON_CLK_MT6795_MMSYS
> +       tristate "Clock driver for MediaTek MT6795 mmsys"

snip...

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

While checking the error path, I learned that
mtk_register_reset_controller_with_dev uses devm_reset_controller_register and it will
be unregister the reset automatically if probe failed.

Thanks for this patch!

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 


thanks,
Miles

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
