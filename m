Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522DE4EDBB6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiCaOcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbiCaOcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:32:42 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424921D97F6;
        Thu, 31 Mar 2022 07:30:54 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22VEUl5u028395;
        Thu, 31 Mar 2022 09:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648737047;
        bh=DTsAXHsLpGJy+LIvYdmkcffjEFLI3/tliy7tyjjkRfk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pmzfz9baJ+yROSPki4tioJZSeuYznepHb9Mh1Uj3ozGAqtVu3MRA7DwIypQjP4xPs
         w5q41iREanAOWZ/bjnXEx8qPeNJtJEusY6EMOobOGFeC+iRGdpOUgC9obeY8C8JXUu
         Nzr4qMRz2sRTKH2R/55Db52WWv1QRkJSmkSELXdE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22VEUlh3001272
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 09:30:47 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 09:30:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 09:30:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22VEUjHg102892;
        Thu, 31 Mar 2022 09:30:46 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <r-ravikumar@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j721e-common-proc-board: add DP to j7 evm
Date:   Thu, 31 Mar 2022 20:00:35 +0530
Message-ID: <20220331143035.16210-3-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220331143035.16210-1-r-ravikumar@ti.com>
References: <20220331143035.16210-1-r-ravikumar@ti.com>
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

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add the endpoint nodes to describe connection from
DSS => MHDP => DisplayPort connector.
Also add the phy link node and required pinmux nodes
for hotplug.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 78 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index f5ca8e26ed99..8ddc0d3bd058 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -148,6 +148,28 @@
 		pinctrl-0 = <&main_mcan2_gpio_pins_default>;
 		standby-gpios = <&main_gpio0 127 GPIO_ACTIVE_HIGH>;
 	};
+
+	dp_pwr_3v3: fixedregulator-dp-prw {
+		compatible = "regulator-fixed";
+		regulator-name = "dp-pwr";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&exp4 0 0>;	/* P0 - DP0_PWR_SW_EN */
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
@@ -658,6 +686,41 @@
 				 <&k3_clks 152 18>;	/* PLL23_HSDIV0 */
 };
 
+&dss_ports {
+	port@0 {
+		reg = <0>;
+		dpi0_out: endpoint {
+			remote-endpoint = <&dp0_in>;
+		};
+	};
+};
+
+&mhdp {
+	phys = <&torrent_phy_dp>;
+	phy-names = "dpphy";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp0_pins_default>;
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
@@ -793,6 +856,17 @@
 	};
 };
 
+&serdes4 {
+	torrent_phy_dp: phy@0 {
+		reg = <0>;
+		resets = <&serdes_wiz4 1>;
+		cdns,phy-type = <PHY_TYPE_DP>;
+		cdns,num-lanes = <4>;
+		cdns,max-bit-rate = <5400>;
+		#phy-cells = <0>;
+	};
+};
+
 &pcie0_rc {
 	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes0_pcie_link>;
@@ -843,10 +917,6 @@
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

