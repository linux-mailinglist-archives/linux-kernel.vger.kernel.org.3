Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD3E5A2FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiHZTXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241984AbiHZTXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:23:23 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F81FBD74A;
        Fri, 26 Aug 2022 12:23:21 -0700 (PDT)
Received: from toolbox.int.toradex.com ([104.5.61.88]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MAxNa-1obaYC2O3Q-009ylT;
 Fri, 26 Aug 2022 21:23:00 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/5] ARM: dts: imx6sl: use tabs for code indent
Date:   Fri, 26 Aug 2022 21:22:48 +0200
Message-Id: <20220826192252.794651-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826192252.794651-1-marcel@ziswiler.com>
References: <20220826192252.794651-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9lDwyVjEVDSvIfUZAiZVxnA/2RAVdX8hKdg+kkZ+gZLLhLBLiSU
 IOXg9nzNfbx1g0QlxllestKkhgqJhCyB9Fks+It459IAPuq+uDZRbWY87J9avrrZ9xCXNAO
 9NrykUsjC6BEEzaXbs2WPxQM2v/8SjBSOugoYCE+gZnpc71rSK4BkFYuqsdQq0TWY+I/o6L
 YtLbcTeDYLDy3oFe50Auw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+r7/XnQsCtE=:NZ2WhorXxIHbxpgU/Rz8Ja
 ifczISVUvjfssEF01l+DAYKVnKaPGx6f7f7ppQY7pUgFG8mqB/4RNAI+UJDOo/Zm/MNhEdCeA
 k445AMpWL+Efp/hIdWMLT5t+dnp8Q0eV6Uc3rtjqFWArR225JvMR7MRJp3ABsJoqgMTGCADjk
 s50nO0crElgzvHRbQsC3VSYDRayqxow36lXvRG67IgJIiEh8Jpd87jBNeBDCcRyWQ3A+kG+BE
 TwqOUA/91tWBEAVNKxYU3FujS5mRPm6+HhEG7S3ZRsN4lrjwrLHaSTpgt1BcNNv2uudzj3iEx
 2EoNjpUsBbB3M3zS08RfBm5x4qSY7qUMPlMcVAE8NKV3BTjn45NjLXkcQ3EMCEFsPg5RVyVBt
 8z9UgsG7wGPk7chWsambLYxPE3Taii99m4akFuXnK7wpZguEta1fu2a0A47HB+rgEGhpGrgHo
 4AOovqTHAy/gTBFLfUhxRovzl1NIg3MbV6VW8pptZm164k0yxF4YNHTzuadeOOOtRv8zg5CqJ
 A8K6cWOJawQZ8dGuo+ardlDE0z8+Xyd9cqlMGEKZhFo4Vd/59JESy6miL0Lz2FtWtfpJG8vqZ
 WEMYLwPM8vMPpywNf6y4El+mnf/bzPXXIi/RP2RQnXj+qanVx7TdLWF8ADa66JyE8NhE7d4Eo
 6o/DXKIHaw4eXWyBzW6l0sls0nohEl3tZuOZnJ2QUa/Id2bkygAlqNeJnr7nNJ6rq9tgi6nqW
 e1WUCFDU+WpZ26Tu+inZ0Y4UmtDRTdZa+rYemw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes the following error:

arch/arm/boot/dts/imx6sl.dtsi:714: error: code indent should use tabs
where possible

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6sl.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 06a515121dfc..271f4b971a83 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -61,10 +61,10 @@ cpu0: cpu@0 {
 				<792000  1175000>,
 				<396000  975000>;
 			fsl,soc-operating-points =
-				/* ARM kHz      SOC-PU uV */
-				<996000         1225000>,
-				<792000         1175000>,
-				<396000         1175000>;
+				/* ARM kHz	SOC-PU uV */
+				<996000		1225000>,
+				<792000		1175000>,
+				<396000		1175000>;
 			clock-latency = <61036>; /* two CLK32 periods */
 			#cooling-cells = <2>;
 			clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>,
@@ -222,7 +222,7 @@ ecspi4: spi@2014000 {
 
 				uart5: serial@2018000 {
 					compatible = "fsl,imx6sl-uart",
-						   "fsl,imx6q-uart", "fsl,imx21-uart";
+						     "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02018000 0x4000>;
 					interrupts = <0 30 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -235,7 +235,7 @@ uart5: serial@2018000 {
 
 				uart1: serial@2020000 {
 					compatible = "fsl,imx6sl-uart",
-						   "fsl,imx6q-uart", "fsl,imx21-uart";
+						     "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02020000 0x4000>;
 					interrupts = <0 26 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -248,7 +248,7 @@ uart1: serial@2020000 {
 
 				uart2: serial@2024000 {
 					compatible = "fsl,imx6sl-uart",
-						   "fsl,imx6q-uart", "fsl,imx21-uart";
+						     "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02024000 0x4000>;
 					interrupts = <0 27 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -309,7 +309,7 @@ ssi3: ssi@2030000 {
 
 				uart3: serial@2034000 {
 					compatible = "fsl,imx6sl-uart",
-						   "fsl,imx6q-uart", "fsl,imx21-uart";
+						     "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02034000 0x4000>;
 					interrupts = <0 28 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -322,7 +322,7 @@ uart3: serial@2034000 {
 
 				uart4: serial@2038000 {
 					compatible = "fsl,imx6sl-uart",
-						   "fsl,imx6q-uart", "fsl,imx21-uart";
+						     "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02038000 0x4000>;
 					interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SL_CLK_UART>,
@@ -711,7 +711,7 @@ pd_pu: power-domain@1 {
 						#power-domain-cells = <0>;
 						power-supply = <&reg_pu>;
 						clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
-						         <&clks IMX6SL_CLK_GPU2D_PODF>;
+							 <&clks IMX6SL_CLK_GPU2D_PODF>;
 					};
 
 					pd_disp: power-domain@2 {
-- 
2.36.1

