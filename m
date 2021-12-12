Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29304717AD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhLLBn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:43:56 -0500
Received: from marcansoft.com ([212.63.210.85]:35968 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhLLBnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:43:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D1B3642598;
        Sun, 12 Dec 2021 01:43:51 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH 1/2] arm64: dts: apple: t8103: Rename clk24 to clkref
Date:   Sun, 12 Dec 2021 10:43:45 +0900
Message-Id: <20211212014346.69320-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now know that this frequency comes from the external reference
oscillator and is used for various SoC blocks, and isn't just a random
24MHz clock, so let's call it something more appropriate.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 8203c60d4819..33c9ea6c7c63 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -96,11 +96,11 @@ timer {
 			     <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	clk24: clock-24m {
+	clkref: clock-ref {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
-		clock-output-names = "clk24";
+		clock-output-names = "clkref";
 	};
 
 	soc {
@@ -114,7 +114,7 @@ soc {
 		i2c0: i2c@235010000 {
 			compatible = "apple,t8103-i2c", "apple,i2c";
 			reg = <0x2 0x35010000 0x0 0x4000>;
-			clocks = <&clk24>;
+			clocks = <&clkref>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 627 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-0 = <&i2c0_pins>;
@@ -127,7 +127,7 @@ i2c0: i2c@235010000 {
 		i2c1: i2c@235014000 {
 			compatible = "apple,t8103-i2c", "apple,i2c";
 			reg = <0x2 0x35014000 0x0 0x4000>;
-			clocks = <&clk24>;
+			clocks = <&clkref>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 628 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-0 = <&i2c1_pins>;
@@ -140,7 +140,7 @@ i2c1: i2c@235014000 {
 		i2c2: i2c@235018000 {
 			compatible = "apple,t8103-i2c", "apple,i2c";
 			reg = <0x2 0x35018000 0x0 0x4000>;
-			clocks = <&clk24>;
+			clocks = <&clkref>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 629 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-0 = <&i2c2_pins>;
@@ -154,7 +154,7 @@ i2c2: i2c@235018000 {
 		i2c3: i2c@23501c000 {
 			compatible = "apple,t8103-i2c", "apple,i2c";
 			reg = <0x2 0x3501c000 0x0 0x4000>;
-			clocks = <&clk24>;
+			clocks = <&clkref>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 630 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-0 = <&i2c3_pins>;
@@ -167,7 +167,7 @@ i2c3: i2c@23501c000 {
 		i2c4: i2c@235020000 {
 			compatible = "apple,t8103-i2c", "apple,i2c";
 			reg = <0x2 0x35020000 0x0 0x4000>;
-			clocks = <&clk24>;
+			clocks = <&clkref>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 631 IRQ_TYPE_LEVEL_HIGH>;
 			pinctrl-0 = <&i2c4_pins>;
@@ -188,7 +188,7 @@ serial0: serial@235200000 {
 			 * TODO: figure out the clocking properly, there may
 			 * be a third selectable clock.
 			 */
-			clocks = <&clk24>, <&clk24>;
+			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
 			power-domains = <&ps_uart0>;
 			status = "disabled";
@@ -200,7 +200,7 @@ serial2: serial@235208000 {
 			reg-io-width = <4>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 607 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk24>, <&clk24>;
+			clocks = <&clkref>, <&clkref>;
 			clock-names = "uart", "clk_uart_baud0";
 			power-domains = <&ps_uart2>;
 			status = "disabled";
@@ -327,7 +327,7 @@ pinctrl_nub: pinctrl@23d1f0000 {
 		wdt: watchdog@23d2b0000 {
 			compatible = "apple,t8103-wdt", "apple,wdt";
 			reg = <0x2 0x3d2b0000 0x0 0x4000>;
-			clocks = <&clk24>;
+			clocks = <&clkref>;
 			interrupt-parent = <&aic>;
 			interrupts = <AIC_IRQ 338 IRQ_TYPE_LEVEL_HIGH>;
 		};
-- 
2.33.0

