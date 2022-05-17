Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D43529D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbiEQJLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiEQJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:10:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F864B86B;
        Tue, 17 May 2022 02:08:35 -0700 (PDT)
X-UUID: 6c43586b3ad74e128767874098025e85-20220517
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:b90e6212-ccee-45e0-aae1-e7356ee88c09,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:772c7ae2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 6c43586b3ad74e128767874098025e85-20220517
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 437650018; Tue, 17 May 2022 17:08:30 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 17 May 2022 17:08:28 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 17 May 2022 17:08:27 +0800
Message-ID: <38e38006662b52631a2145228444b9d70f9eb2c6.camel@mediatek.com>
Subject: Re: [PATCH 2/2] iommu: mtk_iommu: Add support for MT6795 Helio X10
 M4Us
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
        <phone-devel@vger.kernel.org>, <paul.bouchara@somainline.org>,
        <yf.wang@mediatek.com>, <mingyuan.ma@mediatek.com>
Date:   Tue, 17 May 2022 17:08:26 +0800
In-Reply-To: <20220513151411.395744-3-angelogioacchino.delregno@collabora.com>
References: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
         <20220513151411.395744-3-angelogioacchino.delregno@collabora.com>
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

On Fri, 2022-05-13 at 17:14 +0200, AngeloGioacchino Del Regno wrote:
> Add support for the M4Us found in the MT6795 Helio X10 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/iommu/mtk_iommu.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 71b2ace74cd6..3d802dd3f377 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -157,6 +157,7 @@
>  enum mtk_iommu_plat {
>  	M4U_MT2712,
>  	M4U_MT6779,
> +	M4U_MT6795,
>  	M4U_MT8167,
>  	M4U_MT8173,
>  	M4U_MT8183,
> @@ -953,7 +954,8 @@ static int mtk_iommu_hw_init(const struct
> mtk_iommu_data *data, unsigned int ban
>  	 * Global control settings are in bank0. May re-init these
> global registers
>  	 * since no sure if there is bank0 consumers.
>  	 */
> -	if (data->plat_data->m4u_plat == M4U_MT8173) {
> +	if (data->plat_data->m4u_plat == M4U_MT6795 ||
> +	    data->plat_data->m4u_plat == M4U_MT8173) {
>  		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
>  			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
>  	} else {
> @@ -1138,6 +1140,9 @@ static int mtk_iommu_probe(struct
> platform_device *pdev)
>  		case M4U_MT2712:
>  			p = "mediatek,mt2712-infracfg";
>  			break;
> +		case M4U_MT6795:
> +			p = "mediatek,mt6795-infracfg";
> +			break;
>  		case M4U_MT8173:
>  			p = "mediatek,mt8173-infracfg";
>  			break;
> @@ -1404,6 +1409,18 @@ static const struct mtk_iommu_plat_data
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

This is nearly same with mt8173_data. mt8173 has one more larb than
mt6795, its larbid_remap is also ok for mt6795.

thus it looks we could use mt8173 as the backward compatible.
    compatible = "mediatek,mt6795-m4u",
                 "mediatek,mt8173-m4u";

After this, the only thing is about "mediatek,mt6795-infracfg". we have
to try again with mediatek,mt6795-infracfg after mediatek,mt8173-
infracfg fail. I think we should allow the backward case in 4GB mode
judgment if we have.

What's your opinion? or some other suggestion?
Thanks.

> +
>  static const struct mtk_iommu_plat_data mt8167_data = {
>  	.m4u_plat     = M4U_MT8167,
>  	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR |
> MTK_IOMMU_TYPE_MM,
> @@ -1515,6 +1532,7 @@ static const struct mtk_iommu_plat_data
> mt8195_data_vpp = {
>  static const struct of_device_id mtk_iommu_of_ids[] = {
>  	{ .compatible = "mediatek,mt2712-m4u", .data = &mt2712_data},
>  	{ .compatible = "mediatek,mt6779-m4u", .data = &mt6779_data},
> +	{ .compatible = "mediatek,mt6795-m4u", .data = &mt6795_data},
>  	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
>  	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>  	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},

