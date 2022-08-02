Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF86587CCD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbiHBM7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiHBM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:59:17 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6279F20BEC;
        Tue,  2 Aug 2022 05:59:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AFEF93200926;
        Tue,  2 Aug 2022 08:59:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 02 Aug 2022 08:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1659445146; x=
        1659531546; bh=e69w31e7e/7d0EmO5mFp65sRGccZp1oPXI8E7rKhCCI=; b=i
        b0G9TFpUlnUivlLX/H0nvNhjUwmj5ByRYpTaJJ53ogvM4cqGg824iutwgbFyzg+O
        WeK2izewREbl8GIcJvUhyzEDaRimrY+oqV0bLkq2J7yj+tEdZV2A4tXaTCgLPOC0
        icgTiBIHGWlYK3uX3Vuz/ShzwBqXO3EL0s5yUpXvdw/1KZiAJxYpf/k+npLrqVw5
        RTslqtF2aRabjFHcwBBPk8YWVkhzTp0enNNkiomI9vZcy9vFz7o+uMk8pgTy4Mv1
        jR0RvXrA0BTt2i/Ctt8wM8h3cjh5hQfsK5kGJI0P9xpOUA3QlxVA+vnUkitKNutO
        Riwppm+c7F4Gzi698Nd7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659445146; x=1659531546; bh=e69w31e7e/7d0
        EmO5mFp65sRGccZp1oPXI8E7rKhCCI=; b=kOHKeQHicVjPwvvTRROJmlSCmvmJt
        bMkRqSkhmEFxEGb6ojJm/9l5B8DEXzLwPMqSCu4uFjrvCYx42Awlp33wjjTEap2y
        vNVp+7kuffVBzJxZyRNRJe/Xoy8qTpAD7A/9P8zlBZEcQmrzw8Sri9432fmOkG3P
        1GITupKXm+s2NLifEfJ17Of9gTU3GZdsNAMtsvXdGlHiqPkfmczQviVvca58FdQN
        S6mL9adhrnIW2z8akucHormKgJe3Hx9pEgI4pfYnrClRCxtnyuCeyiDZkqKyXik1
        rOGF+/m8wwWDPjY2c03blLEt54+T/pCYV10yQNU7SjYDXlMB/H+Ko74Zg==
X-ME-Sender: <xms:mh_pYpFDt48FagJUh_C0ZKMWqjWvxyKGrU_N5HBZ7iTG3bRRE6bDqQ>
    <xme:mh_pYuUmXidagAi_MLP-BOdYpiO1H8ZKHPURWtl1bGhcqyMDELiC4jFkMI2ldfGgZ
    QzvRKvloGyGWBSRSW4>
X-ME-Received: <xmr:mh_pYrKlhMIn0DNI7sp6DlfnTSQnwUQE49ylpt0Iv6kMTO_1IIfTPMDOpoeHVEUZrVcrxuuObt35>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvhedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhhishht
    rghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
    eqnecuggftrfgrthhtvghrnhepiedtfeekteelvdelveevueeujeffuefguedvteekveej
    jeeutedufeethffgheehnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:mh_pYvHkU2B-e3XJW1vTjnG3de_hvnWLFNfYlaSZdYbWsdrlBxKLGQ>
    <xmx:mh_pYvXE2Ku17yQLoLNJMnKrKcqEtT1iHg3v1ROOCe7qU6eILfdAZg>
    <xmx:mh_pYqOWAnVysGtF5nft2TuflGd_jfZOPOPJC2slbxbArZ6tYVGm6Q>
    <xmx:mh_pYou8ObN4roJUTD52nFwtmyrs7ldhHJrcg2n4REGMo7YVHWHfIQ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 08:59:01 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     shawnguo@kernel.org, alistair23@gmail.com, robh+dt@kernel.org,
        linus.walleij@linaro.org, s.hauer@pengutronix.de,
        andreas@kemnade.info, krzysztof.kozlowski+dt@linaro.org,
        rydberg@bitmath.org, dmitry.torokhov@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 4/4] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Date:   Tue,  2 Aug 2022 22:58:27 +1000
Message-Id: <20220802125827.34509-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802125827.34509-1-alistair@alistair23.me>
References: <20220802125827.34509-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the cyttsp5 touchscreen controller for the reMarkable 2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 100 ++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index a2a91bfdd98e..fea480af8e48 100644
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
@@ -84,6 +97,70 @@ wacom_digitizer: digitizer@9 {
 	};
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	tsc@24 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
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
@@ -177,6 +254,15 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
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
@@ -184,6 +270,20 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
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
2.37.1

