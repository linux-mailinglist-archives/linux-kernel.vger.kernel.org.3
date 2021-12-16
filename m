Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AA04771C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbhLPM0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:26:25 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43619 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236805AbhLPM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:26:21 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 957BC5805EC;
        Thu, 16 Dec 2021 07:26:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 16 Dec 2021 07:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=cz/W+o1QaYv6K
        IuV4GCrT7jbxJ0xS3lwdZjaIKs47tY=; b=rMvhDDSTPeQkF93YkxffldS9Nx2pN
        yUY4GdHY53zCO3hs04TWvgr0zlGXn0Iu38m3y8AZpwa+iIC5vQ9La5Uj6e+EY6x7
        S4Vi/mJMskyIIgw6MQJKikEOIhYMFrf0YYfUnBIjfJiv9YcYC+eGM12oWb1j0kHo
        MNaTkakMsp9Q9OlxKz2F850bx7zF4cbVR6CAJYKFbbAD70FzGrnyLLL7/bRMl9+j
        F8L2pqeZBWfFEsQekdvULAEBWf9uO3ZtxC8Ou9qaHTkt52HfopD+p852jivG7ZFI
        R0/JtPvKeCYmEkjGFB9NPj3fUPUYBsWRynlclsSui2T+uNStYlOZdcEHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=cz/W+o1QaYv6KIuV4GCrT7jbxJ0xS3lwdZjaIKs47tY=; b=nN+gG9wF
        oL0t/12sNotGBPoMwm60vzRn1U/IXCGj/q3+eQtQJzhMXJjtjSGEXFQZRZpKs6X3
        ePeXvrDW1CXj89cxc2KMke2bR/GNtQFFpA1BEO2puRjbziKq0HoNwHDw6+GSomm0
        9Iyf2iMpRcxI6e0aj5wdf0JgOLhn/QOdX9lCNpT7UyJ0xqYLCB+KUymyF7eNbPhe
        9IDFl9oAkheoSl28Q0Y1foJpKVk4NFlAdWfB96UuIVx4tWwHLaxRYcBiw38wUn1l
        lbO3JXXV/YPVwrSfeJut3OFjuHsUS/k5A50jYBWPWJRG2G6Q9iTkvFZ/D+tzWxTu
        ZEERDTmvLHloWQ==
X-ME-Sender: <xms:bDC7YekxkPUxqjw414NbZ8zixRUqTd6K0Bob5HDG-17KqbxR0dseqw>
    <xme:bDC7YV2y_nOejaDh-XhMrZp6KT39Qg8T-pPjpyn7I6fVOANvvY5Kp5-fqZ6nRdQpo
    VbD15S_RSLm-HVFraA>
X-ME-Received: <xmr:bDC7YcrXzUIt3XsmxjijZR8C-YHyYNFbBuGmoCBDJU12lxKfJHQj0zpwrda_Yf5noZMNM_tAa5NwlIDRrkqFoi9M76N4kknbs2_oTfebuq-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:bDC7YSnJn8B2Nuaaezod-k9xYBS2D9hV8_CkT0sAKNUUsjlhabN5mA>
    <xmx:bDC7Yc1A085kapgI_TIqEAI6ixYEAMGi_w_fYgnJ9M0xTudhZjU7lA>
    <xmx:bDC7YZthDeDKgeYgAkUeJs3bDlN_1vQ13x49r0xWXt3hGP4A8YJLuw>
    <xmx:bDC7YVH5b8TxsB3L1igJdN8H85QU-WkNNM6QBYgwTO5ibvj0p1a0sg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 07:26:14 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, lgirdwood@gmail.com, robh+dt@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, linux-hwmon@vger.kernel.org,
        alistair23@gmail.com, amitk@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v17 7/8] ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a
Date:   Thu, 16 Dec 2021 22:25:24 +1000
Message-Id: <20211216122525.136139-8-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216122525.136139-1-alistair@alistair23.me>
References: <20211216122525.136139-1-alistair@alistair23.me>
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

