Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC95B2D9D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIIEm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIIEm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:42:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F52E2938;
        Thu,  8 Sep 2022 21:42:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z9-20020a17090a468900b001ffff693b27so441574pjf.2;
        Thu, 08 Sep 2022 21:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=JDjtSG+gwH2qlwCxPBWJXUQX1Nbq4myEQelim1fY0Pc=;
        b=VQ6VPll3U64mkMC+BFqUyttE+g/p68TnAR5OXibzYR25rbASMItXUwGiLg/B3AgTeK
         KRhvv+5Pua2aljA/Rb79qbTzXwGxkbV+8lBKJpyYIHFG6Vd7H35NItzHSsDZN4BGXief
         bUNDX8rSfZGeJODtQZPZB2cxM2oeQdaTWwGhZpM0MODyK5DYWss5QPAt0reL15FHzLSG
         dSij9GdsXgieD+IR2SaWp/RrU8011KvMjnqbF6NmfGNKfpxc3PgCn4oRcvVJ+MpAhxPR
         eGLFzqcRjdTzWnOXNtP9eYpnzpU2PjAfNjtCweK6DLBzXQPYIAWy7XUP7I4Zwr2P0iuE
         7Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JDjtSG+gwH2qlwCxPBWJXUQX1Nbq4myEQelim1fY0Pc=;
        b=6NZb9dqWuDGCczX4YoWAWFa89UaFoeP3qllIhUu9X4YY5fAXJBPq5vPEspeUZUua+L
         GvT/JOpoilFI4B/PgoH8fkjOD3nS1kUCyL5Ffb8n+gUcBT6uk7ucPLiXMkjRfpFtgkI3
         78NceF3jtNOUHo8YjRRFMUt1wxveLVM1dgVys3kNbhzIcD/VaZH8c+EOXZQmDynUlgOc
         WMey1cXm8kQSupb6W1CmgNzxXgbBDFy67qZoyKmAeX0AjYPWsLi3rYbnJHEKMVb1Hjnv
         Uky95GCaCP3GhAA+mT35KCupvwtfcO5Sq3Ysvr2IEL7IKgjhg71Rzp4Fgbk4tAft6MBO
         nTAw==
X-Gm-Message-State: ACgBeo2fWJAdi34W+7+BRxOgD18nthgbdCdvefvfNkr0+/mDt8VOiE6u
        gPNl/i+mL7uYDwwXQvUanVTMSLYzOO91Jg==
X-Google-Smtp-Source: AA6agR4bwJ7gNhAuPVwXBe89DSzVafG+uVaSe9IpJXzP+Jm0eI+Da57EusV7fC4NMP4HYZMgkA2SWg==
X-Received: by 2002:a17:90a:4105:b0:202:80ac:4686 with SMTP id u5-20020a17090a410500b0020280ac4686mr3377855pjf.154.1662698544226;
        Thu, 08 Sep 2022 21:42:24 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id lw2-20020a17090b180200b00200b12f2bf5sm10569097pjb.1.2022.09.08.21.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 21:42:23 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heghedus.razvan@gmail.com, evgreen@chromium.org,
        yuanjilin@cdjrlc.com, stern@rowland.harvard.edu,
        jj251510319013@gmail.com, gregkh@linuxfoundation.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/usb/core/driver: check return value of usb_set_interface()
Date:   Thu,  8 Sep 2022 21:42:14 -0700
Message-Id: <20220909044215.2620024-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check return value of usb_set_interface() and report error if it fails.
Otherwise usb_set_interface() may fail without any warnings. 

This flaw was found using an experimental static analysis tool we are
developing. Report warnings when the function usb_set_interface() fails
can increase the dianosability.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/usb/core/driver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 7e7e119c253f..ee375b5eafe6 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1332,8 +1332,10 @@ static int usb_resume_interface(struct usb_device *udev,
 
 		/* Carry out a deferred switch to altsetting 0 */
 		if (intf->needs_altsetting0 && !intf->dev.power.is_prepared) {
-			usb_set_interface(udev, intf->altsetting[0].
-					desc.bInterfaceNumber, 0);
+			status = usb_set_interface(udev, intf->altsetting[0].desc.bInterfaceNumber, 0);
+			if (status < 0)
+				dev_err(intf->dev, "usb_set_interface error %d\n",
+							status);
 			intf->needs_altsetting0 = 0;
 		}
 		goto done;
-- 
2.25.1

