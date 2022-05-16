Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1005285E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbiEPNuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244042AbiEPNtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:49:39 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383EC3AA53;
        Mon, 16 May 2022 06:48:50 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Ma0RF-1oB9i331MF-00LkqK;
 Mon, 16 May 2022 15:48:41 +0200
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
Subject: [PATCH v2 12/24] ARM: dts: imx7-colibri: move rtc node
Date:   Mon, 16 May 2022 15:47:22 +0200
Message-Id: <20220516134734.493065-13-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X0WEQjkhmnZwbNEDAiGqW4mG5C2Sp/jTOe0UlIDwurNkfKLWyLB
 A4/gutYfgES/ZG/argspC2+/tJSv8QuhgyroL0rEfGN6GttAGMsHWpDi75RDPH/+Z9JfRii
 QVDnOfPwbVRuzAHns0f8ux8jZ+cvLU0XUfz4OPFG/Nhwi8+eHATcf7F0HS+o1dHvNr/ItCz
 H9Tifvl1KDOKQpA5oPdeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tp2euVNqiFk=:/jFsraWQBx/mtQ3s7ZIfKu
 I+Ql7llu/RZe2Sgmso43NSjlmzMYJ7uFYUFAfcLEUL2ZVaLA7ugJXs3YYwPOhacBd5EVRw1ho
 j5xrWCiqP7oehvLob3ARdx6dG3wc9TY/dCOrtbRQX+zMxidGLaVLhDl285IfQeiPxhOWrxVmo
 towuv5vJx9p9OGqavdfe1VqtCOyP38NOswq/teU9pCwBzq/QpoID0LuHax6PCDUb3mQvbh+Rq
 1BbPM+FfSIe27oDmyfP2J1TbAsGtLouCTLV5RWTcTGsf4kT8cipiWwNklNyr4GF3KXJqF1GBj
 kCyC9MUK3/Ssgdh4/tJJA6cnVJMq+oLSiCXZXInyuv1xsw1zp8eg+59nqn6zeTzMto+6q5umt
 FhpForC3JZHI9tlqQapy9cC8ZbjZ8OfuySKYQMwY813uVB4gbXNBpc4nnJDWNL9KMuFSG0QKv
 Hfu5TYp015+wnLzmGBov3nmHd0dCyuEBKGr2NetDNd1dVk9zUDfyc8Vz8BrzP9xFoaFTm8KrU
 qY+o1s47RJrmmYp+613UXtu3rj6rUsQ6Qu3WP0lbR3xlB4r3moT+oXk3xvk3OVwlb7hvK1Mr9
 euAaKk3lfDpgNrP5szRl5/LVUnQqXtCSlveoMzBD8TjnusihYOpljvQDVHj5cb8F0B7/RSnbU
 eYuab79M3AZfSYPm76Y4bYOklk08piPdGACRu4wblI+QLxXsdJcgn6RFmucdsXNTGvI7fDWIj
 wJV030xeStTuJeoZ
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

(no changes since v1)

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

