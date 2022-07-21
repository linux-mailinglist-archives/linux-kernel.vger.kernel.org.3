Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784C057CEF0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiGUPaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGUPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:30:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A5724F2E;
        Thu, 21 Jul 2022 08:30:09 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LFJdOd006832;
        Thu, 21 Jul 2022 17:29:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=wFw+9MtYX34VtKeZy9kUu51hTbB86KM3IiU9bAj+FLY=;
 b=AGl9CIFVLELsc4c7+ip8dbNZeasHOjGtfDwyo9q8VTWpCbosRS72+dBBjgz0K4ePqaxV
 aKjUE2wIe9aIYaCyh0q4kBW+n/HmLgjXKsRv0XfE29iGyYQzl7yDzJ34QslBaMM+x+8Z
 WXa8ltRvQ4hpXvOh1qImM7Icn7YU6ndtBIkLW7NUikpenbEYUKBlsxDeKv2yqgDY++hD
 PkFLQFxtLxsNhcBzVj+oz+XfViqeYPqhU8v4+riF/08hN12mSenZnZE3M9RJ+AF4INee
 HBQW03jaZssNn1IqpOcYKF9vj/U03oJgGeOJx/7fWrXy6Db4nuAIlkn1t0UC55eNFu90 Zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hbnp6du3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 17:29:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CEC5F100038;
        Thu, 21 Jul 2022 17:29:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CA699226FCC;
        Thu, 21 Jul 2022 17:29:52 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 21 Jul
 2022 17:29:52 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <alexandre.torgue@foss.st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>
Subject: [PATCH 2/2] ARM: dts: stm32: enable i2c1 and i2c5 on stm32mp135f-dk.dts
Date:   Thu, 21 Jul 2022 17:29:33 +0200
Message-ID: <20220721152933.3805272-3-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721152933.3805272-1-alain.volmat@foss.st.com>
References: <20220721152933.3805272-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the two i2c busses i2c1 and i2c5 available on the
stm32mp135f-dk Discovery board.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 34 ++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp135f-dk.dts     | 26 ++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
index d2472cd8f1d0..749078ba9d42 100644
--- a/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp13-pinctrl.dtsi
@@ -6,6 +6,40 @@
 #include <dt-bindings/pinctrl/stm32-pinfunc.h>
 
 &pinctrl {
+	i2c1_pins_a: i2c1-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
+				 <STM32_PINMUX('E', 8, AF5)>; /* I2C1_SDA */
+			bias-disable;
+			drive-open-drain;
+			slew-rate = <0>;
+		};
+	};
+
+	i2c1_sleep_pins_a: i2c1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 12, ANALOG)>, /* I2C1_SCL */
+				 <STM32_PINMUX('E', 8, ANALOG)>; /* I2C1_SDA */
+		};
+	};
+
+	i2c5_pins_a: i2c5-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 1, AF4)>, /* I2C5_SCL */
+				 <STM32_PINMUX('H', 6, AF4)>; /* I2C5_SDA */
+			bias-disable;
+			drive-open-drain;
+			slew-rate = <0>;
+		};
+	};
+
+	i2c5_sleep_pins_a: i2c5-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('D', 1, ANALOG)>, /* I2C5_SCL */
+				 <STM32_PINMUX('H', 6, ANALOG)>; /* I2C5_SDA */
+		};
+	};
+
 	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
 		pins {
 			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
index e6b8ffd332c7..3e2823332d51 100644
--- a/arch/arm/boot/dts/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
@@ -68,6 +68,32 @@ vdd_sd: vdd-sd {
 	};
 };
 
+&i2c1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c1_pins_a>;
+	pinctrl-1 = <&i2c1_sleep_pins_a>;
+	i2c-scl-rising-time-ns = <96>;
+	i2c-scl-falling-time-ns = <3>;
+	clock-frequency = <1000000>;
+	status = "okay";
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+};
+
+&i2c5 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&i2c5_pins_a>;
+	pinctrl-1 = <&i2c5_sleep_pins_a>;
+	i2c-scl-rising-time-ns = <170>;
+	i2c-scl-falling-time-ns = <5>;
+	clock-frequency = <400000>;
+	status = "okay";
+	/* spare dmas for other usage */
+	/delete-property/dmas;
+	/delete-property/dma-names;
+};
+
 &iwdg2 {
 	timeout-sec = <32>;
 	status = "okay";
-- 
2.25.1

