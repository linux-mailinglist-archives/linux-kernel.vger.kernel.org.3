Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DAA5B0043
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiIGJVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIGJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:21:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C29BAA3CB;
        Wed,  7 Sep 2022 02:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662542482; x=1694078482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SRf39MiEqJa3areQ7kyn/5mObXp0ZhdiIBrwyioA++I=;
  b=nCvCSpg5YbrQbGPyldwoCD1GPcoJWnRevYcKgsre/XuFaiuEc0paWHNs
   P7t0SRMAvEDzCMxDYn8R5IkGNGwXLckcoDAzTNQJzS6xMSi0AHgQpvzng
   kthtTvITjBndSnhjZC3wFXjYFOPk4cpGlsM9PSX+0lN9mtjHhUirn9ZRk
   3UCwPvYXQGkMGjKm0exl5yTO/9lEZyV5qQoRAOjiMviTZjVVdFS/HfWCA
   9LdJjlLvy40B6qB4Z9laQ/ssoQr6lOv6aWHA9QXnTTGAmwdEzGyVe3+wU
   jPhZYzqnD+45FpXV8QUJCg9/Tl0IG7D3QG5ig5RBHtVfuyYjz8HOpze+j
   w==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="179494581"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 02:21:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 02:21:11 -0700
Received: from che-lt-i63539lx.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 02:21:05 -0700
From:   Hari Prasath <Hari.PrasathGE@microchip.com>
To:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <manikandan.m@microchip.com>, <michael@walle.cc>,
        <horatiu.vultur@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <durai.manickamkr@microchip.com>
CC:     <Hari.PrasathGE@microchip.com>
Subject: [linux][PATCH 1/6] ARM: dts: at91: sam9x60: Fix the label numbering for the flexcom functions
Date:   Wed, 7 Sep 2022 14:50:49 +0530
Message-ID: <20220907092054.29915-2-Hari.PrasathGE@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220907092054.29915-1-Hari.PrasathGE@microchip.com>
References: <20220907092054.29915-1-Hari.PrasathGE@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manikandan M <manikandan.m@microchip.com>

Fixed the label numbering of the flexcom functions so that all
13 flexcom functions of sam9x60 are in the following order when the missing
flexcom functions are added:

flx0: uart0, spi0, i2c0
flx1: uart1, spi1, i2c1
flx2: uart2, spi2, i2c2
flx3: uart3, spi3, i2c3
flx4: uart4, spi4, i2c4
flx5: uart5, spi5, i2c5
flx6: uart6, i2c6
flx7: uart7, i2c7
flx8: uart8, i2c8
flx9: uart9, i2c9
flx10: uart10, i2c10
flx11: uart11, i2c11
flx12: uart12, i2c12

Signed-off-by: Manikandan M <manikandan.m@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 7ade9979e1c6..b9b7a235ef89 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -16,8 +16,8 @@
 
 	aliases {
 		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		serial1 = &uart1;
+		i2c1 = &i2c6;
+		serial1 = &uart5;
 	};
 
 	chosen {
@@ -238,7 +238,7 @@
 	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_SPI>;
 	status = "disabled";
 
-	spi0: spi@400 {
+	spi4: spi@400 {
 		compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
 		reg = <0x400 0x200>;
 		interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -257,7 +257,7 @@
 	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
 	status = "okay";
 
-	uart1: serial@200 {
+	uart5: serial@200 {
 		compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 		reg = <0x200 0x200>;
 		interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -282,7 +282,7 @@
 	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
 	status = "okay";
 
-	i2c1: i2c@600 {
+	i2c6: i2c@600 {
 		compatible = "microchip,sam9x60-i2c";
 		reg = <0x600 0x200>;
 		interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -442,7 +442,7 @@
 				 AT91_PIOA 14 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 		};
 
-		pinctrl_flx5_default: flx_uart {
+		pinctrl_flx5_default: flx5_uart {
 			atmel,pins =
 				<AT91_PIOA 7 AT91_PERIPH_C AT91_PINCTRL_NONE
 				 AT91_PIOA 8 AT91_PERIPH_B AT91_PINCTRL_NONE
-- 
2.17.1

