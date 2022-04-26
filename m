Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70A5101FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352421AbiDZPj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352403AbiDZPjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:39:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EECFD25;
        Tue, 26 Apr 2022 08:36:15 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23QFa2fQ095166;
        Tue, 26 Apr 2022 10:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650987362;
        bh=pE01LlepLn5P9pAdXaezuYxpflC2yPhfl2ruFXlenkk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ay/7sTLlOBJXMWgPOrL+QhhBFsYo5zenazlhExMA2PYV+SqgfzvwPvtukAz4A8+Z7
         Yi8CtKWpTSxCwNIm5YH059uzjP+Vy+677ulV7rsjGEvWRQ6GeWvzuy7xnTDx5yeowS
         sneZSbO9JN8Bf/0Xf5ItqcKOhzAIIi3vXCNKp2D8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23QFa229130816
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Apr 2022 10:36:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 26
 Apr 2022 10:36:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 26 Apr 2022 10:36:01 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23QFa0qR016838;
        Tue, 26 Apr 2022 10:36:01 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <r-ravikumar@ti.com>
Subject: [PATCH v4 2/2] arm64: dts: ti: k3-j721e-common-proc-board: add DP to j7 evm
Date:   Tue, 26 Apr 2022 21:05:53 +0530
Message-ID: <20220426153553.18474-3-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426153553.18474-1-r-ravikumar@ti.com>
References: <20220426153553.18474-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add the endpoint nodes to describe connection from
DSS => MHDP => DisplayPort connector.
Also add the required pinmux nodes for hotplug.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 61 +++++++++++++++++--
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 2f119e94e783..4b9e3f671781 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -148,6 +148,28 @@
 		pinctrl-0 = <&main_mcan2_gpio_pins_default>;
 		standby-gpios = <&main_gpio0 127 GPIO_ACTIVE_HIGH>;
 	};
+
+	dp_pwr_3v3: regulator-dp-prw {
+		compatible = "regulator-fixed";
+		regulator-name = "dp-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&exp4 0 GPIO_ACTIVE_HIGH>; /* P0 - DP0_PWR_SW_EN */
+		enable-active-high;
+	};
+
+	dp0: connector {
+		compatible = "dp-connector";
+		label = "DP0";
+		type = "full-size";
+		dp-pwr-supply = <&dp_pwr_3v3>;
+
+		port {
+			dp_connector_in: endpoint {
+				remote-endpoint = <&dp0_out>;
+			};
+		};
+	};
 };
 
 &main_pmx0 {
@@ -190,6 +212,12 @@
 		>;
 	};
 
+	dp0_pins_default: dp0-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1c4, PIN_INPUT, 5) /* SPI0_CS1.DP0_HPD */
+		>;
+	};
+
 	main_i2c1_exp4_pins_default: main-i2c1-exp4-pins-default {
 		pinctrl-single,pins = <
 			J721E_IOPAD(0x230, PIN_INPUT, 7) /* (U2) ECAP0_IN_APWM_OUT.GPIO1_11 */
@@ -658,6 +686,33 @@
 				 <&k3_clks 152 18>;	/* PLL23_HSDIV0 */
 };
 
+&dss_ports {
+	port {
+		dpi0_out: endpoint {
+			remote-endpoint = <&dp0_in>;
+		};
+	};
+};
+
+&dp0_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@0 {
+		reg = <0>;
+		dp0_in: endpoint {
+			remote-endpoint = <&dpi0_out>;
+		};
+	};
+
+	port@4 {
+		reg = <4>;
+		dp0_out: endpoint {
+			remote-endpoint = <&dp_connector_in>;
+		};
+	};
+};
+
 &mcasp0 {
 	status = "disabled";
 };
@@ -807,6 +862,8 @@
 &mhdp {
 	phys = <&torrent_phy_dp>;
 	phy-names = "dpphy";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp0_pins_default>;
 };
 
 &pcie0_rc {
@@ -859,10 +916,6 @@
 	status = "disabled";
 };
 
-&dss {
-	status = "disabled";
-};
-
 &icssg0_mdio {
 	status = "disabled";
 };
-- 
2.17.1

