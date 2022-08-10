Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F98658E9B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiHJJcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiHJJcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:32:47 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066056DFA5;
        Wed, 10 Aug 2022 02:32:45 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A6F2IP021957;
        Wed, 10 Aug 2022 11:32:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=qovgCI/rHlWBP9Q7xRWBKX4sBON8udJGHElHZMj6Q8E=;
 b=Wh4gYNe19Yna6st6HBElBHToRUdGcX4tPC6aCwvdRYtjz7vvXVJKAiv11P9p+rpjxl+c
 mmfhbR4celeu4R5LCG4p+8P0JrdRKXePyI/YbJ0cDcuOPqGpnJBd5gUsVufstPkzK6Hb
 eIq3/M4EdN4BBbUZOPL8Cu4/IgReb/kOdSjH+ZI4qshdVugf/l4zOGCHsMgDFPOsgXxh
 AFJkOKd+R1JCW8dLhvdNmAdMHNuJUJ1+g+dUbm9q3RYGSG1rMoSgkw37p9xuDDrMF0lO
 y63MhQAZK6PWX3kjdRw5QtGJ2CynAgg7j964nsxnjxJ+AHfhosb7G4Fu4V2CbgwZjZyn mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3huwr4kk9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 11:32:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0CB9010002A;
        Wed, 10 Aug 2022 11:32:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 075E021B52F;
        Wed, 10 Aug 2022 11:32:22 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 10 Aug
 2022 11:32:21 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH v2 2/2] ARM: dts: stm32: Create separate pinmux for qspi cs pin in stm32mp15-pinctrl.dtsi
Date:   Wed, 10 Aug 2022 11:32:15 +0200
Message-ID: <20220810093215.794977-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810093215.794977-1-patrice.chotard@foss.st.com>
References: <20220810093215.794977-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_04,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Create a separate pinmux for qspi chip select in stm32mp15-pinctrl.dtsi.
In the case we want to use transfer_one() API to communicate with a SPI
device, chip select signal must be driven individually.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 50 ++++++++++++++++--------
 arch/arm/boot/dts/stm32mp157c-ev1.dts    | 12 +++++-
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index 6052243ad81c..ade4fab45f14 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1189,7 +1189,7 @@ pins {
 	};
 
 	qspi_bk1_pins_a: qspi-bk1-0 {
-		pins1 {
+		pins {
 			pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
 				 <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
 				 <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
@@ -1198,12 +1198,6 @@ pins1 {
 			drive-push-pull;
 			slew-rate = <1>;
 		};
-		pins2 {
-			pinmux = <STM32_PINMUX('B', 6, AF10)>; /* QSPI_BK1_NCS */
-			bias-pull-up;
-			drive-push-pull;
-			slew-rate = <1>;
-		};
 	};
 
 	qspi_bk1_sleep_pins_a: qspi-bk1-sleep-0 {
@@ -1211,13 +1205,12 @@ pins {
 			pinmux = <STM32_PINMUX('F', 8, ANALOG)>, /* QSPI_BK1_IO0 */
 				 <STM32_PINMUX('F', 9, ANALOG)>, /* QSPI_BK1_IO1 */
 				 <STM32_PINMUX('F', 7, ANALOG)>, /* QSPI_BK1_IO2 */
-				 <STM32_PINMUX('F', 6, ANALOG)>, /* QSPI_BK1_IO3 */
-				 <STM32_PINMUX('B', 6, ANALOG)>; /* QSPI_BK1_NCS */
+				 <STM32_PINMUX('F', 6, ANALOG)>; /* QSPI_BK1_IO3 */
 		};
 	};
 
 	qspi_bk2_pins_a: qspi-bk2-0 {
-		pins1 {
+		pins {
 			pinmux = <STM32_PINMUX('H', 2, AF9)>, /* QSPI_BK2_IO0 */
 				 <STM32_PINMUX('H', 3, AF9)>, /* QSPI_BK2_IO1 */
 				 <STM32_PINMUX('G', 10, AF11)>, /* QSPI_BK2_IO2 */
@@ -1226,7 +1219,34 @@ pins1 {
 			drive-push-pull;
 			slew-rate = <1>;
 		};
-		pins2 {
+	};
+
+	qspi_bk2_sleep_pins_a: qspi-bk2-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('H', 2, ANALOG)>, /* QSPI_BK2_IO0 */
+				 <STM32_PINMUX('H', 3, ANALOG)>, /* QSPI_BK2_IO1 */
+				 <STM32_PINMUX('G', 10, ANALOG)>, /* QSPI_BK2_IO2 */
+				 <STM32_PINMUX('G', 7, ANALOG)>; /* QSPI_BK2_IO3 */
+		};
+	};
+
+	qspi_cs1_pins_a: qspi-cs1-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 6, AF10)>; /* QSPI_BK1_NCS */
+			bias-pull-up;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+	};
+
+	qspi_cs1_sleep_pins_a: qspi-cs1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 6, ANALOG)>; /* QSPI_BK1_NCS */
+		};
+	};
+
+	qspi_cs2_pins_a: qspi-cs2-0 {
+		pins {
 			pinmux = <STM32_PINMUX('C', 0, AF10)>; /* QSPI_BK2_NCS */
 			bias-pull-up;
 			drive-push-pull;
@@ -1234,13 +1254,9 @@ pins2 {
 		};
 	};
 
-	qspi_bk2_sleep_pins_a: qspi-bk2-sleep-0 {
+	qspi_cs2_sleep_pins_a: qspi-cs2-sleep-0 {
 		pins {
-			pinmux = <STM32_PINMUX('H', 2, ANALOG)>, /* QSPI_BK2_IO0 */
-				 <STM32_PINMUX('H', 3, ANALOG)>, /* QSPI_BK2_IO1 */
-				 <STM32_PINMUX('G', 10, ANALOG)>, /* QSPI_BK2_IO2 */
-				 <STM32_PINMUX('G', 7, ANALOG)>, /* QSPI_BK2_IO3 */
-				 <STM32_PINMUX('C', 0, ANALOG)>; /* QSPI_BK2_NCS */
+			pinmux = <STM32_PINMUX('C', 0, ANALOG)>; /* QSPI_BK2_NCS */
 		};
 	};
 
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index d142dd30e16b..050c3c27a420 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -255,8 +255,16 @@ &m_can1 {
 
 &qspi {
 	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&qspi_clk_pins_a &qspi_bk1_pins_a &qspi_bk2_pins_a>;
-	pinctrl-1 = <&qspi_clk_sleep_pins_a &qspi_bk1_sleep_pins_a &qspi_bk2_sleep_pins_a>;
+	pinctrl-0 = <&qspi_clk_pins_a
+		     &qspi_bk1_pins_a
+		     &qspi_cs1_pins_a
+		     &qspi_bk2_pins_a
+		     &qspi_cs2_pins_a>;
+	pinctrl-1 = <&qspi_clk_sleep_pins_a
+		     &qspi_bk1_sleep_pins_a
+		     &qspi_cs1_sleep_pins_a
+		     &qspi_bk2_sleep_pins_a
+		     &qspi_cs2_sleep_pins_a>;
 	reg = <0x58003000 0x1000>, <0x70000000 0x4000000>;
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.25.1

