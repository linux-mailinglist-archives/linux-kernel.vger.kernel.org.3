Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB88497EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiAXMLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:11:14 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48091 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238507AbiAXMLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:11:03 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1AF045800C6;
        Mon, 24 Jan 2022 07:11:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 24 Jan 2022 07:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=cz/W+o1QaYv6KI
        uV4GCrT7jbxJ0xS3lwdZjaIKs47tY=; b=zkKju1Exn64yUuWCtIhztzVSDwhS23
        Q6eBc7UO3MhoRDh4c+jxoCNJRn+qJzBEZ5f/7auA2uDjcJG4uK+I2KCuEvrriaLJ
        6aN/clPy41yd42vTXH1HUBIotWkfNm6GSP5ORAr3/0ddjDIVA+AxYbRV81QcVdDN
        eDqlDRXEbvEsimJqQ67bBPml50iCX+3PZUYSQ0lXZWDzuaB0WZuH7e8JbwyA5aNc
        aUSFiPO4QM9ALp7ONFWDqFAL93dSQdgRrDEZKlDfLNgKMCAiYNyr+NB5X/F1B912
        OeUt31qo0Cvjrc8FuwH50O5Io/wfSW6outHV76Srobe1XG/Hdmz8sM2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cz/W+o
        1QaYv6KIuV4GCrT7jbxJ0xS3lwdZjaIKs47tY=; b=F+eMxLXY17mxzbLPbfbNT2
        q8DzLgrNG6/CG/HpNbrdxNdzuf5KrDxYbojqyfogGf0aMFvrKmgxJi/erLaCdjOT
        d2Y+i+pXrH0ddb2qG5RbQYsw+e+QK6BXcss/sx6bY8WH1Dw/pZoMxkgb3Nn8RMAz
        j9zirzcft7L9bp9Ly+fX0uzNVXzYw2Rye6WwGznD8+qUssjy1GwTHLYTMGIRx52n
        TgOlAWgPJPUWX28/9R2V58iB0Lwrvkm26A+lwjA3xN7FBnnY6s8Ze58OwGMw7F+a
        mm60YR/A/BZA5iGK1YKkmMTKDa8cr2J5Z2MsIyVHgmk3EgsLAbP2kkchw0q7vV+Q
        ==
X-ME-Sender: <xms:VpfuYZ2lCMOo5QPgi88_fOQjsEWng0IbKcxSsTkjwJT1Oyg-D3RKEw>
    <xme:VpfuYQGuK-qCCDhDkJF3dNjba2--8WQnyEdBlAr_SoAcDNCm4QeIuZ2apu3xEQ-3R
    7N8NBiwvzuymo1mGJ4>
X-ME-Received: <xmr:VpfuYZ5UOjHKwtsrlv9jwZKNkLy_7GPT3sUowqNwArx9jrbIyuQ5fa3vo5idcEbKOKfEwiYlU4f3oGU9D8Umt2QCRGuJxAf174jMHMYM-mqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:VpfuYW1nZ6gQpTC5sPWmfSwFaj9RXmrXO6pkprChTeCvI0Ohzy-vYQ>
    <xmx:VpfuYcG7srVKEpW3oPLSLFSW3J3EStHZHtAS88b8KEz50F2jMmIQ_Q>
    <xmx:VpfuYX_zm-ZbyUY9hjwiJT-oB9tjbdX4k70MLyfxl0SeLTZ9hEBIzw>
    <xmx:V5fuYaU5H_Smuq8QSBcTQ4Y0VKa7XzZlCA1Ebms2oIbrFwjyIT-vxQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 07:10:57 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, lee.jones@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, rui.zhang@intel.com,
        alistair23@gmail.com, amitk@kernel.org,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v18 7/8] ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a
Date:   Mon, 24 Jan 2022 22:10:08 +1000
Message-Id: <20220124121009.108649-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124121009.108649-1-alistair@alistair23.me>
References: <20220124121009.108649-1-alistair@alistair23.me>
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
2.31.1

