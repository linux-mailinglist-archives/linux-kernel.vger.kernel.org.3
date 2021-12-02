Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015AE466340
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357701AbhLBMOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:14:09 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60627 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357770AbhLBMMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:12:19 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 52446580344;
        Thu,  2 Dec 2021 07:08:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 07:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=716shbgGMma/V
        dWgBLnXtBaiv+CdVe32+vnXxmMr+Y0=; b=Lp9iW0g7V7nLLt8Fbve+x8Kg1gWDW
        ecrUu2OpH0KFYnj/qIMuMawBzf7+tis9g/iiujXhgBttke7tgEhS8jYAs1s11/rs
        4sYFP5QWirkI6objMT/NG5IiejwxOSIH2Cz3mAQjFvB6Pccst+FltDvfPfUCphm2
        8Gfm3WiYQHRWbOHZjhAMjiPyvZBZ8UKtVcWDPIHxKq2kVI/1xq8u0N3SMyUYWvJZ
        MOD44QER5yq5HeNo2CKQGYZbPznDvUx5O/j0/Y1S6JonwKjkDVG4jqekfvN4tX2m
        VtWGAGMP5BuyDbkFDaqTgVpMePWmjed9E4/CQlCgCvM4ZlXGBtnDtcSMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=716shbgGMma/VdWgBLnXtBaiv+CdVe32+vnXxmMr+Y0=; b=feuY2GyV
        j4+EsQciszLIoFVghl/1Wm/HaXrHqDV3Dua5TocNN7eYR+Hx+Ut/AnjIrUAF59B5
        unsycWILCgTgT0h2Q730z3VWY5AuhqLucQwMReX0p/MlNm6cq8IC6bqXEf6Jh2Pm
        B0vh/gDPuWfZ7mtOXgY+4s23tcE2Va6K4jgKp+u+IpM7PNkGrjlGEEg9XnyXOUQ0
        ePjP/kJ2dZor1ug3QpuHR7fxG48uo18/KFE/km5XrfnpV1gglCx9XEec+WAbzwqu
        Nt8XbiqeMLPmiaZpLaw4ZcPnfIWGy0GFVS9kajDxtPeAJ9EQG/6Zvv/uGHNa4cpl
        5QdnZmXh0c+QXA==
X-ME-Sender: <xms:WLeoYTYvjdQcYb4FZujduZZxChWFU5pVZY1I6WKE4G9m9u4n8Vt5OA>
    <xme:WLeoYSa6RfqbnMMPI4LHJcPQC2gcXt4X0dC12GSvn91RWbYiNCf0XQ8ACzC2RpJhF
    3chmHZN_1VIfqnJvso>
X-ME-Received: <xmr:WLeoYV--Vrt_q0Px4xrN4yPDK2Y-J5Rf1wDN7mUKUZfIhQZOwU4sWgVB0_KjeqUmAu7mKpqf4WyK4uz24erC62k4ThuoXezx9-I3Fl6qHdb7u_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:WLeoYZrUb9lEcYL4dszgjK2TB_WjG8V8hbqTduFD1PT_eua_tLSVRA>
    <xmx:WLeoYeql29NdivFk0HShoA9hPqpcQcPBN6GJbLMg7Qdh6nS3qiwReg>
    <xmx:WLeoYfR8NOzPaI9hTb-pBkKYEtDQcoTMXXYIAitSQPX_uf9jm6_HCA>
    <xmx:WLeoYca0sp_X8OtwNMVbNmkKigMV4I81QtBnswGI7egaITECuyVA1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:08:50 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, amitk@kernel.org, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 7/8] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
Date:   Thu,  2 Dec 2021 22:07:57 +1000
Message-Id: <20211202120758.41478-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202120758.41478-1-alistair@alistair23.me>
References: <20211202120758.41478-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 89cbf13097a4..b66d28b30d75 100644
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
@@ -51,6 +72,33 @@ &clks {
 	assigned-clock-rates = <0>, <32768>;
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
@@ -125,6 +173,20 @@ MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x14
 		>;
 	};
 
+	pinctrl_epdpmic: epdpmicgrp {
+		fsl,pins = <
+			MX7D_PAD_SAI2_RX_DATA__GPIO6_IO21 0x00000074
+			MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11 0x00000014
+		>;
+	};
+
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
2.31.1

