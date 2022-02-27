Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB94C5B30
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiB0MpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiB0MpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:45:18 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A7A6D96D;
        Sun, 27 Feb 2022 04:44:41 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2223358021E;
        Sun, 27 Feb 2022 07:44:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 27 Feb 2022 07:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=3N/0HnXvR7lNX6
        PLiCOIE9N0By42le63B3vLNKl7uGQ=; b=lYamvt+SFt7eefzpyuytFOGpymEB3O
        pQyZb37i6pBbsAWy+qhrgkbF3n2qGWrEG0lBCqbvYLbyEyffRmeIf53/rm7zhWp7
        +KCY5QpxE3davNyU6c+RMwMwE+P+pBKUlLmjlL2TCyyN3k3jAJQbxgcqFEjQ+taO
        WBYXqWsHoZHHBTk3JnY59+hjo4Iu8N+/xj84tyk3e6kIfwmelUVLX0Z2SSUh0mQ9
        6XL8dEtEMsZGQB5uWHsIii+fGSoGoZxNQR6XurXvbvz0m51ppFaQp6VxPGusN9wv
        saLPcvqySTJcCJnqf4PvgIWNn6/VwOoEtjVgebAwDhlqCYorXXq0vfuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3N/0Hn
        XvR7lNX6PLiCOIE9N0By42le63B3vLNKl7uGQ=; b=OZhXFXn+j048vBsr8B79iG
        +Fu+/0+A0oSo0VjoV98KhSEv8dcfLECIr9Kdlj3kkN2ae+2nQJb+8abjpK2tqPVx
        EqEnXTu9m8CG5TqPCwvpocsz4nk0fgVkf448moSvsTIWDEcGrR0OAXcRzSgO2mK8
        jwKB/MV5qPpUKZqqgq/fYRK9egnoceImoImRgR6DjabMNLvvoXsTCthEItSDY8bZ
        xW/DKt43aFzlJiYYlL10Z7AmLgjSx1nBi2VkjRE5W5GTSRQk0Y6MwneBAYbHl9c7
        TwpAwa0GgkvE3jfNm+7G949A09Yf3UaMZLXmR+rqoBVD8QoQbLpEvLXMatAiz0nQ
        ==
X-ME-Sender: <xms:OHIbYkCV517FdD9Al6t8-06KfY5OwX41Y1tjInA3Jn3_FG-8VDl7hg>
    <xme:OHIbYmgoqNecagwcdQ3ijwhpJUYYsMS5IzBTkse0i79NVjDb374ZLvhCcPbh_6dso
    IP3VsBNhQ7MYfRcz6U>
X-ME-Received: <xmr:OHIbYnn8Jk5dat_IUiRPnaqz0zP1YNQ4rjIC7Q1cTchx8kBrMn4JEzX31JtLwHKReYmXXo1xTuF3TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:OXIbYqyh3T9i6WI2BQlU2JZBR2EE2ECdM7ACQqSznwa0WK6FsIPuuA>
    <xmx:OXIbYpQicr891nfX5DOscgTSRJ9fGhyHkbPNlBQx5Y6pG0e0o4o2wQ>
    <xmx:OXIbYlZNAMg4bCRbMSFsL7YGKgzNtJcNORafqU7-qwkTfRTQfmWDBQ>
    <xmx:OXIbYm-FjtEwCCbT6eLK06bf0SA3bxhj-toddXhdz-EzFjUWe-RY1A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Feb 2022 07:44:37 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, s.hauer@pengutronix.de, linux-imx@nxp.com,
        shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, andreas@kemnade.info,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v19 2/3] ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a
Date:   Sun, 27 Feb 2022 22:44:24 +1000
Message-Id: <20220227124425.331030-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220227124425.331030-1-alistair@alistair23.me>
References: <20220227124425.331030-1-alistair@alistair23.me>
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
2.34.1

