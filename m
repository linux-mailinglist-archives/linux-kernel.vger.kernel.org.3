Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4744446D380
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhLHMor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:44:47 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:52827 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233631AbhLHMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:44:46 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 02AAE580247;
        Wed,  8 Dec 2021 07:41:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 Dec 2021 07:41:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Xtb2ZyvQwiEmj
        aFTIab7ygGJDdh4OgdnrwNvxS0c+U0=; b=3D0ZAssEs0RKq9FoH4GlSFCifNLoz
        /tbNH1YZYgzKbz7AZJtEVlsKF7KjkO0vEdc+Gg8z7QSrby3ZvcOo3nPtBZXG1Kl8
        81NaZIuM5OHkMXmIjO3vnbeS9/8XuyR//xwsgTLIDr1wK8oaCXb/cvF8pLJe9J7E
        EB6rlkAuc/FLFT7oQyFdST87ZSJuKnPJRS0w3OkC+3BvQ+f3qal8drDY897IxBts
        5oD4VJNsmKHRA9TR/4v3muMEW22faVnPKYIzbCjnKKDVYvYsiS2t4k1cNymKQSzu
        qtVoPZQ5xi9efRpR5xZupw9fg/F7JxV6ZMsWSoyszYOZuF4V8kCtxhnLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Xtb2ZyvQwiEmjaFTIab7ygGJDdh4OgdnrwNvxS0c+U0=; b=M6LdJMZa
        w88FDYukWIi4j0z+XX7qW7PlScdq/Ud0kARHaNLm2N+xBZl7bd2u3UcCDGLL2EOe
        nVS3czhyRCaU8GYJ8gMOcsx8Uld6uho+rK6YKROVWktVUW4pSFxu0IVoTtgAXYIM
        vDn64zTt/BIb5lhR63LUQFyyCTDOVbkb+pGzv0lOHS0n8SDwxzZaLJpA8naepSor
        rLKXZdnQdheEWvecBW3RJmv33VfUba4NN+cFdYHRGN+C9wrrEu44Kz0mifZPS/nf
        XDmQF/dTULCo/1JCZShUCN84gfPOqrQJKxG7LcqsHP2AWlp9PjlSRVkuG1eu1xZh
        3OIDn1Zy3Zq+ig==
X-ME-Sender: <xms:6aewYeEoMMAZLMvV52XKuMjohQ-V6glrjz9gINobzyDxCfEiCg5BDw>
    <xme:6aewYfWpnS4_db8x4yCgdxNO1T7wFjxGDZM65oeyXjA2QXbEzwtZDMF6IIgvTZVP2
    J6BZJ56qW3Gv-U-2Y4>
X-ME-Received: <xmr:6aewYYLTD5uT3bLBDEn8nBd8SdJ1N17_MlCzhw_uZos-g-mA7qJbgNXK2T_-26rJ1FDGoDLsnSdw2EQ2CxYuIdTp4JLYsnIwLNk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:6aewYYFGfzpT6R6jHPmJU6vW7i901Alp-YSUbuPvDVK1KnQaVMPQGw>
    <xmx:6aewYUWvuFrsCkSxsBy5zvsJwZYRwIZqXsXG7B49sfPTdE2PfM3y-Q>
    <xmx:6aewYbM6nXiYzhRcjVu0dXRyc4VxR7T3hjfgJ06WspJRSTshVsWouQ>
    <xmx:6aewYVtacMUsRCFoDSU4SIH0zyM-5cU2MUsJ7-JpgzSCN8kynEHETQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Dec 2021 07:41:07 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     s.hauer@pengutronix.de, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, Jason.Gerecke@wacom.com,
        linux-imx@nxp.com, Ping.Cheng@wacom.com,
        devicetree@vger.kernel.org, martin.chen@wacom.com,
        tatsunosuke.tobita@wacom.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 3/3] ARM: dts: imx7d: remarkable2: add wacom digitizer device
Date:   Wed,  8 Dec 2021 22:40:45 +1000
Message-Id: <20211208124045.61815-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208124045.61815-1-alistair@alistair23.me>
References: <20211208124045.61815-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Wacom I2C support for the reMarkable 2 eInk tablet using the
generic I2C HID framework.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 59 +++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 89cbf13097a4..a2a91bfdd98e 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -34,6 +34,19 @@ reg_brcm: regulator-brcm {
 		startup-delay-us = <150>;
 	};
 
+	reg_digitizer: regulator-digitizer {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_3V3_DIGITIZER";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pinctrl_digitizer_reg>;
+		pinctrl-1 = <&pinctrl_digitizer_reg>;
+		gpio = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <100000>; /* 100 ms */
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -51,6 +64,26 @@ &clks {
 	assigned-clock-rates = <0>, <32768>;
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	wacom_digitizer: digitizer@9 {
+		compatible = "hid-over-i2c";
+		reg = <0x09>;
+		hid-descr-addr = <0x01>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wacom>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+		vdd-supply = <&reg_digitizer>;
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -117,6 +150,25 @@ &wdog1 {
 	fsl,ext-reset-output;
 };
 
+&iomuxc_lpsr {
+	pinctrl_digitizer_reg: digitizerreggrp {
+		fsl,pins = <
+			/* DIGITIZER_PWR_EN */
+			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x14
+		>;
+	};
+
+	pinctrl_wacom: wacomgrp {
+		fsl,pins = <
+			/*MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x00000014 FWE */
+			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x00000074 /* PDCTB */
+			MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1	0x00000034 /* WACOM INT */
+			/*MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x00000014 WACOM PWR ENABLE */
+			/*MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x00000074 WACOM RESET */
+		>;
+	};
+};
+
 &iomuxc {
 	pinctrl_brcm_reg: brcmreggrp {
 		fsl,pins = <
@@ -125,6 +177,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
+			MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.31.1

