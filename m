Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57838533C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbiEYL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242087AbiEYL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:56:24 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D070EE75;
        Wed, 25 May 2022 04:56:22 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3F7475C0281;
        Wed, 25 May 2022 07:56:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 25 May 2022 07:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1653479782; x=
        1653566182; bh=oMGSZjzbX1LP2PGoFYsSrfaJh355mkj0HkJRK8r9QFM=; b=N
        3WMk9NFVaV5ZIIkh1jGR23Sfq8PKuuM+zCveuDI2tlN9krySo9gxFxiJZcfVDdyV
        OKuBDK3WVSk5kloS+P6A04Fh3tkt5HDQTajmaIHU9ggyWN229Nvc7v0FVhLYK5nm
        Tnv1MyhBpKbddhOJiwh1uYNOKOhuKJ9XsYZAA8rrVFIXEdHzO00RMe91oPFgQlYb
        TUTd7QcIPymScizc7HFVAxxoQXuF7ovp10GhcLsmoF55LPQ6aABZLm0OL8qmaBU8
        B2nJKGJ58d6qoJYgYBekhpnLP3EIlU3Wt/StBTgsDBrrZY/bYqU7SUx3NN8o5X5u
        qJG7DiTdj0bsqC0I1nvqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653479782; x=1653566182; bh=oMGSZjzbX1LP2
        PGoFYsSrfaJh355mkj0HkJRK8r9QFM=; b=OjTUUhScHh0SKedijEow7d6jYh+dT
        h1KDmakCqK4D+Au9kI7JYjiA7TIhAAHGx1Sas61XifkziQ5YC9C8WuTruUknNGkK
        HlkpG4NjTgAIDlUdduPunCZvJteqTcuuUTXcsdmr0hpq6nUuYrrHf+qsFnVXNtau
        aEXUNhSudtGXP6wXynAVOaiMhDCeRfDhkgJV8XHKf0ojsHbiPSGGe4L396x578Q3
        BoNdAxTOnzoHUPKY5Bdpi3uUwi6SwZ0CWhhJxQPyWhXnYX7gOumJNpJhMANjwhlM
        O3Rhj3gDN3Zy5LzazK0Ky+Nk3AzRdVG/YQZb6heDe+3eZiUvo9E/XilXA==
X-ME-Sender: <xms:ZhmOYr5iaEzv4JysSz3LahmRrE-RvvML_w-I8Oklk_NKMs2hBCx_pA>
    <xme:ZhmOYg7bRmQLXqn_ug9qhtmWi2Y_rFOSzTcutYcBoFVg6BXhaBhyz0szt91dz2Aii
    ws_hKwWmAbR3Op_ppI>
X-ME-Received: <xmr:ZhmOYicxQmch75tzx-5oqBXul83r8xBBn1cNEOZuTIT9V2UUMXeclnw2wsANGOrGHqaDv4Vz0JwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeehgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:ZhmOYsJjL9YVIcD7RVCNnvwnwo7W6iMjFeFc_QSW98UI3709geZvCw>
    <xmx:ZhmOYvKJ6TQtXsvBf7VzKfUEfn_Uenp2or4eXz8tUsdUGG8oVgIEmg>
    <xmx:ZhmOYlzEXeExHtKjTxG1Zl4uL9u5Xl9Fxdv7VEtGVP8wTWI1RUCLGw>
    <xmx:ZhmOYkBGPurEfNAx6BV2dFyFZykr2EpHeVjFWcKhB9xHC4ysy77E6w>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 07:56:16 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, lee.jones@linaro.org, broonie@kernel.org,
        robh+dt@kernel.org, kernel@pengutronix.de
Cc:     s.hauer@pengutronix.de, alistair23@gmail.com,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        amitk@kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-hwmon@vger.kernel.org, linux-imx@nxp.com, linux@roeck-us.net,
        rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v21 3/4] ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a
Date:   Wed, 25 May 2022 21:55:53 +1000
Message-Id: <20220525115554.430971-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525115554.430971-1-alistair@alistair23.me>
References: <20220525115554.430971-1-alistair@alistair23.me>
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

Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 62 +++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index a2a91bfdd98e..99ac0d242936 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -22,6 +22,27 @@ memory@80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
+	thermal-zones {
+		epd-thermal {
+			thermal-sensors = <&epd_pmic>;
+			polling-delay-passive = <30000>;
+			polling-delay = <30000>;
+			trips {
+				trip0 {
+					temperature = <49000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	reg_brcm: regulator-brcm {
 		compatible = "regulator-fixed";
 		regulator-name = "brcm_reg";
@@ -84,6 +105,33 @@ wacom_digitizer: digitizer@9 {
 	};
 };
 
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4>;
+	status = "okay";
+
+	epd_pmic: sy7636a@62 {
+		compatible = "silergy,sy7636a";
+		reg = <0x62>;
+		status = "okay";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_epdpmic>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#thermal-sensor-cells = <0>;
+
+		epd-pwr-good-gpios = <&gpio6 21 GPIO_ACTIVE_HIGH>;
+		regulators {
+			reg_epdpmic: vcom {
+				regulator-name = "vcom";
+				regulator-boot-on;
+			};
+		};
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -177,6 +225,13 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_epdpmic: epdpmicgrp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21 0x00000074
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11 0x00000014
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
@@ -184,6 +239,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
+			MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.35.3

