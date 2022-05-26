Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47850534B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiEZISt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiEZISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:18:44 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C87522F3;
        Thu, 26 May 2022 01:18:37 -0700 (PDT)
X-UUID: 6242339718e84bdbbf3a98f8c8442b08-20220526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:a387b16c-7344-41a6-a128-3ec16ba99505,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:22
X-CID-INFO: VERSION:1.1.5,REQID:a387b16c-7344-41a6-a128-3ec16ba99505,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:22
X-CID-META: VersionHash:2a19b09,CLOUDID:d26253b8-3c45-407b-8f66-25095432a27a,C
        OID:IGNORED,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,IP:ni
        l,URL:0,File:nil,QS:0,BEC:nil
X-UUID: 6242339718e84bdbbf3a98f8c8442b08-20220526
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1243913882; Thu, 26 May 2022 16:18:28 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 26 May 2022 16:18:28 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 26 May 2022 16:18:27 +0800
Message-ID: <521e50539363c50181fa1c0008598a2c1242df1b.camel@mediatek.com>
Subject: Re: [PATCH v2 2/2] iommu: mtk_iommu: Add support for MT6795 Helio
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
Date:   Thu, 26 May 2022 16:18:26 +0800
In-Reply-To: <20220518101849.46804-3-angelogioacchino.delregno@collabora.com>
References: <20220518101849.46804-1-angelogioacchino.delregno@collabora.com>
         <20220518101849.46804-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-18 at 12:18 +0200, AngeloGioacchino Del Regno wrote:
> Add support for the M4Us found in the MT6795 Helio X10 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/iommu/mtk_iommu.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 090cf6e15f85..97ff30ed2d0f 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -159,6 +159,7 @@
>  enum mtk_iommu_plat {
>  	M4U_MT2712,
>  	M4U_MT6779,
> +	M4U_MT6795,
>  	M4U_MT8167,
>  	M4U_MT8173,
>  	M4U_MT8183,
> @@ -954,7 +955,8 @@ static int mtk_iommu_hw_init(const struct
> mtk_iommu_data *data, unsigned int ban
>  	 * Global control settings are in bank0. May re-init these
> global registers
>  	 * since no sure if there is bank0 consumers.
>  	 */
> -	if (data->plat_data->m4u_plat == M4U_MT8173) {
> +	if (data->plat_data->m4u_plat == M4U_MT6795 ||
> +	    data->plat_data->m4u_plat == M4U_MT8173) {

Add a new flag for this. This setting difference is that the offset for
TF_PROT_TO_PROGRAM_ADDR is 5 in mt8173 while the others' offset is 4.
thus, we could rename the flag like TF_PORT_TO_ADDR_MT8173 or
TF_PORT_TO_ADDR_OFFSET_IS_5.

>  		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
>  			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
>  	} else {
> @@ -1422,6 +1424,18 @@ static const struct mtk_iommu_plat_data
> mt6779_data = {
>  	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
>  };
>  
> +static const struct mtk_iommu_plat_data mt6795_data = {
> +	.m4u_plat     = M4U_MT6795,
> +	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
> +			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
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
> @@ -1533,6 +1547,7 @@ static const struct mtk_iommu_plat_data
> mt8195_data_vpp = {
>  static const struct of_device_id mtk_iommu_of_ids[] = {
>  	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
>  	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
> +	{ .compatible = "mediatek,mt6795-m4u", .data = &mt6795_data},
>  	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
>  	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>  	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},

