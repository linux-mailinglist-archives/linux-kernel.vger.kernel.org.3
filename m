Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D0572F81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiGMHrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiGMHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:47:41 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97F2E5DD3;
        Wed, 13 Jul 2022 00:47:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CAE39C01DA;
        Wed, 13 Jul 2022 09:41:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1657698107; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=vSJoVm9+bdQ/o3Q6dZ6Jra7Qci1VIKd+fIskH70gakE=;
        b=j39BPDn7iBdsswlFGxjDdRGTbpLds5P13f8E7riq3tbSrs2nnanBrqATxOtMmIlAWGm4Y0
        6NEpbyoJV+GPshesxdbDcJrBHQi73O3jTQChCdSRBLreAdhJgUiStxj4Q+nuBGYG6JKSL6
        JKIJBdxZ2ZMeJK+4e1nYhkEMmfhWplQMRbtxxLTQTxdyUzFOIM1h2xelXldf/seoi1KBnz
        nKhtjvg6NStbRFF1EmJkQ9ZDw9Ygt/lzGBZRpMerj2ZjY6PKPKdVodPPhe/7gHxi7yWdqL
        by0mhBgcWHP2SZ31wq9YyZWYhdDXGCA0Q7dxBtbKUn8gMa20EazfLFRw0oDRvA==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 4/6] arm64: dts: imx8mm-kontron: Use upper case PMIC regulator names
Date:   Wed, 13 Jul 2022 09:41:15 +0200
Message-Id: <20220713074118.14733-5-frieder@fris.de>
In-Reply-To: <20220713074118.14733-1-frieder@fris.de>
References: <20220713074118.14733-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Use upper case PMIC regulator names to comply with the bindings.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 .../freescale/imx8mm-kontron-n801x-som.dtsi   | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 2d0661cce89b..2e3d51bbf92e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -85,7 +85,7 @@ pca9450: pmic@25 {
 
 		regulators {
 			reg_vdd_soc: BUCK1 {
-				regulator-name = "buck1";
+				regulator-name = "BUCK1";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <850000>;
 				regulator-boot-on;
@@ -96,7 +96,7 @@ reg_vdd_soc: BUCK1 {
 			};
 
 			reg_vdd_arm: BUCK2 {
-				regulator-name = "buck2";
+				regulator-name = "BUCK2";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <950000>;
 				regulator-boot-on;
@@ -107,7 +107,7 @@ reg_vdd_arm: BUCK2 {
 			};
 
 			reg_vdd_dram: BUCK3 {
-				regulator-name = "buck3";
+				regulator-name = "BUCK3";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <950000>;
 				regulator-boot-on;
@@ -115,7 +115,7 @@ reg_vdd_dram: BUCK3 {
 			};
 
 			reg_vdd_3v3: BUCK4 {
-				regulator-name = "buck4";
+				regulator-name = "BUCK4";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -123,7 +123,7 @@ reg_vdd_3v3: BUCK4 {
 			};
 
 			reg_vdd_1v8: BUCK5 {
-				regulator-name = "buck5";
+				regulator-name = "BUCK5";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
@@ -131,7 +131,7 @@ reg_vdd_1v8: BUCK5 {
 			};
 
 			reg_nvcc_dram: BUCK6 {
-				regulator-name = "buck6";
+				regulator-name = "BUCK6";
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
@@ -139,7 +139,7 @@ reg_nvcc_dram: BUCK6 {
 			};
 
 			reg_nvcc_snvs: LDO1 {
-				regulator-name = "ldo1";
+				regulator-name = "LDO1";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
@@ -147,7 +147,7 @@ reg_nvcc_snvs: LDO1 {
 			};
 
 			reg_vdd_snvs: LDO2 {
-				regulator-name = "ldo2";
+				regulator-name = "LDO2";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
@@ -155,7 +155,7 @@ reg_vdd_snvs: LDO2 {
 			};
 
 			reg_vdda: LDO3 {
-				regulator-name = "ldo3";
+				regulator-name = "LDO3";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
@@ -163,7 +163,7 @@ reg_vdda: LDO3 {
 			};
 
 			reg_vdd_phy: LDO4 {
-				regulator-name = "ldo4";
+				regulator-name = "LDO4";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
@@ -171,7 +171,7 @@ reg_vdd_phy: LDO4 {
 			};
 
 			reg_nvcc_sd: LDO5 {
-				regulator-name = "ldo5";
+				regulator-name = "LDO5";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 			};
-- 
2.37.0

