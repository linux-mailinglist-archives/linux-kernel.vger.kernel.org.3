Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7326C4C5B32
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiB0Mp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiB0MpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:45:22 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB2E6E28D;
        Sun, 27 Feb 2022 04:44:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4F57958021E;
        Sun, 27 Feb 2022 07:44:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 27 Feb 2022 07:44:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=KIEoATxbMV81kK
        7/dQqdRokzAvfbjIR76Q+BP8xavdo=; b=H8o0maa3XW7eLDbng5NZuWaEMAg9Hc
        iRfZVWJiySjT1XNrfN96UkOHnnJcl8VEfQ21lUTsOWiCQnibuZk7J7xFpte9YX0f
        v1ROUSmiZ++zMfc7T4wSN5Th3+IEoAfTDzJYCXWnbDDi6gbm0OHOdMqU9E03bXLG
        bMrf+YBv2gsGdiUtOWwESnqrIhpyAfEiVltj+l5s766T9+LqlYS2BOlp+GiZY0zW
        VKUFnj0EcrLih+ZGgmXvOurV+juCjJYVgmvc4dPhgnsihbzzu4NSWgvMIDT6FlUj
        N7QKzn1oOXST7u0Jp86i2srwfgdVxNX5/MZ4IQL38X1++TMWsxvH31qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KIEoAT
        xbMV81kK7/dQqdRokzAvfbjIR76Q+BP8xavdo=; b=Hj2BIsy/lJw/HbBv+jc/H3
        eEAjPw3JUI2KGEDnPn8Q7sYWjIERu4rRBQYPWljsHfaoSI63iZAK0nRniVVqHBWY
        gUt8Tk/eBcoqS36DezmHYGUPwgizKSibMZ6Pb1rqD28N0oWF2BbqsA08kOL9HknF
        h/2U0e78tJSrHMLYd8dsQM6dJCA4wNvv2QpC2LI8TDecLK2jyqgz1JUvnh/0WBxb
        UzpyBAhZRGm0/6VzGWKAG0vpYI1d+pUKwGmXoC8xFTQqSBA9vXtway/+/CnHjx8h
        rA+1xiUUTnZk2M9pQLw0x5uFVoqFDPYdmlNEQhah0ZLlDJO6zRPVEIEwqjCEyaow
        ==
X-ME-Sender: <xms:PXIbYhWKAy9Nkr_AD8ko_NozmLZZZYiAm-vvKRDxZ5mTbn531yUd9w>
    <xme:PXIbYhnF4vsNHmGA9dGz3jSYym7z2jaDTzlZq47u3638vQeECFHbHbinQnECqDsG0
    8rKn4O8jcVuFQ-qUxQ>
X-ME-Received: <xmr:PXIbYta5DlXRHm6ZjgSx1nEwWYyG7z_PTrJkOex175a8pIA57kA_bRfAm_J9PmRv49rjS3WsPEwXxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:PXIbYkXQZpxP9QQ32sAEomrOla_rqfaBR63eZNGvVyyk104D2O9BPA>
    <xmx:PXIbYrlvxAi2WJuJ2I9x2OsrI02mnj7av4Hn5QPHrZm6rEve5GvftA>
    <xmx:PXIbYhdkdiX-DtQzQ2jzvdgKsh0ArOVoCaTGM9FXbTUYMIpM5-W1Qw>
    <xmx:PXIbYkiMFOBTK28VHQJMnF_YWczeLMy59zLAv40M9Ni9NVHK3OKf8w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Feb 2022 07:44:41 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, s.hauer@pengutronix.de, linux-imx@nxp.com,
        shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, andreas@kemnade.info,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v19 3/3] ARM: dts: imx7d-remarkable2: Enable lcdif
Date:   Sun, 27 Feb 2022 22:44:25 +1000
Message-Id: <20220227124425.331030-4-alistair@alistair23.me>
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
2.34.1

