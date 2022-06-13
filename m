Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5249547F03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiFMFdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiFMFdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:33:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25374E009;
        Sun, 12 Jun 2022 22:33:06 -0700 (PDT)
X-UUID: bd0b444408c644d5bc8d8475048d81a0-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:0658a6c9-37ad-4565-a09e-0e7271fc3390,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:22
X-CID-INFO: VERSION:1.1.5,REQID:0658a6c9-37ad-4565-a09e-0e7271fc3390,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:22
X-CID-META: VersionHash:2a19b09,CLOUDID:324b7d37-84c0-4f9a-9fbd-acd4a0e9ad0f,C
        OID:IGNORED,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,IP:ni
        l,URL:0,File:nil,QS:0,BEC:nil
X-UUID: bd0b444408c644d5bc8d8475048d81a0-20220613
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 410895505; Mon, 13 Jun 2022 13:33:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 13 Jun 2022 13:32:59 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 13 Jun 2022 13:32:58 +0800
Message-ID: <609b356acce95e99718ef7f31fd8cc795bbc72e2.camel@mediatek.com>
Subject: Re: [PATCH v3 3/3] iommu: mtk_iommu: Add support for MT6795 Helio
 X10 M4Us
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <konrad.dybcio@somainline.org>, <marijn.suijten@somainline.org>,
        <martin.botka@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <paul.bouchara@somainline.org>
Date:   Mon, 13 Jun 2022 13:32:57 +0800
In-Reply-To: <20220609104001.97753-4-angelogioacchino.delregno@collabora.com>
References: <20220609104001.97753-1-angelogioacchino.delregno@collabora.com>
         <20220609104001.97753-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-09 at 12:40 +0200, AngeloGioacchino Del Regno wrote:
> Add support for the M4Us found in the MT6795 Helio X10 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Retitle to: iommu/mediatek: Xxx, then

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

> ---
>  drivers/iommu/mtk_iommu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 8611cf8e4bd5..beca1c5a6c10 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -160,6 +160,7 @@
>  enum mtk_iommu_plat {
>  	M4U_MT2712,
>  	M4U_MT6779,
> +	M4U_MT6795,
>  	M4U_MT8167,
>  	M4U_MT8173,
>  	M4U_MT8183,
> @@ -1424,6 +1425,19 @@ static const struct mtk_iommu_plat_data
> mt6779_data = {
>  	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
>  };
>  
> +static const struct mtk_iommu_plat_data mt6795_data = {
> +	.m4u_plat     = M4U_MT6795,
> +	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
> +			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM |
> +			TF_PORT_TO_ADDR_MT8173,
> +	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.banks_num    = 1,
> +	.banks_enable = {true},
> +	.iova_region  = single_domain,
> +	.iova_region_nr = ARRAY_SIZE(single_domain),
> +	.larbid_remap = {{0}, {1}, {2}, {3}, {4}}, /* Linear mapping.
> */
> +};
> +
>  static const struct mtk_iommu_plat_data mt8167_data = {
>  	.m4u_plat     = M4U_MT8167,
>  	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR |
> MTK_IOMMU_TYPE_MM,
> @@ -1536,6 +1550,7 @@ static const struct mtk_iommu_plat_data
> mt8195_data_vpp = {
>  static const struct of_device_id mtk_iommu_of_ids[] = {
>  	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
>  	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
> +	{ .compatible = "mediatek,mt6795-m4u", .data = &mt6795_data},
>  	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
>  	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>  	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},

