Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107794B2BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352187AbiBKRcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:32:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbiBKRcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:32:53 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7DF313;
        Fri, 11 Feb 2022 09:32:51 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r27so10318437oiw.4;
        Fri, 11 Feb 2022 09:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+wyT1oWuhI65Zad/t8RG6/bImnXZf7s8T2d26vS6GI=;
        b=g6zuw8ukKlTvcbYbOJvN9UU28reWfcDSOsjeaLsnbT/SnnHrf9sL491GAH86Rmz5aX
         n+rADKqnIEGOCBSVaXpCO4f5iKuF9YcFx6Yc4A2VACltceaomiDFBfe1FBwhJAjLp6v+
         BQlZPq5hSLwCMnSIiHmkA1nJEkwCXhvYckeE8AQkM5zA/BvrP8CZrY02XTrhCTv0jvMI
         mmM+A4P+viR4mMOt2da/Z42tjR/STcyyAV3u7PQjGxMHU6YW/cC0l8PHSz1SW7O6CbFU
         3gNupCiFfKejGEgDpvl5p6y5/sjA+fuSworBYuCN1tNMwVChvsvQgpJZgNQMhLpXNAVk
         vWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+wyT1oWuhI65Zad/t8RG6/bImnXZf7s8T2d26vS6GI=;
        b=5fkuhR1C8YLbQsOaJC9tP/CkwUFXXjv0dgFb+0gHsSlEvWulMbYXq9DO+XI6wLLB03
         Z6fxGFMcyiSc67RbjCRB/sWzGB7u+4kS/h72ns23ssrDblGYH/j52BbwisYokhTArnLa
         v8JicpzFGwcsg/22E3b4aVYTqEQix1AUtnx1HPaCTHzGRMhFnI46CEJFdMreCH4cUpy9
         LuvajG4PfiGz0K9W9GaVR3kIQwnYvYDH6FXM+PuMiddVaGmEpVUbWggHdqyTyQmiMenv
         CtMjTvOL5O+Q81iguKvBwLiPwa/2JKoGg7oYjmci2jJP+eLGUcmV9/H/Hfrt3x6A+y2Z
         u6YQ==
X-Gm-Message-State: AOAM532jN858P/MZjjsGkcAARlU1G+Ohs8pMFlg/Ou/19kqYVdYKhyAN
        i4ja2dIeUY7IGocN/0fPscwEZZX8eDZagQ==
X-Google-Smtp-Source: ABdhPJwspX4Nthj3g0bIF9RBbZ3fm+EfCLVhWUmmCDg7htTjbBt+00Al3v+DTJrDe/DRxQaL3Hqe9g==
X-Received: by 2002:a05:6808:2204:: with SMTP id bd4mr656487oib.329.1644600770985;
        Fri, 11 Feb 2022 09:32:50 -0800 (PST)
Received: from localhost.localdomain ([2804:d51:4934:ba00:77f0:a455:37a3:1b62])
        by smtp.gmail.com with ESMTPSA id f21sm9314373otq.4.2022.02.11.09.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:32:50 -0800 (PST)
From:   Marcos Alano <marcoshalano@gmail.com>
To:     dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     Marcos Alano <marcoshalano@gmail.com>
Subject: [PATCH] Correct the name for Xbox Series S|X controller
Date:   Fri, 11 Feb 2022 14:32:25 -0300
Message-Id: <20220211173225.1165722-1-marcoshalano@gmail.com>
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

