Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99226569A77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiGGGZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiGGGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:25:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853F14095;
        Wed,  6 Jul 2022 23:25:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2676PDOU043733;
        Thu, 7 Jul 2022 01:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657175113;
        bh=lb+m9O96H+tCbP8mwFdV+Jp8NtTtOe7FFEsdVpkHbrs=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=risD06Y5bodmuhvwLQpSzI7fN200ASpdYPEl6WxEOGYwrB9GGFJAySTXdYfZwU+UG
         FU7QGPzELC6e6f27Kws4Djv+y970T7OQsRvdp3jO5DFepYChkSwWo6vELaVZEy80zv
         fT1KjT8berS3hcv5WH5aX8ofWnPnF4HLV/KULttw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2676PDe5119095
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 01:25:13 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Jul 2022 01:25:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Jul 2022 01:25:13 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2676P51T106842;
        Thu, 7 Jul 2022 01:25:11 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH RESEND 2/6] arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node
Date:   Wed, 6 Jul 2022 23:24:59 -0700
Message-ID: <20220707062503.295663-3-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707062503.295663-1-mranostay@ti.com>
References: <20220707062503.295663-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswath Govindraju <a-govindraju@ti.com>

Add dt node for the single instance of WIZ (SERDES wrapper) and
SERDES module shared by PCIe, eDP and USB.

Acked-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index f7e359da8690..f1e02d896168 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -5,6 +5,13 @@
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+/ {
+	serdes_refclk: serdes-refclk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+	};
+};
+
 &cbass_main {
 	msmc_ram: sram@70000000 {
 		compatible = "mmio-sram";
@@ -33,6 +40,13 @@ scm_conf: scm-conf@104000 {
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00104000 0x18000>;
 
+		serdes_ln_ctrl: mux-controller@80 {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x80 0x3>, <0x84 0x3>, /* SERDES0 lane0/1 select */
+					<0x88 0x3>, <0x8c 0x3>; /* SERDES0 lane2/3 select */
+		};
+
 		usb_serdes_mux: mux-controller@0 {
 			compatible = "mmio-mux";
 			#mux-control-cells = <1>;
@@ -728,6 +742,62 @@ usb0: usb@6000000 {
 		};
 	};
 
+	serdes_wiz0: wiz@5060000 {
+		compatible = "ti,j721e-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 365 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 365 0>, <&k3_clks 365 3>, <&serdes_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		ranges = <0x5060000 0x0 0x5060000 0x10000>;
+
+		assigned-clocks = <&k3_clks 365 3>;
+		assigned-clock-parents = <&k3_clks 365 7>;
+
+		wiz0_pll0_refclk: pll0-refclk {
+			clocks = <&k3_clks 365 3>, <&serdes_refclk>;
+			clock-output-names = "wiz0_pll0_refclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_pll0_refclk>;
+			assigned-clock-parents = <&k3_clks 365 3>;
+		};
+
+		wiz0_pll1_refclk: pll1-refclk {
+			clocks = <&k3_clks 365 3>, <&serdes_refclk>;
+			clock-output-names = "wiz0_pll1_refclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_pll1_refclk>;
+			assigned-clock-parents = <&k3_clks 365 3>;
+		};
+
+		wiz0_refclk_dig: refclk-dig {
+			clocks = <&k3_clks 365 3>, <&serdes_refclk>;
+			clock-output-names = "wiz0_refclk_dig";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz0_refclk_dig>;
+			assigned-clock-parents = <&k3_clks 365 3>;
+		};
+
+		wiz0_cmn_refclk_dig_div: cmn-refclk-dig-div {
+			clocks = <&wiz0_refclk_dig>;
+			#clock-cells = <0>;
+		};
+
+		serdes0: serdes@5060000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05060000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&wiz0_pll0_refclk>;
+			clock-names = "refclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	main_mcan0: can@2701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x02701000 0x00 0x200>,
-- 
2.36.1

