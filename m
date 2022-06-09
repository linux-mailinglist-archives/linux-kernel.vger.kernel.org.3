Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E8E5453B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245264AbiFISJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbiFISIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:08:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB41E39C120;
        Thu,  9 Jun 2022 11:08:50 -0700 (PDT)
X-UUID: 0f46fe5d8de7409e94190e6eefd88765-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:a195b405-18dd-4bd5-a4ed-49db4cfc5322,OB:10,L
        OB:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:a195b405-18dd-4bd5-a4ed-49db4cfc5322,OB:10,LOB
        :20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:b82cd47e-c8dc-403a-96e8-6237210dceee,C
        OID:0599961d4d23,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:0,File:nil,QS:0,BEC:nil
X-UUID: 0f46fe5d8de7409e94190e6eefd88765-20220610
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 512735973; Fri, 10 Jun 2022 02:08:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 10 Jun 2022 02:08:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Jun 2022 02:08:45 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <devicetree@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <joro@8bytes.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <will@kernel.org>, <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: mediatek: mt2712e: Add mediatek,infracfg phandle for IOMMU
Date:   Fri, 10 Jun 2022 02:08:45 +0800
Message-ID: <20220609180845.31195-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220609100802.54513-5-angelogioacchino.delregno@collabora.com>
References: <20220609100802.54513-5-angelogioacchino.delregno@collabora.com>
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
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index 623eb3beabf2..4797537cb368 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -329,6 +329,7 @@ iommu0: iommu@10205000 {
>  		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_LOW>;
>  		clocks = <&infracfg CLK_INFRA_M4U>;
>  		clock-names = "bclk";
> +		mediatek,infracfg = <&infracfg>;
>  		mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
>  				 <&larb3>, <&larb6>;
>  		#iommu-cells = <1>;
> @@ -346,6 +347,7 @@ iommu1: iommu@1020a000 {
>  		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW>;
>  		clocks = <&infracfg CLK_INFRA_M4U>;
>  		clock-names = "bclk";
> +		mediatek,infracfg = <&infracfg>;
>  		mediatek,larbs = <&larb4>, <&larb5>, <&larb7>;
>  		#iommu-cells = <1>;
>  	};
> -- 
> 2.35.1
> 
> 
