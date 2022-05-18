Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAF452B076
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 04:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiERCVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 22:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiERCVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 22:21:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7512249F82;
        Tue, 17 May 2022 19:21:31 -0700 (PDT)
X-UUID: 24987fdde03547f4a4f61ddc3c3d59c9-20220518
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:9a50530c-7d3f-4e8d-9f52-15af072315cb,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:56
X-CID-INFO: VERSION:1.1.5,REQID:9a50530c-7d3f-4e8d-9f52-15af072315cb,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:56
X-CID-META: VersionHash:2a19b09,CLOUDID:798f8fe2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:82908a5a2e09,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 24987fdde03547f4a4f61ddc3c3d59c9-20220518
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1157843924; Wed, 18 May 2022 10:21:26 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 18 May 2022 10:21:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 May 2022 10:21:25 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 18 May 2022 10:21:23 +0800
Message-ID: <124a48372c1ce0c28433f5c93ba1b4ac222ae9b8.camel@mediatek.com>
Subject: Re: [PATCH v8 2/2] phy: mediatek: Add PCIe PHY driver
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
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
Date:   Wed, 18 May 2022 10:21:20 +0800
In-Reply-To: <8affe58a4952d6c405dd41f18c6a7f40b2313fde.camel@mediatek.com>
References: <20220507060621.32252-1-jianjun.wang@mediatek.com>
         <20220507060621.32252-3-jianjun.wang@mediatek.com>
         <8affe58a4952d6c405dd41f18c6a7f40b2313fde.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 11:22 +0800, Rex-BC Chen wrote:
> On Sat, 2022-05-07 at 14:06 +0800, Jianjun Wang wrote:
> > Add PCIe GEN3 PHY driver support on MediaTek chipsets.
> > 
> > +
> > +static int mtk_pcie_phy_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct phy_provider *provider;
> > +	struct mtk_pcie_phy *pcie_phy;
> > +	int ret;
> > +
> > +	pcie_phy = devm_kzalloc(dev, sizeof(*pcie_phy), GFP_KERNEL);
> > +	if (!pcie_phy)
> > +		return -ENOMEM;
> > +
> > +	pcie_phy->sif_base =
> > devm_platform_ioremap_resource_byname(pdev, "sif");
> > +	if (IS_ERR(pcie_phy->sif_base))
> > +		return dev_err_probe(dev, PTR_ERR(pcie_phy->sif_base),
> > +				     "Failed to map phy-sif base\n");
> > +
> > +	pcie_phy->phy = devm_phy_create(dev, dev->of_node,
> > &mtk_pcie_phy_ops);
> > +	if (IS_ERR(pcie_phy->phy))
> > +		return dev_err_probe(dev, PTR_ERR(pcie_phy->phy),
> > +				     "Failed to create PCIe phy\n");
> > +
> > +	pcie_phy->dev = dev;
> > +	pcie_phy->data = of_device_get_match_data(dev);
> > +	if (!pcie_phy->data)
> > +		return dev_err_probe(dev, -EINVAL, "Failed to get phy
> > data\n");
> > +
> > +	if (pcie_phy->data->sw_efuse_supported) {
> > +		/*
> > +		 * Failed to read the efuse data is not a fatal
> > problem,
> > +		 * ignore the failure and keep going.
> > +		 */
> > +		ret = mtk_pcie_read_efuse(pcie_phy);
> > +		if (ret == -EPROBE_DEFER)
> > +			return ret;
> 
> Hello Jianjun,
> 
> even though it's not a fatal problem if we can not read efuse, but I
> tink "ret = -ENOMEM" does not mean we can't read it?
> 
> Do we need to handle this?

Yes, I think we should handle it in this case, I'll fix it in the next
version, thanks for your review.

Thanks.

> 
> BRs,
> Rex
> > +	}
> > +
> > +	phy_set_drvdata(pcie_phy->phy, pcie_phy);
> > +
> > +	provider = devm_of_phy_provider_register(dev,
> > of_phy_simple_xlate);
> > +	if (IS_ERR(provider))
> > +		return dev_err_probe(dev, PTR_ERR(provider),
> > +				     "PCIe phy probe failed\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mtk_pcie_phy_data mt8195_data = {
> > +	.num_lanes = 2,
> > +	.sw_efuse_supported = true,
> > +};
> > +
> > +static const struct of_device_id mtk_pcie_phy_of_match[] = {
> > +	{ .compatible = "mediatek,mt8195-pcie-phy", .data =
> > &mt8195_data },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_pcie_phy_of_match);
> > +
> > +static struct platform_driver mtk_pcie_phy_driver = {
> > +	.probe	= mtk_pcie_phy_probe,
> > +	.driver	= {
> > +		.name = "mtk-pcie-phy",
> > +		.of_match_table = mtk_pcie_phy_of_match,
> > +	},
> > +};
> > +module_platform_driver(mtk_pcie_phy_driver);
> > +
> > +MODULE_DESCRIPTION("MediaTek PCIe PHY driver");
> > +MODULE_AUTHOR("Jianjun Wang <jianjun.wang@mediatek.com>");
> > +MODULE_LICENSE("GPL");
> 
> 

