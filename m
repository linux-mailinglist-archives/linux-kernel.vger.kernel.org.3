Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF03351DC8A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443165AbiEFPwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiEFPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:52:10 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0686D86D;
        Fri,  6 May 2022 08:48:27 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Md2do-1nVsmD3lq6-00IA2M;
 Fri, 06 May 2022 17:48:16 +0200
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
Subject: [PATCH v1 21/24] ARM: dts: imx7-colibri: set regulator-name properties
Date:   Fri,  6 May 2022 17:48:11 +0200
Message-Id: <20220506154811.297154-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0jwSyYr+0a++mhcIj3Eoxc18Lwqu5hmPI2LpI56tec77kLwpoX/
 IDM49M+YA+l7JzQiCPj4nQfxaZOy/kYjnXjqkuAO3R6+xtswla580LYFEl6wPOKhHk6sLKN
 kbHBIPDN5EUSQBZlm5WTaDkn0NHa7mLTNMoUoljTtvp8OoMuIgviud148gylfZocehEyivY
 7lOiNQsFSksaKXHgsY1bQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pmiq4htKZwY=:gnR1yjyMQnO7isHNz5uO/7
 xd526W0kJncjLqnmJrxSUcxUeeCenuiMsvICxUyzcxDBM2TLa52hg909Yk3Z+XyM6ZwDlG5F8
 z+ebpgm2VoXVwBdoyz27arf1YmwW2hG91/vrdPbloqXGNtvvzrDqEoy2hK+h8OoufYLwROhE3
 j4hFCa2hZRzfsSUUTyWn4kJm3bc0xs1O0Y85xaPe9lWMTKwSRzjuNfrgCZ0SBEk89n4TUNpAx
 jOSUCvV5vAEMfvjbzHIh5G0AUKfJREnEj9d7ssnmRWG3mqlqjFHI9yskuspSKFy1NBPouMU+C
 P/zkPegp0VJVBGJq5+CfXJSWXtK0hcq/RqvSRKrigOyGIZDSRFW/cO6MqD0AacBl6jVTnXWTl
 K9t3jv1bkklEoB/julhEM7fUA5aqrmqrwncCafuVWswEE2uU4Go3Gkrm5IAB1SPJdLLaYxt/j
 IlU80n3raovFu1uF1ZF9RjIYiqEnAQTQbvwG+V8iRQvfX116kyf9TNAKL6l1BMUv7qLljENOV
 TfsVPFa3369VgvyXbw64x3LRDN7x1Vq22jzWrqIGJT6du28l8Rhk9cyP1f6fIRgswylQdBac5
 /ALpUVQcHAavJenoX+4UVq7mLnKroI/3Jj6wJOkzdX2TvFiKMZyf9N+5zXjU0LZObrw/AgCGC
 EUjqrRlbPeUUiaRGfcLgqkOrMEoqwB2DJD1NrPkT5imfHn0f/XKLc3EpD2lfb7bnKdTZ6odj8
 05hX1xhCk8+m43xk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Migrate comments to proper regulator-name properties.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

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

