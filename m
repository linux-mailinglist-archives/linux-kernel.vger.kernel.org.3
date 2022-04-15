Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C176502ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352103AbiDONWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiDONWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:22:02 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762D113D71;
        Fri, 15 Apr 2022 06:19:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FDJRWM062604;
        Fri, 15 Apr 2022 08:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650028767;
        bh=IdJ9iwHY5EGSB8L5n3x4tRdWzpPyRv+AwxWcm62Rq/E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=T3mWVOVZIyWXQiZq8lPPhcD69DCjGy3bFOXoZIC2AfWOKgX3zoabfgr2SopeH/0Wi
         pv2lGObUej2uLSw+rjacgDxaEMfH9PAnJ1rXHjXKLm2e4HzCxkqDsN1Ak5N7G4p5eh
         kRllP6+XpAiUuQP9S8vIJEykSxxN2WliB+yUcglE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FDJRMA010662
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 08:19:27 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 08:19:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 08:19:26 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FDJIk9104572;
        Fri, 15 Apr 2022 08:19:23 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62: Add more peripheral nodes
Date:   Fri, 15 Apr 2022 18:49:16 +0530
Message-ID: <20220415131917.431137-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220415131917.431137-1-vigneshr@ti.com>
References: <20220415131917.431137-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add nodes for McSPI, OSPI, DMA, CPSW, MMC and On Chip SRAM nodes.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 266 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi  |  20 ++
 2 files changed, 286 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index c68472c692f4..4b6ba98dd0a2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -6,6 +6,14 @@
  */
 
 &cbass_main {
+	oc_sram: sram@70000000 {
+		compatible = "mmio-sram";
+		reg = <0x00 0x70000000 0x00 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x00 0x70000000 0x10000>;
+	};
+
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
@@ -40,6 +48,12 @@ main_conf: syscon@100000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x00100000 0x20000>;
+
+		phy_gmii_sel: phy@4044 {
+			compatible = "ti,am654-phy-gmii-sel";
+			reg = <0x4044 0x8>;
+			#phy-cells = <1>;
+		};
 	};
 
 	dmss: bus@48000000 {
@@ -61,6 +75,69 @@ secure_proxy_main: mailbox@4d000000 {
 			interrupt-names = "rx_012";
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		inta_main_dmss: interrupt-controller@48000000 {
+			compatible = "ti,sci-inta";
+			reg = <0x00 0x48000000 0x00 0x100000>;
+			#interrupt-cells = <0>;
+			interrupt-controller;
+			interrupt-parent = <&gic500>;
+			msi-controller;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <28>;
+			ti,interrupt-ranges = <4 68 36>;
+			ti,unmapped-event-sources = <&main_bcdma>, <&main_pktdma>;
+		};
+
+		main_bcdma: dma-controller@485c0100 {
+			compatible = "ti,am64-dmss-bcdma";
+			reg = <0x00 0x485c0100 0x00 0x100>,
+			      <0x00 0x4c000000 0x00 0x20000>,
+			      <0x00 0x4a820000 0x00 0x20000>,
+			      <0x00 0x4aa40000 0x00 0x20000>,
+			      <0x00 0x4bc00000 0x00 0x100000>;
+			reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt", "ringrt";
+			msi-parent = <&inta_main_dmss>;
+			#dma-cells = <3>;
+
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <26>;
+			ti,sci-rm-range-bchan = <0x20>; /* BLOCK_COPY_CHAN */
+			ti,sci-rm-range-rchan = <0x21>; /* SPLIT_TR_RX_CHAN */
+			ti,sci-rm-range-tchan = <0x22>; /* SPLIT_TR_TX_CHAN */
+		};
+
+		main_pktdma: dma-controller@485c0000 {
+			compatible = "ti,am64-dmss-pktdma";
+			reg = <0x00 0x485c0000 0x00 0x100>,
+			      <0x00 0x4a800000 0x00 0x20000>,
+			      <0x00 0x4aa00000 0x00 0x40000>,
+			      <0x00 0x4b800000 0x00 0x400000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt";
+			msi-parent = <&inta_main_dmss>;
+			#dma-cells = <2>;
+
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <30>;
+			ti,sci-rm-range-tchan = <0x23>, /* UNMAPPED_TX_CHAN */
+						<0x24>, /* CPSW_TX_CHAN */
+						<0x25>, /* SAUL_TX_0_CHAN */
+						<0x26>; /* SAUL_TX_1_CHAN */
+			ti,sci-rm-range-tflow = <0x10>, /* RING_UNMAPPED_TX_CHAN */
+						<0x11>, /* RING_CPSW_TX_CHAN */
+						<0x12>, /* RING_SAUL_TX_0_CHAN */
+						<0x13>; /* RING_SAUL_TX_1_CHAN */
+			ti,sci-rm-range-rchan = <0x29>, /* UNMAPPED_RX_CHAN */
+						<0x2b>, /* CPSW_RX_CHAN */
+						<0x2d>, /* SAUL_RX_0_CHAN */
+						<0x2f>, /* SAUL_RX_1_CHAN */
+						<0x31>, /* SAUL_RX_2_CHAN */
+						<0x33>; /* SAUL_RX_3_CHAN */
+			ti,sci-rm-range-rflow = <0x2a>, /* FLOW_UNMAPPED_RX_CHAN */
+						<0x2c>, /* FLOW_CPSW_RX_CHAN */
+						<0x2e>, /* FLOW_SAUL_RX_0/1_CHAN */
+						<0x32>; /* FLOW_SAUL_RX_2/3_CHAN */
+		};
 	};
 
 	dmsc: system-controller@44043000 {
@@ -203,6 +280,36 @@ main_i2c3: i2c@20030000 {
 		clock-names = "fck";
 	};
 
+	main_spi0: spi@20100000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x20100000 0x00 0x400>;
+		interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 141 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 172 0>;
+	};
+
+	main_spi1: spi@20110000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x20110000 0x00 0x400>;
+		interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 142 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 173 0>;
+	};
+
+	main_spi2: spi@20120000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x20120000 0x00 0x400>;
+		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 143 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 174 0>;
+	};
+
 	main_gpio_intr: interrupt-controller@a00000 {
 		compatible = "ti,sci-intr";
 		reg = <0x00 0x00a00000 0x00 0x800>;
@@ -249,6 +356,165 @@ main_gpio1: gpio@601000 {
 		clock-names = "gpio";
 	};
 
+	sdhci0: mmc@fa10000 {
+		compatible = "ti,am62-sdhci";
+		reg = <0x00 0x0fa10000 0x00 0x1000>, <0x00 0x0fa18000 0x00 0x400>;
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
+		clock-names = "clk_ahb", "clk_xin";
+		assigned-clocks = <&k3_clks 57 6>;
+		assigned-clock-parents = <&k3_clks 57 8>;
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		ti,trm-icp = <0x2>;
+		bus-width = <8>;
+		ti,clkbuf-sel = <0x7>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-mmc-hs = <0x0>;
+		ti,otap-del-sel-ddr52 = <0x9>;
+		ti,otap-del-sel-hs200 = <0x6>;
+	};
+
+	sdhci1: mmc@fa00000 {
+		compatible = "ti,am62-sdhci";
+		reg = <0x00 0x0fa00000 0x00 0x1000>, <0x00 0x0fa08000 0x00 0x400>;
+		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
+		clock-names = "clk_ahb", "clk_xin";
+		ti,trm-icp = <0x2>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x6>;
+		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,clkbuf-sel = <0x7>;
+		bus-width = <4>;
+	};
+
+	sdhci2: mmc@fa20000 {
+		compatible = "ti,am62-sdhci";
+		reg = <0x00 0x0fa20000 0x00 0x1000>, <0x00 0x0fa28000 0x00 0x400>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
+		clock-names = "clk_ahb", "clk_xin";
+		ti,trm-icp = <0x2>;
+		ti,otap-del-sel-legacy = <0x0>;
+		ti,otap-del-sel-sd-hs = <0x0>;
+		ti,otap-del-sel-sdr12 = <0xf>;
+		ti,otap-del-sel-sdr25 = <0xf>;
+		ti,otap-del-sel-sdr50 = <0xc>;
+		ti,otap-del-sel-sdr104 = <0x6>;
+		ti,otap-del-sel-ddr50 = <0x9>;
+		ti,itap-del-sel-legacy = <0x0>;
+		ti,itap-del-sel-sd-hs = <0x0>;
+		ti,itap-del-sel-sdr12 = <0x0>;
+		ti,itap-del-sel-sdr25 = <0x0>;
+		ti,clkbuf-sel = <0x7>;
+	};
+
+	fss: bus@fc00000 {
+		compatible = "simple-bus";
+		reg = <0x00 0x0fc00000 0x00 0x70000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ospi0: spi@fc40000 {
+			compatible = "ti,am654-ospi", "cdns,qspi-nor";
+			reg = <0x00 0x0fc40000 0x00 0x100>,
+			      <0x05 0x00000000 0x01 0x00000000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			cdns,fifo-depth = <256>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x0>;
+			clocks = <&k3_clks 75 7>;
+			assigned-clocks = <&k3_clks 75 7>;
+			assigned-clock-parents = <&k3_clks 75 8>;
+			assigned-clock-rates = <166666666>;
+			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	cpsw3g: ethernet@8000000 {
+		compatible = "ti,am642-cpsw-nuss";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		reg = <0x00 0x08000000 0x00 0x200000>;
+		reg-names = "cpsw_nuss";
+		ranges = <0x00 0x00 0x00 0x08000000 0x00 0x200000>;
+		clocks = <&k3_clks 13 0>;
+		assigned-clocks = <&k3_clks 13 3>;
+		assigned-clock-parents = <&k3_clks 13 11>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 13 TI_SCI_PD_EXCLUSIVE>;
+
+		dmas = <&main_pktdma 0xc600 15>,
+		       <&main_pktdma 0xc601 15>,
+		       <&main_pktdma 0xc602 15>,
+		       <&main_pktdma 0xc603 15>,
+		       <&main_pktdma 0xc604 15>,
+		       <&main_pktdma 0xc605 15>,
+		       <&main_pktdma 0xc606 15>,
+		       <&main_pktdma 0xc607 15>,
+		       <&main_pktdma 0x4600 15>;
+		dma-names = "tx0", "tx1", "tx2", "tx3", "tx4", "tx5", "tx6",
+			    "tx7", "rx";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cpsw_port1: port@1 {
+				reg = <1>;
+				ti,mac-only;
+				label = "port1";
+				phys = <&phy_gmii_sel 1>;
+				mac-address = [00 00 00 00 00 00];
+				ti,syscon-efuse = <&wkup_conf 0x200>;
+			};
+
+			cpsw_port2: port@2 {
+				reg = <2>;
+				ti,mac-only;
+				label = "port2";
+				phys = <&phy_gmii_sel 2>;
+				mac-address = [00 00 00 00 00 00];
+			};
+		};
+
+		cpsw3g_mdio: mdio@f00 {
+			compatible = "ti,cpsw-mdio","ti,davinci_mdio";
+			reg = <0x00 0xf00 0x00 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&k3_clks 13 0>;
+			clock-names = "fck";
+			bus_freq = <1000000>;
+		};
+
+		cpts@3d000 {
+			compatible = "ti,j721e-cpts";
+			reg = <0x00 0x3d000 0x00 0x400>;
+			clocks = <&k3_clks 13 1>;
+			clock-names = "cpts";
+			interrupts-extended = <&gic500 GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cpts";
+			ti,cpts-ext-ts-inputs = <4>;
+			ti,cpts-periodic-outputs = <2>;
+		};
+	};
+
 	hwspinlock: spinlock@2a000000 {
 		compatible = "ti,am64-hwspinlock";
 		reg = <0x00 0x2a000000 0x00 0x1000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index 9d210d55fc71..d103824c963f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -33,4 +33,24 @@ mcu_i2c0: i2c@4900000 {
 		clocks = <&k3_clks 106 2>;
 		clock-names = "fck";
 	};
+
+	mcu_spi0: spi@4b00000 {
+		compatible = "ti,am654-mcspi", "ti,omap4-mcspi";
+		reg = <0x00 0x04b00000 0x00 0x400>;
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 147 0>;
+	};
+
+	mcu_spi1: spi@4b10000 {
+		compatible = "ti,am654-mcspi","ti,omap4-mcspi";
+		reg = <0x00 0x04b10000 0x00 0x400>;
+		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 148 0>;
+	};
 };
-- 
2.35.3

