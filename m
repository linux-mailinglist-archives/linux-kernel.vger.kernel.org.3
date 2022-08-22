Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10B59BAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiHVICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiHVICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:02:00 -0400
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6041C2B1A1;
        Mon, 22 Aug 2022 01:01:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F19C2BFAE8;
        Mon, 22 Aug 2022 10:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1661155317; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=bWW/Mcp6FRxk3hYHeb0NVlS/tciRYIln8vZV2wTf7ww=;
        b=fMV/KNeNGfJlo+dcLotoHj3eso+Z7oy283ct0O8VfSsfWtjQiegvFLE0yGWORsY7dVh+8/
        Iky/tZVz589RHc/sSSZK50JrIyND6l/PeLX1/LbiGlZabeTJDnLyciRVhXiRAP7pyIKN1x
        MMHhxW1ARg7kwDyV51vhYA/bsjcD+M7K8rm5GPSRSyjDYbVmZA+MobMGhDydHm09pzE5JJ
        5Yx307VO+HG5XunDN7uh05bUKiAQehsgp+YcpjYbq7ZR4C7fZSWg39y4ME/TCjKbZjIvI8
        2oxp4EtY4vBtVjxFix5uYP0w5q7ZPUvGAkGaRvZG4dNIQclLy+OoIKst+eLzfQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 6/8] arm64: dts: imx8mm-kontron: Use voltage rail names from schematic for PMIC regulator-names
Date:   Mon, 22 Aug 2022 10:00:59 +0200
Message-Id: <20220822080103.24016-7-frieder@fris.de>
In-Reply-To: <20220822080103.24016-1-frieder@fris.de>
References: <20220822080103.24016-1-frieder@fris.de>
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

Improve the naming of the regulators to contain the voltage rail
names from the schematic.

Suggested-by: Heiko Thiery <heiko.thiery@gmail.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v3:
* rebase on v6.0-rc1

Changes in v2:
* new patch
---
 .../boot/dts/freescale/imx8mm-kontron-sl.dtsi | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
index 96ecdce67059..ce9c27619e26 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
@@ -85,7 +85,7 @@ pca9450: pmic@25 {
 
 		regulators {
 			reg_vdd_soc: BUCK1 {
-				regulator-name = "buck1";
+				regulator-name = "+0V8_VDD_SOC (BUCK1)";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <850000>;
 				regulator-boot-on;
@@ -96,7 +96,7 @@ reg_vdd_soc: BUCK1 {
 			};
 
 			reg_vdd_arm: BUCK2 {
-				regulator-name = "buck2";
+				regulator-name = "+0V9_VDD_ARM (BUCK2)";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <950000>;
 				regulator-boot-on;
@@ -107,7 +107,7 @@ reg_vdd_arm: BUCK2 {
 			};
 
 			reg_vdd_dram: BUCK3 {
-				regulator-name = "buck3";
+				regulator-name = "+0V9_VDD_DRAM&PU (BUCK3)";
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <950000>;
 				regulator-boot-on;
@@ -115,7 +115,7 @@ reg_vdd_dram: BUCK3 {
 			};
 
 			reg_vdd_3v3: BUCK4 {
-				regulator-name = "buck4";
+				regulator-name = "+3V3 (BUCK4)";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
@@ -123,7 +123,7 @@ reg_vdd_3v3: BUCK4 {
 			};
 
 			reg_vdd_1v8: BUCK5 {
-				regulator-name = "buck5";
+				regulator-name = "+1V8 (BUCK5)";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
@@ -131,7 +131,7 @@ reg_vdd_1v8: BUCK5 {
 			};
 
 			reg_nvcc_dram: BUCK6 {
-				regulator-name = "buck6";
+				regulator-name = "+1V1_NVCC_DRAM (BUCK6)";
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
@@ -139,7 +139,7 @@ reg_nvcc_dram: BUCK6 {
 			};
 
 			reg_nvcc_snvs: LDO1 {
-				regulator-name = "ldo1";
+				regulator-name = "+1V8_NVCC_SNVS (LDO1)";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
@@ -147,7 +147,7 @@ reg_nvcc_snvs: LDO1 {
 			};
 
 			reg_vdd_snvs: LDO2 {
-				regulator-name = "ldo2";
+				regulator-name = "+0V8_VDD_SNVS (LDO2)";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
@@ -155,7 +155,7 @@ reg_vdd_snvs: LDO2 {
 			};
 
 			reg_vdda: LDO3 {
-				regulator-name = "ldo3";
+				regulator-name = "+1V8_VDDA (LDO3)";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
@@ -163,7 +163,7 @@ reg_vdda: LDO3 {
 			};
 
 			reg_vdd_phy: LDO4 {
-				regulator-name = "ldo4";
+				regulator-name = "+0V9_VDD_PHY (LDO4)";
 				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
@@ -171,7 +171,7 @@ reg_vdd_phy: LDO4 {
 			};
 
 			reg_nvcc_sd: LDO5 {
-				regulator-name = "ldo5";
+				regulator-name = "NVCC_SD (LDO5)";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 			};
-- 
2.37.1

