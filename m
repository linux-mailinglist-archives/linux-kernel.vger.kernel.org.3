Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8630252443C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347187AbiELEZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346868AbiELEZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:25:14 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085920F9F5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:25:09 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 898352C044A;
        Thu, 12 May 2022 04:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652329506;
        bh=nYlsTo5qZW0TCBgPU2dnXnCN/Yen0vwyJkFQIABL69s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2c/xTd5muLj+sMuELr31VS8dYCl846CaPDI/8fbhrUYEvPKD4SjYz0cV9iMVRG+P
         H0rc7ssaDFelb7dbSMldzH2cS/muAnPfMvwUg5BfTXfpX4Jrxipb3YaYoIGwuYgPs9
         0PAxHef+v0z5eSB5rJGD1OKlC+Rbr4tn5r5cP2PxojiSBKNQwlzST8ZtVRxtxXVlmC
         M0DGwnlCEsSv9K5tZGbWRThrJ/oWbKtKNjVrqUbP0h4Ki1iyx0qG6h6Hp+1ETcoNCn
         t0htpeiE7XY6Pe43zhQ7HSD85goimSNb25+C0RZgjBEKZH/KhHqrJhfbSG1msdNrax
         WqX7gV8xUJM+Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627c8c220002>; Thu, 12 May 2022 16:25:06 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 1823E13EE85;
        Thu, 12 May 2022 16:25:06 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 108EF2A00D3; Thu, 12 May 2022 16:25:06 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        vadym.kochan@plvision.eu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v7 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and RD-AC5X board
Date:   Thu, 12 May 2022 16:25:00 +1200
Message-Id: <20220512042501.3339775-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220512042501.3339775-1-chris.packham@alliedtelesis.co.nz>
References: <20220512042501.3339775-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=To9G09A7kKYn3NCZ5BUA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 98DX2530 SoC is the Control and Management CPU integrated into
the Marvell 98DX25xx and 98DX35xx series of switch chip (internally
referred to as AlleyCat5 and AlleyCat5X).

These files have been taken from the Marvell SDK and lightly cleaned
up with the License and copyright retained.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    The Marvell SDK has a number of new compatible strings. I've brought
    through some of the drivers or where possible used an in-tree
    alternative (e.g. there is SDK code for a ac5-gpio but two instances =
of
    the existing marvell,orion-gpio seems to cover what is needed if you =
use
    an appropriate binding). I expect that there will a new series of
    patches when I get some different hardware (or additions to this seri=
es
    depending on if/when it lands).
   =20
    Changes in v7:
    - Add missing compatible on usb1
    - Add "rd-ac5x" compatible for board
    - Move aliases to board dts
    - Move board specific usb info to board dts
    - Consolidate usb1 board settings and remove unnecessary compatible
    - Add Allied Telesis copyright
    - Rename files after mailng-list discussion
    Changes in v6:
    - Move CPU nodes above the SoC (Krzysztof)
    - Minor formatting clean ups (Krzysztof)
    - Run through `make dtbs_check`
    - Move gic nodes inside SoC
    - Group clocks under a clock node
    Changes in v5:
    - add #{address,size}-cells property to i2c nodes
    - make i2c nodes disabled in the SoC and enable them in the board
    - add interrupt controller attributes to gpio nodes
    - Move fixed-clock nodes up a level and remove unnecessary @0
    Changes in v4:
    - use 'phy-handle' instead of 'phy'
    - move status=3D"okay" on usb nodes to board dts
    - Add review from Andrew
    Changes in v3:
    - Move memory node to board
    - Use single digit reg value for phy address
    - Remove MMC node (driver needs work)
    - Remove syscon & simple-mfd for pinctrl
    Changes in v2:
    - Make pinctrl a child node of a syscon node
    - Use marvell,armada-8k-gpio instead of orion-gpio
    - Remove nand peripheral. The Marvell SDK does have some changes for =
the
      ac5-nand-controller but I currently lack hardware with NAND fitted =
so
      I can't test it right now. I've therefore chosen to omit the node a=
nd
      not attempted to bring in the driver or binding.
    - Remove pcie peripheral. Again there are changes in the SDK and I ha=
ve
      no way of testing them.
    - Remove prestera node.
    - Remove "marvell,ac5-ehci" compatible from USB node as
      "marvell,orion-ehci" is sufficient
    - Remove watchdog node. There is a buggy driver for the ac5 watchdog =
in
      the SDK but it needs some work so I've dropped the node for now.

 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-98dx25xx.dtsi     | 295 ++++++++++++++++++
 .../boot/dts/marvell/armada-98dx35xx-rd.dts   | 101 ++++++
 .../boot/dts/marvell/armada-98dx35xx.dtsi     |  13 +
 4 files changed, 410 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx25xx.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx35xx-rd.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx35xx.dtsi

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/m=
arvell/Makefile
index 1c794cdcb8e6..b7a4c715afbb 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -24,3 +24,4 @@ dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9132-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9132-db-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9130-crb-A.dtb
 dtb-$(CONFIG_ARCH_MVEBU) +=3D cn9130-crb-B.dtb
+dtb-$(CONFIG_ARCH_MVEBU) +=3D armada-98dx35xx-rd.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-98dx25xx.dtsi b/arch/arm6=
4/boot/dts/marvell/armada-98dx25xx.dtsi
new file mode 100644
index 000000000000..55ab4cd843a9
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-98dx25xx.dtsi
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree For AC5.
+ *
+ * Copyright (C) 2021 Marvell
+ * Copyright (C) 2022 Allied Telesis Labs
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model =3D "Marvell AC5 SoC";
+	compatible =3D "marvell,ac5";
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <2>;
+
+	cpus {
+		#address-cells =3D <2>;
+		#size-cells =3D <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu =3D <&cpu0>;
+				};
+				core1 {
+					cpu =3D <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type =3D "cpu";
+			compatible =3D "arm,armv8";
+			reg =3D <0x0 0x0>;
+			enable-method =3D "psci";
+			next-level-cache =3D <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type =3D "cpu";
+			compatible =3D "arm,armv8";
+			reg =3D <0x0 0x100>;
+			enable-method =3D "psci";
+			next-level-cache =3D <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible =3D "cache";
+		};
+	};
+
+
+	psci {
+		compatible =3D "arm,psci-0.2";
+		method =3D "smc";
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				 <GIC_PPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				 <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>,
+				 <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency =3D <25000000>;
+	};
+
+	pmu {
+		compatible =3D "arm,armv8-pmuv3";
+		interrupts =3D <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible =3D "simple-bus";
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+		dma-ranges;
+
+		internal-regs@7f000000 {
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			compatible =3D "simple-bus";
+			/* 16M internal register @ 0x7f00_0000 */
+			ranges =3D <0x0 0x0 0x7f000000 0x1000000>;
+			dma-coherent;
+
+			uart0: serial@12000 {
+				compatible =3D "snps,dw-apb-uart";
+				reg =3D <0x12000 0x100>;
+				reg-shift =3D <2>;
+				interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width =3D <1>;
+				clock-frequency =3D <328000000>;
+				status =3D "okay";
+			};
+
+			mdio: mdio@22004 {
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+				compatible =3D "marvell,orion-mdio";
+				reg =3D <0x22004 0x4>;
+				clocks =3D <&core_clock>;
+			};
+
+			i2c0: i2c@11000{
+				compatible =3D "marvell,mv78230-i2c";
+				reg =3D <0x11000 0x20>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				clocks =3D <&core_clock>;
+				clock-names =3D "core";
+				interrupts =3D <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency=3D<100000>;
+
+				pinctrl-names =3D "default", "gpio";
+				pinctrl-0 =3D <&i2c0_pins>;
+				pinctrl-1 =3D <&i2c0_gpio>;
+				scl_gpio =3D <&gpio0 26 GPIO_ACTIVE_HIGH>;
+				sda_gpio =3D <&gpio0 27 GPIO_ACTIVE_HIGH>;
+				status =3D "disabled";
+			};
+
+			i2c1: i2c@11100{
+				compatible =3D "marvell,mv78230-i2c";
+				reg =3D <0x11100 0x20>;
+				#address-cells =3D <1>;
+				#size-cells =3D <0>;
+
+				clocks =3D <&core_clock>;
+				clock-names =3D "core";
+				interrupts =3D <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency=3D<100000>;
+
+				pinctrl-names =3D "default", "gpio";
+				pinctrl-0 =3D <&i2c1_pins>;
+				pinctrl-1 =3D <&i2c1_gpio>;
+				scl_gpio =3D <&gpio0 20 GPIO_ACTIVE_HIGH>;
+				sda_gpio =3D <&gpio0 21 GPIO_ACTIVE_HIGH>;
+				status =3D "disabled";
+			};
+
+			gpio0: gpio@18100 {
+				compatible =3D "marvell,orion-gpio";
+				reg =3D <0x18100 0x40>;
+				ngpios =3D <32>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+				gpio-ranges =3D <&pinctrl0 0 0 32>;
+				marvell,pwm-offset =3D <0x1f0>;
+				interrupt-controller;
+				#interrupt-cells =3D <2>;
+			};
+
+			gpio1: gpio@18140 {
+				reg =3D <0x18140 0x40>;
+				compatible =3D "marvell,orion-gpio";
+				ngpios =3D <14>;
+				gpio-controller;
+				#gpio-cells =3D <2>;
+				gpio-ranges =3D <&pinctrl0 0 32 14>;
+				marvell,pwm-offset =3D <0x1f0>;
+				interrupt-controller;
+				#interrupt-cells =3D <2>;
+			};
+		};
+
+		/*
+		 * Dedicated section for devices behind 32bit controllers so we
+		 * can configure specific DMA mapping for them
+		 */
+		behind-32bit-controller@7f000000 {
+			compatible =3D "simple-bus";
+			#address-cells =3D <0x2>;
+			#size-cells =3D <0x2>;
+			ranges =3D <0x0 0x0 0x0 0x7f000000 0x0 0x1000000>;
+			/* Host phy ram starts at 0x200M */
+			dma-ranges =3D <0x0 0x0 0x2 0x0 0x1 0x0>;
+			dma-coherent;
+
+			eth0: ethernet@20000 {
+				compatible =3D "marvell,armada-ac5-neta";
+				reg =3D <0x0 0x20000 0x0 0x4000>;
+				interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&core_clock>;
+				phy-mode =3D "sgmii";
+				status =3D "disabled";
+			};
+
+			eth1: ethernet@24000 {
+				compatible =3D "marvell,armada-ac5-neta";
+				reg =3D <0x0 0x24000 0x0 0x4000>;
+				interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&core_clock>;
+				phy-mode =3D "sgmii";
+				status =3D "disabled";
+			};
+
+			usb0: usb@80000 {
+				compatible =3D "marvell,orion-ehci";
+				reg =3D <0x0 0x80000 0x0 0x500>;
+				interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				status =3D "disabled";
+			};
+
+			usb1: usb@a0000 {
+				compatible =3D "marvell,orion-ehci";
+				reg =3D <0x0 0xa0000 0x0 0x500>;
+				interrupts =3D <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				status =3D "disabled";
+			};
+		};
+
+		pinctrl0: pinctrl@80020100 {
+			compatible =3D "marvell,ac5-pinctrl";
+			reg =3D <0 0x80020100 0 0x20>;
+
+			i2c0_pins: i2c0-pins {
+				marvell,pins =3D "mpp26", "mpp27";
+				marvell,function =3D "i2c0";
+			};
+
+			i2c0_gpio: i2c0-gpio-pins {
+				marvell,pins =3D "mpp26", "mpp27";
+				marvell,function =3D "gpio";
+			};
+
+			i2c1_pins: i2c1-pins {
+				marvell,pins =3D "mpp20", "mpp21";
+				marvell,function =3D "i2c1";
+			};
+
+			i2c1_gpio: i2c1-gpio-pins {
+				marvell,pins =3D "mpp20", "mpp21";
+				marvell,function =3D "i2c1";
+			};
+		};
+
+		spi0: spi@805a0000 {
+			compatible =3D "marvell,armada-3700-spi";
+			reg =3D <0x0 0x805a0000 0x0 0x50>;
+			#address-cells =3D <0x1>;
+			#size-cells =3D <0x0>;
+			clocks =3D <&spi_clock>;
+			interrupts =3D <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			num-cs =3D <1>;
+			status =3D "disabled";
+		};
+
+		spi1: spi@805a8000 {
+			compatible =3D "marvell,armada-3700-spi";
+			reg =3D <0x0 0x805a8000 0x0 0x50>;
+			#address-cells =3D <0x1>;
+			#size-cells =3D <0x0>;
+			clocks =3D <&spi_clock>;
+			interrupts =3D <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			num-cs =3D <1>;
+			status =3D "disabled";
+		};
+
+		gic: interrupt-controller@80600000 {
+			compatible =3D "arm,gic-v3";
+			#interrupt-cells =3D <3>;
+			interrupt-controller;
+			/*#redistributor-regions =3D <1>;*/
+			redistributor-stride =3D <0x0 0x20000>;	// 128kB stride
+			reg =3D <0x0 0x80600000 0x0 0x10000>, /* GICD */
+			      <0x0 0x80660000 0x0 0x40000>; /* GICR */
+			interrupts =3D <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	clocks {
+		core_clock: core-clock {
+			compatible =3D "fixed-clock";
+			#clock-cells =3D <0>;
+			clock-frequency =3D <400000000>;
+		};
+
+		axi_clock: axi-clock {
+			compatible =3D "fixed-clock";
+			#clock-cells =3D <0>;
+			clock-frequency =3D <325000000>;
+		};
+
+		spi_clock: spi-clock {
+			compatible =3D "fixed-clock";
+			#clock-cells =3D <0>;
+			clock-frequency =3D <200000000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-98dx35xx-rd.dts b/arch/ar=
m64/boot/dts/marvell/armada-98dx35xx-rd.dts
new file mode 100644
index 000000000000..c20e032410fa
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-98dx35xx-rd.dts
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree For RD-AC5X.
+ *
+ * Copyright (C) 2021 Marvell
+ * Copyright (C) 2022 Allied Telesis Labs
+ */
+/*
+ * Device Tree file for Marvell Alleycat 5X development board
+ * This board file supports the B configuration of the board
+ */
+
+/dts-v1/;
+
+#include "armada-98dx35xx.dtsi"
+
+/ {
+	model =3D "Marvell RD-AC5X Board";
+	compatible =3D "marvell,rd-ac5x", "marvell,ac5x", "marvell,ac5";
+
+	aliases {
+		serial0 =3D &uart0;
+		spiflash0 =3D &spiflash0;
+		gpio0 =3D &gpio0;
+		gpio1 =3D &gpio1;
+		ethernet0 =3D &eth0;
+		ethernet1 =3D &eth1;
+	};
+
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x2 0x00000000 0x0 0x40000000>;
+	};
+
+	usb1phy: usb-phy {
+		compatible =3D "usb-nop-xceiv";
+		#phy-cells =3D <0>;
+	};
+};
+
+&mdio {
+	phy0: ethernet-phy@0 {
+		reg =3D <0>;
+	};
+};
+
+&i2c0 {
+	status =3D "okay";
+};
+
+&i2c1 {
+	status =3D "okay";
+};
+
+&eth0 {
+	status =3D "okay";
+	phy-handle =3D <&phy0>;
+};
+
+/* USB0 is a host USB */
+&usb0 {
+	status =3D "okay";
+};
+
+/* USB1 is a peripheral USB */
+&usb1 {
+	status =3D "okay";
+	phys =3D <&usb1phy>;
+	phy-names =3D "usb-phy";
+	dr_mode =3D "peripheral";
+};
+
+&spi0 {
+	status =3D "okay";
+
+	spiflash0: flash@0 {
+		compatible =3D "jedec,spi-nor";
+		spi-max-frequency =3D <50000000>;
+		spi-tx-bus-width =3D <1>; /* 1-single, 2-dual, 4-quad */
+		spi-rx-bus-width =3D <1>; /* 1-single, 2-dual, 4-quad */
+		reg =3D <0>;
+
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+
+		partition@0 {
+			label =3D "spi_flash_part0";
+			reg =3D <0x0 0x800000>;
+		};
+
+		parition@1 {
+			label =3D "spi_flash_part1";
+			reg =3D <0x800000 0x700000>;
+		};
+
+		parition@2 {
+			label =3D "spi_flash_part2";
+			reg =3D <0xF00000 0x100000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-98dx35xx.dtsi b/arch/arm6=
4/boot/dts/marvell/armada-98dx35xx.dtsi
new file mode 100644
index 000000000000..62d2650513aa
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-98dx35xx.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree For AC5X.
+ *
+ * Copyright (C) 2022 Allied Telesis Labs
+ */
+
+#include "armada-98dx25xx.dtsi"
+
+/ {
+	model =3D "Marvell AC5X SoC";
+	compatible =3D "marvell,ac5x", "marvell,ac5";
+};
--=20
2.36.0

