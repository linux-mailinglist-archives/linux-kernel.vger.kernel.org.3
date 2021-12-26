Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC11C47F8A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 20:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhLZT4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 14:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhLZT4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:56:22 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E49C061757
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:56:22 -0800 (PST)
Received: from dslb-188-097-047-111.188.097.pools.vodafone-ip.de ([188.97.47.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n1Zcw-0000Fz-P5; Sun, 26 Dec 2021 20:56:18 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/21] staging: r8188eu: bLedStartToLinkBlinkInProgress is set but not used
Date:   Sun, 26 Dec 2021 20:55:45 +0100
Message-Id: <20211226195556.159471-11-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226195556.159471-1-martin@kaiser.cx>
References: <20211226195556.159471-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bLedStartToLinkBlinkInProgress from struct LED_871x.
It's set but not used.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_led.c    | 1 -
 drivers/staging/r8188eu/include/rtw_led.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index 63b811cba277..7eade85302c8 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -23,7 +23,6 @@ static void ResetLedStatus(struct LED_871x *pLed)
 
 	pLed->bLedNoLinkBlinkInProgress = false;
 	pLed->bLedLinkBlinkInProgress = false;
-	pLed->bLedStartToLinkBlinkInProgress = false;
 	pLed->bLedScanBlinkInProgress = false;
 }
 
diff --git a/drivers/staging/r8188eu/include/rtw_led.h b/drivers/staging/r8188eu/include/rtw_led.h
index e7fd3966326b..fd7b0cbd64ac 100644
--- a/drivers/staging/r8188eu/include/rtw_led.h
+++ b/drivers/staging/r8188eu/include/rtw_led.h
@@ -63,7 +63,6 @@ struct LED_871x {
 	/*  ALPHA, added by chiyoko, 20090106 */
 	u8 bLedNoLinkBlinkInProgress;
 	u8 bLedLinkBlinkInProgress;
-	u8 bLedStartToLinkBlinkInProgress;
 	u8 bLedScanBlinkInProgress;
 	struct delayed_work blink_work;
 };
-- 
2.30.2

