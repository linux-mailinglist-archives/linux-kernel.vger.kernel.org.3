Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46FA533C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbiEYL4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbiEYL4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:56:30 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B942BFB;
        Wed, 25 May 2022 04:56:29 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 043A05C028C;
        Wed, 25 May 2022 07:56:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 25 May 2022 07:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1653479788; x=
        1653566188; bh=cW2sCjuMvHwM85PAI9i/8xp1DdjWZBXPTjHUxHrK29Y=; b=f
        U/RliwE14zvu/UWIU8ZdAeDQ+PE0EbSeNRFGwxtBSY2R63HyI0gCBvjZnGFkBTg2
        m5s9cfl8vOiBzGjH1BO+R7PTOejgsbpaU/XOuzaDaoBdVxT2843nzhPwolUBEfR3
        hzLiW5MzRuo7ZLf0WhQbwA7ioW26C9yil9uEg16i6Kvtngg8+2P146NVfasuRSLJ
        nmf8qTl5HuOAlXrUl+OVgrkXVdju/DcQWp6OlQ8efERuS5dZIgik4x2RBjG+He/2
        SweI6fbwFCBzkck3h2kVW4J1YnlkhwkYBtct2hZX4NTC5IgX7sfMJiS+xXPlKH/r
        bb8q6Cd5wHt0N9gm2vL/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653479788; x=1653566188; bh=cW2sCjuMvHwM8
        5PAI9i/8xp1DdjWZBXPTjHUxHrK29Y=; b=DwpT4cDZVlgXouJNw7WGSE3CPrsvP
        F9a3ABSTjk5l6pjJ+VaJeH3tc7Q9Wac56551IHa4cA3swjLEoQquhEiFHLOwVg/r
        fFRAEraqkh2fBCvWop+lX2dNzF8tDR32Gfk0zlE7ZSv2RihRMlpWlu5dfAS3u/lJ
        oI35apWAjuBq/wJD2l5vB9Zmkn/BMwWwp7N2duReXE5LYRKQbk9WWAP7AvQoPKyy
        xJ4SXpKuTmcgITRqdzmf9nJBMQOdarWfKfnuVQw2rgfK2D9K8700w2r9A9UQevrr
        iM2jW4/kt6CYYlhFjMyPv0VcvU+kgN/nJcNtC/N/oRO8JdCOekpwHoKvQ==
X-ME-Sender: <xms:bBmOYqSMh1DyCW3-DxXXsu-RzfKk8zJXqXKItaG-Tj_7jIhe2bStOg>
    <xme:bBmOYvxVODklx5CV9d-ZOiAvzgBZj7LGfploZsQeKs3oiwsJi3c1DjErovT_ETO_D
    LRKirJhhbOND7Tp-A8>
X-ME-Received: <xmr:bBmOYn1c7b2xkk-J1vBGofd6yY22lyxaSnEjDZvHCAmqe2Ym-acAHQK4QGdckr0912cUI4GEyLhr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeehgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeitdefkeetle
    dvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfehheenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:bBmOYmAbSA3mZ9A2ZFgEp6W0m84IJEW3O4GqAD0Gsxki5Bk_aJS5Cg>
    <xmx:bBmOYjisDynF2o2BKsaD53T0fESm5LkLbgwILqLLX1PXLGzDNMZ7mQ>
    <xmx:bBmOYipA7WTWNmi_T2HZIjyQA1NcXdYVF73sLQZtaKtL_U7FtMofpw>
    <xmx:bBmOYsZ4i78qRlS0_DFT-tGDY9u2_P5fW9qatg90kaMlVgqBYnp9Ig>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 07:56:22 -0400 (EDT)
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
Subject: [PATCH v21 4/4] ARM: dts: imx7d-remarkable2: Enable lcdif
Date:   Wed, 25 May 2022 21:55:54 +1000
Message-Id: <20220525115554.430971-5-alistair@alistair23.me>
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
2.35.3

