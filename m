Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB75A9827
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiIANLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiIANLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:11:11 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920825F50;
        Thu,  1 Sep 2022 06:06:04 -0700 (PDT)
X-UUID: 9e3a0af748b64ffba4c6e809486fd1ff-20220901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9qzHLV2C1qM7HQeRv+rphvEHCRtfLmuNYiUYd4EBH0I=;
        b=PrBlLy/V8BbN0qluDCdU2j62GQHeffIk/xKnIDW7hExwJqwDZptBzxi2rwDHp9hIPag3f+XjgJfK8uTLdL8ZSue72RF1TIWI11rbpyBUPx7zKnszAczotsHsjT3/+XWiV9JcX6yRbUTRjZI3F49tv93IrXSQk7AdlhUstr8aMpo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:927f338f-7fab-4e8a-a992-4d1cd4017020,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.10,REQID:927f338f-7fab-4e8a-a992-4d1cd4017020,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:100
X-CID-META: VersionHash:84eae18,CLOUDID:0553d420-1c20-48a5-82a0-25f9c331906d,C
        OID:ce31018120e2,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9e3a0af748b64ffba4c6e809486fd1ff-20220901
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chui-hao.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 961441172; Thu, 01 Sep 2022 21:05:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Sep 2022 21:05:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 1 Sep 2022 21:05:57 +0800
From:   Peter Chiu <chui-hao.chiu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, Ryder Lee <ryder.Lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v5] arm64: dts: mt7986: add built-in Wi-Fi device nodes
Date:   Thu, 1 Sep 2022 21:05:52 +0800
Message-ID: <20220901130552.26234-1-chui-hao.chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

This enables built-in 802.11ax Wi-Fi support.

Reviewed-by: Sam Shih <sam.shih@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>

---
v2: add clocks and clock-names.
v3: rename wmac to wifi and change underscores to dash in node names.
v4: rebase to the latest codebase.
v5: remove useless pins in wf_dbdc_pins node.
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 38 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 23 +++++++++++
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 40 ++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index 882277a52b69..afe37b702eef 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -115,6 +115,13 @@
 	status = "okay";
 };
 
+&wifi {
+	status = "okay";
+	pinctrl-names = "default", "dbdc";
+	pinctrl-0 = <&wf_2g_5g_pins>;
+	pinctrl-1 = <&wf_dbdc_pins>;
+};
+
 &pio {
 	uart1_pins: uart1-pins {
 		mux {
@@ -129,4 +136,35 @@
 			groups = "uart2";
 		};
 	};
+
+	wf_2g_5g_pins: wf-2g-5g-pins {
+		mux {
+			function = "wifi";
+			groups = "wf_2g", "wf_5g";
+		};
+		conf {
+			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
+			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
+			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
+			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
+			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
+			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
+			       "WF1_TOP_CLK", "WF1_TOP_DATA";
+			drive-strength = <4>;
+		};
+	};
+
+	wf_dbdc_pins: wf-dbdc-pins {
+		mux {
+			function = "wifi";
+			groups = "wf_dbdc";
+		};
+		conf {
+			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
+			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
+			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
+			       "WF0_TOP_CLK", "WF0_TOP_DATA";
+			drive-strength = <4>;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index e3a407d03551..890ded0efc51 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mt7986-clk.h>
+#include <dt-bindings/reset/mt7986-resets.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -70,6 +71,11 @@
 			reg = <0 0x43000000 0 0x30000>;
 			no-map;
 		};
+
+		wmcpu_emi: wmcpu-reserved@4fc00000 {
+			no-map;
+			reg = <0 0x4fc00000 0 0x00100000>;
+		};
 	};
 
 	timer {
@@ -261,6 +267,23 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		wifi: wifi@18000000 {
+			compatible = "mediatek,mt7986-wmac";
+			resets = <&watchdog MT7986_TOPRGU_CONSYS_SW_RST>;
+			reset-names = "consys";
+			clocks = <&topckgen CLK_TOP_CONN_MCUSYS_SEL>,
+				 <&topckgen CLK_TOP_AP2CNN_HOST_SEL>;
+			clock-names = "mcu", "ap2conn";
+			reg = <0 0x18000000 0 0x1000000>,
+			      <0 0x10003000 0 0x1000>,
+			      <0 0x11d10000 0 0x1000>;
+			interrupts = <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
+			memory-region = <&wmcpu_emi>;
+		};
 	};
 
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index 0f49d5764ff3..3443013b5971 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -98,3 +98,43 @@
 		};
 	};
 };
+
+&wifi {
+	status = "okay";
+	pinctrl-names = "default", "dbdc";
+	pinctrl-0 = <&wf_2g_5g_pins>;
+	pinctrl-1 = <&wf_dbdc_pins>;
+};
+
+&pio {
+	wf_2g_5g_pins: wf-2g-5g-pins {
+		mux {
+			function = "wifi";
+			groups = "wf_2g", "wf_5g";
+		};
+		conf {
+			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
+			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
+			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
+			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
+			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
+			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
+			       "WF1_TOP_CLK", "WF1_TOP_DATA";
+			drive-strength = <4>;
+		};
+	};
+
+	wf_dbdc_pins: wf-dbdc-pins {
+		mux {
+			function = "wifi";
+			groups = "wf_dbdc";
+		};
+		conf {
+			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
+			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
+			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
+			       "WF0_TOP_CLK", "WF0_TOP_DATA";
+			drive-strength = <4>;
+		};
+	};
+};
-- 
2.18.0

