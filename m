Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FBC501A46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbiDNRnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbiDNRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:42:46 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135CCD4C8C;
        Thu, 14 Apr 2022 10:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649957983; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZiOpzMWO9hjhHMY5nGJBPot082I/+QieyM/+iyIEUDfqrEdCD2F6JIfFW+DI5eK+V57s3IWhzzAY4X+BaB/SdCWYx8yS1WVo0PxdbdtVKod2RfDED5SzrsvgEqXPMM2sLvnfD1ci1v/1ecVXJIZ1UVFpYnoErlGTggvqkoeYp0I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649957983; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=4frekDtBEqArrjelj1qY9f+heZVVCvsElXQVAZOYy5k=; 
        b=XUfIyS64fN6Sp43XA7Snlu8eQwIcRhikRH9G8+Pp3qUgmnJ2PnwFgFuY5ys1NOMCZ9Wx/1dZHJU55JrvWPsXUzmuigPwpzZZnJa7RVq8FMEGHnGeX3+4nWCudIx8FIzFVuJfS0+3ESEWmF+wgA/+l+zYsr+HAVBliB0LPGxyDFM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649957983;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=4frekDtBEqArrjelj1qY9f+heZVVCvsElXQVAZOYy5k=;
        b=W3poNdndHiXXyP0aWjrZo8sYHWunMiP4ToLCXGetqG9CCQoMcScJJahlgbpwDiZg
        +sgDdHzQ3DO+s9FTD2yspCZCiknAvlA+cPJ7iVyXqVif64MS3Dbtvx95CnO7Kqx/6+2
        ZJwcjH9MCW0xjVX6hh8PrQKKhG1N8Rcl/hFBsG5k=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649957982913725.4761330643432; Thu, 14 Apr 2022 10:39:42 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 01/14] pinctrl: ralink: rename MT7628(an) functions to MT76X8
Date:   Thu, 14 Apr 2022 20:39:03 +0300
Message-Id: <20220414173916.5552-2-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414173916.5552-1-arinc.unal@arinc9.com>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions that include "MT7628(an)" are for MT7628 and MT7688 SoCs.
Rename them to MT76X8 to refer to both of the SoCs.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pinctrl/ralink/pinctrl-mt7620.c | 218 ++++++++++++------------
 1 file changed, 109 insertions(+), 109 deletions(-)

diff --git a/drivers/pinctrl/ralink/pinctrl-mt7620.c b/drivers/pinctrl/ralink/pinctrl-mt7620.c
index 6853b5b8b0fe..d3f9feec1f74 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7620.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7620.c
@@ -112,260 +112,260 @@ static struct rt2880_pmx_group mt7620a_pinmux_data[] = {
 	{ 0 }
 };
 
-static struct rt2880_pmx_func pwm1_grp_mt7628[] = {
+static struct rt2880_pmx_func pwm1_grp_mt76x8[] = {
 	FUNC("sdxc d6", 3, 19, 1),
 	FUNC("utif", 2, 19, 1),
 	FUNC("gpio", 1, 19, 1),
 	FUNC("pwm1", 0, 19, 1),
 };
 
-static struct rt2880_pmx_func pwm0_grp_mt7628[] = {
+static struct rt2880_pmx_func pwm0_grp_mt76x8[] = {
 	FUNC("sdxc d7", 3, 18, 1),
 	FUNC("utif", 2, 18, 1),
 	FUNC("gpio", 1, 18, 1),
 	FUNC("pwm0", 0, 18, 1),
 };
 
-static struct rt2880_pmx_func uart2_grp_mt7628[] = {
+static struct rt2880_pmx_func uart2_grp_mt76x8[] = {
 	FUNC("sdxc d5 d4", 3, 20, 2),
 	FUNC("pwm", 2, 20, 2),
 	FUNC("gpio", 1, 20, 2),
 	FUNC("uart2", 0, 20, 2),
 };
 
-static struct rt2880_pmx_func uart1_grp_mt7628[] = {
+static struct rt2880_pmx_func uart1_grp_mt76x8[] = {
 	FUNC("sw_r", 3, 45, 2),
 	FUNC("pwm", 2, 45, 2),
 	FUNC("gpio", 1, 45, 2),
 	FUNC("uart1", 0, 45, 2),
 };
 
-static struct rt2880_pmx_func i2c_grp_mt7628[] = {
+static struct rt2880_pmx_func i2c_grp_mt76x8[] = {
 	FUNC("-", 3, 4, 2),
 	FUNC("debug", 2, 4, 2),
 	FUNC("gpio", 1, 4, 2),
 	FUNC("i2c", 0, 4, 2),
 };
 
-static struct rt2880_pmx_func refclk_grp_mt7628[] = { FUNC("refclk", 0, 37, 1) };
-static struct rt2880_pmx_func perst_grp_mt7628[] = { FUNC("perst", 0, 36, 1) };
-static struct rt2880_pmx_func wdt_grp_mt7628[] = { FUNC("wdt", 0, 38, 1) };
-static struct rt2880_pmx_func spi_grp_mt7628[] = { FUNC("spi", 0, 7, 4) };
+static struct rt2880_pmx_func refclk_grp_mt76x8[] = { FUNC("refclk", 0, 37, 1) };
+static struct rt2880_pmx_func perst_grp_mt76x8[] = { FUNC("perst", 0, 36, 1) };
+static struct rt2880_pmx_func wdt_grp_mt76x8[] = { FUNC("wdt", 0, 38, 1) };
+static struct rt2880_pmx_func spi_grp_mt76x8[] = { FUNC("spi", 0, 7, 4) };
 
-static struct rt2880_pmx_func sd_mode_grp_mt7628[] = {
+static struct rt2880_pmx_func sd_mode_grp_mt76x8[] = {
 	FUNC("jtag", 3, 22, 8),
 	FUNC("utif", 2, 22, 8),
 	FUNC("gpio", 1, 22, 8),
 	FUNC("sdxc", 0, 22, 8),
 };
 
-static struct rt2880_pmx_func uart0_grp_mt7628[] = {
+static struct rt2880_pmx_func uart0_grp_mt76x8[] = {
 	FUNC("-", 3, 12, 2),
 	FUNC("-", 2, 12, 2),
 	FUNC("gpio", 1, 12, 2),
 	FUNC("uart0", 0, 12, 2),
 };
 
-static struct rt2880_pmx_func i2s_grp_mt7628[] = {
+static struct rt2880_pmx_func i2s_grp_mt76x8[] = {
 	FUNC("antenna", 3, 0, 4),
 	FUNC("pcm", 2, 0, 4),
 	FUNC("gpio", 1, 0, 4),
 	FUNC("i2s", 0, 0, 4),
 };
 
-static struct rt2880_pmx_func spi_cs1_grp_mt7628[] = {
+static struct rt2880_pmx_func spi_cs1_grp_mt76x8[] = {
 	FUNC("-", 3, 6, 1),
 	FUNC("refclk", 2, 6, 1),
 	FUNC("gpio", 1, 6, 1),
 	FUNC("spi cs1", 0, 6, 1),
 };
 
-static struct rt2880_pmx_func spis_grp_mt7628[] = {
+static struct rt2880_pmx_func spis_grp_mt76x8[] = {
 	FUNC("pwm_uart2", 3, 14, 4),
 	FUNC("utif", 2, 14, 4),
 	FUNC("gpio", 1, 14, 4),
 	FUNC("spis", 0, 14, 4),
 };
 
-static struct rt2880_pmx_func gpio_grp_mt7628[] = {
+static struct rt2880_pmx_func gpio_grp_mt76x8[] = {
 	FUNC("pcie", 3, 11, 1),
 	FUNC("refclk", 2, 11, 1),
 	FUNC("gpio", 1, 11, 1),
 	FUNC("gpio", 0, 11, 1),
 };
 
-static struct rt2880_pmx_func p4led_kn_grp_mt7628[] = {
+static struct rt2880_pmx_func p4led_kn_grp_mt76x8[] = {
 	FUNC("jtag", 3, 30, 1),
 	FUNC("utif", 2, 30, 1),
 	FUNC("gpio", 1, 30, 1),
 	FUNC("p4led_kn", 0, 30, 1),
 };
 
-static struct rt2880_pmx_func p3led_kn_grp_mt7628[] = {
+static struct rt2880_pmx_func p3led_kn_grp_mt76x8[] = {
 	FUNC("jtag", 3, 31, 1),
 	FUNC("utif", 2, 31, 1),
 	FUNC("gpio", 1, 31, 1),
 	FUNC("p3led_kn", 0, 31, 1),
 };
 
-static struct rt2880_pmx_func p2led_kn_grp_mt7628[] = {
+static struct rt2880_pmx_func p2led_kn_grp_mt76x8[] = {
 	FUNC("jtag", 3, 32, 1),
 	FUNC("utif", 2, 32, 1),
 	FUNC("gpio", 1, 32, 1),
 	FUNC("p2led_kn", 0, 32, 1),
 };
 
-static struct rt2880_pmx_func p1led_kn_grp_mt7628[] = {
+static struct rt2880_pmx_func p1led_kn_grp_mt76x8[] = {
 	FUNC("jtag", 3, 33, 1),
 	FUNC("utif", 2, 33, 1),
 	FUNC("gpio", 1, 33, 1),
 	FUNC("p1led_kn", 0, 33, 1),
 };
 
-static struct rt2880_pmx_func p0led_kn_grp_mt7628[] = {
+static struct rt2880_pmx_func p0led_kn_grp_mt76x8[] = {
 	FUNC("jtag", 3, 34, 1),
 	FUNC("rsvd", 2, 34, 1),
 	FUNC("gpio", 1, 34, 1),
 	FUNC("p0led_kn", 0, 34, 1),
 };
 
-static struct rt2880_pmx_func wled_kn_grp_mt7628[] = {
+static struct rt2880_pmx_func wled_kn_grp_mt76x8[] = {
 	FUNC("rsvd", 3, 35, 1),
 	FUNC("rsvd", 2, 35, 1),
 	FUNC("gpio", 1, 35, 1),
 	FUNC("wled_kn", 0, 35, 1),
 };
 
-static struct rt2880_pmx_func p4led_an_grp_mt7628[] = {
+static struct rt2880_pmx_func p4led_an_grp_mt76x8[] = {
 	FUNC("jtag", 3, 39, 1),
 	FUNC("utif", 2, 39, 1),
 	FUNC("gpio", 1, 39, 1),
 	FUNC("p4led_an", 0, 39, 1),
 };
 
-static struct rt2880_pmx_func p3led_an_grp_mt7628[] = {
+static struct rt2880_pmx_func p3led_an_grp_mt76x8[] = {
 	FUNC("jtag", 3, 40, 1),
 	FUNC("utif", 2, 40, 1),
 	FUNC("gpio", 1, 40, 1),
 	FUNC("p3led_an", 0, 40, 1),
 };
 
-static struct rt2880_pmx_func p2led_an_grp_mt7628[] = {
+static struct rt2880_pmx_func p2led_an_grp_mt76x8[] = {
 	FUNC("jtag", 3, 41, 1),
 	FUNC("utif", 2, 41, 1),
 	FUNC("gpio", 1, 41, 1),
 	FUNC("p2led_an", 0, 41, 1),
 };
 
-static struct rt2880_pmx_func p1led_an_grp_mt7628[] = {
+static struct rt2880_pmx_func p1led_an_grp_mt76x8[] = {
 	FUNC("jtag", 3, 42, 1),
 	FUNC("utif", 2, 42, 1),
 	FUNC("gpio", 1, 42, 1),
 	FUNC("p1led_an", 0, 42, 1),
 };
 
-static struct rt2880_pmx_func p0led_an_grp_mt7628[] = {
+static struct rt2880_pmx_func p0led_an_grp_mt76x8[] = {
 	FUNC("jtag", 3, 43, 1),
 	FUNC("rsvd", 2, 43, 1),
 	FUNC("gpio", 1, 43, 1),
 	FUNC("p0led_an", 0, 43, 1),
 };
 
-static struct rt2880_pmx_func wled_an_grp_mt7628[] = {
+static struct rt2880_pmx_func wled_an_grp_mt76x8[] = {
 	FUNC("rsvd", 3, 44, 1),
 	FUNC("rsvd", 2, 44, 1),
 	FUNC("gpio", 1, 44, 1),
 	FUNC("wled_an", 0, 44, 1),
 };
 
-#define MT7628_GPIO_MODE_MASK		0x3
-
-#define MT7628_GPIO_MODE_P4LED_KN	58
-#define MT7628_GPIO_MODE_P3LED_KN	56
-#define MT7628_GPIO_MODE_P2LED_KN	54
-#define MT7628_GPIO_MODE_P1LED_KN	52
-#define MT7628_GPIO_MODE_P0LED_KN	50
-#define MT7628_GPIO_MODE_WLED_KN	48
-#define MT7628_GPIO_MODE_P4LED_AN	42
-#define MT7628_GPIO_MODE_P3LED_AN	40
-#define MT7628_GPIO_MODE_P2LED_AN	38
-#define MT7628_GPIO_MODE_P1LED_AN	36
-#define MT7628_GPIO_MODE_P0LED_AN	34
-#define MT7628_GPIO_MODE_WLED_AN	32
-#define MT7628_GPIO_MODE_PWM1		30
-#define MT7628_GPIO_MODE_PWM0		28
-#define MT7628_GPIO_MODE_UART2		26
-#define MT7628_GPIO_MODE_UART1		24
-#define MT7628_GPIO_MODE_I2C		20
-#define MT7628_GPIO_MODE_REFCLK		18
-#define MT7628_GPIO_MODE_PERST		16
-#define MT7628_GPIO_MODE_WDT		14
-#define MT7628_GPIO_MODE_SPI		12
-#define MT7628_GPIO_MODE_SDMODE		10
-#define MT7628_GPIO_MODE_UART0		8
-#define MT7628_GPIO_MODE_I2S		6
-#define MT7628_GPIO_MODE_CS1		4
-#define MT7628_GPIO_MODE_SPIS		2
-#define MT7628_GPIO_MODE_GPIO		0
-
-static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
-	GRP_G("pwm1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_PWM1),
-	GRP_G("pwm0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_PWM0),
-	GRP_G("uart2", uart2_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_UART2),
-	GRP_G("uart1", uart1_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_UART1),
-	GRP_G("i2c", i2c_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_I2C),
-	GRP("refclk", refclk_grp_mt7628, 1, MT7628_GPIO_MODE_REFCLK),
-	GRP("perst", perst_grp_mt7628, 1, MT7628_GPIO_MODE_PERST),
-	GRP("wdt", wdt_grp_mt7628, 1, MT7628_GPIO_MODE_WDT),
-	GRP("spi", spi_grp_mt7628, 1, MT7628_GPIO_MODE_SPI),
-	GRP_G("sdmode", sd_mode_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_SDMODE),
-	GRP_G("uart0", uart0_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_UART0),
-	GRP_G("i2s", i2s_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_I2S),
-	GRP_G("spi cs1", spi_cs1_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_CS1),
-	GRP_G("spis", spis_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_SPIS),
-	GRP_G("gpio", gpio_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_GPIO),
-	GRP_G("wled_an", wled_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_WLED_AN),
-	GRP_G("p0led_an", p0led_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_P0LED_AN),
-	GRP_G("p1led_an", p1led_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_P1LED_AN),
-	GRP_G("p2led_an", p2led_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_P2LED_AN),
-	GRP_G("p3led_an", p3led_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_P3LED_AN),
-	GRP_G("p4led_an", p4led_an_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_P4LED_AN),
-	GRP_G("wled_kn", wled_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_WLED_KN),
-	GRP_G("p0led_kn", p0led_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_P0LED_KN),
-	GRP_G("p1led_kn", p1led_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_P1LED_KN),
-	GRP_G("p2led_kn", p2led_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_P2LED_KN),
-	GRP_G("p3led_kn", p3led_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_P3LED_KN),
-	GRP_G("p4led_kn", p4led_kn_grp_mt7628, MT7628_GPIO_MODE_MASK,
-				1, MT7628_GPIO_MODE_P4LED_KN),
+#define MT76X8_GPIO_MODE_MASK		0x3
+
+#define MT76X8_GPIO_MODE_P4LED_KN	58
+#define MT76X8_GPIO_MODE_P3LED_KN	56
+#define MT76X8_GPIO_MODE_P2LED_KN	54
+#define MT76X8_GPIO_MODE_P1LED_KN	52
+#define MT76X8_GPIO_MODE_P0LED_KN	50
+#define MT76X8_GPIO_MODE_WLED_KN	48
+#define MT76X8_GPIO_MODE_P4LED_AN	42
+#define MT76X8_GPIO_MODE_P3LED_AN	40
+#define MT76X8_GPIO_MODE_P2LED_AN	38
+#define MT76X8_GPIO_MODE_P1LED_AN	36
+#define MT76X8_GPIO_MODE_P0LED_AN	34
+#define MT76X8_GPIO_MODE_WLED_AN	32
+#define MT76X8_GPIO_MODE_PWM1		30
+#define MT76X8_GPIO_MODE_PWM0		28
+#define MT76X8_GPIO_MODE_UART2		26
+#define MT76X8_GPIO_MODE_UART1		24
+#define MT76X8_GPIO_MODE_I2C		20
+#define MT76X8_GPIO_MODE_REFCLK		18
+#define MT76X8_GPIO_MODE_PERST		16
+#define MT76X8_GPIO_MODE_WDT		14
+#define MT76X8_GPIO_MODE_SPI		12
+#define MT76X8_GPIO_MODE_SDMODE		10
+#define MT76X8_GPIO_MODE_UART0		8
+#define MT76X8_GPIO_MODE_I2S		6
+#define MT76X8_GPIO_MODE_CS1		4
+#define MT76X8_GPIO_MODE_SPIS		2
+#define MT76X8_GPIO_MODE_GPIO		0
+
+static struct rt2880_pmx_group mt76x8_pinmux_data[] = {
+	GRP_G("pwm1", pwm1_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_PWM1),
+	GRP_G("pwm0", pwm0_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_PWM0),
+	GRP_G("uart2", uart2_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_UART2),
+	GRP_G("uart1", uart1_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_UART1),
+	GRP_G("i2c", i2c_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_I2C),
+	GRP("refclk", refclk_grp_mt76x8, 1, MT76X8_GPIO_MODE_REFCLK),
+	GRP("perst", perst_grp_mt76x8, 1, MT76X8_GPIO_MODE_PERST),
+	GRP("wdt", wdt_grp_mt76x8, 1, MT76X8_GPIO_MODE_WDT),
+	GRP("spi", spi_grp_mt76x8, 1, MT76X8_GPIO_MODE_SPI),
+	GRP_G("sdmode", sd_mode_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_SDMODE),
+	GRP_G("uart0", uart0_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_UART0),
+	GRP_G("i2s", i2s_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_I2S),
+	GRP_G("spi cs1", spi_cs1_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_CS1),
+	GRP_G("spis", spis_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_SPIS),
+	GRP_G("gpio", gpio_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_GPIO),
+	GRP_G("wled_an", wled_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_WLED_AN),
+	GRP_G("p0led_an", p0led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P0LED_AN),
+	GRP_G("p1led_an", p1led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P1LED_AN),
+	GRP_G("p2led_an", p2led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P2LED_AN),
+	GRP_G("p3led_an", p3led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P3LED_AN),
+	GRP_G("p4led_an", p4led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P4LED_AN),
+	GRP_G("wled_kn", wled_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_WLED_KN),
+	GRP_G("p0led_kn", p0led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P0LED_KN),
+	GRP_G("p1led_kn", p1led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P1LED_KN),
+	GRP_G("p2led_kn", p2led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P2LED_KN),
+	GRP_G("p3led_kn", p3led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P3LED_KN),
+	GRP_G("p4led_kn", p4led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+				1, MT76X8_GPIO_MODE_P4LED_KN),
 	{ 0 }
 };
 
 static int mt7620_pinmux_probe(struct platform_device *pdev)
 {
 	if (is_mt76x8())
-		return rt2880_pinmux_init(pdev, mt7628an_pinmux_data);
+		return rt2880_pinmux_init(pdev, mt76x8_pinmux_data);
 	else
 		return rt2880_pinmux_init(pdev, mt7620a_pinmux_data);
 }
-- 
2.25.1

