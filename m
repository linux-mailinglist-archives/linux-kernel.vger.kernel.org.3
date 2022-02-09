Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F314AF69D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiBIQZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236821AbiBIQZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:25:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF85C05CB86;
        Wed,  9 Feb 2022 08:25:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 5A86E1F437CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644423943;
        bh=gDx8AevH/7v2bszTk4dO4GKNMSB8b/jIT4jSxIO98/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfXgUKHm+msioKg64rAQSkHFkHKTZQrdzXczGgHhGPTwcst6IIoxkFPmch14NYSXl
         5bWqx//7S7TObaFng//M5QANQO7w2uNVr/QvnUZaLzha5w4FOIY2b8RAMGVFpjktlB
         UiWz6cAKvAS/EcfOM7YYnLwMZD8bMszJ+BKoiLmCCA9/S7RDg7Xl7dygRA7OdLpiQ2
         X/UDKaoj36PYf+lWQ75acTmDIesTRMJ8oa6iVRXz0yWIajIGEDmTqNQ4+1FLfPwm01
         hvaso6n5QYzAA4Rtgfr3L7SUUwYSjr7BVyGHKZy3EypL98m/c4leFv0qslkchtWsD/
         9hS8CnNd+yL1A==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Detlev Casanova <detlev.casanova@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org (maintainer:ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON
        PARTS)), Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM AND ARM64 SoC
        SUB-ARCHITECTURES (COMMON PARTS)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 2/2] ARM: dts: Add bcm2711-rpi-4-b-7inch-ts-dsi.dts
Date:   Wed,  9 Feb 2022 11:25:12 -0500
Message-Id: <20220209162515.706729-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220209162515.706729-1-detlev.casanova@collabora.com>
References: <20220209162515.706729-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree to support the official Raspberrypi 7" touchscreen for
the Raspberry Pi 4 B

The panel is connected on the DSI 1 port and uses the simple-panel
driver.

The device tree also makes sure to activate:
 * dvp: bcm2711 clock driver
 * hvs: Hardware Video Scaler
 * pixelvalve[0-4]: CRTC modules
 * txp: CRTC Writeback

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts | 129 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile         |   1 +
 .../broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts |   2 +
 4 files changed, 133 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0de64f237cd8..b46daf2df4ce 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -94,6 +94,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
 	bcm2837-rpi-cm3-io3.dtb \
 	bcm2711-rpi-400.dtb \
 	bcm2711-rpi-4-b.dtb \
+	bcm2711-rpi-4-b-7inch-ts-dsi.dtb \
 	bcm2711-rpi-cm4-io.dtb \
 	bcm2835-rpi-zero.dtb \
 	bcm2835-rpi-zero-w.dtb
diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts
new file mode 100644
index 000000000000..62e986358c2a
--- /dev/null
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b-7inch-ts-dsi.dts
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "bcm2711-rpi-4-b.dts"
+
+/ {
+	model = "Raspberry Pi 4 Model B + Rpi 7inch touchscreen";
+
+	panel_disp1: panel_disp1@0 {
+		reg = <0 0 0>;
+		compatible = "raspberrypi,7inch-dsi", "simple-panel";
+		backlight = <&reg_display>;
+		power-supply = <&reg_display>;
+		status = "okay";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&bridge_out>;
+			};
+		};
+	};
+
+	reg_bridge: reg_bridge@0 {
+		reg = <0 0 0>;
+		compatible = "regulator-fixed";
+		regulator-name = "bridge_reg";
+		gpio = <&reg_display 0 0>;
+		vin-supply = <&reg_display>;
+		enable-active-high;
+		status = "okay";
+	};
+};
+
+&i2c_csi_dsi {
+	ft5406: ts@38 {
+		compatible = "edt,edt-ft5506";
+		reg = <0x38>;
+		status = "okay";
+
+		vcc-supply = <&reg_display>;
+		reset-gpio = <&reg_display 1 1>;
+
+		touchscreen-size-x = < 800 >;
+		touchscreen-size-y = < 480 >;
+
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+
+	reg_display: reg_display@45 {
+		compatible = "raspberrypi,7inch-touchscreen-panel-regulator";
+		reg = <0x45>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		status = "okay";
+	};
+
+};
+
+&dsi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	port {
+		dsi_out: endpoint {
+			remote-endpoint = <&bridge_in>;
+		};
+	};
+
+	bridge@0 {
+		reg = <0>;
+		compatible = "toshiba,tc358762";
+		vddc-supply = <&reg_bridge>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				bridge_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+	};
+};
+
+&aon_intr {
+	status = "okay";
+};
+
+&dvp {
+	status = "okay";
+};
+
+&hvs {
+	status = "okay";
+};
+
+&pixelvalve0 {
+	status = "okay";
+};
+
+&pixelvalve1 {
+	status = "okay";
+};
+
+&pixelvalve2 {
+	status = "okay";
+};
+
+&pixelvalve3 {
+	status = "okay";
+};
+
+&pixelvalve4 {
+	status = "okay";
+};
+
+&txp {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index c6882032a428..965361bff829 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2711-rpi-4-b.dtb \
+			      bcm2711-rpi-4-b-7inch-ts-dsi.dtb \
 			      bcm2711-rpi-cm4-io.dtb \
 			      bcm2837-rpi-3-a-plus.dtb \
 			      bcm2837-rpi-3-b.dtb \
diff --git a/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts
new file mode 100644
index 000000000000..c325adc4f874
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b-7inch-ts-dsi.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2711-rpi-4-b-7inch-ts-dsi.dts"
-- 
2.35.1

