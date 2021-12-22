Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A294847D266
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbhLVMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:46:35 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:58343 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241016AbhLVMqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:46:32 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id AEA275803DA;
        Wed, 22 Dec 2021 07:46:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 22 Dec 2021 07:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=liWNH9cngrKwH
        G/iQAoSwWAxTQqxW15kZvnIgwu8SwU=; b=N+IGqbnou+seL9Ny+yn3XiNkHPRRp
        Hab2YkcarkqS15cAYeD5hPSp2Jg4A5xdQd1JPQWGPWjJ3h4u0TSvfAOT6dzpBsyu
        +Etjap+fxYoTlWGAUcr5XTaIbvUCSUILsqx+l5cw5jjkheKQGGqjxR8Iawd9qOxD
        hs6ZTADSnZgSl+OV5rl88UM642fFe74T9KBckeHsvvXJ2qiQUOcG3mSmup/s95yy
        1eymaTxziHjkIBws26QKlUaYj6CzpGLGb9v87eWtJW8rUMuynHrp4FPRg1hoJSwj
        fHymcfhtmzmKhuQS8Seq4BsjHqWXlRWvg07IbFhXu/Px8oud5/eb/puhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=liWNH9cngrKwHG/iQAoSwWAxTQqxW15kZvnIgwu8SwU=; b=PBuJWE4G
        Z+ZVuYxsSrz1trfZ0WSTz1FfL1uJcKoCzMNGuB428SdMIYJzl2BgxCc3j/d2RqCI
        r7ylIp8iFbC9gGU+JwznKK2jmzORvH7OvKHBsCwmEoW6sCBSKuN/m9G8Qw8YjdPR
        xJPWtApch244ILnu2BKb43jQk+LFTi2zWPX6LUimPLp35ootBUYRWbVWHKJv+YCb
        cm9YB3wLAu/RvB85XrvjY9x/4xZqCkIoBgY0hoAQvLFdqSEeeRfzK1fpG2G08ME9
        cSL2EeoB05LakQlhhSkdNwKspGt97XRv6HomHsj2N349FWPciwCjLUkTm2BrBup8
        LQ/sRmyprXhTeA==
X-ME-Sender: <xms:Jx7DYWX_JR7l8elWKKfdIErAszGkkyvVrbRKyFQSn-4nq73KlRgQAQ>
    <xme:Jx7DYSmYtEhgepYgPNrcbS6kmC6hf6fbCjjA1w5DJGTRSEgKN6u_Qy8pZBCZukJpI
    NwQaV8KS4Zcuy_hgtI>
X-ME-Received: <xmr:Jx7DYab3xQCiGmy2B2o8RwH1mzMIKOeYMrzWMQe2gr-6N5IAZdhaTbO4QOuAwcAlvInze_e15Ok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:Jx7DYdUBtbY9PYNgIdgtesMY8jAiwhQG-wXpDVzc4HpSoagVT0DLDQ>
    <xmx:Jx7DYQnqVg2PlaURARGturzNhYcPbBONBeO38RRnVzj4q8h8ip62yg>
    <xmx:Jx7DYSdYeNPPJ6uU7ydK_KFTPJl49S8VWGMMXvR7R7Zggyxerq9jOA>
    <xmx:Jx7DYdhBkp_uOFN2-fHbLHwJX9u3IzQPFz3FHw69uWIpgJBzkEbv_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Dec 2021 07:46:27 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, alistair23@gmail.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, rydberg@bitmath.org,
        andreas@kemnade.info, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 4/4] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Date:   Wed, 22 Dec 2021 22:46:03 +1000
Message-Id: <20211222124603.326920-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211222124603.326920-1-alistair@alistair23.me>
References: <20211222124603.326920-1-alistair@alistair23.me>
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

