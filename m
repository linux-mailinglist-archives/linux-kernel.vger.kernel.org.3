Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4334851D913
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349939AbiEFN3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392581AbiEFN25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:28:57 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F70669738;
        Fri,  6 May 2022 06:25:14 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MXrmL-1nHOrz0GDH-00WlJU;
 Fri, 06 May 2022 15:25:00 +0200
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
Subject: [PATCH v3 12/13] ARM: dts: imx6ull-colibri: move gpio-keys node to som dtsi
Date:   Fri,  6 May 2022 15:24:15 +0200
Message-Id: <20220506132416.273965-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506132416.273965-1-marcel@ziswiler.com>
References: <20220506132416.273965-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6M8m5aUlIenun24YVIZjE6nxPoM/mKqZEGnvhtPd1+zDd33+kIE
 mbIpTdoB8h7Q/RjBBvB7FhJm7XxklUdQjwNmsJHJ7sE8+Enwf0yGMCUgUk3Z9iT7r1M6fKR
 GBpzb7dfP39bTbcjt+reWB+dKx92uhIxr6YOrCTt8bxy74yU87RS1pVFY94Mq7LDLJmpTxj
 O3nzoQsjj/6+17najRyuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oYsiHfk45LE=:AtXr3RrEpz+8VAfPNur2DF
 vS2QFZvoot/nOyN9B1T0ak31L4Rj1ZEu4kSK4S+FhW71ORnUkzXdxjqW0gvdMS6dOx4+zw5Qu
 q/cySsnRvezj6MJtq4jVHT/+4B+tfYPTFhsfPpVrX4p4/b1Q2NRc/NeBfbUev8fNGgMXXurqF
 nPJCu09+E9B36uZ7QRhEgDHbWWCt0j0WETD/PhTpPL4cjR0zInFmHAUZL3pcFKu3A5NYN0ujq
 jSHCn3K1VnYCynAiUf9wCTsy46m0X/TewcibOWTnICaT/2+BIq9eapy3VtQv9mAbP66wW5HKw
 ZjmtqztWi3jgVsDnkfsgAAoLk15+00FeSCHd470eLUdNezJocngn2Iy9osqhZskvAq5gJ1Mf2
 S0xLsJ1t9kubfBMJ4ZeaX/DQ+5DvnhQ06PzGKIM+cbwr8zTzBO8BQiveuBGdP/PdzMefjI9l+
 6MGUUZvV0tYfENB7ZnGEWAIF2nKVS+IXYNevZQFJiqPVrEErGNEEWF2aJTS37yOZahZ75jT9t
 gO3q5MUPzjE09fs8h2eBHwdeExVtN6TSWGZ4TJ8HcRKEVXSMP9QFEN6xKcEttuJpqLjHdjlWi
 opOWwCSCfC7C95LVelfWM9kha3QtNpJQovob+WEg74x8jOo8bd4vzB/lQ4P+7KwVfL7KM4yEB
 nFlNX5WNaFMVV+ROYsD4uS/3Yo+sMsLDJQ/EGafsrq3n+Yob7HvmRbhms2MK3sBcMWbP/gdgZ
 xB5M//qnAe3eJzgb
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

The gpio-keys define module level wake-up pin functionality. Move it
from the carrier board dts file to the Som dtsi file.
While at it, also re-order the properties in the gpio-keys node
alphabetically and rename to sub-node from power to wakeup.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 15 ---------------
 arch/arm/boot/dts/imx6ull-colibri.dtsi         | 16 +++++++++++++++-
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
index 08197c66af12..e29907428c20 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -8,20 +8,6 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_snvs_gpiokeys>;
-
-		power {
-			label = "Wake-Up";
-			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
-
 	/* fixed crystal dedicated to mcp2515 */
 	clk16m: clk16m {
 		compatible = "fixed-clock";
@@ -29,7 +15,6 @@ clk16m: clk16m {
 		clock-frequency = <16000000>;
 	};
 
-
 	reg_3v3: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3.3V";
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 4611fa890889..4292311bdc6e 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -24,6 +24,20 @@ backlight: backlight {
 		status = "okay";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_snvs_gpiokeys>;
+
+		wakeup {
+			debounce-interval = <10>;
+			gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
 	panel_dpi: panel-dpi {
 		compatible = "edt,et057090dhu";
 		backlight = <&backlight>;
@@ -707,7 +721,7 @@ MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x130b0
 
 	pinctrl_snvs_gpiokeys: snvs-gpiokeys-grp {
 		fsl,pins = <
-			MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x130a0	/* SODIMM 45 */
+			MX6ULL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x130a0	/* SODIMM 45 / WAKE_UP */
 		>;
 	};
 
-- 
2.35.1

