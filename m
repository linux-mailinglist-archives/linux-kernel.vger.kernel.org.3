Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CEF501A40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbiDNRnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343638AbiDNRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:42:47 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566BAD4C98;
        Thu, 14 Apr 2022 10:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649958001; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fow4K4nFieAcLysgAMq2CbHwVRdeVvC6YM4/2UMGpFuMYRWI5xOGrUv2EhQuP6o0EX4Uyk9KImJe993Mca0Ol2pc1y/yVdp69mqhoHTnTzdPAM/OfjLqSa/Bf3oMwz2I0z9EuiGy17FuF60SKvjvIdQqNqZ3SVE68xGV5adcchI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649958001; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=yeFRrDWWexujKMer0dgqXI9XuDnePR0CEQKx8LKK0zU=; 
        b=LElQ+lhCajIyyCePEWKOGsotpaxqLiwyFopdSjXactQXXSeFGHdhlBwyzDbRqifUn6S0U+7+ULpk4fz8/8wQ1qAZT7DT5K/0PEGNA+s7Ol56mTlcD5USU9kf48idr3BVwmtNSypbSAhXbOm+/oYx1qMzXJP9PeyTWDcjWbF6iV8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649958001;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=yeFRrDWWexujKMer0dgqXI9XuDnePR0CEQKx8LKK0zU=;
        b=JXAYeJ8MCsGfZIZcbzFIJURuMZzjH6L3w8Vm5hT6QnjZYINs+qUoTl+I37E8zkRU
        uXK596tUlTmwAHLDlJdE33u8fxg7psZshkJ5UICZBl3W1rdD9zpbFjcQrldxaFXxFi8
        bm10S9iWV8Yv1yoXxId/PoKa3SMIeT3/West1jrc=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649957999902450.1836611287223; Thu, 14 Apr 2022 10:39:59 -0700 (PDT)
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
Subject: [PATCH v2 05/14] pinctrl: ralink: rename variable names for functions on MT7620 and MT7621
Date:   Thu, 14 Apr 2022 20:39:07 +0300
Message-Id: <20220414173916.5552-6-arinc.unal@arinc9.com>
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

Variables for functions include "grp" on the Ralink MT7620 and MT7621
subdrivers. Rename them to "func" instead as they define the functions for
the pin groups.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pinctrl/ralink/pinctrl-mt7620.c | 164 ++++++++++++------------
 drivers/pinctrl/ralink/pinctrl-mt7621.c |  48 +++----
 2 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/drivers/pinctrl/ralink/pinctrl-mt7620.c b/drivers/pinctrl/ralink/pinctrl-mt7620.c
index a790f3944314..fde269c68a7b 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7620.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7620.c
@@ -54,20 +54,20 @@
 #define MT7620_GPIO_MODE_EPHY		15
 #define MT7620_GPIO_MODE_PA		20
 
-static struct ralink_pmx_func i2c_grp[] =  { FUNC("i2c", 0, 1, 2) };
-static struct ralink_pmx_func spi_grp[] = { FUNC("spi", 0, 3, 4) };
-static struct ralink_pmx_func uartlite_grp[] = { FUNC("uartlite", 0, 15, 2) };
-static struct ralink_pmx_func mdio_grp[] = {
+static struct ralink_pmx_func i2c_func[] =  { FUNC("i2c", 0, 1, 2) };
+static struct ralink_pmx_func spi_func[] = { FUNC("spi", 0, 3, 4) };
+static struct ralink_pmx_func uartlite_func[] = { FUNC("uartlite", 0, 15, 2) };
+static struct ralink_pmx_func mdio_func[] = {
 	FUNC("mdio", MT7620_GPIO_MODE_MDIO, 22, 2),
 	FUNC("refclk", MT7620_GPIO_MODE_MDIO_REFCLK, 22, 2),
 };
-static struct ralink_pmx_func rgmii1_grp[] = { FUNC("rgmii1", 0, 24, 12) };
-static struct ralink_pmx_func refclk_grp[] = { FUNC("spi refclk", 0, 37, 3) };
-static struct ralink_pmx_func ephy_grp[] = { FUNC("ephy", 0, 40, 5) };
-static struct ralink_pmx_func rgmii2_grp[] = { FUNC("rgmii2", 0, 60, 12) };
-static struct ralink_pmx_func wled_grp[] = { FUNC("wled", 0, 72, 1) };
-static struct ralink_pmx_func pa_grp[] = { FUNC("pa", 0, 18, 4) };
-static struct ralink_pmx_func uartf_grp[] = {
+static struct ralink_pmx_func rgmii1_func[] = { FUNC("rgmii1", 0, 24, 12) };
+static struct ralink_pmx_func refclk_func[] = { FUNC("spi refclk", 0, 37, 3) };
+static struct ralink_pmx_func ephy_func[] = { FUNC("ephy", 0, 40, 5) };
+static struct ralink_pmx_func rgmii2_func[] = { FUNC("rgmii2", 0, 60, 12) };
+static struct ralink_pmx_func wled_func[] = { FUNC("wled", 0, 72, 1) };
+static struct ralink_pmx_func pa_func[] = { FUNC("pa", 0, 18, 4) };
+static struct ralink_pmx_func uartf_func[] = {
 	FUNC("uartf", MT7620_GPIO_MODE_UARTF, 7, 8),
 	FUNC("pcm uartf", MT7620_GPIO_MODE_PCM_UARTF, 7, 8),
 	FUNC("pcm i2s", MT7620_GPIO_MODE_PCM_I2S, 7, 8),
@@ -76,202 +76,202 @@ static struct ralink_pmx_func uartf_grp[] = {
 	FUNC("gpio uartf", MT7620_GPIO_MODE_GPIO_UARTF, 7, 4),
 	FUNC("gpio i2s", MT7620_GPIO_MODE_GPIO_I2S, 7, 4),
 };
-static struct ralink_pmx_func wdt_grp[] = {
+static struct ralink_pmx_func wdt_func[] = {
 	FUNC("wdt rst", 0, 17, 1),
 	FUNC("wdt refclk", 0, 17, 1),
 	};
-static struct ralink_pmx_func pcie_rst_grp[] = {
+static struct ralink_pmx_func pcie_rst_func[] = {
 	FUNC("pcie rst", MT7620_GPIO_MODE_PCIE_RST, 36, 1),
 	FUNC("pcie refclk", MT7620_GPIO_MODE_PCIE_REF, 36, 1)
 };
-static struct ralink_pmx_func nd_sd_grp[] = {
+static struct ralink_pmx_func nd_sd_func[] = {
 	FUNC("nand", MT7620_GPIO_MODE_NAND, 45, 15),
 	FUNC("sd", MT7620_GPIO_MODE_SD, 47, 13)
 };
 
 static struct ralink_pmx_group mt7620a_pinmux_data[] = {
-	GRP("i2c", i2c_grp, 1, MT7620_GPIO_MODE_I2C),
-	GRP("uartf", uartf_grp, MT7620_GPIO_MODE_UART0_MASK,
+	GRP("i2c", i2c_func, 1, MT7620_GPIO_MODE_I2C),
+	GRP("uartf", uartf_func, MT7620_GPIO_MODE_UART0_MASK,
 		MT7620_GPIO_MODE_UART0_SHIFT),
-	GRP("spi", spi_grp, 1, MT7620_GPIO_MODE_SPI),
-	GRP("uartlite", uartlite_grp, 1, MT7620_GPIO_MODE_UART1),
-	GRP_G("wdt", wdt_grp, MT7620_GPIO_MODE_WDT_MASK,
+	GRP("spi", spi_func, 1, MT7620_GPIO_MODE_SPI),
+	GRP("uartlite", uartlite_func, 1, MT7620_GPIO_MODE_UART1),
+	GRP_G("wdt", wdt_func, MT7620_GPIO_MODE_WDT_MASK,
 		MT7620_GPIO_MODE_WDT_GPIO, MT7620_GPIO_MODE_WDT_SHIFT),
-	GRP_G("mdio", mdio_grp, MT7620_GPIO_MODE_MDIO_MASK,
+	GRP_G("mdio", mdio_func, MT7620_GPIO_MODE_MDIO_MASK,
 		MT7620_GPIO_MODE_MDIO_GPIO, MT7620_GPIO_MODE_MDIO_SHIFT),
-	GRP("rgmii1", rgmii1_grp, 1, MT7620_GPIO_MODE_RGMII1),
-	GRP("spi refclk", refclk_grp, 1, MT7620_GPIO_MODE_SPI_REF_CLK),
-	GRP_G("pcie", pcie_rst_grp, MT7620_GPIO_MODE_PCIE_MASK,
+	GRP("rgmii1", rgmii1_func, 1, MT7620_GPIO_MODE_RGMII1),
+	GRP("spi refclk", refclk_func, 1, MT7620_GPIO_MODE_SPI_REF_CLK),
+	GRP_G("pcie", pcie_rst_func, MT7620_GPIO_MODE_PCIE_MASK,
 		MT7620_GPIO_MODE_PCIE_GPIO, MT7620_GPIO_MODE_PCIE_SHIFT),
-	GRP_G("nd_sd", nd_sd_grp, MT7620_GPIO_MODE_ND_SD_MASK,
+	GRP_G("nd_sd", nd_sd_func, MT7620_GPIO_MODE_ND_SD_MASK,
 		MT7620_GPIO_MODE_ND_SD_GPIO, MT7620_GPIO_MODE_ND_SD_SHIFT),
-	GRP("rgmii2", rgmii2_grp, 1, MT7620_GPIO_MODE_RGMII2),
-	GRP("wled", wled_grp, 1, MT7620_GPIO_MODE_WLED),
-	GRP("ephy", ephy_grp, 1, MT7620_GPIO_MODE_EPHY),
-	GRP("pa", pa_grp, 1, MT7620_GPIO_MODE_PA),
+	GRP("rgmii2", rgmii2_func, 1, MT7620_GPIO_MODE_RGMII2),
+	GRP("wled", wled_func, 1, MT7620_GPIO_MODE_WLED),
+	GRP("ephy", ephy_func, 1, MT7620_GPIO_MODE_EPHY),
+	GRP("pa", pa_func, 1, MT7620_GPIO_MODE_PA),
 	{ 0 }
 };
 
-static struct ralink_pmx_func pwm1_grp_mt76x8[] = {
+static struct ralink_pmx_func pwm1_func_mt76x8[] = {
 	FUNC("sdxc d6", 3, 19, 1),
 	FUNC("utif", 2, 19, 1),
 	FUNC("gpio", 1, 19, 1),
 	FUNC("pwm1", 0, 19, 1),
 };
 
-static struct ralink_pmx_func pwm0_grp_mt76x8[] = {
+static struct ralink_pmx_func pwm0_func_mt76x8[] = {
 	FUNC("sdxc d7", 3, 18, 1),
 	FUNC("utif", 2, 18, 1),
 	FUNC("gpio", 1, 18, 1),
 	FUNC("pwm0", 0, 18, 1),
 };
 
-static struct ralink_pmx_func uart2_grp_mt76x8[] = {
+static struct ralink_pmx_func uart2_func_mt76x8[] = {
 	FUNC("sdxc d5 d4", 3, 20, 2),
 	FUNC("pwm", 2, 20, 2),
 	FUNC("gpio", 1, 20, 2),
 	FUNC("uart2", 0, 20, 2),
 };
 
-static struct ralink_pmx_func uart1_grp_mt76x8[] = {
+static struct ralink_pmx_func uart1_func_mt76x8[] = {
 	FUNC("sw_r", 3, 45, 2),
 	FUNC("pwm", 2, 45, 2),
 	FUNC("gpio", 1, 45, 2),
 	FUNC("uart1", 0, 45, 2),
 };
 
-static struct ralink_pmx_func i2c_grp_mt76x8[] = {
+static struct ralink_pmx_func i2c_func_mt76x8[] = {
 	FUNC("-", 3, 4, 2),
 	FUNC("debug", 2, 4, 2),
 	FUNC("gpio", 1, 4, 2),
 	FUNC("i2c", 0, 4, 2),
 };
 
-static struct ralink_pmx_func refclk_grp_mt76x8[] = { FUNC("refclk", 0, 37, 1) };
-static struct ralink_pmx_func perst_grp_mt76x8[] = { FUNC("perst", 0, 36, 1) };
-static struct ralink_pmx_func wdt_grp_mt76x8[] = { FUNC("wdt", 0, 38, 1) };
-static struct ralink_pmx_func spi_grp_mt76x8[] = { FUNC("spi", 0, 7, 4) };
+static struct ralink_pmx_func refclk_func_mt76x8[] = { FUNC("refclk", 0, 37, 1) };
+static struct ralink_pmx_func perst_func_mt76x8[] = { FUNC("perst", 0, 36, 1) };
+static struct ralink_pmx_func wdt_func_mt76x8[] = { FUNC("wdt", 0, 38, 1) };
+static struct ralink_pmx_func spi_func_mt76x8[] = { FUNC("spi", 0, 7, 4) };
 
-static struct ralink_pmx_func sd_mode_grp_mt76x8[] = {
+static struct ralink_pmx_func sd_mode_func_mt76x8[] = {
 	FUNC("jtag", 3, 22, 8),
 	FUNC("utif", 2, 22, 8),
 	FUNC("gpio", 1, 22, 8),
 	FUNC("sdxc", 0, 22, 8),
 };
 
-static struct ralink_pmx_func uart0_grp_mt76x8[] = {
+static struct ralink_pmx_func uart0_func_mt76x8[] = {
 	FUNC("-", 3, 12, 2),
 	FUNC("-", 2, 12, 2),
 	FUNC("gpio", 1, 12, 2),
 	FUNC("uart0", 0, 12, 2),
 };
 
-static struct ralink_pmx_func i2s_grp_mt76x8[] = {
+static struct ralink_pmx_func i2s_func_mt76x8[] = {
 	FUNC("antenna", 3, 0, 4),
 	FUNC("pcm", 2, 0, 4),
 	FUNC("gpio", 1, 0, 4),
 	FUNC("i2s", 0, 0, 4),
 };
 
-static struct ralink_pmx_func spi_cs1_grp_mt76x8[] = {
+static struct ralink_pmx_func spi_cs1_func_mt76x8[] = {
 	FUNC("-", 3, 6, 1),
 	FUNC("refclk", 2, 6, 1),
 	FUNC("gpio", 1, 6, 1),
 	FUNC("spi cs1", 0, 6, 1),
 };
 
-static struct ralink_pmx_func spis_grp_mt76x8[] = {
+static struct ralink_pmx_func spis_func_mt76x8[] = {
 	FUNC("pwm_uart2", 3, 14, 4),
 	FUNC("utif", 2, 14, 4),
 	FUNC("gpio", 1, 14, 4),
 	FUNC("spis", 0, 14, 4),
 };
 
-static struct ralink_pmx_func gpio_grp_mt76x8[] = {
+static struct ralink_pmx_func gpio_func_mt76x8[] = {
 	FUNC("pcie", 3, 11, 1),
 	FUNC("refclk", 2, 11, 1),
 	FUNC("gpio", 1, 11, 1),
 	FUNC("gpio", 0, 11, 1),
 };
 
-static struct ralink_pmx_func p4led_kn_grp_mt76x8[] = {
+static struct ralink_pmx_func p4led_kn_func_mt76x8[] = {
 	FUNC("jtag", 3, 30, 1),
 	FUNC("utif", 2, 30, 1),
 	FUNC("gpio", 1, 30, 1),
 	FUNC("p4led_kn", 0, 30, 1),
 };
 
-static struct ralink_pmx_func p3led_kn_grp_mt76x8[] = {
+static struct ralink_pmx_func p3led_kn_func_mt76x8[] = {
 	FUNC("jtag", 3, 31, 1),
 	FUNC("utif", 2, 31, 1),
 	FUNC("gpio", 1, 31, 1),
 	FUNC("p3led_kn", 0, 31, 1),
 };
 
-static struct ralink_pmx_func p2led_kn_grp_mt76x8[] = {
+static struct ralink_pmx_func p2led_kn_func_mt76x8[] = {
 	FUNC("jtag", 3, 32, 1),
 	FUNC("utif", 2, 32, 1),
 	FUNC("gpio", 1, 32, 1),
 	FUNC("p2led_kn", 0, 32, 1),
 };
 
-static struct ralink_pmx_func p1led_kn_grp_mt76x8[] = {
+static struct ralink_pmx_func p1led_kn_func_mt76x8[] = {
 	FUNC("jtag", 3, 33, 1),
 	FUNC("utif", 2, 33, 1),
 	FUNC("gpio", 1, 33, 1),
 	FUNC("p1led_kn", 0, 33, 1),
 };
 
-static struct ralink_pmx_func p0led_kn_grp_mt76x8[] = {
+static struct ralink_pmx_func p0led_kn_func_mt76x8[] = {
 	FUNC("jtag", 3, 34, 1),
 	FUNC("rsvd", 2, 34, 1),
 	FUNC("gpio", 1, 34, 1),
 	FUNC("p0led_kn", 0, 34, 1),
 };
 
-static struct ralink_pmx_func wled_kn_grp_mt76x8[] = {
+static struct ralink_pmx_func wled_kn_func_mt76x8[] = {
 	FUNC("rsvd", 3, 35, 1),
 	FUNC("rsvd", 2, 35, 1),
 	FUNC("gpio", 1, 35, 1),
 	FUNC("wled_kn", 0, 35, 1),
 };
 
-static struct ralink_pmx_func p4led_an_grp_mt76x8[] = {
+static struct ralink_pmx_func p4led_an_func_mt76x8[] = {
 	FUNC("jtag", 3, 39, 1),
 	FUNC("utif", 2, 39, 1),
 	FUNC("gpio", 1, 39, 1),
 	FUNC("p4led_an", 0, 39, 1),
 };
 
-static struct ralink_pmx_func p3led_an_grp_mt76x8[] = {
+static struct ralink_pmx_func p3led_an_func_mt76x8[] = {
 	FUNC("jtag", 3, 40, 1),
 	FUNC("utif", 2, 40, 1),
 	FUNC("gpio", 1, 40, 1),
 	FUNC("p3led_an", 0, 40, 1),
 };
 
-static struct ralink_pmx_func p2led_an_grp_mt76x8[] = {
+static struct ralink_pmx_func p2led_an_func_mt76x8[] = {
 	FUNC("jtag", 3, 41, 1),
 	FUNC("utif", 2, 41, 1),
 	FUNC("gpio", 1, 41, 1),
 	FUNC("p2led_an", 0, 41, 1),
 };
 
-static struct ralink_pmx_func p1led_an_grp_mt76x8[] = {
+static struct ralink_pmx_func p1led_an_func_mt76x8[] = {
 	FUNC("jtag", 3, 42, 1),
 	FUNC("utif", 2, 42, 1),
 	FUNC("gpio", 1, 42, 1),
 	FUNC("p1led_an", 0, 42, 1),
 };
 
-static struct ralink_pmx_func p0led_an_grp_mt76x8[] = {
+static struct ralink_pmx_func p0led_an_func_mt76x8[] = {
 	FUNC("jtag", 3, 43, 1),
 	FUNC("rsvd", 2, 43, 1),
 	FUNC("gpio", 1, 43, 1),
 	FUNC("p0led_an", 0, 43, 1),
 };
 
-static struct ralink_pmx_func wled_an_grp_mt76x8[] = {
+static struct ralink_pmx_func wled_an_func_mt76x8[] = {
 	FUNC("rsvd", 3, 44, 1),
 	FUNC("rsvd", 2, 44, 1),
 	FUNC("gpio", 1, 44, 1),
@@ -309,55 +309,55 @@ static struct ralink_pmx_func wled_an_grp_mt76x8[] = {
 #define MT76X8_GPIO_MODE_GPIO		0
 
 static struct ralink_pmx_group mt76x8_pinmux_data[] = {
-	GRP_G("pwm1", pwm1_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("pwm1", pwm1_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_PWM1),
-	GRP_G("pwm0", pwm0_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("pwm0", pwm0_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_PWM0),
-	GRP_G("uart2", uart2_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("uart2", uart2_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_UART2),
-	GRP_G("uart1", uart1_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("uart1", uart1_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_UART1),
-	GRP_G("i2c", i2c_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("i2c", i2c_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_I2C),
-	GRP("refclk", refclk_grp_mt76x8, 1, MT76X8_GPIO_MODE_REFCLK),
-	GRP("perst", perst_grp_mt76x8, 1, MT76X8_GPIO_MODE_PERST),
-	GRP("wdt", wdt_grp_mt76x8, 1, MT76X8_GPIO_MODE_WDT),
-	GRP("spi", spi_grp_mt76x8, 1, MT76X8_GPIO_MODE_SPI),
-	GRP_G("sdmode", sd_mode_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP("refclk", refclk_func_mt76x8, 1, MT76X8_GPIO_MODE_REFCLK),
+	GRP("perst", perst_func_mt76x8, 1, MT76X8_GPIO_MODE_PERST),
+	GRP("wdt", wdt_func_mt76x8, 1, MT76X8_GPIO_MODE_WDT),
+	GRP("spi", spi_func_mt76x8, 1, MT76X8_GPIO_MODE_SPI),
+	GRP_G("sdmode", sd_mode_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_SDMODE),
-	GRP_G("uart0", uart0_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("uart0", uart0_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_UART0),
-	GRP_G("i2s", i2s_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("i2s", i2s_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_I2S),
-	GRP_G("spi cs1", spi_cs1_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("spi cs1", spi_cs1_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_CS1),
-	GRP_G("spis", spis_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("spis", spis_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_SPIS),
-	GRP_G("gpio", gpio_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("gpio", gpio_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_GPIO),
-	GRP_G("wled_an", wled_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("wled_an", wled_an_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_WLED_AN),
-	GRP_G("p0led_an", p0led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("p0led_an", p0led_an_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_P0LED_AN),
-	GRP_G("p1led_an", p1led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("p1led_an", p1led_an_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_P1LED_AN),
-	GRP_G("p2led_an", p2led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("p2led_an", p2led_an_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_P2LED_AN),
-	GRP_G("p3led_an", p3led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("p3led_an", p3led_an_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_P3LED_AN),
-	GRP_G("p4led_an", p4led_an_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("p4led_an", p4led_an_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_P4LED_AN),
-	GRP_G("wled_kn", wled_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("wled_kn", wled_kn_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_WLED_KN),
-	GRP_G("p0led_kn", p0led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("p0led_kn", p0led_kn_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_P0LED_KN),
-	GRP_G("p1led_kn", p1led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("p1led_kn", p1led_kn_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_P1LED_KN),
-	GRP_G("p2led_kn", p2led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("p2led_kn", p2led_kn_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_P2LED_KN),
-	GRP_G("p3led_kn", p3led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("p3led_kn", p3led_kn_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_P3LED_KN),
-	GRP_G("p4led_kn", p4led_kn_grp_mt76x8, MT76X8_GPIO_MODE_MASK,
+	GRP_G("p4led_kn", p4led_kn_func_mt76x8, MT76X8_GPIO_MODE_MASK,
 				1, MT76X8_GPIO_MODE_P4LED_KN),
 	{ 0 }
 };
diff --git a/drivers/pinctrl/ralink/pinctrl-mt7621.c b/drivers/pinctrl/ralink/pinctrl-mt7621.c
index bad4f1a8cf3f..1470250ca3b7 100644
--- a/drivers/pinctrl/ralink/pinctrl-mt7621.c
+++ b/drivers/pinctrl/ralink/pinctrl-mt7621.c
@@ -34,59 +34,59 @@
 #define MT7621_GPIO_MODE_SDHCI_SHIFT	18
 #define MT7621_GPIO_MODE_SDHCI_GPIO	1
 
-static struct ralink_pmx_func uart1_grp[] =  { FUNC("uart1", 0, 1, 2) };
-static struct ralink_pmx_func i2c_grp[] =  { FUNC("i2c", 0, 3, 2) };
-static struct ralink_pmx_func uart3_grp[] = {
+static struct ralink_pmx_func uart1_func[] =  { FUNC("uart1", 0, 1, 2) };
+static struct ralink_pmx_func i2c_func[] =  { FUNC("i2c", 0, 3, 2) };
+static struct ralink_pmx_func uart3_func[] = {
 	FUNC("uart3", 0, 5, 4),
 	FUNC("i2s", 2, 5, 4),
 	FUNC("spdif3", 3, 5, 4),
 };
-static struct ralink_pmx_func uart2_grp[] = {
+static struct ralink_pmx_func uart2_func[] = {
 	FUNC("uart2", 0, 9, 4),
 	FUNC("pcm", 2, 9, 4),
 	FUNC("spdif2", 3, 9, 4),
 };
-static struct ralink_pmx_func jtag_grp[] = { FUNC("jtag", 0, 13, 5) };
-static struct ralink_pmx_func wdt_grp[] = {
+static struct ralink_pmx_func jtag_func[] = { FUNC("jtag", 0, 13, 5) };
+static struct ralink_pmx_func wdt_func[] = {
 	FUNC("wdt rst", 0, 18, 1),
 	FUNC("wdt refclk", 2, 18, 1),
 };
-static struct ralink_pmx_func pcie_rst_grp[] = {
+static struct ralink_pmx_func pcie_rst_func[] = {
 	FUNC("pcie rst", MT7621_GPIO_MODE_PCIE_RST, 19, 1),
 	FUNC("pcie refclk", MT7621_GPIO_MODE_PCIE_REF, 19, 1)
 };
-static struct ralink_pmx_func mdio_grp[] = { FUNC("mdio", 0, 20, 2) };
-static struct ralink_pmx_func rgmii2_grp[] = { FUNC("rgmii2", 0, 22, 12) };
-static struct ralink_pmx_func spi_grp[] = {
+static struct ralink_pmx_func mdio_func[] = { FUNC("mdio", 0, 20, 2) };
+static struct ralink_pmx_func rgmii2_func[] = { FUNC("rgmii2", 0, 22, 12) };
+static struct ralink_pmx_func spi_func[] = {
 	FUNC("spi", 0, 34, 7),
 	FUNC("nand1", 2, 34, 7),
 };
-static struct ralink_pmx_func sdhci_grp[] = {
+static struct ralink_pmx_func sdhci_func[] = {
 	FUNC("sdhci", 0, 41, 8),
 	FUNC("nand2", 2, 41, 8),
 };
-static struct ralink_pmx_func rgmii1_grp[] = { FUNC("rgmii1", 0, 49, 12) };
+static struct ralink_pmx_func rgmii1_func[] = { FUNC("rgmii1", 0, 49, 12) };
 
 static struct ralink_pmx_group mt7621_pinmux_data[] = {
-	GRP("uart1", uart1_grp, 1, MT7621_GPIO_MODE_UART1),
-	GRP("i2c", i2c_grp, 1, MT7621_GPIO_MODE_I2C),
-	GRP_G("uart3", uart3_grp, MT7621_GPIO_MODE_UART3_MASK,
+	GRP("uart1", uart1_func, 1, MT7621_GPIO_MODE_UART1),
+	GRP("i2c", i2c_func, 1, MT7621_GPIO_MODE_I2C),
+	GRP_G("uart3", uart3_func, MT7621_GPIO_MODE_UART3_MASK,
 		MT7621_GPIO_MODE_UART3_GPIO, MT7621_GPIO_MODE_UART3_SHIFT),
-	GRP_G("uart2", uart2_grp, MT7621_GPIO_MODE_UART2_MASK,
+	GRP_G("uart2", uart2_func, MT7621_GPIO_MODE_UART2_MASK,
 		MT7621_GPIO_MODE_UART2_GPIO, MT7621_GPIO_MODE_UART2_SHIFT),
-	GRP("jtag", jtag_grp, 1, MT7621_GPIO_MODE_JTAG),
-	GRP_G("wdt", wdt_grp, MT7621_GPIO_MODE_WDT_MASK,
+	GRP("jtag", jtag_func, 1, MT7621_GPIO_MODE_JTAG),
+	GRP_G("wdt", wdt_func, MT7621_GPIO_MODE_WDT_MASK,
 		MT7621_GPIO_MODE_WDT_GPIO, MT7621_GPIO_MODE_WDT_SHIFT),
-	GRP_G("pcie", pcie_rst_grp, MT7621_GPIO_MODE_PCIE_MASK,
+	GRP_G("pcie", pcie_rst_func, MT7621_GPIO_MODE_PCIE_MASK,
 		MT7621_GPIO_MODE_PCIE_GPIO, MT7621_GPIO_MODE_PCIE_SHIFT),
-	GRP_G("mdio", mdio_grp, MT7621_GPIO_MODE_MDIO_MASK,
+	GRP_G("mdio", mdio_func, MT7621_GPIO_MODE_MDIO_MASK,
 		MT7621_GPIO_MODE_MDIO_GPIO, MT7621_GPIO_MODE_MDIO_SHIFT),
-	GRP("rgmii2", rgmii2_grp, 1, MT7621_GPIO_MODE_RGMII2),
-	GRP_G("spi", spi_grp, MT7621_GPIO_MODE_SPI_MASK,
+	GRP("rgmii2", rgmii2_func, 1, MT7621_GPIO_MODE_RGMII2),
+	GRP_G("spi", spi_func, MT7621_GPIO_MODE_SPI_MASK,
 		MT7621_GPIO_MODE_SPI_GPIO, MT7621_GPIO_MODE_SPI_SHIFT),
-	GRP_G("sdhci", sdhci_grp, MT7621_GPIO_MODE_SDHCI_MASK,
+	GRP_G("sdhci", sdhci_func, MT7621_GPIO_MODE_SDHCI_MASK,
 		MT7621_GPIO_MODE_SDHCI_GPIO, MT7621_GPIO_MODE_SDHCI_SHIFT),
-	GRP("rgmii1", rgmii1_grp, 1, MT7621_GPIO_MODE_RGMII1),
+	GRP("rgmii1", rgmii1_func, 1, MT7621_GPIO_MODE_RGMII1),
 	{ 0 }
 };
 
-- 
2.25.1

