Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538194B8C87
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiBPPev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:34:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbiBPPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:34:48 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40EB2722E7;
        Wed, 16 Feb 2022 07:34:35 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21GFG9GJ026154;
        Wed, 16 Feb 2022 15:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=C/vNlfnuxnBokMqtLqKU8eady2cxWqT7exgOoWwBDtk=;
 b=mGuTBBsHkTIlfqWMd9Doo5aiY/k9BRcwB8x+THCFCn/TEPrU0tKjSKkwcRAnn2Q/qyZM
 AW45x+8VievUodFtQI3SZRa4ENsc1eMkHU1otDrq+EdqrdvUlBQJsgmC9/DkobpmQf42
 CSvv20qBA6eYxodOVFJL8sn0iWJ9NjBVrMJPwqqX3ZD1R7eKndLbA+LjcHak0Q2a6kTG
 b6awYg8XWSkB/kzpxGsWDQV6SzpDry44JXPNwrYi0u1OVhQkc/l2RmVPkM6IM4J/5u86
 xtlMOlvNFQGru64ftPT2MI/kLqhN9sN9iVIFD/C7pGJgT2++/64od7m44jvnzKtmFIae Pw== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3e90xs9sgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 15:34:23 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id DD7F09B;
        Wed, 16 Feb 2022 15:34:22 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com, verdun@hpe.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH] [v3] arch: arm: boot: dts: Create HPE GXP Device Tree
Date:   Wed, 16 Feb 2022 09:36:30 -0600
Message-Id: <20220216153632.40981-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <nick.hawkins@hpe.com>
References: <nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: m5SZeiv8_JaYyRNqhsGWtv1lprOGdTDR
X-Proofpoint-GUID: m5SZeiv8_JaYyRNqhsGWtv1lprOGdTDR
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_07,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160091
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Description: Originally this was of a larger patch
HPE BMC GXP SUPPORT that was rejected for being to big.
This is why the label v3 is being used.
This patch Create a basic device tree layout that
 will allow the HPE GXP to boot. The undocumented
 bindings hpe,gxp-wdt and hpe,gxp-timer are being
 documented in patches:
  [v1] dt-bindings: timer: Add HPE GXP Timer binding
  [v1] dt-bindings: watchdog: Add HPE GXP Watchdog timer binding
  [v1]dt-bindings: vendor-prefixes: add HPE Prefix
 that are currently out for review.
The dts file is largely empty for this initial patch but
follow up patches will add more content.

Information: GXP is the name of the HPE SoC.
 This SoC is used to implement BMC features of HPE servers
  (all ProLiant, Synergy, and many Apollo, and Superdome machines)
   It does support many features including:
        ARMv7 architecture, and it is based on a Cortex A9 core
        Use an AXI bus to which
                a memory controller is attached, as well as
                 multiple SPI interfaces to connect boot flash,
                 and ROM flash, a 10/100/1000 Mac engine which
                 supports SGMII (2 ports) and RMII
                Multiple I2C engines to drive connectivity with a
				 host infrastructure
                A video engine which support VGA and DP, as well as
                 an hardware video encoder
                Multiple PCIe ports
                A PECI interface, and LPC eSPI
                Multiple UART for debug purpose, and Virtual UART for
                 host connectivity
                A GPIO engine.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 MAINTAINERS                              |   7 +
 arch/arm/boot/dts/Makefile               |   2 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts |  27 ++++
 arch/arm/boot/dts/hpe-gxp.dtsi           | 169 +++++++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
 create mode 100644 arch/arm/boot/dts/hpe-gxp.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..ca9fcc611b1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8385,6 +8385,13 @@ L:	linux-efi@vger.kernel.org
 S:	Maintained
 F:	block/partitions/efi.*
 
+GXP ARM ARCHITECTURE
+M:	Nick Hawkins <nick.hawkins@hpe.com>
+M:	Jean-Marie <verdun@hpe.com>
+S:	Maintained
+F:	arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
+F:	arch/arm/boot/dts/hpe-gxp.dtsi
+
 H8/300 ARCHITECTURE
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 L:	uclinux-h8-devel@lists.sourceforge.jp (moderated for non-subscribers)
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 235ad559acb2..a96b4d5b7f68 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1549,3 +1549,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-vegman-n110.dtb \
 	aspeed-bmc-vegman-rx20.dtb \
 	aspeed-bmc-vegman-sx20.dtb
+dtb-$(CONFIG_ARCH_HPE_GXP) += \
+	hpe-bmc-dl360gen10.dtb
diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
new file mode 100644
index 000000000000..179de6945e3f
--- /dev/null
+++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for HPE DL360Gen10
+ */
+
+/include/ "hpe-gxp.dtsi"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "hpe,gxp";
+	model = "Hewlett Packard Enterprise ProLiant dl360 Gen10";
+
+	chosen {
+		bootargs = "earlyprintk console=ttyS0,115200 user_debug=31";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x20000000>;
+	};
+
+	ahb {
+
+	};
+
+};
diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
new file mode 100644
index 000000000000..f62109abf685
--- /dev/null
+++ b/arch/arm/boot/dts/hpe-gxp.dtsi
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for HPE GXP
+ */
+
+/dts-v1/;
+/ {
+	model = "Hewlett Packard Enterprise GXP BMC";
+	compatible = "hpe,gxp";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "arm,armv7";
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x20000000>;
+	};
+
+	ahb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges;
+
+		vic0: interrupt-controller@ceff0000 {
+			compatible = "arm,pl192-vic";
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0xceff0000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		vic1: vic@80f00000 {
+			compatible = "arm,pl192-vic";
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x80f00000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		timer0: timer@c0000080 {
+			compatible = "hpe,gxp-timer";
+			reg = <0xc0000080 0x1>, <0xc0000094 0x01>, <0xc0000088 0x08>;
+			interrupts = <0>;
+			interrupt-parent = <&vic0>;
+			clock-frequency = <400000000>;
+		};
+
+		watchdog: watchdog@c0000090 {
+			compatible = "hpe,gxp-wdt";
+			reg = <0xc0000090 0x02>, <0xc0000096 0x01>;
+		};
+
+		uarta: serial@c00000e0 {
+			compatible = "ns16550a";
+			reg = <0xc00000e0 0x8>;
+			interrupts = <17>;
+			interrupt-parent = <&vic0>;
+			clock-frequency = <1846153>;
+			reg-shift = <0>;
+		};
+
+		uartb: serial@c00000e8 {
+			compatible = "ns16550a";
+			reg = <0xc00000e8 0x8>;
+			interrupts = <18>;
+			interrupt-parent = <&vic0>;
+			clock-frequency = <1846153>;
+			reg-shift = <0>;
+		};
+
+		uartc: serial@c00000f0 {
+			compatible = "ns16550a";
+			reg = <0xc00000f0 0x8>;
+			interrupts = <19>;
+			interrupt-parent = <&vic0>;
+			clock-frequency = <1846153>;
+			reg-shift = <0>;
+		};
+
+		usb0: ehci@cefe0000 {
+			compatible = "generic-ehci";
+			reg = <0xcefe0000 0x100>;
+			interrupts = <7>;
+			interrupt-parent = <&vic0>;
+		};
+
+		usb1: ohci@cefe0100 {
+			compatible = "generic-ohci";
+			reg = <0xcefe0100 0x110>;
+			interrupts = <6>;
+			interrupt-parent = <&vic0>;
+		};
+
+		sram@d0000000 {
+			compatible = "mtd-ram";
+			reg = <0xd0000000 0x80000>;
+			bank-width = <1>;
+			erase-size =<1>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "host-reserved";
+				reg = <0x0 0x10000>;
+			};
+			partition@10000 {
+				label = "nvram";
+				reg = <0x10000 0x70000>;
+			};
+		};
+
+		vrom@58000000 {
+			compatible = "mtd-ram";
+			bank-width = <4>;
+			reg = <0x58000000 0x4000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			partition@0 {
+				label = "vrom-prime";
+				reg = <0x0 0x2000000>;
+			};
+			partition@2000000 {
+				label = "vrom-second";
+				reg = <0x2000000 0x2000000>;
+			};
+		};
+
+		i2cg: i2cg@c00000f8 {
+			compatible = "syscon";
+			reg = <0xc00000f8 0x08>;
+		};
+	};
+
+	clocks {
+		osc: osc {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "osc";
+			clock-frequency = <33333333>;
+		};
+
+		iopclk: iopclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clocks = <&osc>;
+			clock-out-put-names = "iopclk";
+			clock-frequency = <400000000>;
+		};
+
+		memclk: memclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clocks = <&osc>;
+			clock-out-put-names = "memclk";
+			clock-frequency = <800000000>;
+		};
+	};
+};
-- 
2.17.1

