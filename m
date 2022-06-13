Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934D4547EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiFMFcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiFMFcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:32:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDEA1032;
        Sun, 12 Jun 2022 22:32:39 -0700 (PDT)
X-UUID: bc1d8f81d4cc4ad0a682904ebf31f49a-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:ffedf2af-c1b3-4263-9c21-41511bb22f4f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:a05357c6-12ba-4305-bfdf-9aefbdc32516,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: bc1d8f81d4cc4ad0a682904ebf31f49a-20220613
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 814096980; Mon, 13 Jun 2022 13:32:30 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 13 Jun 2022 13:32:29 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 13 Jun 2022 13:32:28 +0800
Message-ID: <aa77b49f5a2bb7fc3e6292225c400c44525536a4.camel@mediatek.com>
Subject: Re: [PATCH v3 2/3] iommu: mtk_iommu: Introduce new flag
 TF_PORT_TO_ADDR_MT8173
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
Date:   Mon, 13 Jun 2022 13:32:28 +0800
In-Reply-To: <20220609104001.97753-3-angelogioacchino.delregno@collabora.com>
References: <20220609104001.97753-1-angelogioacchino.delregno@collabora.com>
         <20220609104001.97753-3-angelogioacchino.delregno@collabora.com>
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
> In preparation for adding support for MT6795, add a new flag named
> TF_PORT_TO_ADDR_MT8173 and use that instead of checking for m4u_plat
> type in mtk_iommu_hw_init() to avoid seeing a long list of m4u_plat
> checks there in the future.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Retitle to: iommu/mediatek: Xxx, then

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

> ---
>  drivers/iommu/mtk_iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 0ea0848581e9..8611cf8e4bd5 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -140,6 +140,7 @@
>  #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
>  /* IOMMU I/O (r/w) is enabled using PERICFG_IOMMU_1 register */
>  #define HAS_PERI_IOMMU1_REG		BIT(17)
> +#define TF_PORT_TO_ADDR_MT8173		BIT(18)
>  
>  #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>  				((((pdata)->flags) & (mask)) == (_x))
> @@ -960,7 +961,7 @@ static int mtk_iommu_hw_init(const struct
> mtk_iommu_data *data, unsigned int ban
>  	 * Global control settings are in bank0. May re-init these
> global registers
>  	 * since no sure if there is bank0 consumers.
>  	 */
> -	if (data->plat_data->m4u_plat == M4U_MT8173) {
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data,
> TF_PORT_TO_ADDR_MT8173)) {
>  		regval = F_MMU_PREFETCH_RT_REPLACE_MOD |
>  			 F_MMU_TF_PROT_TO_PROGRAM_ADDR_MT8173;
>  	} else {
> @@ -1437,7 +1438,8 @@ static const struct mtk_iommu_plat_data
> mt8167_data = {
>  static const struct mtk_iommu_plat_data mt8173_data = {
>  	.m4u_plat     = M4U_MT8173,
>  	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
> -			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM,
> +			HAS_LEGACY_IVRP_PADDR | MTK_IOMMU_TYPE_MM |
> +			TF_PORT_TO_ADDR_MT8173,
>  	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
>  	.banks_num    = 1,
>  	.banks_enable = {true},

