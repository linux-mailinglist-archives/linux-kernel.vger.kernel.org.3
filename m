Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFAB5A991F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiIANia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiIANhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:37:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B84B0CB;
        Thu,  1 Sep 2022 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662039324; x=1693575324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d2iUfrhEMIj32cIjtAG6kmTs6cmS2qn1d7T1i0Rrnpk=;
  b=CHkMBvSj1Vo0iPUQk2oc/JzoZzN1oZ0k53FeyzbCcrSpZzkpTL0zj26T
   iy6otQ2fU8fm3lpcHWdlcZ7Id0VMPpkI5IFrQOhR3Cq7ed7+165H9bK8r
   R1P46AOzCYmnN31k/aYOQ3bLjfGyZab+e22XULkMQs2iEmJ/VpovxrZ0y
   ZYg6WWtoijp6BgjRNZoaYbjy7cTIFpIdjH3JU/6wZeYA8xePCLnd8G7R8
   RpGpZIrZnGFxtFVDBoPD5aY3ZXHonq8QRUdMsFI2Y8X5jfURHm0twWwOY
   WpD7rQzf9TYfrBS0s+Msv3NEKnipK9JS36uXs4LiIO1bTclQerqfYTGk2
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="111754634"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 06:35:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 06:35:14 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Sep 2022 06:35:11 -0700
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
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 9/9] riscv: dts: microchip: add a devicetree for aries' m100pfsevp
Date:   Thu, 1 Sep 2022 14:34:04 +0100
Message-ID: <20220901133403.3392291-10-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901133403.3392291-1-conor.dooley@microchip.com>
References: <20220901133403.3392291-1-conor.dooley@microchip.com>
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

Add device trees for both configs used by the Aries Embedded
M100PFSEVP. The M100OFSEVP consists of a MPFS250T on a SOM,
featuring:
- 2GB DDR4 SDRAM dedicated to the HMS
- 512MB DDR4 SDRAM dedicated to the FPGA
- 32 MB SPI NOR Flash
- 4 GByte eMMC

and a carrier board with:
- 2x Gigabit Ethernet
- USB
- 2x UART
- 2x CAN
- TFT connector
- HSMC extension connector
- 3x PMOD extension connectors
- microSD-card slot

Link: https://www.aries-embedded.com/polarfire-soc-fpga-microsemi-m100pfs-som-mpfs025t-pcie-serdes
Link: https://www.aries-embedded.com/evaluation-kit/fpga/polarfire-microchip-soc-fpga-m100pfsevp-riscv-hsmc-pmod
Link: https://downloads.aries-embedded.de/products/M100PFS/Hardware/M100PFSEVP-Schematics.pdf
Co-developed-by: Wolfgang Grandegger <wg@aries-embedded.de>
Signed-off-by: Wolfgang Grandegger <wg@aries-embedded.de>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Note to self:
The amount of DDR at 0x10... is probably a fraction of what is actually there.

 arch/riscv/boot/dts/microchip/Makefile        |   1 +
 .../dts/microchip/mpfs-m100pfs-fabric.dtsi    |  45 +++++
 .../boot/dts/microchip/mpfs-m100pfsevp.dts    | 179 ++++++++++++++++++
 3 files changed, 225 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-m100pfsevp.dts

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index f18477b2e86d..7427a20934f3 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-icicle-kit.dtb
+dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
 dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
 dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
 obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
diff --git a/arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi
new file mode 100644
index 000000000000..7b9ee13b6a3a
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-m100pfs-fabric.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2022 Microchip Technology Inc */
+
+/ {
+	fabric_clk3: fabric-clk3 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <62500000>;
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
diff --git a/arch/riscv/boot/dts/microchip/mpfs-m100pfsevp.dts b/arch/riscv/boot/dts/microchip/mpfs-m100pfsevp.dts
new file mode 100644
index 000000000000..184cb36a175e
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/mpfs-m100pfsevp.dts
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Original all-in-one devicetree:
+ * Copyright (C) 2021-2022 - Wolfgang Grandegger <wg@aries-embedded.de>
+ * Rewritten to use includes:
+ * Copyright (C) 2022 - Conor Dooley <conor.dooley@microchip.com>
+ */
+/dts-v1/;
+
+#include "mpfs.dtsi"
+#include "mpfs-m100pfs-fabric.dtsi"
+
+/* Clock frequency (in Hz) of the rtcclk */
+#define MTIMER_FREQ	1000000
+
+/ {
+	model = "Aries Embedded M100PFEVPS";
+	compatible = "aries,m100pfsevp", "microchip,mpfs";
+
+	aliases {
+		ethernet0 = &mac0;
+		ethernet1 = &mac1;
+		serial0 = &mmuart0;
+		serial1 = &mmuart1;
+		serial2 = &mmuart2;
+		serial3 = &mmuart3;
+		serial4 = &mmuart4;
+		gpio0 = &gpio0;
+		gpio1 = &gpio2;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	cpus {
+		timebase-frequency = <MTIMER_FREQ>;
+	};
+
+	ddrc_cache_lo: memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+	};
+	ddrc_cache_hi: memory@1040000000 {
+		device_type = "memory";
+		reg = <0x10 0x40000000 0x0 0x40000000>;
+	};
+};
+
+&can0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&gpio0 {
+	interrupts = <13>, <14>, <15>, <16>,
+		     <17>, <18>, <19>, <20>,
+		     <21>, <22>, <23>, <24>,
+		     <25>, <26>;
+	ngpios = <14>;
+	status = "okay";
+
+	pmic-irq-hog {
+		gpio-hog;
+		gpios = <13 0>;
+		input;
+	};
+
+	/* Set to low for eMMC, high for SD-card */
+	mmc-sel-hog {
+		gpio-hog;
+		gpios = <12 0>;
+		output-high;
+	};
+};
+
+&gpio2 {
+	interrupts = <13>, <14>, <15>, <16>,
+		     <17>, <18>, <19>, <20>,
+		     <21>, <22>, <23>, <24>,
+		     <25>, <26>, <27>, <28>,
+		     <29>, <30>, <31>, <32>,
+		     <33>, <34>, <35>, <36>,
+		     <37>, <38>, <39>, <40>,
+		     <41>, <42>, <43>, <44>;
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+	phy-mode = "gmii";
+	phy-handle = <&phy0>;
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&mac1 {
+	status = "okay";
+	phy-mode = "gmii";
+	phy-handle = <&phy1>;
+	phy1: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&mbox {
+	status = "okay";
+};
+
+&mmc {
+	max-frequency = <50000000>;
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	no-1-8-v;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	disable-wp;
+	status = "okay";
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
+&pcie {
+	status = "okay";
+};
+
+&qspi {
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
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&syscontroller {
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.36.1

