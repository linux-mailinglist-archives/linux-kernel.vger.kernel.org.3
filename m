Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F4548161A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 19:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhL2Stk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 13:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhL2Stj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 13:49:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6DCC061574;
        Wed, 29 Dec 2021 10:49:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso7373896wmi.0;
        Wed, 29 Dec 2021 10:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=G0Og+6NFv6SaO+M7/U1stCtiQeGo6vEyctBfh1ct+NQ=;
        b=awhOfFI0n/FtrovD0sUPAiLgT2R5Mt7EByWUIQLtNKa/PrB+s0kkPwb8wG/7r7rF5Y
         0olUmcn/jI31TTgfs0m3SYak5mUPHh6I08UsEHSHTAgpDGNiSn58VraAmldH+aeX/4er
         1Zx0dk6KOvvsA8bCcd4xXwHXdHLIM5USs1Nro073QDX7wdB4bEDO96b0297vAZO3kCza
         cnGKliWB2gT8Ns+3qK9SIvPxUWwWj1PrksJYCDINo6h0Y6cIOuNXnYsfQhC7TTBwa5B2
         MagO/PDqG4hJRBIJOfPNEytkm8JaBRdTRpSMSUpRojcIFqOD0UYSGdvWWPwnysNFc/OG
         cYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G0Og+6NFv6SaO+M7/U1stCtiQeGo6vEyctBfh1ct+NQ=;
        b=orFXkCyXBkJUJUDLBK5+T6pdg4NjuU39SCAe4XK7tgUXP+dVqj7a99rf8NnY/4LsL7
         HTOVBbkNFy8Clzs2dgThdL48rrDSg0mCsasKNhAZQXe0W/p2sH04k2QjSazo4KVxouEX
         jY5aW8xNzVoOQitaIwj62+HnY28gsd3T8VM3QFnsjMceCnM7CoL3PK60WMFOVnRWS0SA
         7B2GXxOVew/ukc3iYQnec+y7bbtXw3cKIVZ5RpYriAXsIVvUc/xXuZyHkeSjVie/Ohh5
         0HiTyZyLIqbAGmbC0TNs/4A/8vLkZb6WO0WISsfqF0cr+SHp7nmrNn9g/fxkvglCmpB2
         v39w==
X-Gm-Message-State: AOAM532jnlCHJja5qbatycoD7UdwqcAIg/1QfntAxGJRup+/GdNEkqjK
        jngTa6FmY7hw2WANo1Ba3BA=
X-Google-Smtp-Source: ABdhPJxZou4FoIQiYriEye75yWz59pj2EmTtYjlPZrwnyKJqjILkmd7cVuZv8inu85aIEoLt5XYouA==
X-Received: by 2002:a1c:494:: with SMTP id 142mr23348978wme.191.1640803775991;
        Wed, 29 Dec 2021 10:49:35 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2626:5600:5f5:a4cc:1dcf:a62])
        by smtp.gmail.com with ESMTPSA id j85sm35617430wmj.3.2021.12.29.10.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:49:35 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] arm: pxa: remove dead and obsolete IrDA initialization
Date:   Wed, 29 Dec 2021 19:48:54 +0100
Message-Id: <20211229184854.3466-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d64c2a76123f ("staging: irda: remove the irda network stack and
drivers") removes the Intel PXA2xx Internal FICP driver, and the config
PXA_FICP and the config IRDA.

Further, this removes any proper effect from the setup functions in the
file ./include/linux/platform_data/irda-pxaficp.h. So, delete all users
in arch/arm/mach-pxa/ and this header file.

Clean up radically various left-over of IRDA in the ./arch/arm/mach-pxa.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c                  | 18 -----
 arch/arm/mach-pxa/corgi.c                     | 10 ---
 arch/arm/mach-pxa/devices.c                   | 42 ------------
 arch/arm/mach-pxa/eseries.c                   |  8 ---
 arch/arm/mach-pxa/hx4700.c                    | 11 ---
 arch/arm/mach-pxa/include/mach/eseries-gpio.h |  3 -
 arch/arm/mach-pxa/lpd270.c                    |  1 -
 arch/arm/mach-pxa/lubbock.c                   | 22 ------
 arch/arm/mach-pxa/magician.c                  | 12 ----
 arch/arm/mach-pxa/mainstone.c                 | 27 --------
 arch/arm/mach-pxa/palm27x.c                   | 16 -----
 arch/arm/mach-pxa/palm27x.h                   |  6 --
 arch/arm/mach-pxa/palmld.c                    |  2 -
 arch/arm/mach-pxa/palmt5.c                    |  2 -
 arch/arm/mach-pxa/palmtc.c                    | 19 ------
 arch/arm/mach-pxa/palmte2.c                   |  9 ---
 arch/arm/mach-pxa/palmtreo.c                  |  2 -
 arch/arm/mach-pxa/palmtx.c                    |  2 -
 arch/arm/mach-pxa/palmz72.c                   |  2 -
 arch/arm/mach-pxa/poodle.c                    | 11 ---
 arch/arm/mach-pxa/pxa2xx.c                    | 29 --------
 arch/arm/mach-pxa/spitz.c                     | 23 -------
 arch/arm/mach-pxa/tosa.c                      | 64 ------------------
 arch/arm/mach-pxa/trizeps4.c                  | 67 -------------------
 include/linux/platform_data/irda-pxaficp.h    | 26 -------
 25 files changed, 434 deletions(-)
 delete mode 100644 include/linux/platform_data/irda-pxaficp.h

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 26140249c784..9cf9dca337e8 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -46,7 +46,6 @@
 #include <linux/platform_data/mmc-pxamci.h>
 #include "udc.h"
 #include "pxa27x-udc.h"
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 
 #include "generic.h"
@@ -330,22 +329,6 @@ static void __init balloon3_udc_init(void)
 static inline void balloon3_udc_init(void) {}
 #endif
 
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-#if defined(CONFIG_IRDA) || defined(CONFIG_IRDA_MODULE)
-static struct pxaficp_platform_data balloon3_ficp_platform_data = {
-	.transceiver_cap	= IR_FIRMODE | IR_SIRMODE | IR_OFF,
-};
-
-static void __init balloon3_irda_init(void)
-{
-	pxa_set_ficp_info(&balloon3_ficp_platform_data);
-}
-#else
-static inline void balloon3_irda_init(void) {}
-#endif
-
 /******************************************************************************
  * USB Host
  ******************************************************************************/
@@ -780,7 +763,6 @@ static void __init balloon3_init(void)
 	pxa_set_stuart_info(NULL);
 
 	balloon3_i2c_init();
-	balloon3_irda_init();
 	balloon3_lcd_init();
 	balloon3_leds_init();
 	balloon3_mmc_init();
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 593c7f793da5..7e9764911bf6 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -47,7 +47,6 @@
 #include <asm/mach/irq.h>
 
 #include "pxa25x.h"
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include "udc.h"
 #include <mach/corgi.h>
@@ -508,14 +507,6 @@ static struct gpiod_lookup_table corgi_mci_gpio_table = {
 	},
 };
 
-/*
- * Irda
- */
-static struct pxaficp_platform_data corgi_ficp_platform_data = {
-	.gpio_pwdown		= CORGI_GPIO_IR_ON,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
 
 /*
  * USB Device Controller
@@ -750,7 +741,6 @@ static void __init corgi_init(void)
  	pxa_set_udc_info(&udc_info);
 	gpiod_add_lookup_table(&corgi_mci_gpio_table);
 	pxa_set_mci_info(&corgi_mci_platform_data);
-	pxa_set_ficp_info(&corgi_ficp_platform_data);
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(corgi_i2c_devices));
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 09b8495f3fd9..d475a934e8c3 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -14,7 +14,6 @@
 #include <linux/platform_data/usb-pxa3xx-ulpi.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <mach/irqs.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/keypad-pxa27x.h>
@@ -376,47 +375,6 @@ struct platform_device pxa_device_asoc_platform = {
 	.id		= -1,
 };
 
-static u64 pxaficp_dmamask = ~(u32)0;
-
-static struct resource pxa_ir_resources[] = {
-	[0] = {
-		.start  = IRQ_STUART,
-		.end    = IRQ_STUART,
-		.flags  = IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start  = IRQ_ICP,
-		.end    = IRQ_ICP,
-		.flags  = IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start  = 0x40800000,
-		.end	= 0x4080001b,
-		.flags  = IORESOURCE_MEM,
-	},
-	[4] = {
-		.start  = 0x40700000,
-		.end	= 0x40700023,
-		.flags  = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device pxa_device_ficp = {
-	.name		= "pxa2xx-ir",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(pxa_ir_resources),
-	.resource	= pxa_ir_resources,
-	.dev		= {
-		.dma_mask = &pxaficp_dmamask,
-		.coherent_dma_mask = 0xffffffff,
-	},
-};
-
-void __init pxa_set_ficp_info(struct pxaficp_platform_data *info)
-{
-	pxa_register_device(&pxa_device_ficp, info);
-}
-
 static struct resource pxa_rtc_resources[] = {
 	[0] = {
 		.start  = 0x40900000,
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index f37c44b6139d..5631ab600ad6 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -37,7 +37,6 @@
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include "udc.h"
-#include <linux/platform_data/irda-pxaficp.h>
 
 #include "devices.h"
 #include "generic.h"
@@ -67,11 +66,6 @@ static struct platform_device e7xx_gpio_vbus __maybe_unused = {
 	.id	= -1,
 };
 
-struct pxaficp_platform_data e7xx_ficp_platform_data = {
-	.gpio_pwdown		= GPIO_E7XX_IR_OFF,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
 int eseries_tmio_enable(struct platform_device *dev)
 {
 	/* Reset - bring SUSPEND high before PCLR */
@@ -542,7 +536,6 @@ static void __init e740_init(void)
 	gpiod_add_lookup_table(&e7xx_gpio_vbus_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(e740_devices));
 	pxa_set_ac97_info(NULL);
-	pxa_set_ficp_info(&e7xx_ficp_platform_data);
 }
 
 MACHINE_START(E740, "Toshiba e740")
@@ -742,7 +735,6 @@ static void __init e750_init(void)
 	gpiod_add_lookup_table(&e7xx_gpio_vbus_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(e750_devices));
 	pxa_set_ac97_info(NULL);
-	pxa_set_ficp_info(&e7xx_ficp_platform_data);
 }
 
 MACHINE_START(E750, "Toshiba e750")
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 1d4c5db54be2..1b4ff555c604 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -42,7 +42,6 @@
 
 #include "pxa27x.h"
 #include <mach/hx4700.h>
-#include <linux/platform_data/irda-pxaficp.h>
 
 #include <sound/ak4641.h>
 #include <video/platform_lcd.h>
@@ -151,15 +150,6 @@ static unsigned long hx4700_pin_config[] __initdata = {
 	GPIO66_GPIO,	/* nSDIO_IRQ */
 };
 
-/*
- * IRDA
- */
-
-static struct pxaficp_platform_data ficp_info = {
-	.gpio_pwdown		= GPIO105_HX4700_nIR_ON,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
 /*
  * GPIO Keys
  */
@@ -891,7 +881,6 @@ static void __init hx4700_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	pwm_add_table(hx4700_pwm_lookup, ARRAY_SIZE(hx4700_pwm_lookup));
 
-	pxa_set_ficp_info(&ficp_info);
 	pxa27x_set_i2c_power_info(NULL);
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(i2c_board_info));
diff --git a/arch/arm/mach-pxa/include/mach/eseries-gpio.h b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
index 5c645600d401..e38c7ee019f8 100644
--- a/arch/arm/mach-pxa/include/mach/eseries-gpio.h
+++ b/arch/arm/mach-pxa/include/mach/eseries-gpio.h
@@ -38,9 +38,6 @@
 #define GPIO_E800_PCMCIA_PWR0    20
 #define GPIO_E800_PCMCIA_PWR1    73
 
-/* e7xx IrDA power control */
-#define GPIO_E7XX_IR_OFF         38
-
 /* e740 audio control GPIOs */
 #define GPIO_E740_WM9705_nAVDD2  16
 #define GPIO_E740_MIC_ON         40
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index 6fc40bc06910..f13ba9b9f83e 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -42,7 +42,6 @@
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/smemc.h>
 
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index e2411971422d..574897eae2a3 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -49,7 +49,6 @@
 #include <mach/audio.h>
 #include <mach/lubbock.h>
 #include "udc.h"
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include "pm.h"
@@ -455,26 +454,6 @@ static struct pxamci_platform_data lubbock_mci_platform_data = {
 	.exit 			= lubbock_mci_exit,
 };
 
-static void lubbock_irda_transceiver_mode(struct device *dev, int mode)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	if (mode & IR_SIRMODE) {
-		lubbock_set_misc_wr(BIT(4), 0);
-	} else if (mode & IR_FIRMODE) {
-		lubbock_set_misc_wr(BIT(4), BIT(4));
-	}
-	pxa2xx_transceiver_mode(dev, mode);
-	local_irq_restore(flags);
-}
-
-static struct pxaficp_platform_data lubbock_ficp_platform_data = {
-	.gpio_pwdown		= -1,
-	.transceiver_cap	= IR_SIRMODE | IR_FIRMODE,
-	.transceiver_mode	= lubbock_irda_transceiver_mode,
-};
-
 static void __init lubbock_init(void)
 {
 	int flashboot = (LUB_CONF_SWITCHES & 1);
@@ -500,7 +479,6 @@ static void __init lubbock_init(void)
 	pxa_set_udc_info(&udc_info);
 	pxa_set_fb_info(NULL, &sharp_lm8v31);
 	pxa_set_mci_info(&lubbock_mci_platform_data);
-	pxa_set_ficp_info(&lubbock_ficp_platform_data);
 	pxa_set_ac97_info(NULL);
 
 	lubbock_flash_data[0].width = lubbock_flash_data[1].width =
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index cd9fa465b9b2..4471855ffaff 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -38,7 +38,6 @@
 #include <mach/magician.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 
 #include <linux/regulator/max1586.h>
@@ -123,16 +122,6 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO115_GPIO,	/* nPEN_IRQ */
 };
 
-/*
- * IrDA
- */
-
-static struct pxaficp_platform_data magician_ficp_info = {
-	.gpio_pwdown		= GPIO83_MAGICIAN_nIR_EN,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-	.gpio_pwdown_inverted	= 0,
-};
-
 /*
  * GPIO Keys
  */
@@ -1001,7 +990,6 @@ static void __init magician_init(void)
 
 	pwm_add_table(magician_pwm_lookup, ARRAY_SIZE(magician_pwm_lookup));
 
-	pxa_set_ficp_info(&magician_ficp_info);
 	pxa27x_set_i2c_power_info(&magician_i2c_power_info);
 	pxa_set_i2c_info(&i2c_info);
 
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index d237bd030238..603af99c660a 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -49,7 +49,6 @@
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 #include <mach/smemc.h>
@@ -360,31 +359,6 @@ static struct pxamci_platform_data mainstone_mci_platform_data = {
 	.exit			= mainstone_mci_exit,
 };
 
-static void mainstone_irda_transceiver_mode(struct device *dev, int mode)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	if (mode & IR_SIRMODE) {
-		MST_MSCWR1 &= ~MST_MSCWR1_IRDA_FIR;
-	} else if (mode & IR_FIRMODE) {
-		MST_MSCWR1 |= MST_MSCWR1_IRDA_FIR;
-	}
-	pxa2xx_transceiver_mode(dev, mode);
-	if (mode & IR_OFF) {
-		MST_MSCWR1 = (MST_MSCWR1 & ~MST_MSCWR1_IRDA_MASK) | MST_MSCWR1_IRDA_OFF;
-	} else {
-		MST_MSCWR1 = (MST_MSCWR1 & ~MST_MSCWR1_IRDA_MASK) | MST_MSCWR1_IRDA_FULL;
-	}
-	local_irq_restore(flags);
-}
-
-static struct pxaficp_platform_data mainstone_ficp_platform_data = {
-	.gpio_pwdown		= -1,
-	.transceiver_cap	= IR_SIRMODE | IR_FIRMODE | IR_OFF,
-	.transceiver_mode	= mainstone_irda_transceiver_mode,
-};
-
 static struct gpio_keys_button gpio_keys_button[] = {
 	[0] = {
 		.desc	= "wakeup",
@@ -596,7 +570,6 @@ static void __init mainstone_init(void)
 	mainstone_backlight_register();
 
 	pxa_set_mci_info(&mainstone_mci_platform_data);
-	pxa_set_ficp_info(&mainstone_ficp_platform_data);
 	pxa_set_ohci_info(&mainstone_ohci_platform_data);
 	pxa_set_i2c_info(NULL);
 	pxa_set_ac97_info(&mst_audio_ops);
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 6230381a7ca0..9bb2f892d7a9 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -28,7 +28,6 @@
 #include <mach/audio.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include "udc.h"
 #include <linux/platform_data/asoc-palm27x.h>
 #include "palm27x.h"
@@ -189,21 +188,6 @@ void __init palm27x_udc_init(int vbus, int pullup, int vbus_inverted)
 }
 #endif
 
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-#if defined(CONFIG_IRDA) || defined(CONFIG_IRDA_MODULE)
-static struct pxaficp_platform_data palm27x_ficp_platform_data = {
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-void __init palm27x_irda_init(int pwdn)
-{
-	palm27x_ficp_platform_data.gpio_pwdown = pwdn;
-	pxa_set_ficp_info(&palm27x_ficp_platform_data);
-}
-#endif
-
 /******************************************************************************
  * WM97xx audio, battery
  ******************************************************************************/
diff --git a/arch/arm/mach-pxa/palm27x.h b/arch/arm/mach-pxa/palm27x.h
index bd3075bbb3aa..7985a608db55 100644
--- a/arch/arm/mach-pxa/palm27x.h
+++ b/arch/arm/mach-pxa/palm27x.h
@@ -41,12 +41,6 @@ extern void __init palm27x_udc_init(int vbus, int pullup,
 static inline void palm27x_udc_init(int vbus, int pullup, int vbus_inverted) {}
 #endif
 
-#if defined(CONFIG_IRDA) || defined(CONFIG_IRDA_MODULE)
-extern void __init palm27x_irda_init(int pwdn);
-#else
-static inline void palm27x_irda_init(int pwdn) {}
-#endif
-
 #if	defined(CONFIG_TOUCHSCREEN_WM97XX) || \
 	defined(CONFIG_TOUCHSCREEN_WM97XX_MODULE)
 extern void __init palm27x_ac97_init(int minv, int maxv, int jack,
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 5f73716a77f0..8e780d1103e5 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -33,7 +33,6 @@
 #include <mach/palmld.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 #include <linux/platform_data/asoc-palm27x.h>
 #include "palm27x.h"
@@ -351,7 +350,6 @@ static void __init palmld_init(void)
 	palm27x_mmc_init(&palmld_mci_gpio_table);
 	palm27x_pm_init(PALMLD_STR_BASE);
 	palm27x_lcd_init(-1, &palm_320x480_lcd_mode);
-	palm27x_irda_init(GPIO_NR_PALMLD_IR_DISABLE);
 	palm27x_ac97_init(PALMLD_BAT_MIN_VOLTAGE, PALMLD_BAT_MAX_VOLTAGE,
 			GPIO_NR_PALMLD_EARPHONE_DETECT, 95);
 	palm27x_pwm_init(GPIO_NR_PALMLD_BL_POWER, GPIO_NR_PALMLD_LCD_POWER);
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 7c7cbb4e677e..858e805dd0b0 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -33,7 +33,6 @@
 #include "palmt5.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 #include "udc.h"
 #include <linux/platform_data/asoc-palm27x.h>
@@ -202,7 +201,6 @@ static void __init palmt5_init(void)
 	palm27x_lcd_init(-1, &palm_320x480_lcd_mode);
 	palm27x_udc_init(GPIO_NR_PALMT5_USB_DETECT_N,
 			GPIO_NR_PALMT5_USB_PULLUP, 1);
-	palm27x_irda_init(GPIO_NR_PALMT5_IR_DISABLE);
 	palm27x_ac97_init(PALMT5_BAT_MIN_VOLTAGE, PALMT5_BAT_MAX_VOLTAGE,
 			GPIO_NR_PALMT5_EARPHONE_DETECT, 95);
 	palm27x_pwm_init(GPIO_NR_PALMT5_BL_POWER, GPIO_NR_PALMT5_LCD_POWER);
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index 455cb8ccaf26..6961bc61b485 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -33,7 +33,6 @@
 #include <mach/palmtc.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include "udc.h"
 
 #include "generic.h"
@@ -211,23 +210,6 @@ static void __init palmtc_pwm_init(void)
 static inline void palmtc_pwm_init(void) {}
 #endif
 
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-#if defined(CONFIG_IRDA) || defined(CONFIG_IRDA_MODULE)
-static struct pxaficp_platform_data palmtc_ficp_platform_data = {
-	.gpio_pwdown		= GPIO_NR_PALMTC_IR_DISABLE,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-static void __init palmtc_irda_init(void)
-{
-	pxa_set_ficp_info(&palmtc_ficp_platform_data);
-}
-#else
-static inline void palmtc_irda_init(void) {}
-#endif
-
 /******************************************************************************
  * Keyboard
  ******************************************************************************/
@@ -518,7 +500,6 @@ static void __init palmtc_init(void)
 	palmtc_mmc_init();
 	palmtc_keys_init();
 	palmtc_pwm_init();
-	palmtc_irda_init();
 	palmtc_mkp_init();
 	palmtc_udc_init();
 	palmtc_ts_init();
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index a2b10db4aacc..1d8f47dc93f0 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -33,7 +33,6 @@
 #include "palmte2.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include "udc.h"
 #include <linux/platform_data/asoc-palm27x.h>
 
@@ -188,14 +187,6 @@ static struct platform_device palmte2_backlight = {
 	},
 };
 
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-static struct pxaficp_platform_data palmte2_ficp_platform_data = {
-	.gpio_pwdown		= GPIO_NR_PALMTE2_IR_DISABLE,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
 /******************************************************************************
  * UDC
  ******************************************************************************/
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 2bf0f7f3ea24..c31a0017d17f 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -33,7 +33,6 @@
 #include "palmtreo.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 #include "udc.h"
 #include <linux/platform_data/usb-ohci-pxa27x.h>
@@ -417,7 +416,6 @@ static void __init palmphone_common_init(void)
 	palm27x_pm_init(TREO_STR_BASE);
 	palm27x_lcd_init(GPIO_NR_TREO_BL_POWER, &palm_320x320_new_lcd_mode);
 	palm27x_udc_init(GPIO_NR_TREO_USB_DETECT, GPIO_NR_TREO_USB_PULLUP, 1);
-	palm27x_irda_init(GPIO_NR_TREO_IR_EN);
 	palm27x_ac97_init(-1, -1, -1, 95);
 	palm27x_pwm_init(GPIO_NR_TREO_BL_POWER, -1);
 	palm27x_power_init(GPIO_NR_TREO_POWER_DETECT, -1);
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 07332c92c9f7..288e2bcf20c3 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -36,7 +36,6 @@
 #include <mach/palmtx.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 #include "udc.h"
 #include <linux/platform_data/asoc-palm27x.h>
@@ -357,7 +356,6 @@ static void __init palmtx_init(void)
 	palm27x_lcd_init(-1, &palm_320x480_lcd_mode);
 	palm27x_udc_init(GPIO_NR_PALMTX_USB_DETECT_N,
 			GPIO_NR_PALMTX_USB_PULLUP, 1);
-	palm27x_irda_init(GPIO_NR_PALMTX_IR_DISABLE);
 	palm27x_ac97_init(PALMTX_BAT_MIN_VOLTAGE, PALMTX_BAT_MAX_VOLTAGE,
 			GPIO_NR_PALMTX_EARPHONE_DETECT, 95);
 	palm27x_pwm_init(GPIO_NR_PALMTX_BL_POWER, GPIO_NR_PALMTX_LCD_POWER);
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index b4a5fe02a0af..a7dc9bc6186b 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -38,7 +38,6 @@
 #include "palmz72.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 #include "udc.h"
 #include <linux/platform_data/asoc-palm27x.h>
@@ -297,7 +296,6 @@ static void __init palmz72_init(void)
 	palm27x_lcd_init(-1, &palm_320x320_lcd_mode);
 	palm27x_udc_init(GPIO_NR_PALMZ72_USB_DETECT_N,
 			GPIO_NR_PALMZ72_USB_PULLUP, 0);
-	palm27x_irda_init(GPIO_NR_PALMZ72_IR_DISABLE);
 	palm27x_ac97_init(PALMZ72_BAT_MIN_VOLTAGE, PALMZ72_BAT_MAX_VOLTAGE,
 			-1, 113);
 	palm27x_pwm_init(-1, -1);
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 3a4ecc3c8f8b..c4c8c3dc1e5b 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -42,7 +42,6 @@
 #include "pxa25x.h"
 #include <linux/platform_data/mmc-pxamci.h>
 #include "udc.h"
-#include <linux/platform_data/irda-pxaficp.h>
 #include <mach/poodle.h>
 #include <linux/platform_data/video-pxafb.h>
 
@@ -299,15 +298,6 @@ static struct gpiod_lookup_table poodle_mci_gpio_table = {
 	},
 };
 
-/*
- * Irda
- */
-static struct pxaficp_platform_data poodle_ficp_platform_data = {
-	.gpio_pwdown		= POODLE_GPIO_IR_ON,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-
 /*
  * USB Device Controller
  */
@@ -446,7 +436,6 @@ static void __init poodle_init(void)
 	pxa_set_udc_info(&udc_info);
 	gpiod_add_lookup_table(&poodle_mci_gpio_table);
 	pxa_set_mci_info(&poodle_mci_platform_data);
-	pxa_set_ficp_info(&poodle_ficp_platform_data);
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(poodle_i2c_devices));
 	poodle_init_spi();
diff --git a/arch/arm/mach-pxa/pxa2xx.c b/arch/arm/mach-pxa/pxa2xx.c
index 2d26cd2afbf3..973b1fbde63e 100644
--- a/arch/arm/mach-pxa/pxa2xx.c
+++ b/arch/arm/mach-pxa/pxa2xx.c
@@ -16,38 +16,9 @@
 #include <mach/pxa2xx-regs.h>
 #include "mfp-pxa25x.h"
 #include <mach/reset.h>
-#include <linux/platform_data/irda-pxaficp.h>
 
 void pxa2xx_clear_reset_status(unsigned int mask)
 {
 	/* RESET_STATUS_* has a 1:1 mapping with RCSR */
 	RCSR = mask;
 }
-
-static unsigned long pxa2xx_mfp_fir[] = {
-	GPIO46_FICP_RXD,
-	GPIO47_FICP_TXD,
-};
-
-static unsigned long pxa2xx_mfp_sir[] = {
-	GPIO46_STUART_RXD,
-	GPIO47_STUART_TXD,
-};
-
-static unsigned long pxa2xx_mfp_off[] = {
-	GPIO46_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO47_GPIO | MFP_LPM_DRIVE_LOW,
-};
-
-void pxa2xx_transceiver_mode(struct device *dev, int mode)
-{
-	if (mode & IR_OFF) {
-		pxa2xx_mfp_config(pxa2xx_mfp_off, ARRAY_SIZE(pxa2xx_mfp_off));
-	} else if (mode & IR_SIRMODE) {
-		pxa2xx_mfp_config(pxa2xx_mfp_sir, ARRAY_SIZE(pxa2xx_mfp_sir));
-	} else if (mode & IR_FIRMODE) {
-		pxa2xx_mfp_config(pxa2xx_mfp_fir, ARRAY_SIZE(pxa2xx_mfp_fir));
-	} else
-		BUG();
-}
-EXPORT_SYMBOL_GPL(pxa2xx_transceiver_mode);
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 371008e9bb02..8c4aef0cbd1f 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -40,7 +40,6 @@
 #include "pxa27x.h"
 #include "pxa27x-udc.h"
 #include <mach/reset.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/video-pxafb.h>
@@ -691,27 +690,6 @@ static void __init spitz_uhc_init(void)
 static inline void spitz_uhc_init(void) {}
 #endif
 
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-#if defined(CONFIG_PXA_FICP) || defined(CONFIG_PXA_FICP_MODULE)
-static struct pxaficp_platform_data spitz_ficp_platform_data = {
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-static void __init spitz_irda_init(void)
-{
-	if (machine_is_akita())
-		spitz_ficp_platform_data.gpio_pwdown = AKITA_GPIO_IR_ON;
-	else
-		spitz_ficp_platform_data.gpio_pwdown = SPITZ_GPIO_IR_ON;
-
-	pxa_set_ficp_info(&spitz_ficp_platform_data);
-}
-#else
-static inline void spitz_irda_init(void) {}
-#endif
-
 /******************************************************************************
  * Framebuffer
  ******************************************************************************/
@@ -1015,7 +993,6 @@ static void __init spitz_init(void)
 	spitz_leds_init();
 	spitz_mmc_init();
 	spitz_pcmcia_init();
-	spitz_irda_init();
 	spitz_uhc_init();
 	spitz_lcd_init();
 	spitz_nor_init();
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 431709725d02..fe3393f1f50a 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -41,7 +41,6 @@
 
 #include "pxa25x.h"
 #include <mach/reset.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include "udc.h"
 #include "tosa_bt.h"
@@ -304,68 +303,6 @@ static struct gpiod_lookup_table tosa_mci_gpio_table = {
 	},
 };
 
-/*
- * Irda
- */
-static void tosa_irda_transceiver_mode(struct device *dev, int mode)
-{
-	if (mode & IR_OFF) {
-		gpio_set_value(TOSA_GPIO_IR_POWERDWN, 0);
-		pxa2xx_transceiver_mode(dev, mode);
-		gpio_direction_output(TOSA_GPIO_IRDA_TX, 0);
-	} else {
-		pxa2xx_transceiver_mode(dev, mode);
-		gpio_set_value(TOSA_GPIO_IR_POWERDWN, 1);
-	}
-}
-
-static int tosa_irda_startup(struct device *dev)
-{
-	int ret;
-
-	ret = gpio_request(TOSA_GPIO_IRDA_TX, "IrDA TX");
-	if (ret)
-		goto err_tx;
-	ret = gpio_direction_output(TOSA_GPIO_IRDA_TX, 0);
-	if (ret)
-		goto err_tx_dir;
-
-	ret = gpio_request(TOSA_GPIO_IR_POWERDWN, "IrDA powerdown");
-	if (ret)
-		goto err_pwr;
-
-	ret = gpio_direction_output(TOSA_GPIO_IR_POWERDWN, 0);
-	if (ret)
-		goto err_pwr_dir;
-
-	tosa_irda_transceiver_mode(dev, IR_SIRMODE | IR_OFF);
-
-	return 0;
-
-err_pwr_dir:
-	gpio_free(TOSA_GPIO_IR_POWERDWN);
-err_pwr:
-err_tx_dir:
-	gpio_free(TOSA_GPIO_IRDA_TX);
-err_tx:
-	return ret;
-}
-
-static void tosa_irda_shutdown(struct device *dev)
-{
-	tosa_irda_transceiver_mode(dev, IR_SIRMODE | IR_OFF);
-	gpio_free(TOSA_GPIO_IR_POWERDWN);
-	gpio_free(TOSA_GPIO_IRDA_TX);
-}
-
-static struct pxaficp_platform_data tosa_ficp_platform_data = {
-	.gpio_pwdown		= -1,
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-	.transceiver_mode	= tosa_irda_transceiver_mode,
-	.startup		= tosa_irda_startup,
-	.shutdown		= tosa_irda_shutdown,
-};
-
 /*
  * Tosa AC IN
  */
@@ -945,7 +882,6 @@ static void __init tosa_init(void)
 
 	gpiod_add_lookup_table(&tosa_mci_gpio_table);
 	pxa_set_mci_info(&tosa_mci_platform_data);
-	pxa_set_ficp_info(&tosa_ficp_platform_data);
 	pxa_set_i2c_info(NULL);
 	pxa_set_ac97_info(NULL);
 	platform_scoop_config = &tosa_pcmcia_config;
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index f76f8be09554..4bd426b13515 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -44,18 +44,12 @@
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <mach/smemc.h>
 
 #include "generic.h"
 #include "devices.h"
 
-/*	comment out the following line if you want to use the
- *	Standard UART from PXA for serial / irda transmission
- *	and acivate it if you have status leds connected */
-#define STATUS_LEDS_ON_STUART_PINS 1
-
 /*****************************************************************************
  * MultiFunctionPins of CPU
  *****************************************************************************/
@@ -94,13 +88,8 @@ static unsigned long trizeps4_pin_config[] __initdata = {
 	GPIO43_BTUART_TXD,
 	GPIO44_BTUART_CTS,
 	GPIO45_BTUART_RTS,
-#ifdef STATUS_LEDS_ON_STUART_PINS
 	GPIO46_GPIO,
 	GPIO47_GPIO,
-#else
-	GPIO46_STUART_RXD,
-	GPIO47_STUART_TXD,
-#endif
 	/* PCMCIA */
 	GPIO11_GPIO,			/* TRIZEPS4_CD_IRQ */
 	GPIO13_GPIO,			/* TRIZEPS4_READY_NINT */
@@ -233,7 +222,6 @@ static struct platform_device dm9000_device = {
  * LED's on GPIO pins of PXA
  ****************************************************************************/
 static struct gpio_led trizeps4_led[] = {
-#ifdef STATUS_LEDS_ON_STUART_PINS
 	{
 		.name = "led0:orange:heartbeat",	/* */
 		.default_trigger = "heartbeat",
@@ -246,7 +234,6 @@ static struct gpio_led trizeps4_led[] = {
 		.gpio = GPIO_SYS_BUSY_LED,
 		.active_low = 1,
 	},
-#endif
 };
 
 static struct gpio_led_platform_data trizeps4_led_data = {
@@ -354,57 +341,6 @@ static struct pxamci_platform_data trizeps4_mci_platform_data = {
 	.setpower 	= NULL,	/* power-switching not supported */
 };
 
-/****************************************************************************
- * IRDA mode switching on stuart
- ****************************************************************************/
-#ifndef STATUS_LEDS_ON_STUART_PINS
-static short trizeps_conxs_ircr;
-
-static int trizeps4_irda_startup(struct device *dev)
-{
-	trizeps_conxs_ircr &= ~ConXS_IRCR_SD;
-	IRCR_writew(trizeps_conxs_ircr);
-	return 0;
-}
-
-static void trizeps4_irda_shutdown(struct device *dev)
-{
-	trizeps_conxs_ircr |= ConXS_IRCR_SD;
-	IRCR_writew(trizeps_conxs_ircr);
-}
-
-static void trizeps4_irda_transceiver_mode(struct device *dev, int mode)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	/* Switch mode */
-	if (mode & IR_SIRMODE)
-		trizeps_conxs_ircr &= ~ConXS_IRCR_MODE;	/* Slow mode */
-	else if (mode & IR_FIRMODE)
-		trizeps_conxs_ircr |= ConXS_IRCR_MODE;	/* Fast mode */
-
-	/* Switch power */
-	if (mode & IR_OFF)
-		trizeps_conxs_ircr |= ConXS_IRCR_SD;
-	else
-		trizeps_conxs_ircr &= ~ConXS_IRCR_SD;
-
-	IRCR_writew(trizeps_conxs_ircr);
-	local_irq_restore(flags);
-
-	pxa2xx_transceiver_mode(dev, mode);
-}
-
-static struct pxaficp_platform_data trizeps4_ficp_platform_data = {
-	.gpio_pwdown		= -1,
-	.transceiver_cap	= IR_SIRMODE | IR_FIRMODE | IR_OFF,
-	.transceiver_mode	= trizeps4_irda_transceiver_mode,
-	.startup		= trizeps4_irda_startup,
-	.shutdown		= trizeps4_irda_shutdown,
-};
-#endif
-
 /****************************************************************************
  * OHCI USB port
  ****************************************************************************/
@@ -516,9 +452,6 @@ static void __init trizeps4_init(void)
 		pxa_set_fb_info(NULL, &toshiba_lcd);
 
 	pxa_set_mci_info(&trizeps4_mci_platform_data);
-#ifndef STATUS_LEDS_ON_STUART_PINS
-	pxa_set_ficp_info(&trizeps4_ficp_platform_data);
-#endif
 	pxa_set_ohci_info(&trizeps4_ohci_platform_data);
 	pxa_set_ac97_info(NULL);
 	pxa_set_i2c_info(NULL);
diff --git a/include/linux/platform_data/irda-pxaficp.h b/include/linux/platform_data/irda-pxaficp.h
deleted file mode 100644
index bd35ddcf3068..000000000000
--- a/include/linux/platform_data/irda-pxaficp.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ASMARM_ARCH_IRDA_H
-#define ASMARM_ARCH_IRDA_H
-
-/* board specific transceiver capabilities */
-
-#define IR_OFF		1
-#define IR_SIRMODE	2
-#define IR_FIRMODE	4
-
-struct pxaficp_platform_data {
-	int transceiver_cap;
-	void (*transceiver_mode)(struct device *dev, int mode);
-	int (*startup)(struct device *dev);
-	void (*shutdown)(struct device *dev);
-	int gpio_pwdown;		/* powerdown GPIO for the IrDA chip */
-	bool gpio_pwdown_inverted;	/* gpio_pwdown is inverted */
-};
-
-extern void pxa_set_ficp_info(struct pxaficp_platform_data *info);
-
-#if defined(CONFIG_PXA25x) || defined(CONFIG_PXA27x)
-void pxa2xx_transceiver_mode(struct device *dev, int mode);
-#endif
-
-#endif
-- 
2.17.1

