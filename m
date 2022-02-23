Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659EE4C1D76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbiBWVG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbiBWVGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:06:50 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638834DF79;
        Wed, 23 Feb 2022 13:06:21 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1B05E22247;
        Wed, 23 Feb 2022 22:06:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645650379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SBkyV3Y37C1PQOYlMNcw1v4s6vUf2MzUko1G+h5pAHs=;
        b=gckdT97Tc7r0urgZ5KftgN2f0Ex4RaFi5rRBMzXM0NmKAgahjB/z+P8J6+nyiTCmLJGZRX
        0ZtuIAHT/388SGrl0XFCV5TfuDmZzTUNVq9fWFr27pczWbtnyO4cr41ZQyU/uKamKeF0/P
        5x0Ff1jduV7l6YKdqZUErntuUwAWSLE=
From:   Michael Walle <michael@walle.cc>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     heiko.thiery@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 1/2] arm64: dts: imx8mn-evk: use proper names for PMIC outputs
Date:   Wed, 23 Feb 2022 22:05:58 +0100
Message-Id: <20220223210559.1999209-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the power signal names as given in the schematics of the reference
board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index b4225cfcb6d9..eaa06f49aef5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -41,7 +41,7 @@ pmic: pmic@25 {
 
 		regulators {
 			buck1: BUCK1{
-				regulator-name = "BUCK1";
+				regulator-name = "VDD_ARM_0V9";
 				regulator-min-microvolt = <600000>;
 				regulator-max-microvolt = <2187500>;
 				regulator-boot-on;
@@ -50,7 +50,7 @@ buck1: BUCK1{
 			};
 
 			buck2: BUCK2 {
-				regulator-name = "BUCK2";
+				regulator-name = "VDD_SOC";
 				regulator-min-microvolt = <600000>;
 				regulator-max-microvolt = <2187500>;
 				regulator-boot-on;
@@ -61,7 +61,7 @@ buck2: BUCK2 {
 			};
 
 			buck4: BUCK4{
-				regulator-name = "BUCK4";
+				regulator-name = "VDD_3V3";
 				regulator-min-microvolt = <600000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -69,7 +69,7 @@ buck4: BUCK4{
 			};
 
 			buck5: BUCK5{
-				regulator-name = "BUCK5";
+				regulator-name = "VDD_1V8";
 				regulator-min-microvolt = <600000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -77,7 +77,7 @@ buck5: BUCK5{
 			};
 
 			buck6: BUCK6 {
-				regulator-name = "BUCK6";
+				regulator-name = "NVCC_DRAM_1V1";
 				regulator-min-microvolt = <600000>;
 				regulator-max-microvolt = <3400000>;
 				regulator-boot-on;
@@ -85,7 +85,7 @@ buck6: BUCK6 {
 			};
 
 			ldo1: LDO1 {
-				regulator-name = "LDO1";
+				regulator-name = "NVCC_SNVS_1V8";
 				regulator-min-microvolt = <1600000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -93,7 +93,7 @@ ldo1: LDO1 {
 			};
 
 			ldo2: LDO2 {
-				regulator-name = "LDO2";
+				regulator-name = "VDD_SNVS_0V8";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1150000>;
 				regulator-boot-on;
@@ -101,7 +101,7 @@ ldo2: LDO2 {
 			};
 
 			ldo3: LDO3 {
-				regulator-name = "LDO3";
+				regulator-name = "VDDA_1V8";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -109,7 +109,7 @@ ldo3: LDO3 {
 			};
 
 			ldo4: LDO4 {
-				regulator-name = "LDO4";
+				regulator-name = "VDD_PHY_1V2";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -117,7 +117,7 @@ ldo4: LDO4 {
 			};
 
 			ldo5: LDO5 {
-				regulator-name = "LDO5";
+				regulator-name = "NVCC_SD2";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
-- 
2.30.2

