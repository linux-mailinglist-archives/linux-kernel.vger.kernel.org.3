Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15306562F83
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiGAJGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiGAJGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:06:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149C114E;
        Fri,  1 Jul 2022 02:06:03 -0700 (PDT)
X-UUID: 7bf54f5d3122414ab72b5d34e9d28e84-20220701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:af400ecc-fc78-4c3f-8811-04654e690bbd,OB:0,LO
        B:20,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:90
X-CID-INFO: VERSION:1.1.7,REQID:af400ecc-fc78-4c3f-8811-04654e690bbd,OB:0,LOB:
        20,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:90
X-CID-META: VersionHash:87442a2,CLOUDID:17e559d6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:241272e3c83d,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7bf54f5d3122414ab72b5d34e9d28e84-20220701
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 559337415; Fri, 01 Jul 2022 17:05:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 1 Jul 2022 17:05:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 1 Jul 2022 17:05:53 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 6/6] arm64: dts: mt8192: Add vcodec lat and core nodes
Date:   Fri, 1 Jul 2022 17:05:47 +0800
Message-ID: <20220701090547.21429-7-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220701090547.21429-1-allen-kh.cheng@mediatek.com>
References: <20220701090547.21429-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vcodec lat and core nodes for mt8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 6d9164b47bd1..2a1ad3084a01 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1437,6 +1437,66 @@
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

