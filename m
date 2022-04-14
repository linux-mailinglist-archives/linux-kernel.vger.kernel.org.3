Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761E8501478
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353075AbiDNOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 10:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344006AbiDNNjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:39:33 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0180F8BF43;
        Thu, 14 Apr 2022 06:36:35 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23EDaRD6009825;
        Thu, 14 Apr 2022 08:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649943387;
        bh=MuALufS27IYgRFCVcWUTMGjvsiQ0FveOuIy4CrAFgDw=;
        h=From:To:CC:Subject:Date;
        b=Yhnd6VQ1qFoZzKaZaOQhZB1XEdaKwKaZsSzdMsHHEQ0AOogWYuBLBwS5oqU6SI54c
         PTZeapLtoRnF5E3SNV9BhCzswE/Ra3dPCBR8fSnLTxbYNvzICsUs1g6Ebyysmx1p9l
         /O0T2vdVxLTx6wmC1ZRrIPsUMlTEXST6YNmsUfa0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23EDaRQp007336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Apr 2022 08:36:27 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 14
 Apr 2022 08:36:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 14 Apr 2022 08:36:27 -0500
Received: from swubn03.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23EDaON6056137;
        Thu, 14 Apr 2022 08:36:24 -0500
From:   Aparna M <a-m1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kishon@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <nikhil.nd@ti.com>
Subject: [RESEND PATCH v3] arm64: dts: ti: k3-am642-sk: Enable WLAN connected to SDHCI0
Date:   Thu, 14 Apr 2022 19:06:12 +0530
Message-ID: <20220414133612.13365-1-a-m1@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

WL1837 module is connected to SDHCI0 in AM642 SK. Enable it here.
This will enable the WiFi functionaliy on the board.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Nikhil Devshatwar <nikhil.nd@ti.com>
Signed-off-by: Aparna M <a-m1@ti.com>
---

v3 RESEND: rebased on top of v5.18-rc2
v2 -> v3: Use generic node names for the regulators as per DT Specs
v1 -> v2: Add "From" tag in commit message

 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 1d7db8bf3a5c..59f506cbd275 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -125,6 +125,31 @@
 		vin-supply = <&vcc_3v3_sys>;
 		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
 	};
+
+	com8_ls_en: regulator-1 {
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
+	wlan_en: regulator-2 {
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

