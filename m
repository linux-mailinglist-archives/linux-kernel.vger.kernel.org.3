Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1971D51142B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiD0JNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiD0JND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:13:03 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588E4245E6F;
        Wed, 27 Apr 2022 02:09:43 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R98xZS095481;
        Wed, 27 Apr 2022 04:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651050539;
        bh=kupnSmCLa8ukKSu5s2c5515veWPch3RoCk/juFoT/6Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KQLf9wV0dRUKRDV92bduBg3H2KjUfK739e7Ig2QfBKLkdLQ7+kQIWEAjikKqZRkvA
         z3yzPgqiipGHSObsUQ69Yob2lsmFqY9W6C+eaDrzh9t/Sz7isplESuY/9WVoyVxa9x
         NG8w5Z4hSwpUZEXbZKgK/gclYt5nQGRH8vR0eps8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R98xeu122332
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 04:08:59 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 04:08:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 04:08:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R98ws5058588;
        Wed, 27 Apr 2022 04:08:59 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-am625-sk: Add DSS ports, HDMI tx & peripherals
Date:   Wed, 27 Apr 2022 14:38:50 +0530
Message-ID: <20220427090850.32280-5-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427090850.32280-1-a-bhatia1@ti.com>
References: <20220427090850.32280-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add DT nodes for sil9022 HDMI transmitter (tx), HDMI connector and the
HDMI fixed master clock on the am625-sk board.

Additionally, add and connect output port for DSS (vp2), input and output
ports for the sil9022 HDMI tx and the input port for the HDMI connector.

The sil9022 HDMI tx is connected on the i2c1 bus. The HDMI connector on
the board is of type "a". The clock frequency of the master clock that
supports the HDMI tx is 12.288 MHz.

The dpi output signals from the vp2 of DSS are fed into the sil9022 HDMI
transmitter. These signals are converted into HDMI signals which are
further passed on to the HDMI connector on the board, on which display
can be connected via appropriate HDMI cables.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 63 ++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 96414c5dacf7..9567fa4a447b 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -134,6 +134,23 @@ led-0 {
 			default-state = "off";
 		};
 	};
+
+	hdmi_mstrclk: hdmi-mstrclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
+
+	hdmi: connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
 };
 
 &main_pmx0 {
@@ -385,6 +402,38 @@ exp1: gpio@22 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
 	};
+
+	sii9022: sii9022@3b {
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+
+		clocks = <&hdmi_mstrclk>;
+		clock-names = "mclk";
+
+		interrupt-parent = <&exp1>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &main_i2c2 {
@@ -450,6 +499,20 @@ &dss {
 	pinctrl-0 = <&main_dss0_pins_default>;
 };
 
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* VP2: DPI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
+
 &mailbox0_cluster0 {
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;
-- 
2.36.0

