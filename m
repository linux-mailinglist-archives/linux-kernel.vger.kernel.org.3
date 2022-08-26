Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADB35A297E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbiHZO3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbiHZO3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:29:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46209A74EE;
        Fri, 26 Aug 2022 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661524150; x=1693060150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wYLnJ/r2/6cv7cgLTA2f55BdTU7OBp01DEfsGbye9PI=;
  b=fcrFjlL95wxOnAeTyDviVw2S8dUAiJGl8H71zEAfW6OtmzeJpPvWO7S6
   HoznQka5QKD5TPBS/LZDplcJhAUxPwn0/Y7Mlef6dNvgE+OTnCDo/FTeo
   9pkMyl6Ft8RUW6SkWWpvv675yRuADQLIDQnUN1iYiwSrNSryvgp57pR03
   Rf2BYfJntI3tyMEussFHP/wwYlpPyN/tYzstPkhylAyIty+UbZnmWQUG/
   MuVO8wjG4k91RgrlLRzn6mpfYE7ilSf68Zu31hOIT2RUKHTmTBkET3sr7
   KmOqo/DpicMSg0P6SbZTo3XZXFK1Dyfyy2HqdszFTia4mDwncXbx/sXcr
   A==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="174335928"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 07:29:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 07:29:05 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 26 Aug 2022 07:29:02 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/9] riscv: dts: microchip: add sevkit device tree
Date:   Fri, 26 Aug 2022 15:28:06 +0100
Message-ID: <20220826142806.3658434-9-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826142806.3658434-1-conor.dooley@microchip.com>
References: <20220826142806.3658434-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vattipalli Praveen <praveen.kumar@microchip.com>

Add a basic dts for the Microchip Smart Embedded Vision dev kit.
The SEV kit is an upcoming first party board, featuring an MPFS250T and:
- Dual Sony Camera Sensors (IMX334)
- IEEE 802.11 b/g/n 20MHz (1x1) Wi-Fi
- Bluetooth 5 Low Energy
- 4 GB DDR4 x64
- 2 GB LPDDR4 x32
- 1 GB SPI Flash
- 8 GB eMMC flash & SD card slot (multiplexed)
- HDMI2.0 Video Input/Output
- MIPI DSI Output
- MIPI CSI-2 Input

Link: https://onlinedocs.microchip.com/pr/GUID-404D3738-DC76-46BA-8683-6A77E837C2DD-en-US-1/index.html?GUID-065AEBEE-7B2C-4895-8579-B1D73D797F06
Signed-off-by: Vattipalli Praveen <praveen.kumar@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/Makefile        |   1 +
 .../dts/microchip/mpfs-sev-kit-fabric.dtsi    |  45 ++++++
 .../riscv/boot/dts/microchip/mpfs-sev-kit.dts | 145 ++++++++++++++++++
 3 files changed, 191 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index 39aae7b04f1c..f18477b2e86d 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
+dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
 obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
diff --git a/arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
new file mode 100644
index 000000000000..8545baf4d129
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-sev-kit-fabric.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2022 Microchip Technology Inc */
+
+/ {
+	fabric_clk3: fabric-clk3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	fabric_clk1: fabric-clk1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <125000000>;
+	};
+
+	pcie: pcie@2000000000 {
+		compatible = "microchip,pcie-host-1.0";
+		#address-cells = <0x3>;
+		#interrupt-cells = <0x1>;
+		#size-cells = <0x2>;
+		device_type = "pci";
+		reg = <0x20 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
+		reg-names = "cfg", "apb";
+		bus-range = <0x0 0x7f>;
+		interrupt-parent = <&plic>;
+		interrupts = <119>;
+		interrupt-map = <0 0 0 1 &pcie_intc 0>,
+				<0 0 0 2 &pcie_intc 1>,
+				<0 0 0 3 &pcie_intc 2>,
+				<0 0 0 4 &pcie_intc 3>;
+		interrupt-map-mask = <0 0 0 7>;
+		clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
+		clock-names = "fic0", "fic1", "fic3";
+		ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
+		msi-parent = <&pcie>;
+		msi-controller;
+		status = "disabled";
+		pcie_intc: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
+};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts
new file mode 100644
index 000000000000..e810ad453452
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-sev-kit.dts
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2022 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "mpfs.dtsi"
+#include "mpfs-sev-kit-fabric.dtsi"
+
+/* Clock frequency (in Hz) of the rtcclk */
+#define RTCCLK_FREQ		1000000
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Microchip PolarFire-SoC SEV Kit";
+	compatible = "microchip,mpfs-sev-kit", "microchip,mpfs";
+
+	aliases {
+		ethernet0 = &mac1;
+		serial0 = &mmuart0;
+		serial1 = &mmuart1;
+		serial2 = &mmuart2;
+		serial3 = &mmuart3;
+		serial4 = &mmuart4;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	cpus {
+		timebase-frequency = <RTCCLK_FREQ>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		fabricbuf0ddrc: buffer@80000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x80000000 0x0 0x2000000>;
+		};
+
+		fabricbuf1ddrnc: buffer@c4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xc4000000 0x0 0x4000000>;
+		};
+
+		fabricbuf2ddrncwcb: buffer@d4000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xd4000000 0x0 0x4000000>;
+		};
+	};
+
+	ddrc_cache: memory@1000000000 {
+		device_type = "memory";
+		reg = <0x10 0x0 0x0 0x76000000>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&gpio2 {
+	interrupts = <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>,
+		     <53>, <53>, <53>, <53>;
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+	phy-mode = "sgmii";
+	phy-handle = <&phy0>;
+	phy1: ethernet-phy@9 {
+		reg = <9>;
+	};
+	phy0: ethernet-phy@8 {
+		reg = <8>;
+	};
+};
+
+&mac1 {
+	status = "okay";
+	phy-mode = "sgmii";
+	phy-handle = <&phy1>;
+};
+
+&mbox {
+	status = "okay";
+};
+
+&mmc {
+	status = "okay";
+	bus-width = <4>;
+	disable-wp;
+	cap-sd-highspeed;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+};
+
+&mmuart1 {
+	status = "okay";
+};
+
+&mmuart2 {
+	status = "okay";
+};
+
+&mmuart3 {
+	status = "okay";
+};
+
+&mmuart4 {
+	status = "okay";
+};
+
+&refclk {
+	clock-frequency = <125000000>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&syscontroller {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+	dr_mode = "otg";
+};
-- 
2.36.1

