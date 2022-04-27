Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4D512057
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbiD0P4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbiD0P4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:56:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D830E5B8AC;
        Wed, 27 Apr 2022 08:52:47 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23RFqeGZ059667;
        Wed, 27 Apr 2022 10:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651074760;
        bh=iQNR/J2TTO4CXprgVUyWcFOqEc9DDh1c8RUauqT+Jcs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TJeN4mxqfRUWMiwVSogSPUjZ7Fs7E/6PomW6RzxTdIy3NwaRa4jIq1cok0tFBDk8G
         5LpHhujgBww6MorDwI6w40bBn3J5j1OX+2OPNwE8mvPiz7+Tnev8wjc2KWCmahKM0C
         Q8UgLXg2jIE7WKwhlpyrglwuamWSBADDcGoZLDow=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23RFqeZ0085305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 10:52:40 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 10:52:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 10:52:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23RFqc9Q013951;
        Wed, 27 Apr 2022 10:52:39 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <r-ravikumar@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-j721e-sk: Enable HDMI
Date:   Wed, 27 Apr 2022 21:22:32 +0530
Message-ID: <20220427155232.10659-3-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427155232.10659-1-r-ravikumar@ti.com>
References: <20220427155232.10659-1-r-ravikumar@ti.com>
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

Add node for dvi bridge and the endpoint nodes to
describe connection from
DSS => TI TFP410 DPI-to-DVI Bridge => HDMI connector.
Also add the required pinmux for HDMI hotplug and
powerdown

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 80 +++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 07b1e40fbc47..27a5911dfa8f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -225,6 +225,59 @@
 			};
 		};
 	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_hpd_pins_default>;
+
+		ddc-i2c-bus = <&main_i2c1>;
+
+		/* HDMI_HPD */
+		hpd-gpios = <&main_gpio1 0 GPIO_ACTIVE_HIGH>;
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&tfp410_out>;
+			};
+		};
+	};
+
+	dvi-bridge {
+		compatible = "ti,tfp410";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_pdn_pins_default>;
+
+		powerdown-gpios = <&main_gpio0 127 GPIO_ACTIVE_LOW>;
+		ti,deskew = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				tfp410_in: endpoint {
+					remote-endpoint = <&dpi_out0>;
+					pclk-sample = <1>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				tfp410_out: endpoint {
+					remote-endpoint =
+						<&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &main_pmx0 {
@@ -329,6 +382,18 @@
 		>;
 	};
 
+	hdmi_hpd_pins_default: hdmi-hpd-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x204, PIN_INPUT, 7) /* (AD5) UART1_RTSn.GPIO1_0 */
+		>;
+	};
+
+	hdmi_pdn_pins_default: hdmi-pdn-pins-default {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x200, PIN_INPUT, 7) /* (AC4) UART1_CTSn.GPIO0_127 */
+		>;
+	};
+
 	/* Reset for M.2 E Key slot on PCIe0  */
 	ekey_reset_pins_default: ekey-reset-pns-pins-default {
 		pinctrl-single,pins = <
@@ -733,11 +798,24 @@
 };
 
 &dss_ports {
-	port {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	port@0  {
+		reg = <0>;
+
 		dpi0_out: endpoint {
 			remote-endpoint = <&dp0_in>;
 		};
 	};
+
+	port@1 {
+		reg = <1>;
+
+		dpi_out0: endpoint {
+			remote-endpoint = <&tfp410_in>;
+		};
+	};
 };
 
 &dp0_ports {
-- 
2.17.1

