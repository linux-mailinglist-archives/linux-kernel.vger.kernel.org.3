Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDEA487179
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345932AbiAGDwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiAGDwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:52:06 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423EBC061245;
        Thu,  6 Jan 2022 19:52:06 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 8so4338276pgc.10;
        Thu, 06 Jan 2022 19:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ys1A3HofKEhlRvWsZyRKeSFGsAvmpbUdt2u0ZRIt6K4=;
        b=S2oJhRzWvyjJlf26HhTSzAs1s/WlWJ6pAdEsAXH0AdW13w2vC+PZLUoxy1c2JepK/z
         07A45S1edwep4mRVedLrJuT8vffz6bfeO4Nq5fmYlfGAh6S9kymxxkuwF3x6ujiglufW
         OK/x+yB9GlatNcYzay+d5nQUfjR2UHf+fdXBKlRM0eFzWnEkVA0TFcVQmABJac+T2rs6
         +1Et7xddE/xvShnsGVNJiKIwVNlWurJlxoiKiXX44RpCGFkwg3KWiPiTZXAn7h3HIsSD
         tDS3Csxmyjx4lDDB2+HUaSXqksTOAjvR02xA6pzFnAvQad/FsJguTAvD9vuxUF/ITkUP
         aS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ys1A3HofKEhlRvWsZyRKeSFGsAvmpbUdt2u0ZRIt6K4=;
        b=RC9sT0T7rTWaP3v5ms0JUDg833HP2zKMVZtltHCKGPTQa6qyMDyDJWJiCA0txeP0oB
         F/wxX8yGRB+Wa7SblP+amER+crZ7FmD9CEsaukaElc5lNOG2/1r/fxniTfhndFaNmHsn
         NOz/2RiI6IkcU69Bn6bpTAEncTFMnVTTvSxVTO/fuwg32EJUy80cf2OpzuhvsFKQSnIy
         W9biovL21a+RERFRgoouUMinQpSMQFEnk5POvZpQZCgLBXyX3DhOcBEQmDix2z6clLpu
         4NIxI+3XJ3Y6MkkQWGqkZ5j9gtmgo4pqDPjp94tZrK6NZFe70aYPzO/K1HYU5U2UGTNg
         jPRA==
X-Gm-Message-State: AOAM5322BZ84gZlrQFV/abTgK0I0mcEq3WfeVkL8yG1Can89UF6S/1m4
        3M4yuim4MFhbnH29UXG6lUriagsFxUA=
X-Google-Smtp-Source: ABdhPJyMvh/0Kr6Hq2kpwbHDrPq03KIzS9Lvu3aoHtw0mrC2VDV/1VilDLd3aabuNvUYX3aeKpXAaQ==
X-Received: by 2002:a63:580d:: with SMTP id m13mr55177214pgb.298.1641527525456;
        Thu, 06 Jan 2022 19:52:05 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j16sm4043855pfj.16.2022.01.06.19.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:52:05 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/5] MIPS: BCM47XX: Add board entry for Linksys WRT320N v1
Date:   Thu,  6 Jan 2022 19:51:38 -0800
Message-Id: <20220107035141.2325384-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107035141.2325384-1-f.fainelli@gmail.com>
References: <20220107035141.2325384-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This router is based on a Broadcom BCM4717A1 chipset and supports
802.11n Wi-Fi. Add a board entry for that router and register LEDs and
buttons accordingly.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/bcm47xx/board.c                          |  1 +
 arch/mips/bcm47xx/buttons.c                        |  9 +++++++++
 arch/mips/bcm47xx/leds.c                           | 10 ++++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |  1 +
 4 files changed, 21 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index 35266a70e22a..d9148c66e0e7 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -141,6 +141,7 @@ struct bcm47xx_board_type_list2 bcm47xx_board_list_boot_hw[] __initconst = {
 	{{BCM47XX_BOARD_LINKSYS_WRT300NV11, "Linksys WRT300N V1.1"}, "WRT300N", "1.1"},
 	{{BCM47XX_BOARD_LINKSYS_WRT310NV1, "Linksys WRT310N V1"}, "WRT310N", "1.0"},
 	{{BCM47XX_BOARD_LINKSYS_WRT310NV2, "Linksys WRT310N V2"}, "WRT310N", "2.0"},
+	{{BCM47XX_BOARD_LINKSYS_WRT320N_V1, "Linksys WRT320N V1"}, "WRT320N", "1.0"},
 	{{BCM47XX_BOARD_LINKSYS_WRT54G3GV2, "Linksys WRT54G3GV2-VF"}, "WRT54G3GV2-VF", "1.0"},
 	{{BCM47XX_BOARD_LINKSYS_WRT610NV1, "Linksys WRT610N V1"}, "WRT610N", "1.0"},
 	{{BCM47XX_BOARD_LINKSYS_WRT610NV2, "Linksys WRT610N V2"}, "WRT610N", "2.0"},
diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 9e7ecc585d59..25b4cc3aecd2 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -282,6 +282,12 @@ bcm47xx_buttons_linksys_wrt310n_v2[] __initconst = {
 	BCM47XX_GPIO_KEY(6, KEY_RESTART),
 };
 
+static const struct gpio_keys_button
+bcm47xx_buttons_linksys_wrt320n_v1[] __initconst = {
+	BCM47XX_GPIO_KEY(5, KEY_WPS_BUTTON),
+	BCM47XX_GPIO_KEY(8, KEY_RESTART),
+};
+
 static const struct gpio_keys_button
 bcm47xx_buttons_linksys_wrt54g3gv2[] __initconst = {
 	BCM47XX_GPIO_KEY(5, KEY_WIMAX),
@@ -617,6 +623,9 @@ int __init bcm47xx_buttons_register(void)
 	case BCM47XX_BOARD_LINKSYS_WRT310NV2:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt310n_v2);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRT320N_V1:
+		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt320n_v1);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G3GV2:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_linksys_wrt54g3gv2);
 		break;
diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
index 167c42c71e79..649bb03c9bb7 100644
--- a/arch/mips/bcm47xx/leds.c
+++ b/arch/mips/bcm47xx/leds.c
@@ -313,6 +313,13 @@ bcm47xx_leds_linksys_wrt310nv1[] __initconst = {
 	BCM47XX_GPIO_LED(9, "blue", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
 };
 
+static const struct gpio_led
+bcm47xx_leds_linksys_wrt320n_v1[] __initconst = {
+	BCM47XX_GPIO_LED(1, "blue", "wlan", 1, LEDS_GPIO_DEFSTATE_OFF),
+	BCM47XX_GPIO_LED(2, "blue", "power", 0, LEDS_GPIO_DEFSTATE_ON),
+	BCM47XX_GPIO_LED(4, "amber", "wps", 1, LEDS_GPIO_DEFSTATE_OFF),
+};
+
 static const struct gpio_led
 bcm47xx_leds_linksys_wrt54g_generic[] __initconst = {
 	BCM47XX_GPIO_LED(0, "unk", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
@@ -689,6 +696,9 @@ void __init bcm47xx_leds_register(void)
 	case BCM47XX_BOARD_LINKSYS_WRT310NV1:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt310nv1);
 		break;
+	case BCM47XX_BOARD_LINKSYS_WRT320N_V1:
+		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt320n_v1);
+		break;
 	case BCM47XX_BOARD_LINKSYS_WRT54G3GV2:
 		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g3gv2);
 		break;
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index f879be3e8099..73e8809600b0 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -72,6 +72,7 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_LINKSYS_WRT300NV11,
 	BCM47XX_BOARD_LINKSYS_WRT310NV1,
 	BCM47XX_BOARD_LINKSYS_WRT310NV2,
+	BCM47XX_BOARD_LINKSYS_WRT320N_V1,
 	BCM47XX_BOARD_LINKSYS_WRT54G3GV2,
 	BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0101,
 	BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467,
-- 
2.25.1

