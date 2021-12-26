Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA6E47F8AC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbhLZT4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhLZT4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:25 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E043C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:25 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zcz-0000Fz-MT; Sun, 26 Dec 2021 20:56:21 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 13/21] staging: r8188eu: remove obsolete comments
Date:   Sun, 26 Dec 2021 20:55:48 +0100
Message-Id: <20211226195556.159471-14-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some comments that don't make sense any more.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_led.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index ffd23b73f852..2672ab165784 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -18,8 +18,8 @@ enum LED_CTL_MODE {
 	LED_CTL_START_TO_LINK = 8,
 	LED_CTL_START_WPS = 9,
 	LED_CTL_STOP_WPS = 10,
-	LED_CTL_START_WPS_BOTTON = 11, /* added for runtop */
-	LED_CTL_STOP_WPS_FAIL = 12, /* added for ALPHA */
+	LED_CTL_START_WPS_BOTTON = 11,
+	LED_CTL_STOP_WPS_FAIL = 12,
 };
 
 enum LED_STATE_871x {
@@ -35,7 +35,7 @@ enum LED_STATE_871x {
 				    * Server case */
 	LED_BLINK_TXRX = 9,
 	LED_BLINK_WPS = 10,	/*  LED is blinkg during WPS communication */
-	LED_BLINK_WPS_STOP = 11,	/* for ALPHA */
+	LED_BLINK_WPS_STOP = 11,
 	LED_BLINK_RUNTOP = 13, /*  Customized for RunTop */
 };
 
@@ -54,7 +54,6 @@ struct LED_871x {
 
 	u32 BlinkTimes; /*  Number of times to toggle led state for blinking. */
 
-	/*  ALPHA, added by chiyoko, 20090106 */
 	bool bLedNoLinkBlinkInProgress;
 	bool bLedLinkBlinkInProgress;
 	bool bLedScanBlinkInProgress;
@@ -64,12 +63,10 @@ struct LED_871x {
 void LedControl8188eu(struct adapter *padapter, enum LED_CTL_MODE	LedAction);
 
 struct led_priv{
-	/* add for led control */
 	struct LED_871x			SwLed0;
 	bool	bRegUseLed;
 	void (*LedControlHandler)(struct adapter *padapter,
 				  enum LED_CTL_MODE LedAction);
-	/* add for led control */
 };
 
 #define rtw_led_control(adapt, action) \
-- 
2.30.2

