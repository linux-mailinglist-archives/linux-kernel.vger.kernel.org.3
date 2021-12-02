Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4308D46638B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358099AbhLBMYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:24:48 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:48335 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358019AbhLBMYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:24:10 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CF437580310;
        Thu,  2 Dec 2021 07:20:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 07:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=E2mEUczJYwXrm
        34iccAe79u+uvatvOdS7oNMfFy13c0=; b=UB6zAMt1jb4oUTggBbfxqjD18aILV
        QZ//sqPIhdHwthJoYXCLhzjxMTECXvXfJE8zVosF4d7vzUPkqAbZ1k1yAKj6j/Jk
        p8ejd+sV8eSst5pXf4bSwywgjsv4y43O+ExGMZpYYJ2kWYlOmgSzs/bm33wNYsUU
        VD1Uv9New+v4pJXjZXjwSt/Fjun3QyU3iIXb4VJfX1jrGclbNEgfQdEgKtvb/dOK
        aGUByh/DbIIKzeMhN8+TpdkphRLKkdVCVkJqvKApBkP7aZFZCHWCjJSJE483+Sky
        rzfqt2J41kGiZaj4NkiKFpYDLBEGuorLXHAtTInQBQBSXZ7cf+YPh+xkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=E2mEUczJYwXrm34iccAe79u+uvatvOdS7oNMfFy13c0=; b=mLsddHlA
        1cgG0TBBXonQU8dmbMfycGqBlTEmFf97k4RQyMS77dmu07dKhwjTjdL4UpsKdGba
        WP6s91P3ZfgKW80jdG85eV3mZLCF68Ae8F86fPu3QAgntzR53S+D4Bz8GVpIOWzX
        QP8acHzGq1pSZ5yvv2cDMyYufC6owwYKwd2EuI7DMSnPcFhWFhZA1QbP/7m6YT4t
        LEttFCqZxdBmVzX/jIl7jp8EnIk9zH+63Hn2w/F8SxxKuwluJj7ldPMu6txY/JH+
        ZjKxqilj2oOBX9WmHEO1LEQLmWtF+q5O4dUouBoPU8Zs2H1djV1vvBzVtzz+h9d+
        0266CvVO1cTE+Q==
X-ME-Sender: <xms:H7qoYSx0cSqHwVSPT5A47aN7Rtj6aYAoY3xKguMSrjHlQEsk4hnSEA>
    <xme:H7qoYeQaNIkjEfI52AIJMvuGz_tjAjGqwpgMFE1oQOAbC3v5qEDxV3ygNbf6CcIWV
    JaVHI8atiqwNZBeZBQ>
X-ME-Received: <xmr:H7qoYUWj6LSZLS5mggJXTdbblUmB6U7yRWDG1uY_vhTuNFb52Vt_rQi3PwUnpZwnqZv3OBzMGtJBnrmJDWivn3mDJZt1sPhunUz18Hu4FGJN45M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:H7qoYYjuPKjY_3jw8TWRPNcgbxEJY_8mvu8Ajlz251i2SOkl5HpE_A>
    <xmx:H7qoYUCE43HSYOG7DqNqT11pYLXIKQrru-rPGED5Y9iveFFiR9TKHw>
    <xmx:H7qoYZJrl9JgZBrVbjmCqXZBQVifeRHIl9uYKFdhQZWXFsRiNzfloQ>
    <xmx:H7qoYUvBCmTR48XqlPymUoTcdGspRgrEsTLEKHU__WBxzp0DHKydTA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:20:43 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, andreas@kemnade.info, alistair23@gmail.com,
        dmitry.torokhov@gmail.com, linus.walleij@linaro.org,
        rydberg@bitmath.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 4/4] ARM: dts: imx7d: remarkable2: Enable the cyttsp5
Date:   Thu,  2 Dec 2021 22:20:21 +1000
Message-Id: <20211202122021.43124-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202122021.43124-1-alistair@alistair23.me>
References: <20211202122021.43124-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 89 +++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 89cbf13097a4..8c398b5c788e 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "imx7d.dtsi"
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	model = "reMarkable 2.0";
@@ -34,6 +35,18 @@ reg_brcm: regulator-brcm {
 		startup-delay-us = <150>;
 	};
 
+	reg_touch: regulator-touch {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_3V3_TOUCH";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pinctrl_touch_reg>;
+		pinctrl-1 = <&pinctrl_touch_reg>;
+		gpio = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -51,6 +64,59 @@ &clks {
 	assigned-clock-rates = <0>, <32768>;
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	tsc@24 {
+		compatible = "cypress,tt21000";
+		reg = <0x24>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&reg_touch>;
+		touchscreen-size-x = <880>;
+		touchscreen-size-y = <1280>;
+
+		button@0 {
+			linux,code = <KEY_HOMEPAGE>;
+		};
+
+		button@1 {
+			linux,code = <KEY_MENU>;
+		};
+
+		button@2 {
+			linux,code = <KEY_BACK>;
+		};
+
+		button@3 {
+			linux,code = <KEY_SEARCH>;
+		};
+
+		button@4 {
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button@5 {
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		button@6 {
+			linux,code = <KEY_CAMERA>;
+		};
+
+		button@7 {
+			linux,code = <KEY_POWER>;
+		};
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -125,6 +191,29 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+			/* CYTTSP interrupt */
+			MX7D_PAD_GPIO1_IO14__GPIO1_IO14		0x54
+			/* CYTTSP reset */
+			MX7D_PAD_GPIO1_IO13__GPIO1_IO13		0x04
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
+			MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
+		>;
+	};
+
+	pinctrl_touch_reg: touchreggrp {
+		fsl,pins = <
+			/* TOUCH_PWR_EN */
+			MX7D_PAD_GPIO1_IO11__GPIO1_IO11		0x14
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.31.1

