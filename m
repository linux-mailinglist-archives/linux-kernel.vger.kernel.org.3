Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE9476559
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhLOWGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhLOWFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:05:55 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92664C06173E;
        Wed, 15 Dec 2021 14:05:54 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 132so21519639qkj.11;
        Wed, 15 Dec 2021 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nfw84skwDiWF0hVkBaCmIEgDDYUu9HQAVCA9TAQoLGM=;
        b=HEgHrqcsFZ9SyjVnl/2KVYnV6dY+aDoDk2TnanqmRScBi8vs+gzIVf5lPF70JznrWD
         8xror+R84Stijbs7TboPzeP7aeGYAwlCQTC/y2TEwLfXpvffNSD3FhY6WY83hV6YbD79
         gebmbnvF7PZivHPKms+81IEdrN+aFx9I9OTvMpf8J97kbV6iUqg4Hzk6na79oMCq4hI1
         rfIJ4VHRP8iN05/Fblc3yiNpCsYre7XKdB5ud4oSqNVjRzWCUO9k3ovWecuBFQYNL4US
         mQ3nWHpO608quueK7Nqp3b9JUCY2C5o0tgdNsZ981rl+khoW/y00uBonxkzJGoWisb3V
         Beeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nfw84skwDiWF0hVkBaCmIEgDDYUu9HQAVCA9TAQoLGM=;
        b=O8l8FVPO7ERGBwYHPx/uOOJv0zVxkn/bRbNLyW7Di2uWbxrHLwkw1LaHHMi8ZuglPe
         P43tv9M11+mR/Y9HJy9yXm6IArKAjVUWsZTZvS8V34F8Yx3dvZysHLk6hxJVU01jzrjC
         VokZ2OxWniYMOIu5rrVVSTnKHmXI88ubi13xAbrTtprzrMH72G4UNiIghTsvKpdyhmLf
         ti/PHdc7n6xO7v2xvxHvzhAc4N0TI2Hc4CZ+6v7uCmZ/rd8dCXIrUu7w1wW+F6gVe+Vg
         SyDODrSSaGLkmwdjMStWR7Z7bl1oiVS4oWDYMc8jPtktnQLhLgTqXobpAljunytOp808
         sgkA==
X-Gm-Message-State: AOAM532NMRhpRTKoyPncNZd65N8tumf0vJX7ocfVG3iou18NFSxrKx/1
        uOQq6yAO5/pDNwxc6UEoSI0=
X-Google-Smtp-Source: ABdhPJzA29KNN3tMeFW5WKmK5xkxdIu1YzBmNCfWdBVgQH2bUSqHaXTXn0/E2gHJsWlxZB7I34BWJg==
X-Received: by 2002:a05:620a:c11:: with SMTP id l17mr10361187qki.493.1639605953742;
        Wed, 15 Dec 2021 14:05:53 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id s20sm2471592qtc.75.2021.12.15.14.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:05:53 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v5 7/9] tty: serial: fsl_lpuart: Add i.MXRT1050 support
Date:   Wed, 15 Dec 2021 17:05:36 -0500
Message-Id: <20211215220538.4180616-8-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215220538.4180616-1-Mr.Bossman075@gmail.com>
References: <20211215220538.4180616-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Taube <mr.bossman075@gmail.com>

Add support for i.MXRT1050's uart.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1->V2:
* Nothing done
V2->V3:
* Rename imxrt to imxrt1050
V3->V4:
* Nothing done
V4->V5:
* Change commit description to just 1050
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 3affe52a364d..ce3e26144689 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -247,6 +247,7 @@ enum lpuart_type {
 	LS1028A_LPUART,
 	IMX7ULP_LPUART,
 	IMX8QXP_LPUART,
+	IMXRT1050_LPUART,
 };
 
 struct lpuart_port {
@@ -310,6 +311,11 @@ static struct lpuart_soc_data imx8qxp_data = {
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
 };
+static struct lpuart_soc_data imxrt1050_data = {
+	.devtype = IMXRT1050_LPUART,
+	.iotype = UPIO_MEM32,
+	.reg_off = IMX_REG_OFF,
+};
 
 static const struct of_device_id lpuart_dt_ids[] = {
 	{ .compatible = "fsl,vf610-lpuart",	.data = &vf_data, },
@@ -317,6 +323,7 @@ static const struct of_device_id lpuart_dt_ids[] = {
 	{ .compatible = "fsl,ls1028a-lpuart",	.data = &ls1028a_data, },
 	{ .compatible = "fsl,imx7ulp-lpuart",	.data = &imx7ulp_data, },
 	{ .compatible = "fsl,imx8qxp-lpuart",	.data = &imx8qxp_data, },
+	{ .compatible = "fsl,imxrt1050-lpuart",	.data = &imxrt1050_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
@@ -2626,6 +2633,7 @@ OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1028a-lpuart", ls1028a_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imxrt1050-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
 
-- 
2.34.1

