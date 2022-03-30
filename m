Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8964EBDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244930AbiC3Jns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbiC3Jnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:43:45 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959F2266B43;
        Wed, 30 Mar 2022 02:41:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D3C0E5C0184;
        Wed, 30 Mar 2022 05:41:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 30 Mar 2022 05:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=3hHZ36EYO7sQbI
        1D42ytjQY6P2jHR5kstQ9BR6QaL/A=; b=c1PbrKg4XAyocP0Zp7JrxBA2O/0bEh
        e7fTNFaUCBYNVK53R3cwN5c/rOByq5AKZif8danpWC0AXT+i5bwdic9QJxn22PCP
        dL1pGyk5fZfqWoc3kpoyQ2iujy4g2NYUwRCHsv/zdiE9+OVNtdasX3VLhoBxLacD
        IkmPWWcrhRSkxxyrmcGOEnb0QLpgVkUAsASOlkHK3C3yT7upN2/yMqKHK5wOaVTv
        bf2wDJA8qgg6DcvqBDMiMt2xLJlTKGnqSc2ZD1H+caG1HMO+IXPDk7uTuMIIINaw
        Vbd3EBydLfwNsL9H6f9yi8FezZX71TmAv02ERikVHLSzzKA0hpEbT9EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3hHZ36
        EYO7sQbI1D42ytjQY6P2jHR5kstQ9BR6QaL/A=; b=VqQDQ8voedpvJ3h3d1pWoI
        6TK1DeeMsFo3c792RfJKtd4pF2I/ikIucGqBjbWlD1AKbw6yPmUqlXS+Dn7E/2AE
        wRtjnGLBpKrFZJvw1MR3rps3Gi+MuA8aXVASUqzzeeyxJjh9kbjSyE0+Y1UQGf50
        PMrNyYkYS6z4hDgvFXICIvjFg6V8HowzNp/NE2Bv1m2YWbM6L6peBB+x6Rr8Grff
        oi/RV9TTq40mmsZeX5rFtEGBmxqmvTGjFTVA3eWYpqrKX1fKZjQTOf12B6640QdK
        tBpof3PTHzGyE/mnK0gXsITCWfYjjy9T1iK5Gf0DER4eGDh/XDHQFzFhNX+2yLAg
        ==
X-ME-Sender: <xms:5SVEYoBzA_0pwkhlqt3WzFU2j32VRhLd97wJZUJoHOWfne30eKR7TA>
    <xme:5SVEYqhJM5bof1xlql8CQxTh9IpNqUJOVQW6TV_kAw7NypZZPFGE8AYOe52yvpv9k
    l6dGjszCFFo1UjFJ4A>
X-ME-Received: <xmr:5SVEYrmkQ5YruT5f8oOrUg8GOXKxltuaolg4AQp0gzpRCAJgkfLh4HiiZ4BQQjlWjcmZWxJXld8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:5SVEYuzEOk5Y7jYBTswzMC2WWC8tA5zI7jhBL_iHfJGgUjmbS57WRA>
    <xmx:5SVEYtSkxYlOWGdYmo7fIp1CZL4OqblyuCSfLB_6seCq7yV2iC0AgA>
    <xmx:5SVEYpZClIcMvb4Xo_qhuns-3Cnl3HnDBiFFDJJ3zINFdF3J5Owzvw>
    <xmx:5SVEYuKnAQr-HHMeU-WyeqvFHFr3sXztVTNXSlfhmOyvycA8uCxkow>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 05:41:50 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lgirdwood@gmail.com, robh+dt@kernel.org, kernel@pengutronix.de,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-hwmon@vger.kernel.org, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        alistair23@gmail.com, s.hauer@pengutronix.de, andreas@kemnade.info,
        linux@roeck-us.net, rui.zhang@intel.com,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        amitk@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v20 3/4] ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a
Date:   Wed, 30 Mar 2022 19:41:25 +1000
Message-Id: <20220330094126.30252-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330094126.30252-1-alistair@alistair23.me>
References: <20220330094126.30252-1-alistair@alistair23.me>
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
2.35.1

