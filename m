Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4CB502909
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352890AbiDOL7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352750AbiDOL7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:59:16 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8380DA8EEB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 04:56:46 -0700 (PDT)
Received: from localhost.localdomain (abxj52.neoplus.adsl.tpnet.pl [83.9.3.52])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id 0B9E43F686;
        Fri, 15 Apr 2022 13:56:43 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/23] ARM: dts: qcom-msm8974*: Fix UART naming
Date:   Fri, 15 Apr 2022 13:56:13 +0200
Message-Id: <20220415115633.575010-4-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415115633.575010-1-konrad.dybcio@somainline.org>
References: <20220415115633.575010-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's either uart10, or blsp2_uart4, not blsp2_uart10, as there aren't 10
UARTs on BLSP2. Fix the naming to align with what's done in arm64/qcom.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts    |  6 +++---
 arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts        | 10 +++++-----
 .../dts/qcom-msm8974-sony-xperia-shinano-castor.dts    |  2 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi                    |  6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
index 069136170198..7bd577e8e941 100644
--- a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
@@ -12,7 +12,7 @@ / {
 
 	aliases {
 		serial0 = &blsp1_uart1;
-		serial1 = &blsp2_uart10;
+		serial1 = &blsp2_uart4;
 	};
 
 	chosen {
@@ -374,7 +374,7 @@ shutdown {
 			};
 		};
 
-		blsp2_uart10_pin_a: blsp2-uart10-pin-active {
+		blsp2_uart4_pin_a: blsp2-uart4-pin-active {
 			tx {
 				pins = "gpio53";
 				function = "blsp_uart10";
@@ -473,7 +473,7 @@ serial@f9960000 {
 		status = "okay";
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&blsp2_uart10_pin_a>;
+		pinctrl-0 = <&blsp2_uart4_pin_a>;
 
 		bluetooth {
 			compatible = "brcm,bcm43438-bt";
diff --git a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
index 96e1c978b878..e4a01a631403 100644
--- a/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-samsung-klte.dts
@@ -326,13 +326,13 @@ serial@f991e000 {
 		status = "okay";
 	};
 
-	/* blsp2_uart8 */
+	/* blsp2_uart2 */
 	serial@f995e000 {
 		status = "okay";
 
 		pinctrl-names = "default", "sleep";
-		pinctrl-0 = <&blsp2_uart8_pins_active>;
-		pinctrl-1 = <&blsp2_uart8_pins_sleep>;
+		pinctrl-0 = <&blsp2_uart2_pins_active>;
+		pinctrl-1 = <&blsp2_uart2_pins_sleep>;
 
 		bluetooth {
 			compatible = "brcm,bcm43540-bt";
@@ -380,14 +380,14 @@ volume-up {
 	};
 
 	pinctrl@fd510000 {
-		blsp2_uart8_pins_active: blsp2-uart8-pins-active {
+		blsp2_uart2_pins_active: blsp2-uart2-pins-active {
 			pins = "gpio45", "gpio46", "gpio47", "gpio48";
 			function = "blsp_uart8";
 			drive-strength = <8>;
 			bias-disable;
 		};
 
-		blsp2_uart8_pins_sleep: blsp2-uart8-pins-sleep {
+		blsp2_uart2_pins_sleep: blsp2-uart2-pins-sleep {
 			pins = "gpio45", "gpio46", "gpio47", "gpio48";
 			function = "gpio";
 			drive-strength = <2>;
diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts
index e66937e3f7dd..d0d03ef12c31 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-shinano-castor.dts
@@ -11,7 +11,7 @@ / {
 
 	aliases {
 		serial0 = &blsp1_uart2;
-		serial1 = &blsp2_uart7;
+		serial1 = &blsp2_uart1;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index e216630a1d02..e102b72558f1 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -713,7 +713,7 @@ blsp1_uart2: serial@f991e000 {
 			status = "disabled";
 		};
 
-		blsp2_uart7: serial@f995d000 {
+		blsp2_uart1: serial@f995d000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf995d000 0x1000>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_NONE>;
@@ -722,7 +722,7 @@ blsp2_uart7: serial@f995d000 {
 			status = "disabled";
 		};
 
-		blsp2_uart8: serial@f995e000 {
+		blsp2_uart2: serial@f995e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf995e000 0x1000>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
@@ -731,7 +731,7 @@ blsp2_uart8: serial@f995e000 {
 			status = "disabled";
 		};
 
-		blsp2_uart10: serial@f9960000 {
+		blsp2_uart4: serial@f9960000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf9960000 0x1000>;
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.35.2

