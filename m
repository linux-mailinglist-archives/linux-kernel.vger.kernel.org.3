Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC100488915
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiAILyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:54:07 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46453 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235391AbiAILyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:54:03 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3087658036F;
        Sun,  9 Jan 2022 06:54:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 09 Jan 2022 06:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=liWNH9cngrKwH
        G/iQAoSwWAxTQqxW15kZvnIgwu8SwU=; b=cboZRsWYwKPdbffWxfww33xQDo0vD
        Ep4ViXirP7xaQDkH6hMOf+YgadAj1oUIIGwibcOpTVB5tXut4W9tapzvaI7dj49G
        ijWFEjw2Q+AyNJ7mU3f6YnLTDUyFHHmA9u2u0k5WJbJGLROFqleuq0q3VI8Hg2lD
        LseFGxYBbNFfEZ9esvesz496wZbir/hVRetOhMoq7pqUdzTu6hnx9osyoqLOZ/Fd
        nBTTUL3WpMFgv8+jVwqSrPhcEgdNa3Yx8OmDoIC3OmyayO789vrR33ciTVKXrYQX
        EAlsa8wCvA7LNVjjtib+ajgTz/zIQ+YVh03vaE2xaYPBT/jcPsZErqHVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=liWNH9cngrKwHG/iQAoSwWAxTQqxW15kZvnIgwu8SwU=; b=FDMnC1Tw
        d2NwocaWEn4wo9nLzLnziQ0cYavgqqafQtRUy7sn58TikzDGxmbDay+HNvbq1Lui
        HL9NuF8hvNz32bpCqTdQv+kvRdLEqZ+cdHm1C8vksIGt1Zvg0jdmtNm+882yNTz+
        aiEW4Xt6RIOjjIOTedPNnTophkxZ9BYDcJUN0Pe4CNTepJ47ZC/+OFrKxltXF9Cu
        dt5vU2mnDpr9Au23OEQ6ArdWrYwMHiTjpZp5I57oEHKQEnTEimrxWGQiBBym5PXj
        z+aU5dRO1GYTeb6oOilsxeIPm9+tC2qisp/Yqvm2CZzFyJQ8WXJ+Ftq/8YsXwsun
        KfupYFfRS0z6Pw==
X-ME-Sender: <xms:28zaYbJtOxynKymtn--sf_1rLqzn2wiwiJ1tynFF_ioqsjXiLrApQA>
    <xme:28zaYfK86S1TTyISOaZjmnfLKLC-IafkQ3tYixxEzjN2ZmYKFVgTE8nx1DDVmE-kf
    plt-EFcW4TOl0ZVzJ0>
X-ME-Received: <xmr:28zaYTs3v44g78GCdQ46waDQceTqH_44MDUgMShLCPOTX3XCDK5T53JidOP66GQtRJciFmCTIOoTVYyDpmDoBVdSGjQFV6Nub10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:28zaYUbyUOwFpQ-Ef93T8l1r3r_T9Ita2nPBqry_-gHA3bj3BBlsEg>
    <xmx:28zaYSbQ7aCIOhaJu2FreCqpi3i01i3K0K3HAr816kGz1oWetllZKQ>
    <xmx:28zaYYBgMoZIQvZaA5guc_bUV9X7wPtCTwgcnNAM1XUJetAd7OUYlA>
    <xmx:28zaYYkwP8c5qfDcO7w_hpKdi9W3BQsBnn-Gs6oDISPBdkGrY07lwQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jan 2022 06:53:58 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, rydberg@bitmath.org,
        andreas@kemnade.info, linus.walleij@linaro.org,
        alistair23@gmail.com, robh+dt@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 4/4] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Date:   Sun,  9 Jan 2022 21:53:31 +1000
Message-Id: <20220109115331.388633-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220109115331.388633-1-alistair@alistair23.me>
References: <20220109115331.388633-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the cyttsp5 touchscreen controller for the reMarkable 2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 89 +++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 89cbf13097a4..f12d6805b214 100644
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
+		button-0 {
+			linux,code = <KEY_HOMEPAGE>;
+		};
+
+		button-1 {
+			linux,code = <KEY_MENU>;
+		};
+
+		button-2 {
+			linux,code = <KEY_BACK>;
+		};
+
+		button-3 {
+			linux,code = <KEY_SEARCH>;
+		};
+
+		button-4 {
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-5 {
+			linux,code = <KEY_VOLUMEUP>;
+		};
+
+		button-6 {
+			linux,code = <KEY_CAMERA>;
+		};
+
+		button-7 {
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

