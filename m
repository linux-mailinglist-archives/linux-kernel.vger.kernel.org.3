Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84C24EC534
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbiC3NJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbiC3NJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:09:24 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768EC78907
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:07:39 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k10so22018761oia.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=iHRrjC7NGgHX48bIJgJGcmUknIuFtHx4WhnT2MgRlL4=;
        b=Kp0gzgzMfQ3kAvf1gdqVG9PW5fvH8A0wiM4iIvt/os2m6GCy08yYL67z/4CzATgJeE
         uWtPe78fPYk6XMDFsIi+sC12sSsR7hWAI01iUU/B4UeBhpp5yuWO1APRl80MMrCw8nXt
         az93SELSRfONXauqZ+Uu9Ti+fOA7Pypjke+BMgKn4U4EGLjaLw07BFcr+jcIVg2igMLk
         pSTUW5v6OhQ+M89TATX9k5I5KvYJ8rhmW96WrZi1dEP9c3PdkThDfiqqlj7UK7Kra4KA
         h0xyfDDbPGR7k5w6MGeKR3kJW1BJhwPa1VfpK8odK3A3koHsn3fZ4BdVJYU7I54cZqhp
         7pfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=iHRrjC7NGgHX48bIJgJGcmUknIuFtHx4WhnT2MgRlL4=;
        b=eNSnQ7Zb6vGvPkFyifAd8vv49krAWN29vF4iEPGz6uU0cjLngls6yXOkQaJTWnlGLD
         V550kyOeeE+VpdQXXlbLdDmXaCk0elvW5Dn0hEOVVjTzWw2foHE0AzSwDIA1/ex1MbAq
         rgLadUdaE1nunO+GZhVadnjBwCn93JfBzpfJKv6b0c4iVVKjACYXN/8snfv2BH8DFYYK
         1UKVg+MmqbrXoPqS7L1vt0SQ8a9iMgKNEiMbKFiokpVus9bdr0I1Sz7ERmgmM9SCGcVY
         tNN67S8JUwaSC8bFUXIhC03hhi53Tke8PXciD0DzZBiEQyZznpXGEj/tiPsvXtZeDhlp
         UJcA==
X-Gm-Message-State: AOAM530o10qrfe50S3RFnyDw8BHpROl/0VnEFYUG2RHWJBKp4enPeDMO
        73LEB5ruuqc/A7XYpXvAl9TPfJYEeXoJRQ==
X-Google-Smtp-Source: ABdhPJyrbIXiZOh+V+60qXAY07OWSGBpHcV9cLP7AqXSJjdmJ5cpofJ52ZV786SXOXELUk9wteiGSQ==
X-Received: by 2002:a05:6808:146:b0:2f4:748:5588 with SMTP id h6-20020a056808014600b002f407485588mr1704317oie.292.1648645658296;
        Wed, 30 Mar 2022 06:07:38 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id q6-20020acaf206000000b002ef960f65b3sm10264175oih.25.2022.03.30.06.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:07:37 -0700 (PDT)
Date:   Wed, 30 Mar 2022 08:07:36 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: r8188eu: remove unnecessary spaces
Message-ID: <YkRWGCmMytlqgvkZ@bertie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conform to Linux kernel coding style. Issue found by checkpatch:

WARNING: Statements should start on a tabstop

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_led.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
index ccd43accb7dc..4b047c438389 100644
--- a/drivers/staging/r8188eu/core/rtw_led.c
+++ b/drivers/staging/r8188eu/core/rtw_led.c
@@ -278,7 +278,7 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
 			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
-		 }
+		}
 		break;
 	case LED_CTL_TX:
 	case LED_CTL_RX:
@@ -304,7 +304,7 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 		}
 		break;
 	case LED_CTL_START_WPS: /* wait until xinpin finish */
-		 if (!pLed->bLedWPSBlinkInProgress) {
+		if (!pLed->bLedWPSBlinkInProgress) {
 			if (pLed->bLedNoLinkBlinkInProgress) {
 				cancel_delayed_work(&pLed->blink_work);
 				pLed->bLedNoLinkBlinkInProgress = false;
@@ -328,7 +328,7 @@ void rtw_led_control(struct adapter *padapter, enum LED_CTL_MODE LedAction)
 			else
 				pLed->BlinkingLedState = RTW_LED_ON;
 			schedule_delayed_work(&pLed->blink_work, LED_BLINK_SCAN_INTVL);
-		 }
+		}
 		break;
 	case LED_CTL_STOP_WPS:
 		if (pLed->bLedNoLinkBlinkInProgress) {
-- 
2.32.0

