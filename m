Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6874B354F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 14:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbiBLNeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 08:34:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiBLNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 08:34:02 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2306522B15;
        Sat, 12 Feb 2022 05:33:59 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id u13so12655650oie.5;
        Sat, 12 Feb 2022 05:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+wyT1oWuhI65Zad/t8RG6/bImnXZf7s8T2d26vS6GI=;
        b=gLSbeYhwGwkcXyLJKOhGJ1gPIApGeQKBWZzEuIZFY1jaEVb9CYhpHAepSHmjWxUqBB
         +ob92FTKpN7PKU4Clqh9aasZJ1inJeASbnRUUlaGUylX/4HmIDSKnF324FMqQxEZcXV2
         Rd0lX0QDQr/JskJSzilVYr5aOoo+P94d1mT2WMkGFW/9IXDvM+n0Kj6dG/VA/VXo/mzY
         XnSsTGWh242NHYo93shXrj12pKy2EeJmqecYLBFxspdQdqUokWwd24Uw3b52Z/DhYhVt
         R6oImWr/urvLOEHvSZssu1oqY7ISL8oX1zoa9oc4NrWMCayo0Cyf+WqHQOJOfCOOSmU9
         pt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+wyT1oWuhI65Zad/t8RG6/bImnXZf7s8T2d26vS6GI=;
        b=WFSOZ2hDf0c0HN8B6jyDCP9gqlnZp9kvcKSbZW6C9Vg9hYPVGcROYs2q9bIgAJm3wZ
         R3GygCsZfdizrt5PfOr5ZTQrURRnGp/afFnfKAxhKdIwKzYzEUW0AjwI8tbIayhGkkC6
         eiQjQKwOe+Ya/a5YfufdZn9gKUemEKFnmqRpwYSRmLSnl9t/OKmlUsln2gaCLgFSzZlI
         MojTcWZ/tkyJIsXlI0AORmb9J7qsFqI1+de5KPxzpUCo8JnLHD/5/uB2YlhZmCgv2zme
         LSKduot4dOYGbl4mPxsbCSgHklDtmLQyXM1cdsMkEgIhUwi2oG8NAIrk1pC8HA32bc5C
         ZKyA==
X-Gm-Message-State: AOAM530mjbv726BAaJ57OE0zKHjRFPkVg3WvQ0k2puO/dFCwNR5FIf5M
        FqNX13lWq+NxgT1fLadlPVT+F4olW6dZpQ==
X-Google-Smtp-Source: ABdhPJyNnhmRTvEIFjo5TjSWNWvTd6jrihUL2ibDHeir2TmC2fFqn/j0PMzSqxjemGAtqYsolODvLA==
X-Received: by 2002:a05:6808:488:: with SMTP id z8mr2307220oid.220.1644672838406;
        Sat, 12 Feb 2022 05:33:58 -0800 (PST)
Received: from localhost.localdomain ([2804:d51:4934:ba00:3201:7b94:7a78:8d5a])
        by smtp.gmail.com with ESMTPSA id t21sm10492701oor.4.2022.02.12.05.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 05:33:57 -0800 (PST)
From:   Marcos Alano <marcoshalano@gmail.com>
To:     dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     Marcos Alano <marcoshalano@gmail.com>
Subject: [PATCH] Correct the name for Xbox Series S|X controller
Date:   Sat, 12 Feb 2022 10:33:47 -0300
Message-Id: <20220212133347.1606190-1-marcoshalano@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Change the name of controller to a more meaningful one.

Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
---
 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 4c914f75a902..18190b529bca 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -131,7 +131,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
-	{ 0x045e, 0x0b12, "Microsoft Xbox One X pad", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
+	{ 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
 	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
-- 
2.35.1

