Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB6A5453AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbiFISGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiFISGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:06:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E363207F3;
        Thu,  9 Jun 2022 11:06:10 -0700 (PDT)
X-UUID: ee99b984265c4058ac6cfab810248d3e-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:bfdda56a-d5a8-48be-aa50-547f0f4203a1,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:bfdda56a-d5a8-48be-aa50-547f0f4203a1,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:ec22d47e-c8dc-403a-96e8-6237210dceee,C
        OID:656875a871f0,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:0,File:nil,QS:0,BEC:nil
X-UUID: ee99b984265c4058ac6cfab810248d3e-20220610
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1258525352; Fri, 10 Jun 2022 02:06:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 10 Jun 2022 02:06:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Jun 2022 02:06:05 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <devicetree@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <joro@8bytes.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <will@kernel.org>, <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 3/6] arm64: dts: mediatek: mt8173: Add mediatek,infracfg phandle for IOMMU
Date:   Fri, 10 Jun 2022 02:06:05 +0800
Message-ID: <20220609180605.31142-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220609100802.54513-4-angelogioacchino.delregno@collabora.com>
References: <20220609100802.54513-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The IOMMU driver now looks for the "mediatek,infracfg" phandle as a
> new way to retrieve a syscon to that:
> even though the old way is retained, it has been deprecated and the
> driver will write a message in kmsg advertising to use the phandle
> way instead.
> 
> For this reason, assign the right phandle to mediatek,infracfg in
> the iommu node.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 40d7b47fc52e..825a3c670373 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -588,6 +588,7 @@ iommu: iommu@10205000 {
>  			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
>  			clocks = <&infracfg CLK_INFRA_M4U>;
>  			clock-names = "bclk";
> +			mediatek,infracfg = <&infracfg>;
>  			mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
>  					 <&larb3>, <&larb4>, <&larb5>;
>  			#iommu-cells = <1>;
> -- 
> 2.35.1
> 
> 
