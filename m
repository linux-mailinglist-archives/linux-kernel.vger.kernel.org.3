Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8F14717AE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhLLBn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:43:58 -0500
Received: from marcansoft.com ([212.63.210.85]:35994 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhLLBn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:43:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id E280E425BB;
        Sun, 12 Dec 2021 01:43:54 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH 2/2] arm64: dts: apple: t8103: Sort nodes by address
Date:   Sun, 12 Dec 2021 10:43:46 +0900
Message-Id: <20211212014346.69320-2-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212014346.69320-1-marcan@marcan.st>
References: <20211212014346.69320-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We decided to keep SoC nodes sorted by address for sanity; fix a couple
that slipped into the wrong place.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 56 ++++++++++++++--------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 33c9ea6c7c63..4950e6340995 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -274,34 +274,6 @@ pcie_pins: pcie-pins {
 			};
 		};
 
-		pmgr_mini: power-management@23d280000 {
-			compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0x2 0x3d280000 0 0x4000>;
-		};
-
-		pinctrl_aop: pinctrl@24a820000 {
-			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
-			reg = <0x2 0x4a820000 0x0 0x4000>;
-
-			gpio-controller;
-			#gpio-cells = <2>;
-			gpio-ranges = <&pinctrl_aop 0 0 42>;
-			apple,npins = <42>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			interrupt-parent = <&aic>;
-			interrupts = <AIC_IRQ 268 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 269 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 270 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 271 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 272 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 273 IRQ_TYPE_LEVEL_HIGH>,
-				     <AIC_IRQ 274 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		pinctrl_nub: pinctrl@23d1f0000 {
 			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x3d1f0000 0x0 0x4000>;
@@ -324,6 +296,13 @@ pinctrl_nub: pinctrl@23d1f0000 {
 				     <AIC_IRQ 336 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pmgr_mini: power-management@23d280000 {
+			compatible = "apple,t8103-pmgr", "apple,pmgr", "syscon", "simple-mfd";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x2 0x3d280000 0 0x4000>;
+		};
+
 		wdt: watchdog@23d2b0000 {
 			compatible = "apple,t8103-wdt", "apple,wdt";
 			reg = <0x2 0x3d2b0000 0x0 0x4000>;
@@ -353,6 +332,27 @@ pinctrl_smc: pinctrl@23e820000 {
 				     <AIC_IRQ 397 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pinctrl_aop: pinctrl@24a820000 {
+			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
+			reg = <0x2 0x4a820000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aop 0 0 42>;
+			apple,npins = <42>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 269 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 270 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 272 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 273 IRQ_TYPE_LEVEL_HIGH>,
+				     <AIC_IRQ 274 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		pcie0_dart_0: dart@681008000 {
 			compatible = "apple,t8103-dart";
 			reg = <0x6 0x81008000 0x0 0x4000>;
-- 
2.33.0

