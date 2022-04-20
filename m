Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1463C508B73
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379947AbiDTPD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379871AbiDTPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:02:55 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD2AFD1B;
        Wed, 20 Apr 2022 08:00:06 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KEXKZw028897;
        Wed, 20 Apr 2022 14:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=FThOS7HgbypSTpDCD5OKTFFor5T4+jTmD4Iwx6tYZX0=;
 b=lIOfWNcxZfehIAUKpbhFrc0w6F2ZkcMkwmAvvUR0wBT60XXB6RcZqzQyxa5AL5b0UU0W
 qMYBvmba9173YouY8XGvDF6zmG02RJJJhhnaE0goyATaeHzUCwE+Qtuk+2Wzz45l3KN8
 zSO3l47CNG5z1Go5fbZzwj9A5ARnMRGWbRv6DriyiDIcfYaGDF2gbS8ac2eJKuGRofV/
 DwSRleckCJM0CtamyuXEaD+FSGfvT8DZ3V2DSVP6M6JZ3ByvLXz0S5ye/8lZouAbdhGj
 2GsYP+h/srVk+eZZNFcj8r3RweyGLZmFxIwzsvo2oDowfH6kGqJQOMBhKuaulUGI2FZ/ fQ== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjm1k88cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:59:56 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 9C3D281;
        Wed, 20 Apr 2022 14:59:55 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 4B52D37;
        Wed, 20 Apr 2022 14:59:55 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick@hpe.com, joel@jms.id.au, arnd@arndb.de
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/11] arch: arm: boot: dts: Introduce HPE GXP Device tree
Date:   Wed, 20 Apr 2022 10:01:54 -0500
Message-Id: <20220420150156.47405-10-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420150156.47405-1-nick.hawkins@hpe.com>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: VbaIKAmvfJ-MdR-4g8vWqyoWrBSrwhy-
X-Proofpoint-GUID: VbaIKAmvfJ-MdR-4g8vWqyoWrBSrwhy-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200089
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

The dts file is empty at this point but will be
updated in subsequent updates as board specific features
are enabled.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
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
---
 arch/arm/boot/dts/Makefile               |   2 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts |  13 +++
 arch/arm/boot/dts/hpe-gxp.dtsi           | 128 +++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
 create mode 100644 arch/arm/boot/dts/hpe-gxp.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e41eca79c950..a217c403c819 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -250,6 +250,8 @@ dtb-$(CONFIG_ARCH_HISI) += \
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
index 000000000000..69e9c6672ea8
--- /dev/null
+++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
@@ -0,0 +1,13 @@
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
+	compatible = "hpe,gxp-dl360gen10","hpe,gxp";
+	model = "Hewlett Packard Enterprise ProLiant dl360 Gen10";
+};
diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
new file mode 100644
index 000000000000..e0b77f4a799a
--- /dev/null
+++ b/arch/arm/boot/dts/hpe-gxp.dtsi
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for HPE GXP
+ */
+
+/dts-v1/;
+/ {
+	model = "Hewlett Packard Enterprise GXP BMC";
+	compatible = "hpe,gxp","hpe,gxp-dl360gen10";
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
+		};
+	};
+
+	clocks {
+
+		pll: pll {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <1600000000>;
+		};
+
+		iopclk: iopclk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <4>;
+			clock-mult = <1>;
+			clocks = <&pll>;
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x20000000>;
+	};
+
+	axi {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		dma-ranges;
+
+		ahb@c0000000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0xc0000000 0x30000000>;
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
+				compatible = "hpe,gxp-echi","generic-ehci";
+				reg = <0xefe0000 0x100>;
+				interrupts = <7>;
+				interrupt-parent = <&vic0>;
+			};
+
+			st: timer@80 {
+				compatible = "hpe,gxp-timer","simple-mfd";
+				reg = <0x80 0x16>;
+				interrupts = <0>;
+				interrupt-parent = <&vic0>;
+				clocks = <&iopclk>;
+				clock-names = "iopclk";
+				watchdog {
+					compatible = "hpe,gxp-wdt";
+				};
+			};
+
+			usb1: usb@efe0100 {
+				compatible = "hpe,gxp-ohci","generic-ohci";
+				reg = <0xefe0100 0x110>;
+				interrupts = <6>;
+				interrupt-parent = <&vic0>;
+			};
+		};
+	};
+
+};
-- 
2.17.1

