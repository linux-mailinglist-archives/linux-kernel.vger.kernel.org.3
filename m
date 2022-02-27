Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3C4C5B21
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiB0Mlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiB0Mlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:41:36 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6026D1BE;
        Sun, 27 Feb 2022 04:40:58 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id EDEBC580227;
        Sun, 27 Feb 2022 07:33:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 27 Feb 2022 07:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=Og9BxYB3S6s2eW
        9bem199hyPU+nZaWl1s2wrCXUxwp0=; b=G5mMzYi3Zqa8sX3Ad06ij1OH/1TQtn
        cDs2P7z1JwC52M3yQ/xa7tpMJPCRb0/M9iwtQ9cb7n2Y3Jcztezs9G/2YU6XZtfs
        kH8lCD0a1dAxCPkf/VB0xaSz3eaw0Gvtjb+Hga9ytTWZRGhifcmkD8unA14XrvrT
        1NppcPu5+0oGmm2CWfmY3fry/0yy+pkpmfuh6isTayPr5kTQ5bUbPjFCuFI2qaCw
        JLjouH+sCPYbfm7xovMuM79Wn+0K2i7JdcoyDau9BPOK98GGkwt2dVSy2Ewqico1
        IJTIgcj23IxyMwoFTKaXWwKkUAO/4klVg6Q+YqMbT/M2gvSiDNVZwCfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Og9BxY
        B3S6s2eW9bem199hyPU+nZaWl1s2wrCXUxwp0=; b=BDHT3zB9Hn9ioXF9I2l83G
        kZIYTD96pcYeBuER7wiQBB3hMIhCoKKUFWuWbziviSFvDhlpd0sj6NhFW+Hm61tj
        q3rBl3+8QXLRUapj85KNTWbE4K0qNQuUlglfKRrJQfdCO6p48qXftnyBHai+YH/i
        FzY8jhwf8ty6mM76MLfGhOSoyd31xwIFOTQq9zVBx7gwd8I77tqzOSC/+enAJYGQ
        a2XvEjI6i43KfFEQFXUi/KYO8bamescmcYsHa2PQo52P3XCt1owAEKpnPsCh86CZ
        zMSCB4iqrgw6iZ5H5tmAXtFlbwJm1c9hz0i0N2Mzgl143SMItg3jeGxwVDRwt2/A
        ==
X-ME-Sender: <xms:p28bYqXd_-wKnX4YqwxQGBzd_A2iEbZoiZYM9_YARtfYsTchnw8Lig>
    <xme:p28bYmm5JXyI30xZ8yZA4EQnpJUknQCVbdnHlVI1Hg8xJ42ZWJclrsTOXG7xoPlO2
    39MrLiKQ1i9rlfzD2s>
X-ME-Received: <xmr:p28bYuaf0LLdmjfRnDPTWakxOIYv2oEKmT-SFBzGa75SuSPrH893_njQuF-rlXTCswzkZ-h8mTyqVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:p28bYhUlaLMYy7H68B9FIWs-98W1LdZAqDqrOaYz4GXY4xQ80p_gnQ>
    <xmx:p28bYklsSJZHJe2pJEidXuw-FQDyGhOi5SYgavDF8eWO9riUnQMYmw>
    <xmx:p28bYmdNUrDaLdf3GmJI-oW3EC1kvxk-LI7QFOxK03P70t16zH724A>
    <xmx:p28bYhi1VCgh0C3owVT4_S-S_z0rvTXdjOeBHyb_8qsuoMN51Cij0Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Feb 2022 07:33:40 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, rydberg@bitmath.org,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v6 4/4] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Date:   Sun, 27 Feb 2022 22:33:18 +1000
Message-Id: <20220227123318.313009-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220227123318.313009-1-alistair@alistair23.me>
References: <20220227123318.313009-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the cyttsp5 touchscreen controller for the reMarkable 2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index a2a91bfdd98e..ca18ccc03197 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "imx7d.dtsi"
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	model = "reMarkable 2.0";
@@ -47,6 +48,18 @@ reg_digitizer: regulator-digitizer {
 		startup-delay-us = <100000>; /* 100 ms */
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
@@ -84,6 +97,67 @@ wacom_digitizer: digitizer@9 {
 	};
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
+			reg = <0>;
+			linux,keycodes = <KEY_HOMEPAGE>;
+		};
+
+		button@1 {
+			reg = <1>;
+			linux,keycodes = <KEY_MENU>;
+		};
+
+		button@2 {
+			reg = <2>;
+			linux,keycodes = <KEY_BACK>;
+		};
+
+		button@3 {
+			reg = <3>;
+			linux,keycodes = <KEY_SEARCH>;
+		};
+
+		button@4 {
+			reg = <4>;
+			linux,keycodes = <KEY_VOLUMEDOWN>;
+		};
+
+		button@5 {
+			reg = <5>;
+			linux,keycodes = <KEY_VOLUMEUP>;
+		};
+
+		button@6 {
+			reg = <6>;
+			linux,keycodes = <KEY_CAMERA>;
+		};
+
+		button@7 {
+			reg = <7>;
+			linux,keycodes = <KEY_POWER>;
+		};
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -177,6 +251,15 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
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
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
@@ -184,6 +267,20 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
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
2.34.1

