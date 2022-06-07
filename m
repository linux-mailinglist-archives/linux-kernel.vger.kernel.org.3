Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41954034F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbiFGQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiFGQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:03:04 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E22C110;
        Tue,  7 Jun 2022 09:03:01 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 257E4aEK008111;
        Tue, 7 Jun 2022 18:02:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=nb5LpqJUj5iizl/xOOfiQHg6cuAiGW78cC6YDScMeX8=;
 b=2gOz6fK+uQsK+kY8GliGVTAUIgswgYKoCND3JGle4iiaDIAyNuhv+d51fvA2rx19tESo
 e+kJscvSvyyWAWrqp/b8GgMADtyfYDRiU+o7TqjNdwSvVxdj4zEOcrZNZDTNQ2OVcCv4
 j6/Vi/vddrnF+Lmx6eTd4UnpUZWAIDNCzDTWRaszdde6Y8Z0w4zL/AdR9CujVi6zzfzh
 scrbjUIRZBLm9G8LIXlmJEKP+LoVc1KiVWqUNQCNTRW+AKh4KN6cHSM+bvPL8vzDHzPR
 dAttHZ82BwGzMKP/sVnAapeW6u4h/tGNTADEFQEHJWGI2uCeQg+VDxkVfWzKN7daFmTt jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gfvhaas2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jun 2022 18:02:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F35E510002A;
        Tue,  7 Jun 2022 18:02:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 17BBE231519;
        Tue,  7 Jun 2022 18:02:39 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 7 Jun
 2022 18:02:38 +0200
From:   Alexandre Torgue <alexandre.torgue@foss.st.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: stm32: move SCMI related nodes in a dedicated file for stm32mp15
Date:   Tue, 7 Jun 2022 18:02:38 +0200
Message-ID: <20220607160238.17200-1-alexandre.torgue@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-07_07,2022-06-07_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a "secure" version of STM32 boards (DK1/DK2/ED1/EV1), SCMI (clock/
reset) protocol and OP-TEE node have been added in SoC dtsi file
(stm32mp151.dtsi). They have been added with a status disabled in order to
keep our legacy unchanged. It is actually not enough to keep our legacy
unchanged.

First, just a reminder about our use case: TF-A (BL2) loads and starts
OP-TEE, then loads and runs U-Boot. U-Boot code checks if an OP-TEE is
running, if yes it searches in Kernel device tree if an OP-TEE node is
present:

-If the OP-TEE node is not present then U-Boot copies OP-TEE node and its
reserved memory region from U-Boot device tree to the kernel device tree.

-If the OP-TEE node is present then it does nothing (this OP-TEE node will
be used by Linux). So U-Boot lets the kernel device tree unchanged thinking
it is correct for an OP-TEE usage. It is the case for our legacy boards,
the OP-TEE node is present (although disabled) but the reserved memory
region is not declared. As no memory region has been reserved for OP-TEE,
the end of DDR is seen by the kernel as free and then used for CMA. But as
OP-TEE is running, this end of DDR is already used by OP-TEE. So as soon as
kernel tries to access to the CMA region OP-TEE raises an error.

To fix it, all OP-TEE node and SCMI is moved in a dedicated file.

Fixes: 40b4157dbd8c ("ARM: dts: stm32: enable optee firmware and SCMI support on STM32MP15")
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp15-scmi.dtsi b/arch/arm/boot/dts/stm32mp15-scmi.dtsi
new file mode 100644
index 000000000000..e90cf3acd0b3
--- /dev/null
+++ b/arch/arm/boot/dts/stm32mp15-scmi.dtsi
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
+ * Author: Alexandre Torgue <alexandre.torgue@foss.st.com> for STMicroelectronics.
+ */
+
+/ {
+	firmware {
+		optee: optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		scmi: scmi {
+			compatible = "linaro,scmi-optee";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			linaro,optee-channel-id = <0>;
+			shmem = <&scmi_shm>;
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
+		};
+	};
+
+	soc {
+		scmi_sram: sram@2ffff000 {
+			compatible = "mmio-sram";
+			reg = <0x2ffff000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x2ffff000 0x1000>;
+
+			scmi_shm: scmi-sram@0 {
+				compatible = "arm,scmi-shmem";
+				reg = <0 0x80>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 1b2fd3426a81..7fdc324b3cf9 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -115,33 +115,6 @@
 		status = "disabled";
 	};
 
-	firmware {
-		optee: optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-			status = "disabled";
-		};
-
-		scmi: scmi {
-			compatible = "linaro,scmi-optee";
-			#address-cells = <1>;
-			#size-cells = <0>;
-			linaro,optee-channel-id = <0>;
-			shmem = <&scmi_shm>;
-			status = "disabled";
-
-			scmi_clk: protocol@14 {
-				reg = <0x14>;
-				#clock-cells = <1>;
-			};
-
-			scmi_reset: protocol@16 {
-				reg = <0x16>;
-				#reset-cells = <1>;
-			};
-		};
-	};
-
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -149,20 +122,6 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
-		scmi_sram: sram@2ffff000 {
-			compatible = "mmio-sram";
-			reg = <0x2ffff000 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x2ffff000 0x1000>;
-
-			scmi_shm: scmi-sram@0 {
-				compatible = "arm,scmi-shmem";
-				reg = <0 0x80>;
-				status = "disabled";
-			};
-		};
-
 		timers2: timer@40000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
index e3d3f3f30c7d..36371d6ed660 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "stm32mp157a-dk1.dts"
+#include "stm32mp15-scmi.dtsi"
 
 / {
 	model = "STMicroelectronics STM32MP157A-DK1 SCMI Discovery Board";
@@ -54,10 +55,6 @@
 	resets = <&scmi_reset RST_SCMI_MCU>;
 };
 
-&optee {
-	status = "okay";
-};
-
 &rcc {
 	compatible = "st,stm32mp1-rcc-secure", "syscon";
 	clock-names = "hse", "hsi", "csi", "lse", "lsi";
@@ -76,11 +73,3 @@
 &rtc {
 	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
 };
-
-&scmi {
-	status = "okay";
-};
-
-&scmi_shm {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
index 45dcd299aa9e..03226a596904 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "stm32mp157c-dk2.dts"
+#include "stm32mp15-scmi.dtsi"
 
 / {
 	model = "STMicroelectronics STM32MP157C-DK2 SCMI Discovery Board";
@@ -63,10 +64,6 @@
 	resets = <&scmi_reset RST_SCMI_MCU>;
 };
 
-&optee {
-	status = "okay";
-};
-
 &rcc {
 	compatible = "st,stm32mp1-rcc-secure", "syscon";
 	clock-names = "hse", "hsi", "csi", "lse", "lsi";
@@ -85,11 +82,3 @@
 &rtc {
 	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
 };
-
-&scmi {
-	status = "okay";
-};
-
-&scmi_shm {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
index 458e0ca3cded..c1a79272c068 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "stm32mp157c-ed1.dts"
+#include "stm32mp15-scmi.dtsi"
 
 / {
 	model = "STMicroelectronics STM32MP157C-ED1 SCMI eval daughter";
@@ -59,10 +60,6 @@
 	resets = <&scmi_reset RST_SCMI_MCU>;
 };
 
-&optee {
-	status = "okay";
-};
-
 &rcc {
 	compatible = "st,stm32mp1-rcc-secure", "syscon";
 	clock-names = "hse", "hsi", "csi", "lse", "lsi";
@@ -81,11 +78,3 @@
 &rtc {
 	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
 };
-
-&scmi {
-	status = "okay";
-};
-
-&scmi_shm {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
index df9c113edb4b..7842384ddbe4 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "stm32mp157c-ev1.dts"
+#include "stm32mp15-scmi.dtsi"
 
 / {
 	model = "STMicroelectronics STM32MP157C-EV1 SCMI eval daughter on eval mother";
@@ -68,10 +69,6 @@
 	resets = <&scmi_reset RST_SCMI_MCU>;
 };
 
-&optee {
-	status = "okay";
-};
-
 &rcc {
 	compatible = "st,stm32mp1-rcc-secure", "syscon";
 	clock-names = "hse", "hsi", "csi", "lse", "lsi";
@@ -90,11 +87,3 @@
 &rtc {
 	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
 };
-
-&scmi {
-	status = "okay";
-};
-
-&scmi_shm {
-	status = "okay";
-};
-- 
2.17.1

