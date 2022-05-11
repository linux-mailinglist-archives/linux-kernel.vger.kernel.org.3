Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8208522A62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 05:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiEKDW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 23:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiEKDWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:22:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328A773574;
        Tue, 10 May 2022 20:22:07 -0700 (PDT)
X-UUID: 4db11a3136c04ddc8720a80458304ead-20220511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:28241b3e-b691-40ba-adb3-6ca2732df83b,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:90835bb3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 4db11a3136c04ddc8720a80458304ead-20220511
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1454611897; Wed, 11 May 2022 11:22:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 11 May 2022 11:22:02 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 May 2022 11:22:01 +0800
Message-ID: <8affe58a4952d6c405dd41f18c6a7f40b2313fde.camel@mediatek.com>
Subject: Re: [PATCH v8 2/2] phy: mediatek: Add PCIe PHY driver
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Vinod Koul" <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Wei-Shun Chang <weishunc@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <randy.wu@mediatek.com>,
        <jieyy.yang@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <qizhong.cheng@mediatek.com>, <jian.yang@mediatek.com>
Date:   Wed, 11 May 2022 11:22:01 +0800
In-Reply-To: <20220507060621.32252-3-jianjun.wang@mediatek.com>
References: <20220507060621.32252-1-jianjun.wang@mediatek.com>
         <20220507060621.32252-3-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-05-07 at 14:06 +0800, Jianjun Wang wrote:
> Add PCIe GEN3 PHY driver support on MediaTek chipsets.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/phy/mediatek/Kconfig        |  11 ++
>  drivers/phy/mediatek/Makefile       |   1 +
>  drivers/phy/mediatek/phy-mtk-pcie.c | 267
> ++++++++++++++++++++++++++++
>  3 files changed, 279 insertions(+)
>  create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
> 
> diff --git a/drivers/phy/mediatek/Kconfig
> b/drivers/phy/mediatek/Kconfig
> index 55f8e6c048ab..387ed1b3f2cc 100644
> --- a/drivers/phy/mediatek/Kconfig
> +++ b/drivers/phy/mediatek/Kconfig
> @@ -55,3 +55,14 @@ config PHY_MTK_MIPI_DSI
>  	select GENERIC_PHY
>  	help
>  	  Support MIPI DSI for Mediatek SoCs.
> +
> +config PHY_MTK_PCIE
> +	tristate "MediaTek PCIe-PHY Driver"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on OF
> +	select GENERIC_PHY
> +	help
> +	  Say 'Y' here to add support for MediaTek PCIe PHY driver.
> +	  This driver create the basic PHY instance and provides
> initialize
> +	  callback for PCIe GEN3 port, it supports software efuse
> +	  initialization.
> diff --git a/drivers/phy/mediatek/Makefile
> b/drivers/phy/mediatek/Makefile
> index ace660fbed3a..788c13147f63 100644
> --- a/drivers/phy/mediatek/Makefile
> +++ b/drivers/phy/mediatek/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_PHY_MTK_TPHY)		+= phy-mtk-tphy.o
>  obj-$(CONFIG_PHY_MTK_UFS)		+= phy-mtk-ufs.o
>  obj-$(CONFIG_PHY_MTK_XSPHY)		+= phy-mtk-xsphy.o
> +obj-$(CONFIG_PHY_MTK_PCIE)		+= phy-mtk-pcie.o
>  
>  phy-mtk-hdmi-drv-y			:= phy-mtk-hdmi.o
>  phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt2701.o
> diff --git a/drivers/phy/mediatek/phy-mtk-pcie.c
> b/drivers/phy/mediatek/phy-mtk-pcie.c
> new file mode 100644
> index 000000000000..e4bcf1e9941c
> --- /dev/null
> +++ b/drivers/phy/mediatek/phy-mtk-pcie.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Jianjun Wang <jianjun.wang@mediatek.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "phy-mtk-io.h"
> +
> +#define PEXTP_ANA_GLB_00_REG		0x9000
> +/* Internal Resistor Selection of TX Bias Current */
> +#define EFUSE_GLB_INTR_SEL		GENMASK(28, 24)
> +
> +#define PEXTP_ANA_LN0_TRX_REG		0xa000
> +
> +#define PEXTP_ANA_TX_REG		0x04
> +/* TX PMOS impedance selection */
> +#define EFUSE_LN_TX_PMOS_SEL		GENMASK(5, 2)
> +/* TX NMOS impedance selection */
> +#define EFUSE_LN_TX_NMOS_SEL		GENMASK(11, 8)
> +
> +#define PEXTP_ANA_RX_REG		0x3c
> +/* RX impedance selection */
> +#define EFUSE_LN_RX_SEL			GENMASK(3, 0)
> +
> +#define PEXTP_ANA_LANE_OFFSET		0x100
> +
> +/**
> + * struct mtk_pcie_lane_efuse - eFuse data for each lane
> + * @tx_pmos: TX PMOS impedance selection data
> + * @tx_nmos: TX NMOS impedance selection data
> + * @rx_data: RX impedance selection data
> + * @lane_efuse_supported: software eFuse data is supported for this
> lane
> + */
> +struct mtk_pcie_lane_efuse {
> +	u32 tx_pmos;
> +	u32 tx_nmos;
> +	u32 rx_data;
> +	bool lane_efuse_supported;
> +};
> +
> +/**
> + * struct mtk_pcie_phy_data - phy data for each SoC
> + * @num_lanes: supported lane numbers
> + * @sw_efuse_supported: support software to load eFuse data
> + */
> +struct mtk_pcie_phy_data {
> +	int num_lanes;
> +	bool sw_efuse_supported;
> +};
> +
> +/**
> + * struct mtk_pcie_phy - PCIe phy driver main structure
> + * @dev: pointer to device
> + * @phy: pointer to generic phy
> + * @sif_base: IO mapped register base address of system interface
> + * @data: pointer to SoC dependent data
> + * @sw_efuse_en: software eFuse enable status
> + * @efuse_glb_intr: internal resistor selection of TX bias current
> data
> + * @efuse: pointer to eFuse data for each lane
> + */
> +struct mtk_pcie_phy {
> +	struct device *dev;
> +	struct phy *phy;
> +	void __iomem *sif_base;
> +	const struct mtk_pcie_phy_data *data;
> +
> +	bool sw_efuse_en;
> +	u32 efuse_glb_intr;
> +	struct mtk_pcie_lane_efuse *efuse;
> +};
> +
> +static void mtk_pcie_efuse_set_lane(struct mtk_pcie_phy *pcie_phy,
> +				    unsigned int lane)
> +{
> +	struct mtk_pcie_lane_efuse *data = &pcie_phy->efuse[lane];
> +	void __iomem *addr;
> +
> +	if (!data->lane_efuse_supported)
> +		return;
> +
> +	addr = pcie_phy->sif_base + PEXTP_ANA_LN0_TRX_REG +
> +	       lane * PEXTP_ANA_LANE_OFFSET;
> +
> +	mtk_phy_update_bits(addr + PEXTP_ANA_TX_REG,
> EFUSE_LN_TX_PMOS_SEL,
> +			    FIELD_PREP(EFUSE_LN_TX_PMOS_SEL, data-
> >tx_pmos));
> +
> +	mtk_phy_update_bits(addr + PEXTP_ANA_TX_REG,
> EFUSE_LN_TX_NMOS_SEL,
> +			    FIELD_PREP(EFUSE_LN_TX_NMOS_SEL, data-
> >tx_nmos));
> +
> +	mtk_phy_update_bits(addr + PEXTP_ANA_RX_REG, EFUSE_LN_RX_SEL,
> +			    FIELD_PREP(EFUSE_LN_RX_SEL, data-
> >rx_data));
> +}
> +
> +/**
> + * mtk_pcie_phy_init() - Initialize the phy
> + * @phy: the phy to be initialized
> + *
> + * Initialize the phy by setting the efuse data.
> + * The hardware settings will be reset during suspend, it should be
> + * reinitialized when the consumer calls phy_init() again on resume.
> + */
> +static int mtk_pcie_phy_init(struct phy *phy)
> +{
> +	struct mtk_pcie_phy *pcie_phy = phy_get_drvdata(phy);
> +	int i;
> +
> +	if (!pcie_phy->sw_efuse_en)
> +		return 0;
> +
> +	/* Set global data */
> +	mtk_phy_update_bits(pcie_phy->sif_base + PEXTP_ANA_GLB_00_REG,
> +			    EFUSE_GLB_INTR_SEL,
> +			    FIELD_PREP(EFUSE_GLB_INTR_SEL, pcie_phy-
> >efuse_glb_intr));
> +
> +	for (i = 0; i < pcie_phy->data->num_lanes; i++)
> +		mtk_pcie_efuse_set_lane(pcie_phy, i);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops mtk_pcie_phy_ops = {
> +	.init	= mtk_pcie_phy_init,
> +	.owner	= THIS_MODULE,
> +};
> +
> +static int mtk_pcie_efuse_read_for_lane(struct mtk_pcie_phy
> *pcie_phy,
> +					unsigned int lane)
> +{
> +	struct mtk_pcie_lane_efuse *efuse = &pcie_phy->efuse[lane];
> +	struct device *dev = pcie_phy->dev;
> +	char efuse_id[16];
> +	int ret;
> +
> +	snprintf(efuse_id, sizeof(efuse_id), "tx_ln%d_pmos", lane);
> +	ret = nvmem_cell_read_variable_le_u32(dev, efuse_id, &efuse-
> >tx_pmos);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read %s\n",
> efuse_id);
> +
> +	snprintf(efuse_id, sizeof(efuse_id), "tx_ln%d_nmos", lane);
> +	ret = nvmem_cell_read_variable_le_u32(dev, efuse_id, &efuse-
> >tx_nmos);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read %s\n",
> efuse_id);
> +
> +	snprintf(efuse_id, sizeof(efuse_id), "rx_ln%d", lane);
> +	ret = nvmem_cell_read_variable_le_u32(dev, efuse_id, &efuse-
> >rx_data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read %s\n",
> efuse_id);
> +
> +	if (!(efuse->tx_pmos || efuse->tx_nmos || efuse->rx_data))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "No eFuse data found for lane%d,
> but dts enable it\n",
> +				     lane);
> +
> +	efuse->lane_efuse_supported = true;
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_read_efuse(struct mtk_pcie_phy *pcie_phy)
> +{
> +	struct device *dev = pcie_phy->dev;
> +	bool nvmem_enabled;
> +	int ret, i;
> +
> +	/* nvmem data is optional */
> +	nvmem_enabled = device_property_present(dev, "nvmem-cells");
> +	if (!nvmem_enabled)
> +		return 0;
> +
> +	ret = nvmem_cell_read_variable_le_u32(dev, "glb_intr",
> +					      &pcie_phy-
> >efuse_glb_intr);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read
> glb_intr\n");
> +
> +	pcie_phy->sw_efuse_en = true;
> +
> +	pcie_phy->efuse = devm_kzalloc(dev, pcie_phy->data->num_lanes *
> +				       sizeof(*pcie_phy->efuse),
> GFP_KERNEL);
> +	if (!pcie_phy->efuse)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < pcie_phy->data->num_lanes; i++) {
> +		ret = mtk_pcie_efuse_read_for_lane(pcie_phy, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *provider;
> +	struct mtk_pcie_phy *pcie_phy;
> +	int ret;
> +
> +	pcie_phy = devm_kzalloc(dev, sizeof(*pcie_phy), GFP_KERNEL);
> +	if (!pcie_phy)
> +		return -ENOMEM;
> +
> +	pcie_phy->sif_base =
> devm_platform_ioremap_resource_byname(pdev, "sif");
> +	if (IS_ERR(pcie_phy->sif_base))
> +		return dev_err_probe(dev, PTR_ERR(pcie_phy->sif_base),
> +				     "Failed to map phy-sif base\n");
> +
> +	pcie_phy->phy = devm_phy_create(dev, dev->of_node,
> &mtk_pcie_phy_ops);
> +	if (IS_ERR(pcie_phy->phy))
> +		return dev_err_probe(dev, PTR_ERR(pcie_phy->phy),
> +				     "Failed to create PCIe phy\n");
> +
> +	pcie_phy->dev = dev;
> +	pcie_phy->data = of_device_get_match_data(dev);
> +	if (!pcie_phy->data)
> +		return dev_err_probe(dev, -EINVAL, "Failed to get phy
> data\n");
> +
> +	if (pcie_phy->data->sw_efuse_supported) {
> +		/*
> +		 * Failed to read the efuse data is not a fatal
> problem,
> +		 * ignore the failure and keep going.
> +		 */
> +		ret = mtk_pcie_read_efuse(pcie_phy);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;

Hello Jianjun,

even though it's not a fatal problem if we can not read efuse, but I
tink "ret = -ENOMEM" does not mean we can't read it?

Do we need to handle this?

BRs,
Rex
> +	}
> +
> +	phy_set_drvdata(pcie_phy->phy, pcie_phy);
> +
> +	provider = devm_of_phy_provider_register(dev,
> of_phy_simple_xlate);
> +	if (IS_ERR(provider))
> +		return dev_err_probe(dev, PTR_ERR(provider),
> +				     "PCIe phy probe failed\n");
> +
> +	return 0;
> +}
> +
> +static const struct mtk_pcie_phy_data mt8195_data = {
> +	.num_lanes = 2,
> +	.sw_efuse_supported = true,
> +};
> +
> +static const struct of_device_id mtk_pcie_phy_of_match[] = {
> +	{ .compatible = "mediatek,mt8195-pcie-phy", .data =
> &mt8195_data },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mtk_pcie_phy_of_match);
> +
> +static struct platform_driver mtk_pcie_phy_driver = {
> +	.probe	= mtk_pcie_phy_probe,
> +	.driver	= {
> +		.name = "mtk-pcie-phy",
> +		.of_match_table = mtk_pcie_phy_of_match,
> +	},
> +};
> +module_platform_driver(mtk_pcie_phy_driver);
> +
> +MODULE_DESCRIPTION("MediaTek PCIe PHY driver");
> +MODULE_AUTHOR("Jianjun Wang <jianjun.wang@mediatek.com>");
> +MODULE_LICENSE("GPL");

