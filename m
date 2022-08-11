Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9C458F634
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 05:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiHKC7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbiHKC63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:58:29 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FD388DF6;
        Wed, 10 Aug 2022 19:58:26 -0700 (PDT)
X-UUID: 9df42101fb36466d9dc59996463daf50-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SdSvl08QBY24eCCXtUMIqOHU5q/Sxwjp4vGfwhwWU8o=;
        b=sd22/oerpZK8UVNsT1zPaIu73JFCd8vyP8bwHIbJt/gNXUgG6laFANMUxZqeaVdljSIugUQK4SqWZFCIMUcaMrVKKOCmKnRDEzFOEgUHoTqMOtDjLedqsLVnxwByGXiCa+oycfFkXaJxiM/Ypf0Wz3+Cy4DC511hwBI4MVEwAYQ=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:a12b945f-109f-43d1-ad97-610cc5c77ba2,OB:0,LO
        B:30,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:105
X-CID-INFO: VERSION:1.1.9,REQID:a12b945f-109f-43d1-ad97-610cc5c77ba2,OB:0,LOB:
        30,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:105
X-CID-META: VersionHash:3d8acc9,CLOUDID:ff99fafc-9e71-4a0f-ba6b-417998daea35,C
        OID:06ccca463c45,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9df42101fb36466d9dc59996463daf50-20220811
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 579568239; Thu, 11 Aug 2022 10:58:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 10:58:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Aug 2022 10:58:16 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
CC:     <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v6 12/20] arm64: dts: mt8195: Add power domains controller
Date:   Thu, 11 Aug 2022 10:58:05 +0800
Message-ID: <20220811025813.21492-13-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220811025813.21492-1-tinghan.shen@mediatek.com>
References: <20220811025813.21492-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains controller node for mt8195.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 326 +++++++++++++++++++++++
 1 file changed, 326 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 8d59a7da32714..7e77aecb1296e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
+#include <dt-bindings/power/mt8195-power.h>
 
 / {
 	compatible = "mediatek,mt8195";
@@ -338,6 +339,331 @@
 			#interrupt-cells = <2>;
 		};
 
+		scpsys: syscon@10006000 {
+			compatible = "mediatek,mt8195-scpsys", "syscon", "simple-mfd";
+			reg = <0 0x10006000 0 0x1000>;
+
+			/* System Power Manager */
+			spm: power-controller {
+				compatible = "mediatek,mt8195-power-controller";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#power-domain-cells = <1>;
+
+				/* power domain of the SoC */
+				mfg0: power-domain@MT8195_POWER_DOMAIN_MFG0 {
+					reg = <MT8195_POWER_DOMAIN_MFG0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8195_POWER_DOMAIN_MFG1 {
+						reg = <MT8195_POWER_DOMAIN_MFG1>;
+						clocks = <&apmixedsys CLK_APMIXED_MFGPLL>;
+						clock-names = "mfg";
+						mediatek,infracfg = <&infracfg_ao>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8195_POWER_DOMAIN_MFG2 {
+							reg = <MT8195_POWER_DOMAIN_MFG2>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_MFG3 {
+							reg = <MT8195_POWER_DOMAIN_MFG3>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_MFG4 {
+							reg = <MT8195_POWER_DOMAIN_MFG4>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_MFG5 {
+							reg = <MT8195_POWER_DOMAIN_MFG5>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_MFG6 {
+							reg = <MT8195_POWER_DOMAIN_MFG6>;
+							#power-domain-cells = <0>;
+						};
+					};
+				};
+
+				power-domain@MT8195_POWER_DOMAIN_VPPSYS0 {
+					reg = <MT8195_POWER_DOMAIN_VPPSYS0>;
+					clocks = <&topckgen CLK_TOP_VPP>,
+						 <&topckgen CLK_TOP_CAM>,
+						 <&topckgen CLK_TOP_CCU>,
+						 <&topckgen CLK_TOP_IMG>,
+						 <&topckgen CLK_TOP_VENC>,
+						 <&topckgen CLK_TOP_VDEC>,
+						 <&topckgen CLK_TOP_WPE_VPP>,
+						 <&topckgen CLK_TOP_CFG_VPP0>,
+						 <&vppsys0 CLK_VPP0_SMI_COMMON>,
+						 <&vppsys0 CLK_VPP0_GALS_VDO0_LARB0>,
+						 <&vppsys0 CLK_VPP0_GALS_VDO0_LARB1>,
+						 <&vppsys0 CLK_VPP0_GALS_VENCSYS>,
+						 <&vppsys0 CLK_VPP0_GALS_VENCSYS_CORE1>,
+						 <&vppsys0 CLK_VPP0_GALS_INFRA>,
+						 <&vppsys0 CLK_VPP0_GALS_CAMSYS>,
+						 <&vppsys0 CLK_VPP0_GALS_VPP1_LARB5>,
+						 <&vppsys0 CLK_VPP0_GALS_VPP1_LARB6>,
+						 <&vppsys0 CLK_VPP0_SMI_REORDER>,
+						 <&vppsys0 CLK_VPP0_SMI_IOMMU>,
+						 <&vppsys0 CLK_VPP0_GALS_IMGSYS_CAMSYS>,
+						 <&vppsys0 CLK_VPP0_GALS_EMI0_EMI1>,
+						 <&vppsys0 CLK_VPP0_SMI_SUB_COMMON_REORDER>,
+						 <&vppsys0 CLK_VPP0_SMI_RSI>,
+						 <&vppsys0 CLK_VPP0_SMI_COMMON_LARB4>,
+						 <&vppsys0 CLK_VPP0_GALS_VDEC_VDEC_CORE1>,
+						 <&vppsys0 CLK_VPP0_GALS_VPP1_WPE>,
+						 <&vppsys0 CLK_VPP0_GALS_VDO0_VDO1_VENCSYS_CORE1>;
+					clock-names = "vppsys", "vppsys1", "vppsys2", "vppsys3",
+						      "vppsys4", "vppsys5", "vppsys6", "vppsys7",
+						      "vppsys0-0", "vppsys0-1", "vppsys0-2", "vppsys0-3",
+						      "vppsys0-4", "vppsys0-5", "vppsys0-6", "vppsys0-7",
+						      "vppsys0-8", "vppsys0-9", "vppsys0-10", "vppsys0-11",
+						      "vppsys0-12", "vppsys0-13", "vppsys0-14",
+						      "vppsys0-15", "vppsys0-16", "vppsys0-17",
+						      "vppsys0-18";
+					mediatek,infracfg = <&infracfg_ao>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8195_POWER_DOMAIN_VDEC1 {
+						reg = <MT8195_POWER_DOMAIN_VDEC1>;
+						clocks = <&vdecsys CLK_VDEC_LARB1>;
+						clock-names = "vdec1-0";
+						mediatek,infracfg = <&infracfg_ao>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8195_POWER_DOMAIN_VENC_CORE1 {
+						reg = <MT8195_POWER_DOMAIN_VENC_CORE1>;
+						mediatek,infracfg = <&infracfg_ao>;
+						#power-domain-cells = <0>;
+					};
+
+					power-domain@MT8195_POWER_DOMAIN_VDOSYS0 {
+						reg = <MT8195_POWER_DOMAIN_VDOSYS0>;
+						clocks = <&topckgen CLK_TOP_CFG_VDO0>,
+							 <&vdosys0 CLK_VDO0_SMI_GALS>,
+							 <&vdosys0 CLK_VDO0_SMI_COMMON>,
+							 <&vdosys0 CLK_VDO0_SMI_EMI>,
+							 <&vdosys0 CLK_VDO0_SMI_IOMMU>,
+							 <&vdosys0 CLK_VDO0_SMI_LARB>,
+							 <&vdosys0 CLK_VDO0_SMI_RSI>;
+						clock-names = "vdosys0", "vdosys0-0", "vdosys0-1",
+							      "vdosys0-2", "vdosys0-3",
+							      "vdosys0-4", "vdosys0-5";
+						mediatek,infracfg = <&infracfg_ao>;
+						#address-cells = <1>;
+						#size-cells = <0>;
+						#power-domain-cells = <1>;
+
+						power-domain@MT8195_POWER_DOMAIN_VPPSYS1 {
+							reg = <MT8195_POWER_DOMAIN_VPPSYS1>;
+							clocks = <&topckgen CLK_TOP_CFG_VPP1>,
+								 <&vppsys1 CLK_VPP1_VPPSYS1_GALS>,
+								 <&vppsys1 CLK_VPP1_VPPSYS1_LARB>;
+							clock-names = "vppsys1", "vppsys1-0",
+								      "vppsys1-1";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_WPESYS {
+							reg = <MT8195_POWER_DOMAIN_WPESYS>;
+							clocks = <&wpesys CLK_WPE_SMI_LARB7>,
+								 <&wpesys CLK_WPE_SMI_LARB8>,
+								 <&wpesys CLK_WPE_SMI_LARB7_P>,
+								 <&wpesys CLK_WPE_SMI_LARB8_P>;
+							clock-names = "wepsys-0", "wepsys-1", "wepsys-2",
+								      "wepsys-3";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_VDEC0 {
+							reg = <MT8195_POWER_DOMAIN_VDEC0>;
+							clocks = <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
+							clock-names = "vdec0-0";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_VDEC2 {
+							reg = <MT8195_POWER_DOMAIN_VDEC2>;
+							clocks = <&vdecsys_core1 CLK_VDEC_CORE1_LARB1>;
+							clock-names = "vdec2-0";
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_VENC {
+							reg = <MT8195_POWER_DOMAIN_VENC>;
+							mediatek,infracfg = <&infracfg_ao>;
+							#power-domain-cells = <0>;
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_VDOSYS1 {
+							reg = <MT8195_POWER_DOMAIN_VDOSYS1>;
+							clocks = <&topckgen CLK_TOP_CFG_VDO1>,
+								 <&vdosys1 CLK_VDO1_SMI_LARB2>,
+								 <&vdosys1 CLK_VDO1_SMI_LARB3>,
+								 <&vdosys1 CLK_VDO1_GALS>;
+							clock-names = "vdosys1", "vdosys1-0",
+								      "vdosys1-1", "vdosys1-2";
+							mediatek,infracfg = <&infracfg_ao>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#power-domain-cells = <1>;
+
+							power-domain@MT8195_POWER_DOMAIN_DP_TX {
+								reg = <MT8195_POWER_DOMAIN_DP_TX>;
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
+
+							power-domain@MT8195_POWER_DOMAIN_EPD_TX {
+								reg = <MT8195_POWER_DOMAIN_EPD_TX>;
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
+
+							power-domain@MT8195_POWER_DOMAIN_HDMI_TX {
+								reg = <MT8195_POWER_DOMAIN_HDMI_TX>;
+								clocks = <&topckgen CLK_TOP_HDMI_APB>;
+								clock-names = "hdmi_tx";
+								#power-domain-cells = <0>;
+							};
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_IMG {
+							reg = <MT8195_POWER_DOMAIN_IMG>;
+							clocks = <&imgsys CLK_IMG_LARB9>,
+								 <&imgsys CLK_IMG_GALS>;
+							clock-names = "img-0", "img-1";
+							mediatek,infracfg = <&infracfg_ao>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#power-domain-cells = <1>;
+
+							power-domain@MT8195_POWER_DOMAIN_DIP {
+								reg = <MT8195_POWER_DOMAIN_DIP>;
+								#power-domain-cells = <0>;
+							};
+
+							power-domain@MT8195_POWER_DOMAIN_IPE {
+								reg = <MT8195_POWER_DOMAIN_IPE>;
+								clocks = <&topckgen CLK_TOP_IPE>,
+									 <&imgsys CLK_IMG_IPE>,
+									 <&ipesys CLK_IPE_SMI_LARB12>;
+								clock-names = "ipe", "ipe-0", "ipe-1";
+								mediatek,infracfg = <&infracfg_ao>;
+								#power-domain-cells = <0>;
+							};
+						};
+
+						power-domain@MT8195_POWER_DOMAIN_CAM {
+							reg = <MT8195_POWER_DOMAIN_CAM>;
+							clocks = <&camsys CLK_CAM_LARB13>,
+								 <&camsys CLK_CAM_LARB14>,
+								 <&camsys CLK_CAM_CAM2MM0_GALS>,
+								 <&camsys CLK_CAM_CAM2MM1_GALS>,
+								 <&camsys CLK_CAM_CAM2SYS_GALS>;
+							clock-names = "cam-0", "cam-1", "cam-2", "cam-3",
+								      "cam-4";
+							mediatek,infracfg = <&infracfg_ao>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#power-domain-cells = <1>;
+
+							power-domain@MT8195_POWER_DOMAIN_CAM_RAWA {
+								reg = <MT8195_POWER_DOMAIN_CAM_RAWA>;
+								#power-domain-cells = <0>;
+							};
+
+							power-domain@MT8195_POWER_DOMAIN_CAM_RAWB {
+								reg = <MT8195_POWER_DOMAIN_CAM_RAWB>;
+								#power-domain-cells = <0>;
+							};
+
+							power-domain@MT8195_POWER_DOMAIN_CAM_MRAW {
+								reg = <MT8195_POWER_DOMAIN_CAM_MRAW>;
+								#power-domain-cells = <0>;
+							};
+						};
+					};
+				};
+
+				power-domain@MT8195_POWER_DOMAIN_PCIE_MAC_P0 {
+					reg = <MT8195_POWER_DOMAIN_PCIE_MAC_P0>;
+					mediatek,infracfg = <&infracfg_ao>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8195_POWER_DOMAIN_PCIE_MAC_P1 {
+					reg = <MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
+					mediatek,infracfg = <&infracfg_ao>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8195_POWER_DOMAIN_PCIE_PHY {
+					reg = <MT8195_POWER_DOMAIN_PCIE_PHY>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY {
+					reg = <MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY>;
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8195_POWER_DOMAIN_CSI_RX_TOP {
+					reg = <MT8195_POWER_DOMAIN_CSI_RX_TOP>;
+					clocks = <&topckgen CLK_TOP_SENINF>,
+						 <&topckgen CLK_TOP_SENINF2>;
+					clock-names = "csi_rx_top", "csi_rx_top1";
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8195_POWER_DOMAIN_ETHER {
+					reg = <MT8195_POWER_DOMAIN_ETHER>;
+					clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET_MAC>;
+					clock-names = "ether";
+					#power-domain-cells = <0>;
+				};
+
+				power-domain@MT8195_POWER_DOMAIN_ADSP {
+					reg = <MT8195_POWER_DOMAIN_ADSP>;
+					clocks = <&topckgen CLK_TOP_ADSP>,
+						 <&topckgen CLK_TOP_AUDIO_LOCAL_BUS>;
+					clock-names = "adsp", "adsp1";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					mediatek,infracfg = <&infracfg_ao>;
+					#power-domain-cells = <1>;
+
+					power-domain@MT8195_POWER_DOMAIN_AUDIO {
+						reg = <MT8195_POWER_DOMAIN_AUDIO>;
+						clocks = <&topckgen CLK_TOP_A1SYS_HP>,
+							 <&topckgen CLK_TOP_AUD_INTBUS>,
+							 <&topckgen CLK_TOP_AUDIO_LOCAL_BUS>,
+							 <&infracfg_ao CLK_INFRA_AO_AUDIO_26M_B>;
+						clock-names = "audio", "audio1", "audio2",
+							      "audio3";
+						mediatek,infracfg = <&infracfg_ao>;
+						#power-domain-cells = <0>;
+					};
+				};
+			};
+		};
+
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8195-wdt",
 				     "mediatek,mt6589-wdt";
-- 
2.18.0

