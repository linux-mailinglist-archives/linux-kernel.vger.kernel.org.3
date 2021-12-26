Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1076547F8A9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhLZT4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbhLZT4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:22 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BF8C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:21 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zcv-0000Fz-RC; Sun, 26 Dec 2021 20:56:17 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/21] staging: r8188eu: remove unused blink mode defines
Date:   Sun, 26 Dec 2021 20:55:44 +0100
Message-Id: <20211226195556.159471-10-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove defines for led blink modes which are not used by this driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/rtw_led.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index 69656da76d19..e7fd3966326b 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -34,21 +34,15 @@ enum LED_STATE_871x {
 	RTW_LED_OFF = 2,
 	LED_BLINK_NORMAL = 3,
 	LED_BLINK_SLOWLY = 4,
-	LED_BLINK_POWER_ON = 5,
 	LED_BLINK_SCAN = 6, /*  LED is blinking during scanning period,
 			     * the # of times to blink is depend on time
 			     * for scanning. */
-	LED_BLINK_NO_LINK = 7, /*  LED is blinking during no link state. */
 	LED_BLINK_StartToBlink = 8,/*  Customzied for Sercomm Printer
 				    * Server case */
 	LED_BLINK_TXRX = 9,
 	LED_BLINK_WPS = 10,	/*  LED is blinkg during WPS communication */
 	LED_BLINK_WPS_STOP = 11,	/* for ALPHA */
-	LED_BLINK_WPS_STOP_OVERLAP = 12,	/* for BELKIN */
 	LED_BLINK_RUNTOP = 13, /*  Customized for RunTop */
-	LED_BLINK_CAMEO = 14,
-	LED_BLINK_XAVI = 15,
-	LED_BLINK_ALWAYS_ON = 16,
 };
 
 struct LED_871x {
-- 
2.30.2

