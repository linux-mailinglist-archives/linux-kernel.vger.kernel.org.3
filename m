Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7804E51C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 13:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbiCWMC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 08:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244048AbiCWMCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 08:02:24 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7DF7A9AA;
        Wed, 23 Mar 2022 05:00:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 542BD3200C14;
        Wed, 23 Mar 2022 08:00:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 23 Mar 2022 08:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=hC7X5s7HQc6viR
        9PYr+JWHUjZSf2EJs42JixYxm/GUk=; b=Vwvtf8uz64RJAN1RwMGE1LktKYKT3p
        FmDL6lnQG8yjgqqADVZ6AuJHVV2OBbaRdgxhwpt3kbSr3ZJ4yNOMX/kK/KyeJySL
        abhDm4GvdLoNp5n4eeEAVGTHEsgr6U06X3/KLfi/X+G2yG/Xo53nAmAoeJn4ySee
        AMRmwbNR6ff1KRbMCwRtCnDuQSH8Yv8JSnBLcufPqbWlmp9qo9lesu6IeO1I5Vhy
        Clm/aFqu9qwmEFhWdKPse5hfBCrWH6YResE41HNYmBC9cgRfLXWBYZ4uPlPdhY6p
        dim4irdlTIPEg/hoK9+ufPOuV1kvFnyDK+Hm8iBHweebuGorkS0dMn5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hC7X5s
        7HQc6viR9PYr+JWHUjZSf2EJs42JixYxm/GUk=; b=W42ngcLU9LbL/r588aAs5A
        tHqeNqqdk06SYG0Ip/JiUmLBcAxNDU8hFbUYHeIyIhSRXJ/FstyuxRhhMlaJYyoy
        NlwN7tRlkGfg6Rvut1/t7US7pP9GiGOHGfpl1ay+Qggcan0r14MFd5Mdq9i2DsoO
        EIkgl+BrbRKAa8ALQZr1KLt4HuzTWN8d4gNIYojDrNSTM0Lr45UZKQtCE5YdEHil
        ZRKUbWyaS8RFEaNlaUcaB0I7CYxeV+0t0gQ7wyTV7IAItr+GyOsJzSmAmLFo8WfM
        bb2dy8cJDg23iofso0WeP+Oy+RecLfzuXbQqaUwwVrgKnDUieWtn+K4fa7IePnKA
        ==
X-ME-Sender: <xms:9Qs7Yi1vsZ-qh6hVPcD8P6TaZNofAU3rFZWfMXTSW87-tMDC11TI3w>
    <xme:9Qs7YlHg4DNU6TTfMKXFubmuNQmaC4tSdHhWXxolRAdeMhMaNht5qSh08NUSTeqtI
    iYXqiG_TgKH7d7QHNk>
X-ME-Received: <xmr:9Qs7Yq6gVCCesyiQTEtu1ppFaWRHQsMd27C1uKMlc_NCCIN4vUOEA_eO24OS0gFVuscyn-yPz3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegjedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:9Qs7Yj0qsBXA4SnjgRYlh1oVMYO-cvJiFBebWVUHBjCdabRpKnasBQ>
    <xmx:9Qs7YlGOdJTnMxMBeXvFAXV9mvMGGcSxEokk8rgFRRsE6iMrc_LkZw>
    <xmx:9Qs7Ys_6D98euwnidXGN8iPI2xLIrVeByIDPJ4nyn0b_WQ3SAf-BMg>
    <xmx:9Qs7YkBUyALGqBGSnnkcoZiTSAeQK0IeJ06UXFpS-RO5XSNteAZKWQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Mar 2022 08:00:49 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     alistair23@gmail.com, rydberg@bitmath.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, andreas@kemnade.info,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v7 4/4] ARM: dts: imx7d-remarkable2: Enable the cyttsp5
Date:   Wed, 23 Mar 2022 22:00:21 +1000
Message-Id: <20220323120021.361137-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323120021.361137-1-alistair@alistair23.me>
References: <20220323120021.361137-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 03a4029e1e57..b0c5bea32a09 100644
--- a/arch/arm/boot/dts/imx7d-remarkable2.dts
+++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "imx7d.dtsi"
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	model = "reMarkable 2.0";
@@ -78,6 +79,18 @@ reg_sdoe: regulator-sdoe {
 		enable-active-high;
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
@@ -125,6 +138,70 @@ wacom_digitizer: digitizer@9 {
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
 &i2c4 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default", "sleep";
@@ -266,6 +343,15 @@ MX7D_PAD_ENET1_RGMII_TXC__GPIO7_IO11 0x00000014
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
@@ -273,6 +359,13 @@ MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C3_SDA__I2C3_SDA		0x4000007f
+			MX7D_PAD_I2C3_SCL__I2C3_SCL		0x4000007f
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_I2C4_SDA__I2C4_SDA		0x4000007f
@@ -320,6 +413,13 @@ MX7D_PAD_LCD_DATA22__GPIO3_IO27		0x74
 		>;
 	};
 
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
2.35.1

