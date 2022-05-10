Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B95214E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbiEJMOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241541AbiEJMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:14:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF60299567;
        Tue, 10 May 2022 05:10:36 -0700 (PDT)
X-UUID: 6e9199e5d31d4d658ece6abf3b3c987f-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:4d3528c5-1e19-4c16-aaad-777b0a8b0531,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:eef1e816-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 6e9199e5d31d4d658ece6abf3b3c987f-20220510
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 440288455; Tue, 10 May 2022 20:10:29 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 10 May 2022 20:10:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 May 2022 20:10:29 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 10 May 2022 20:10:28 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH next v3 1/2] arm64: dts: mediatek: mt8195: add efuse node and cells
Date:   Tue, 10 May 2022 20:10:26 +0800
Message-ID: <20220510121027.19041-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add efuse node and cells used by t-phy to fix the bit shift issue

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3:
  add reviewed-by and tested-by;
  fix duplicated unit-address warning;

NOTE:
  based on v5.18-next/dts64 of matthias.bgg's branch;

v2: no changes, just based on new mt8195.dtsi

---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 55 ++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index b57e620c2c72..d5bc4cf5f4ac 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -691,6 +691,53 @@
 			status = "disabled";
 		};
 
+		efuse: efuse@11c10000 {
+			compatible = "mediatek,mt8195-efuse", "mediatek,efuse";
+			reg = <0 0x11c10000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			u3_tx_imp_p0: usb3-tx-imp@184,1 {
+				reg = <0x184 0x1>;
+				bits = <0 5>;
+			};
+			u3_rx_imp_p0: usb3-rx-imp@184,2 {
+				reg = <0x184 0x2>;
+				bits = <5 5>;
+			};
+			u3_intr_p0: usb3-intr@185 {
+				reg = <0x185 0x1>;
+				bits = <2 6>;
+			};
+			comb_tx_imp_p1: usb3-tx-imp@186,1 {
+				reg = <0x186 0x1>;
+				bits = <0 5>;
+			};
+			comb_rx_imp_p1: usb3-rx-imp@186,2 {
+				reg = <0x186 0x2>;
+				bits = <5 5>;
+			};
+			comb_intr_p1: usb3-intr@187 {
+				reg = <0x187 0x1>;
+				bits = <2 6>;
+			};
+			u2_intr_p0: usb2-intr-p0@188,1 {
+				reg = <0x188 0x1>;
+				bits = <0 5>;
+			};
+			u2_intr_p1: usb2-intr-p1@188,2 {
+				reg = <0x188 0x2>;
+				bits = <5 5>;
+			};
+			u2_intr_p2: usb2-intr-p2@189,1 {
+				reg = <0x189 0x1>;
+				bits = <2 5>;
+			};
+			u2_intr_p3: usb2-intr-p3@189,2 {
+				reg = <0x189 0x2>;
+				bits = <7 5>;
+			};
+		};
+
 		u3phy2: t-phy@11c40000 {
 			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v3";
 			#address-cells = <1>;
@@ -873,6 +920,10 @@
 				clocks = <&apmixedsys CLK_APMIXED_PLL_SSUSB26M>,
 					 <&topckgen CLK_TOP_SSUSB_PHY_P1_REF>;
 				clock-names = "ref", "da_ref";
+				nvmem-cells = <&comb_intr_p1>,
+					      <&comb_rx_imp_p1>,
+					      <&comb_tx_imp_p1>;
+				nvmem-cell-names = "intr", "rx_imp", "tx_imp";
 				#phy-cells = <1>;
 			};
 		};
@@ -897,6 +948,10 @@
 				clocks = <&apmixedsys CLK_APMIXED_PLL_SSUSB26M>,
 					 <&topckgen CLK_TOP_SSUSB_PHY_REF>;
 				clock-names = "ref", "da_ref";
+				nvmem-cells = <&u3_intr_p0>,
+					      <&u3_rx_imp_p0>,
+					      <&u3_tx_imp_p0>;
+				nvmem-cell-names = "intr", "rx_imp", "tx_imp";
 				#phy-cells = <1>;
 			};
 		};
-- 
2.18.0

