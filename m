Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9171497EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbiAXMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:11:16 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:53695 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237863AbiAXMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:11:10 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8198C58018C;
        Mon, 24 Jan 2022 07:11:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 24 Jan 2022 07:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=iFE30ZBYJvCyNk
        M0bB9sCSLWOJ+dFFVmxcQv5U8f2Ek=; b=sFaJZbgtUeLAWxocb1HvewYSWmgi1J
        Re1ZdEuZzL/938sA+qmN8/V9uqSF0L0vNex+CnpmYcNX7FQv5Ab+4EsQWhgwYyS2
        BxBRjkarT13aS94OAP7CA5+ZtFovRlo781V9mXCY0+2naEz2uqm+thCrqRRTjP3C
        +8i8adF5ILCqVpjdpmFXgJbcxkt92Hao8M++0wm+u3kSM3nNe7kFR3T5pAqhSVPI
        NHrGxktbZFDL9myBRd1SKz9DtxHXVr6I9e+GSntdBdwhR6d92bXLqO7AqkBe1XC1
        vQn27LWHTajONUzwk7ri/UDXb2+eoaaiapnBgFuf9r5OKtkIAAfJPC6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iFE30Z
        BYJvCyNkM0bB9sCSLWOJ+dFFVmxcQv5U8f2Ek=; b=SxrHIhM9QqCGIGebAZRtTh
        YexoR8oVDJ5lzGLRIsbH0rfne1ycAoMdqmKWdIiKzg2sA+KPuIZPzIgprJlWMzp3
        BkGCC5TZ6heQU7KhS5Mdu1nzti/9e4oeCVvl1lD+vN4q5jPJmJ132dLU2Ind1aVT
        3l1PnYZ2oJYPOKC8HG/N9WdJcA2pxZ0GfoaWpAwUUXDkqFDdAxYRWFw80esffR7u
        qX8Z00KRPR8nOoWgvEIPbnjW2IPIchNYxZvpRk9+jJCoPphrDkb+ZNit7qenWDLS
        6+L/tk4zNltJR5PTU419W3ecZgTL4Ahcmlwm6rhHe6lrqyWJiLJxLr/mli+pWRMQ
        ==
X-ME-Sender: <xms:XZfuYTGqGKqgzT4iF0o1VUBZ4VDY2TXBdSC6ceGKDioz7591nWp9Nw>
    <xme:XZfuYQWZikCehBHIKL2WcSVzj7uO0yzV9Bana6O9g1ZVBJFl3eH9r2KamBbVTx7hF
    BzrKFbzfjLsYMur7lQ>
X-ME-Received: <xmr:XZfuYVL9eV6hR4iAO9MckKw5oXCizGOnU80_7HfLjz08dG19yG9diSW9Y-sMgahdr_qpRYnHtCK2IWiR_8LebgKqaSrIRfD5n2yyCrAshDjj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:XZfuYRH0A7zj_roVyA5Rpvn806K1fiOzZBoS8VXz9zzwMcCoEhh81w>
    <xmx:XZfuYZX15ZRVwpqEJG5Fh_tDwkCTBUf8AE3nDMzvw4LQCxnIudAXCA>
    <xmx:XZfuYcMK0By7wOuhnGcuTTGHIgUNi1vV7WVyQrukOH0Ka0tBJ4hAhQ>
    <xmx:XZfuYdn56FVv7fMDhdTQZ8XAwiMg3C_QoLid89kUn_WAQRghgzqdxQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 07:11:03 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, lee.jones@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, rui.zhang@intel.com,
        alistair23@gmail.com, amitk@kernel.org,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v18 8/8] ARM: dts: imx7d-remarkable2: Enable lcdif
Date:   Mon, 24 Jan 2022 22:10:09 +1000
Message-Id: <20220124121009.108649-9-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124121009.108649-1-alistair@alistair23.me>
References: <20220124121009.108649-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Connect the dispaly on the reMarkable2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/boot/dts/imx7d-remarkable2.dts | 74 +++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
index 99ac0d242936..03a4029e1e57 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -68,6 +68,16 @@ reg_digitizer: regulator-digitizer {
 		startup-delay-us = <100000>; /* 100 ms */
 	};
 
+	reg_sdoe: regulator-sdoe {
+		compatible = "regulator-fixed";
+		regulator-name = "SDOE";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pinctrl_sdoe_reg>;
+		pinctrl-1 = <&pinctrl_sdoe_reg>;
+		gpio = <&gpio3 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -76,6 +86,16 @@ wifi_pwrseq: wifi_pwrseq {
 		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
 		clock-names = "ext_clock";
 	};
+
+	panel {
+		compatible = "eink,vb3300-kca";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
 };
 
 &clks {
@@ -132,6 +152,20 @@ reg_epdpmic: vcom {
 	};
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif>;
+	lcd-supply = <&reg_epdpmic>;
+	lcd2-supply = <&reg_sdoe>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -246,6 +280,46 @@ MX7D_PAD_I2C4_SCL__I2C4_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
+			MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
+			MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
+			MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
+			MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
+			MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
+			MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
+			MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
+			MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
+			MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
+			MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
+			MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
+			MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
+			MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
+			MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
+			MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
+
+			MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
+			MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
+			MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
+			MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
+			MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
+
+			MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
+			MX7D_PAD_LCD_CLK__LCD_CLK		0x79
+			MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
+			MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+			MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+			MX7D_PAD_LCD_RESET__LCD_RESET		0x79
+		>;
+	};
+
+	pinctrl_sdoe_reg: sdoereggrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA22__GPIO3_IO27		0x74
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.31.1

