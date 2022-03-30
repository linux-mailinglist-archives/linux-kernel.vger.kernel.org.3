Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473814EBDE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbiC3Jn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244958AbiC3Jny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:43:54 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA8926758A;
        Wed, 30 Mar 2022 02:42:06 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 509C35C0112;
        Wed, 30 Mar 2022 05:42:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 30 Mar 2022 05:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=MwfV7nsItBnW3O
        zn8rdsGHNQf72GR2WAjiX9XTD015E=; b=VqXkFVdSuwozC3TVRTXmgAgA0DNufN
        ICcHcs7su254A753czgLfAAYq4DzUIylEOBNkl6vSy+pxXOEtljJPaCSr5oiOsen
        xUf98usU8u9N6DA2YFtGBL/VGHbRJdlNRHeR8WRuCaDURxA6Z4tVV33ZH9eDpGdT
        satBMZ9QAW0la4K56GNZcd1cooFAzBfpp6GHqmL2I6ea50F16214F0nzVXYTj2lq
        QNDaKhJ4eve9Fg72Xpen7YReKdEHcTKHFA+n3kpd+CFLnNxVju+VdvKSiPYE9T0p
        3IonpU/P3oIqfUUILtFGdPT5cewDfuqqy6rhMXgPJwz0h457cd89JoZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MwfV7n
        sItBnW3Ozn8rdsGHNQf72GR2WAjiX9XTD015E=; b=iJfZWwIwJ8yxPEzgX2ydP/
        p4zrZKUYupVD6W7iz8nChu6aNFD7/Vk1b0y2ws+wNXgD4lsN4DOdkUdX+ZRvd+QU
        YFiXE3vtDcVz+rfXU3G8t4NzetWeuzp8PMvw/RoAbZB1gV4WRAH3/OW+PHd3EYQb
        Ufn9Dbwg577uD/+UW+bqKkyQKCGd2I9wOBL/E1v43uchwGRNPs1GEEjgvG9tTnB3
        EaxTYtBAbChXRhxoWOsTSHksI0yLwxfpfhFOYL5DJWsq9OVTDbEVTOA1ARy9ybrb
        NJBIo/xMbWyosSPxdUQEcSVQcCrTrSRQ7z1Gz/Ajikimkd9hyyI7K/G7aPprIIYQ
        ==
X-ME-Sender: <xms:7SVEYn1Btm_cQLmb5P7LHrD0uLtzB2o6_xtQxmhczgEL5o7JqfhkkQ>
    <xme:7SVEYmFMolz001gqukiQtLkIRpmaAQOTbNEC8VE1PKkivtP5xKKMQ_dPOruuDC4Dd
    b8eD1PPyerCHjaPURo>
X-ME-Received: <xmr:7SVEYn4DhsAXzkedLVY45shYmQ3224lDZ0gkUMNzcRegF00GUbXHbwMOAIhf8ZJVnVXKV9yR5C8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeivddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:7SVEYs0cPiHJAdEkZDb59ADEj0HL-3HHVK4-r6YvE95DDI3BSuy-GQ>
    <xmx:7SVEYqE1koR2pjNeSkxvg-SMhcPjRGEeSkpWcmTMGhziZuzTecfRVw>
    <xmx:7SVEYt8Xwl3JfAQWg5s2GhZlnhZsZ0gJ92bEvfkN0QbKk8rIkfUWUA>
    <xmx:7SVEYo_aDvwZtJ0AV-ED-JglPLog_tgBzBKp2TfxcetO2iWnbY9pTA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Mar 2022 05:41:58 -0400 (EDT)
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
Subject: [PATCH v20 4/4] ARM: dts: imx7d-remarkable2: Enable lcdif
Date:   Wed, 30 Mar 2022 19:41:26 +1000
Message-Id: <20220330094126.30252-5-alistair@alistair23.me>
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
2.35.1

