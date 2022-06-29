Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41F155FF83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiF2MOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiF2MOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:14:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F599201A5;
        Wed, 29 Jun 2022 05:14:13 -0700 (PDT)
X-UUID: 4c70321ca54c4a47bb6cd45e2445435b-20220629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:f747da34-23f7-483c-bd15-986c90479c71,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.7,REQID:f747da34-23f7-483c-bd15-986c90479c71,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:87442a2,CLOUDID:09981986-57f0-47ca-ba27-fe8c57fbf305,C
        OID:d91d96d255a6,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4c70321ca54c4a47bb6cd45e2445435b-20220629
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 250583227; Wed, 29 Jun 2022 20:14:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 29 Jun 2022 20:14:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 29 Jun 2022 20:14:08 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 5/5] arm64: dts: mt8192: Add vcodec lat and core nodes
Date:   Wed, 29 Jun 2022 20:13:58 +0800
Message-ID: <20220629121358.19458-6-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220629121358.19458-1-allen-kh.cheng@mediatek.com>
References: <20220629121358.19458-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vcodec lat and core nodes for mt8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 72af328126de..a7f58dbe964d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1434,6 +1434,66 @@
 			power-domains = <&spm MT8192_POWER_DOMAIN_ISP2>;
 		};
 
+		vcodec_dec: vcodec-dec@16000000 {
+			compatible = "mediatek,mt8192-vcodec-dec";
+			reg = <0 0x16000000 0 0x1000>;
+			mediatek,scp = <&scp>;
+			iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
+			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0 0 0 0x16000000 0 0x26000>;
+
+			vcodec_lat: vcodec-lat@10000 {
+				compatible = "mediatek,mtk-vcodec-lat";
+				reg = <0x0 0x10000 0 0x800>;
+				interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
+				iommus = <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
+					 <&iommu0 M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
+				clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+					 <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
+					 <&vdecsys_soc CLK_VDEC_SOC_LAT>,
+					 <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
+					 <&topckgen CLK_TOP_MAINPLL_D4>;
+				clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
+				assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
+				assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
+				power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
+			};
+
+			vcodec_core: vcodec-core@25000 {
+				compatible = "mediatek,mtk-vcodec-core";
+				reg = <0 0x25000 0 0x1000>;
+				interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
+				iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_UFO_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_PP_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_PRED_RD_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_PRED_WR_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_PPWRAP_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_TILE_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_VLD_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_VLD2_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_AVC_MV_EXT>,
+					 <&iommu0 M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT>;
+				clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+					 <&vdecsys CLK_VDEC_VDEC>,
+					 <&vdecsys CLK_VDEC_LAT>,
+					 <&vdecsys CLK_VDEC_LARB1>,
+					 <&topckgen CLK_TOP_MAINPLL_D4>;
+				clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
+				assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
+				assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
+				power-domains = <&spm MT8192_POWER_DOMAIN_VDEC2>;
+			};
+		};
+
 		larb5: larb@1600d000 {
 			compatible = "mediatek,mt8192-smi-larb";
 			reg = <0 0x1600d000 0 0x1000>;
-- 
2.18.0

