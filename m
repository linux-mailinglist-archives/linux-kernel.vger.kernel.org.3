Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F81D51DF90
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389615AbiEFTSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389700AbiEFTSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:18:03 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E436B0BD;
        Fri,  6 May 2022 12:14:19 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246F2umG022677;
        Fri, 6 May 2022 19:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=TVw+whUeep26mQVxPmdkz6l5/OGMJrfRUc62S0y09dQ=;
 b=A0DJJ0v+Lbmt3pg1torSPkJfJdN6GgT4jr3aBymQo8UvsZdap7c3nBNvLWSUzMDSuCxh
 axkECL+JpYVEFGr03vM1Lw5JKcQSUrf8u8Hd8/2D0aI0Pp8lLssHdTvtGtn3rKembX4Q
 iPuhVA0irPNR0dRymcrgEkxIbLqqhpzvGHY40KF57mZ82T7AdTtQnSskurJtZeBuhAuI
 LGVl13dVaYpEIBPlLydo93uwa2tp9l8dIVVsmwQiQ15B7l01ZczX1q8qCUrASb8KRrAf
 rLyw8dY6vRwtH26yQGiTuPQUt1ked8XdLFK386P/mcFbgO4Z3gQwuU9RqTrRZhXcL4li AQ== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fvee1nv8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 19:14:09 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 4A2684F;
        Fri,  6 May 2022 19:14:08 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id D541748;
        Fri,  6 May 2022 19:14:07 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v7 7/8] ARM: dts: Introduce HPE GXP Device tree
Date:   Fri,  6 May 2022 14:13:38 -0500
Message-Id: <20220506191339.78617-7-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506191339.78617-1-nick.hawkins@hpe.com>
References: <20220506191339.78617-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: hA8nQBP2RiB59lFnImnsVJ8K_eghE7xI
X-Proofpoint-GUID: hA8nQBP2RiB59lFnImnsVJ8K_eghE7xI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_07,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060097
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The HPE SoC is new to linux. A basic device tree layout with minimum
required for linux to boot including a timer and watchdog support has
been created.

The dts file is empty at this point but will be updated in subsequent
updates as board specific features are enabled.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v7:
* Changed cache register area length from 0xFFC to 0x1000
* Added space between "," in compatible list for the
  hpe-bmc-dl360gen10.dts
* Added aliases, chosen, and memory to hpe-bmc-dl360gen10.dts
* Removed memory from hpe-gxp.dtsi
v6:
* Added cache-controller to CPU
* Removed hpe,gxp-wdt and removed simple-mfd from hpe,gxp-timer
* Added space after ',' in compatible lists in the dtsi containing more
  than one item
* Switched clock name iopclk to iop based on feedback from
  hpe,gxp-timer.yaml
* Added clock labels clock-0 and clock-1
* Added dma-ranges to ahb
* Changed subject to better match ones in the log
* Changed description to fit 75 characters per line
v5:
* Fixed commit message to show previous changes
* Fixed typo ehci -> echi
v4:
* Removed hpe,gxp-cpu-init as it was no longer necessary
* Removed bootargs as requested
* Removed empty ahb node
* Moved reg after compatible, everywhere
* Removed osc and memclk
* Removed syscon@c00000f8 as it was not necessary for boot
* Fixed Alphabetical issue in dts/Makefile
* Added specific board binding for dl360gen10
* Removed empty node
* Added Accurate Clock Architecture
* Fixed generic-echi and generic-ochi issues
* Removed i2cg
v3:
* Fixed issues with warnings
* Used proper patchset format
v2:
* Reduced size of dtsi to essential components
* Followed the proper format for having a dtsi and
  dts
---
 arch/arm/boot/dts/Makefile               |   2 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts |  26 +++++
 arch/arm/boot/dts/hpe-gxp.dtsi           | 127 +++++++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
 create mode 100644 arch/arm/boot/dts/hpe-gxp.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7c16f8a2b738..293717719c70 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -255,6 +255,8 @@ dtb-$(CONFIG_ARCH_HISI) += \
 	hi3519-demb.dtb
 dtb-$(CONFIG_ARCH_HIX5HD2) += \
 	hisi-x5hd2-dkb.dtb
+dtb-$(CONFIG_ARCH_HPE_GXP) += \
+	hpe-bmc-dl360gen10.dtb
 dtb-$(CONFIG_ARCH_INTEGRATOR) += \
 	integratorap.dtb \
 	integratorap-im-pd1.dtb \
diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
new file mode 100644
index 000000000000..3a7382ce40ef
--- /dev/null
+++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
@@ -0,0 +1,26 @@
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
+	compatible = "hpe,gxp-dl360gen10", "hpe,gxp";
+	model = "Hewlett Packard Enterprise ProLiant dl360 Gen10";
+
+	aliases {
+		serial0 = &uartc;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x20000000>;
+	};
+};
diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
new file mode 100644
index 000000000000..cf735b3c4f35
--- /dev/null
+++ b/arch/arm/boot/dts/hpe-gxp.dtsi
@@ -0,0 +1,127 @@
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
+			compatible = "arm,cortex-a9";
+			reg = <0>;
+			device_type = "cpu";
+			next-level-cache = <&L2>;
+		};
+	};
+
+	clocks {
+		pll: clock-0 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1600000000>;
+		};
+
+		iopclk: clock-1 {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clocks = <&pll>;
+		};
+	};
+
+	axi {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		dma-ranges;
+
+		L2: cache-controller@b0040000 {
+			compatible = "arm,pl310-cache";
+			reg = <0xb0040000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		ahb@c0000000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xc0000000 0x30000000>;
+			dma-ranges;
+
+			vic0: interrupt-controller@eff0000 {
+				compatible = "arm,pl192-vic";
+				reg = <0xeff0000 0x1000>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			vic1: interrupt-controller@80f00000 {
+				compatible = "arm,pl192-vic";
+				reg = <0x80f00000 0x1000>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			uarta: serial@e0 {
+				compatible = "ns16550a";
+				reg = <0xe0 0x8>;
+				interrupts = <17>;
+				interrupt-parent = <&vic0>;
+				clock-frequency = <1846153>;
+				reg-shift = <0>;
+			};
+
+			uartb: serial@e8 {
+				compatible = "ns16550a";
+				reg = <0xe8 0x8>;
+				interrupts = <18>;
+				interrupt-parent = <&vic0>;
+				clock-frequency = <1846153>;
+				reg-shift = <0>;
+			};
+
+			uartc: serial@f0 {
+				compatible = "ns16550a";
+				reg = <0xf0 0x8>;
+				interrupts = <19>;
+				interrupt-parent = <&vic0>;
+				clock-frequency = <1846153>;
+				reg-shift = <0>;
+			};
+
+			usb0: usb@efe0000 {
+				compatible = "hpe,gxp-ehci", "generic-ehci";
+				reg = <0xefe0000 0x100>;
+				interrupts = <7>;
+				interrupt-parent = <&vic0>;
+			};
+
+			st: timer@80 {
+				compatible = "hpe,gxp-timer";
+				reg = <0x80 0x16>;
+				interrupts = <0>;
+				interrupt-parent = <&vic0>;
+				clocks = <&iopclk>;
+				clock-names = "iop";
+			};
+
+			usb1: usb@efe0100 {
+				compatible = "hpe,gxp-ohci", "generic-ohci";
+				reg = <0xefe0100 0x110>;
+				interrupts = <6>;
+				interrupt-parent = <&vic0>;
+			};
+		};
+	};
+};
-- 
2.17.1

