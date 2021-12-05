Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F066468B9E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhLEPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbhLEPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:16:39 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3940C061751
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 07:13:11 -0800 (PST)
Received: from dslb-188-097-212-203.188.097.pools.vodafone-ip.de ([188.97.212.203] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mttCO-0007gF-0O; Sun, 05 Dec 2021 16:13:08 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 02/10] staging: r8188eu: remove a bunch of unused led defines
Date:   Sun,  5 Dec 2021 16:12:43 +0100
Message-Id: <20211205151251.6861-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211205151251.6861-1-martin@kaiser.cx>
References: <20211205151251.6861-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a couple of unused defines from rtw_led.h.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_led.h | 32 -----------------------
 1 file changed, 32 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 7e901aae92fb..f0272a7e8aa7 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -7,39 +7,12 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define MSECS(t)        (HZ * ((t) / 1000) + (HZ * ((t) % 1000)) / 1000)
-
-#define LED_BLINK_NORMAL_INTERVAL		100
-#define LED_BLINK_SLOWLY_INTERVAL		200
-#define LED_BLINK_LONG_INTERVAL			400
-
 #define LED_BLINK_NO_LINK_INTVL			msecs_to_jiffies(1000)
 #define LED_BLINK_LINK_INTVL			msecs_to_jiffies(500)
 #define LED_BLINK_SCAN_INTVL			msecs_to_jiffies(180)
 #define LED_BLINK_FASTER_INTVL			msecs_to_jiffies(50)
 #define LED_BLINK_WPS_SUCESS_INTVL		msecs_to_jiffies(5000)
 
-#define LED_BLINK_NORMAL_INTERVAL_NETTRONIX	100
-#define LED_BLINK_SLOWLY_INTERVAL_NETTRONIX	2000
-
-#define LED_BLINK_SLOWLY_INTERVAL_PORNET	1000
-#define LED_BLINK_NORMAL_INTERVAL_PORNET	100
-
-#define LED_BLINK_FAST_INTERVAL_BITLAND		30
-
-/*  060403, rcnjko: Customized for AzWave. */
-#define LED_CM2_BLINK_ON_INTERVAL		250
-#define LED_CM2_BLINK_OFF_INTERVAL		4750
-
-#define LED_CM8_BLINK_INTERVAL			500	/* for QMI */
-#define LED_CM8_BLINK_OFF_INTERVAL		3750	/* for QMI */
-
-/*  080124, lanhsin: Customized for RunTop */
-#define LED_RunTop_BLINK_INTERVAL		300
-
-/*  060421, rcnjko: Customized for Sercomm Printer Server case. */
-#define LED_CM3_BLINK_INTERVAL			1500
-
 enum LED_CTL_MODE {
 	LED_CTL_POWER_ON = 1,
 	LED_CTL_LINK = 2,
@@ -53,8 +26,6 @@ enum LED_CTL_MODE {
 	LED_CTL_STOP_WPS = 10,
 	LED_CTL_START_WPS_BOTTON = 11, /* added for runtop */
 	LED_CTL_STOP_WPS_FAIL = 12, /* added for ALPHA */
-	LED_CTL_STOP_WPS_FAIL_OVERLAP = 13, /* added for BELKIN */
-	LED_CTL_CONNECTION_NO_TRANSFER = 14,
 };
 
 enum LED_STATE_871x {
@@ -81,11 +52,8 @@ enum LED_STATE_871x {
 };
 
 enum LED_PIN_871x {
-	LED_PIN_NULL = 0,
 	LED_PIN_LED0 = 1,
 	LED_PIN_LED1 = 2,
-	LED_PIN_LED2 = 3,
-	LED_PIN_GPIO0 = 4,
 };
 
 struct LED_871x {
-- 
2.20.1

