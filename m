Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD2B55FF80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiF2MO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiF2MON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:14:13 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE521836;
        Wed, 29 Jun 2022 05:14:12 -0700 (PDT)
X-UUID: 04ea8ec84e3046e1a2eaabb63628789a-20220629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:aa8a51b8-981b-4633-8cd5-e6cf88fe35d1,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:90
X-CID-INFO: VERSION:1.1.7,REQID:aa8a51b8-981b-4633-8cd5-e6cf88fe35d1,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:90
X-CID-META: VersionHash:87442a2,CLOUDID:51fef662-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:5f389b0b4db4,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 04ea8ec84e3046e1a2eaabb63628789a-20220629
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1634325734; Wed, 29 Jun 2022 20:14:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 29 Jun 2022 20:14:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 29 Jun 2022 20:14:07 +0800
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
Subject: [PATCH 4/5] arm64: dts: mt8192: Add dsi node
Date:   Wed, 29 Jun 2022 20:13:57 +0800
Message-ID: <20220629121358.19458-5-allen-kh.cheng@mediatek.com>
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

Add dsi ndoe for mt8192 SoC.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 26d01544b4ea..72af328126de 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1334,6 +1334,24 @@
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
 		};
 
+		dsi0: dsi@14010000 {
+			compatible = "mediatek,mt8183-dsi";
+			reg = <0 0x14010000 0 0x1000>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
+			mediatek,syscon-dsi = <&mmsys 0x140>;
+			clocks = <&mmsys CLK_MM_DSI0>,
+				 <&mmsys CLK_MM_DSI_DSI0>,
+				 <&mipi_tx0>;
+			clock-names = "engine", "digital", "hs";
+			phys = <&mipi_tx0>;
+			phy-names = "dphy";
+			status = "disabled";
+
+			port {
+				dsi_out: endpoint { };
+			};
+		};
+
 		ovl_2l2: ovl@14014000 {
 			compatible = "mediatek,mt8192-disp-ovl-2l";
 			reg = <0 0x14014000 0 0x1000>;
-- 
2.18.0

