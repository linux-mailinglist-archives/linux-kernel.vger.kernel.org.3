Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCC152869A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiEPOMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiEPOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:11:53 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D0A39170;
        Mon, 16 May 2022 07:11:51 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M0fge-1nboeN04Vy-00uoRf;
 Mon, 16 May 2022 16:11:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/24] ARM: dts: imx7-colibri: set regulator-name properties
Date:   Mon, 16 May 2022 16:11:32 +0200
Message-Id: <20220516141132.494450-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7fDkecJiIdWhhkseM2UHEIeRbAfUN9L0fuj/Olpd3l8aVa8q+Ao
 g2UxncVMOsMEiu/58Njd0itutHLKCPiMieSdaXFFy/nZ5BZmnJOwEtZ1FYj8BvGsQCNFjRq
 UHYx1aSwXD0ay4WPWY/51uxoLnkbgIopNndOsNVA+95N9ZQxqxClW7JuI5bhUAJwNeGkH5X
 oliaPghad2qJKEbMCNuOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LWhw25dwow8=:lvjOMp9c7+J/TPSHEJUHhV
 MFMtI1CSViAVge8ftz4M9RjQVhvCFQAhmB0NyJpP4eSNoKMnDYyCKL7mDE0BxzrHXE0cIUOYF
 OUClA8Z1ZuMR8tU7R/87Pp7dIJU52fLkY+5b64lRnCLHQVPRN12lBR23xaP47OWJfAtgbDBlW
 NwfJN7kABIOT6JSyOhRJyvKmwOCm63S+MSVPoskgYk7MARYZSClZV5h571PS7Cb7F6JU/JiVw
 8MubkM8tJz96JZPbb903gDyLyo2oQnLT3G0Mu+vznuQSRFizl2wjoNprFoAqEGMM6mDwsWfEj
 UWuqT5HP4yBzdshpAxha8Y1qMAgktDiJN1aWBk1kCV7pCaJ4jKAYxoTDI2r0NRJNEvzZDeUw+
 6OrdvD8EBt0/hRQfVKxGt9M1dv6dF8g1vSK6m5C7n8qLZwZtkIdyTne/xYJXeaVnicwgQufRM
 VSt+E7umgPDLdU4N22YFRnGAfbEZqREA4mjW/D3Lg5nl58599j1zqE3f03X5SHuRedQtvsrAp
 I1+nsDaJHsly5eQQ7btKKh2Us7hIW03Vv4za9v4TB99bJdA/Ugqv2cEP8kBiCpQ+enTpbRa7X
 QS+S5ruC8yD3YZO+LsJPUNeh9oNzI+nk3I7wVFxpIBncUzNxe8YZeBZ+tW+Ljq+JFZ3j8BV0H
 BPcfqbM7BfZZsd09NeBHdyDCkdj/7xy1kSUzM0IUh8rlJ2QwJeA/CxIrkfXcHamY7Aho=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Migrate comments to proper regulator-name properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7-colibri.dtsi | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index cbe4f072d4ef..27706a2bc3c4 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -424,66 +424,75 @@ pmic@33 {
 		reg = <0x33>;
 
 		regulators {
-			reg_DCDC1: DCDC1 {  /* V1.0_SOC */
+			reg_DCDC1: DCDC1 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <1100000>;
 				regulator-min-microvolt = <1000000>;
+				regulator-name = "+V1.0_SOC";
 			};
 
-			reg_DCDC2: DCDC2 { /* V1.1_ARM */
+			reg_DCDC2: DCDC2 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <1100000>;
 				regulator-min-microvolt = <975000>;
+				regulator-name = "+V1.1_ARM";
 			};
 
-			reg_DCDC3: DCDC3 { /* V1.8 */
+			reg_DCDC3: DCDC3 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <1800000>;
 				regulator-min-microvolt = <1800000>;
+				regulator-name = "+V1.8";
 			};
 
-			reg_DCDC4: DCDC4 { /* V1.35_DRAM */
+			reg_DCDC4: DCDC4 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <1350000>;
 				regulator-min-microvolt = <1350000>;
+				regulator-name = "+V1.35_DRAM";
 			};
 
-			reg_LDO1: LDO1 { /* PWR_EN_+V3.3_ETH */
+			reg_LDO1: LDO1 {
 				regulator-boot-on;
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <3300000>;
+				regulator-name = "PWR_EN_+V3.3_ETH";
 			};
 
-			reg_LDO2: LDO2 { /* +V1.8_SD */
+			reg_LDO2: LDO2 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <1800000>;
+				regulator-name = "+V1.8_SD";
 			};
 
-			reg_LDO3: LDO3 { /* PWR_EN_+V3.3_LPSR */
+			reg_LDO3: LDO3 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <3300000>;
+				regulator-name = "PWR_EN_+V3.3_LPSR";
 			};
 
-			reg_LDO4: LDO4 { /* V1.8_LPSR */
+			reg_LDO4: LDO4 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <1800000>;
 				regulator-min-microvolt = <1800000>;
+				regulator-name = "+V1.8_LPSR";
 			};
 
-			reg_LDO5: LDO5 { /* PWR_EN_+V3.3 */
+			reg_LDO5: LDO5 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <3300000>;
+				regulator-name = "PWR_EN_+V3.3";
 			};
 		};
 	};
-- 
2.35.1

