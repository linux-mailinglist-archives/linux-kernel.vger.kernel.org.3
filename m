Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC36E4C0E81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbiBWIvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbiBWIu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:50:58 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46F079C70;
        Wed, 23 Feb 2022 00:50:30 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21N8oPY7076115;
        Wed, 23 Feb 2022 02:50:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645606225;
        bh=6CIkt/hlkAwW03RCFxZHbRpIUvcGICDjdJbyN3FRFrM=;
        h=From:To:CC:Subject:Date;
        b=FEJKTtcJlTcVHSJTSh6ZicVjayJoiV9pgWhohPylOGsg0bcWdGCHnGUHqfjtKt3+X
         KBkaN7hrfUq1Khied9SoR3aH5U8Dhqko11u7mEKa6mhV3Y368KSFy4oc/Ic2ppaRdV
         zozkz5iUGEqexrPqjlUuFBuX0jqlycETcsx8Ti34=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21N8oPoT048788
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 02:50:25 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 02:50:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 02:50:24 -0600
Received: from swubn03.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21N8oKm5067262;
        Wed, 23 Feb 2022 02:50:21 -0600
From:   Aparna M <a-m1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <nikhil.nd@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am642-sk: Enable WLAN connected to SDHCI0
Date:   Wed, 23 Feb 2022 14:20:18 +0530
Message-ID: <20220223085018.29283-1-a-m1@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WL1837 module is connected to SDHCI0 in AM642 SK. Enable it here.
This will enable the WiFi functionaliy on the board.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
Signed-off-by: Aparna M <a-m1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 6b04745147be..1178bb982f05 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -125,6 +125,31 @@
 		vin-supply = <&vcc_3v3_sys>;
 		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
 	};
+
+	com8_ls_en: fixed-regulator-com8 {
+		compatible = "regulator-fixed";
+		regulator-name = "com8_ls_en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		pinctrl-0 = <&main_com8_ls_en_pins_default>;
+		pinctrl-names = "default";
+		gpio = <&main_gpio0 62 GPIO_ACTIVE_LOW>;
+	};
+
+	wlan_en: fixed-regulator-wlan {
+		/* output of SN74AVC4T245RSVR */
+		compatible = "regulator-fixed";
+		regulator-name = "wlan_en";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		pinctrl-0 = <&main_wlan_en_pins_default>;
+		pinctrl-names = "default";
+		vin-supply = <&com8_ls_en>;
+		gpio = <&main_gpio0 48 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &main_pmx0 {
@@ -216,6 +241,23 @@
 			AM64X_IOPAD(0x0270, PIN_INPUT, 0) /* (D18) ECAP0_IN_APWM_OUT */
 		>;
 	};
+	main_wlan_en_pins_default: main-wlan-en-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00c4, PIN_OUTPUT_PULLUP, 7) /* (V8) GPIO0_48 */
+		>;
+	};
+
+	main_com8_ls_en_pins_default: main-com8-ls-en-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00fc, PIN_OUTPUT, 7) /* (U7) PRG1_PRU0_GPO17.GPIO0_62 */
+		>;
+	};
+
+	main_wlan_pins_default: main-wlan-pins-default {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x00bc, PIN_INPUT, 7) /* (U8) GPIO0_46 */
+		>;
+	};
 };
 
 &mcu_uart0 {
@@ -293,6 +335,26 @@
 	status = "reserved";
 };
 
+&sdhci0 {
+	vmmc-supply = <&wlan_en>;
+	bus-width = <4>;
+	non-removable;
+	cap-power-off-card;
+	keep-power-in-suspend;
+	ti,driver-strength-ohm = <50>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1837";
+		reg = <2>;
+		pinctrl-0 = <&main_wlan_pins_default>;
+		pinctrl-names = "default";
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <46 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
 &sdhci1 {
 	/* SD/MMC */
 	vmmc-supply = <&vdd_mmc1>;
-- 
2.17.1

