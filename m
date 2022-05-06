Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC93951DC22
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442905AbiEFPdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442911AbiEFPcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:32:55 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C16D3AD;
        Fri,  6 May 2022 08:29:10 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MRSm1-1nPfjz0fmH-00NSFR;
 Fri, 06 May 2022 17:28:58 +0200
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
Subject: [PATCH v1 12/24] ARM: dts: imx7-colibri: move rtc node
Date:   Fri,  6 May 2022 17:27:57 +0200
Message-Id: <20220506152809.295409-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506152809.295409-1-marcel@ziswiler.com>
References: <20220506152809.295409-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xjSlamvLAi6Uw+RHd6U7taVRuhpg5MGJ0CqVYOoEcJK0tG/8mnh
 dlWDNmWtpbQG/hrJb5pTWgqDuSVfUHy7QJgUNI1tYBukX6ON0WmhTWqCqTkjK3vxEoXT2Z+
 1qeSl82wRRlZ5up5aIJgWoOqoTJ5FprcmbUcuEUmqT/zgJTDn04ii9HbAwys3quN9/nUEju
 VJeorvkTZIkz0dCw0WJsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A5chbVZ63TA=:RUoK36KABzWuVZd1KXUPNH
 4AvDavS2YQ75WjH3nkYKEGrxhzcle/FYYKlC05Hv52oGxFALJYaUyhwL5MXlmueP+hzpXoxQd
 oDRiJ1y/MdFXjpsd+dpmNAA3A/zc2Vp/FIXOSPd/TJ8drV8IApfWnUQcGKntm5iPV5RVtzEXv
 RkkEn7SEbPr92g1pFEPySGQ92Di8NShlzukAZGO/jwW3z2wdxxT0W5yr51Poyho5umO+AD4y3
 fNZR9fEJz1qL1Masl6X9uo1WYgpVqXMvlaBnRHaeVAJzAZ78ZZpqvQsnRhY7H15gL5o+I7pLb
 PMe6Ht9s3AHgbIBiNRACtI+nRvW3EWrtB5zIPRLbz5qwdW2ebJ0cuOZHBUP9b2i3Kag0OYd/u
 Pm4IxtF4BRYVqoDCf8SaahrsU6I/f1864moQlQvEysTOqp4vF16V9LZ9ncXj/ob4roNtbv8ZF
 l1lsCms64q4YuXIaCVSzTfPfXOqkEntw1ir8xyR6LtQDZ/B3Ke8MOLz6FZ3mPJYQ22vGUZjfG
 tGSDeSxjxt16bawhL+0ounImbvi85L8yjDmM7ZOaeB9CIaIbtN0440/8QgWrTo32Xl26GsK1y
 jnU/mxTE3aUvd7XOwAj8XfECLiWgirk1HqDqoJTfOLTOUPcA+lECPt3WB8CdNh3tfc+wPVBv1
 Gbb1BqN76oQUszATbIZuMNiSkZT4W7pez8sPqxgmWhx0wmtMzglAsuzwhu8ociQZGpzrWf2BB
 rIBWvo47wOKV03Ra
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move I2C RTC to module-level to be enabled on carrier board-level.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx7-colibri-aster.dtsi   | 11 +++++------
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 11 +++++------
 arch/arm/boot/dts/imx7-colibri.dtsi         |  7 +++++++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-aster.dtsi b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
index f3a5cb7d6a0c..9796bfabe241 100644
--- a/arch/arm/boot/dts/imx7-colibri-aster.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-aster.dtsi
@@ -21,12 +21,6 @@ &fec1 {
 
 &i2c4 {
 	status = "okay";
-
-	/* M41T0M6 real time clock on carrier board */
-	rtc: rtc@68 {
-		compatible = "st,m41t0";
-		reg = <0x68>;
-	};
 };
 
 &pwm1 {
@@ -45,6 +39,11 @@ &pwm4 {
 	status = "okay";
 };
 
+/* M41T0M6 real time clock */
+&rtc {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 618831e89ce8..e3aac56aece8 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -56,12 +56,6 @@ &fec1 {
 
 &i2c4 {
 	status = "okay";
-
-	/* M41T0M6 real time clock on carrier board */
-	rtc: rtc@68 {
-		compatible = "st,m41t0";
-		reg = <0x68>;
-	};
 };
 
 &pwm1 {
@@ -80,6 +74,11 @@ &pwm4 {
 	status = "okay";
 };
 
+/* M41T0M6 real time clock */
+&rtc {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 3da9ddc06aae..da3df00c7d67 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -507,6 +507,13 @@ atmel_mxt_ts: touchscreen@4a {
 		reset-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;      /* SODIMM 106 / RST */
 		status = "disabled";
 	};
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc: rtc@68 {
+		compatible = "st,m41t0";
+		reg = <0x68>;
+		status = "disabled";
+	};
 };
 
 &lcdif {
-- 
2.35.1

