Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422184D52A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbiCJTwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343755AbiCJTwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:52:16 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85C7199E0F;
        Thu, 10 Mar 2022 11:51:10 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AI3NvS026223;
        Thu, 10 Mar 2022 19:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=JTtUrMqgvE3d39OeHvoZ8TTt3JTWnI60ocv2Ve6ttmo=;
 b=BaWyy5ERfbtzdyj1H/YdgCzyeQ5pVAsjmdQumQTISfusPeG6996UH5Upo7NlyM04ip3C
 Jc+PjALrx3sxdVaXLm5hbyA6b/33r17aeZspnA02Y1/VbofCUODBcMEZZLXJJIgKxZDw
 ZtkOK5609L5V1gf6Lqq7BdBLC9yK/OW9jxjINX2y6IPFL9SkqpozyVKPjTYrOx6EXM9f
 H0IMFjdsAbCFmhfMvqwgdPU+hdwvSD55xzySEu3jExp11NMkNOqO5CsQF/Rh4oKsMQ6i
 Q311pLpb4/9caRCmtQqAuiMZUtlyHZe7898A5h0VAJ9fvfRqbrpe1CyaMmTyqS7D75aS 3A== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eqb9f7sh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 19:51:02 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 20D8C77;
        Thu, 10 Mar 2022 19:50:51 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com
Cc:     Nick Hawkins <nick.hawkins@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device tree
Date:   Thu, 10 Mar 2022 13:52:28 -0600
Message-Id: <20220310195229.109477-9-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: cyUUBG--l5de2rGnEjaKDr6Qy40y6Vyt
X-Proofpoint-ORIG-GUID: cyUUBG--l5de2rGnEjaKDr6Qy40y6Vyt
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=984 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100101
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The HPE SoC is new to linux. This patch
creates the basic device tree layout with minimum required
for linux to boot. This includes timer and watchdog
support.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 arch/arm/boot/dts/Makefile               |   2 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts |  27 +++++
 arch/arm/boot/dts/hpe-gxp.dtsi           | 148 +++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
 create mode 100644 arch/arm/boot/dts/hpe-gxp.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e41eca79c950..2823b359d373 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1550,3 +1550,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-vegman-n110.dtb \
 	aspeed-bmc-vegman-rx20.dtb \
 	aspeed-bmc-vegman-sx20.dtb
+dtb-$(CONFIG_ARCH_HPE_GXP) += \
+	hpe-bmc-dl360gen10.dtb
diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
new file mode 100644
index 000000000000..da5eac1213a8
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
+		bootargs = "earlyprintk console=ttyS2,115200";
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
index 000000000000..dfaf8df829fe
--- /dev/null
+++ b/arch/arm/boot/dts/hpe-gxp.dtsi
@@ -0,0 +1,148 @@
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
+			device_type = "cpu";
+			reg = <0>;
+		};
+	};
+
+	gxp-init@cefe0010 {
+		compatible = "hpe,gxp-cpu-init";
+		reg = <0xcefe0010 0x04>;
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
+			interrupt-controller;
+			reg = <0xceff0000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		vic1: interrupt-controller@80f00000 {
+			compatible = "arm,pl192-vic";
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
+		usb0: usb@cefe0000 {
+			compatible = "generic-ehci";
+			reg = <0xcefe0000 0x100>;
+			interrupts = <7>;
+			interrupt-parent = <&vic0>;
+		};
+
+		usb1: usb@cefe0100 {
+			compatible = "generic-ohci";
+			reg = <0xcefe0100 0x110>;
+			interrupts = <6>;
+			interrupt-parent = <&vic0>;
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
+		i2cg: syscon@c00000f8 {
+			compatible = "simple-mfd", "syscon";
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
+			clock-output-names = "iopclk";
+			clock-frequency = <400000000>;
+		};
+
+		memclk: memclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-output-names = "memclk";
+			clock-frequency = <800000000>;
+		};
+	};
+};
-- 
2.17.1

