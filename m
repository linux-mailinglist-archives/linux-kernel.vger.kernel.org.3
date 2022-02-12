Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB024B3790
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 20:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiBLTLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 14:11:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiBLTLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 14:11:07 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1B606C0;
        Sat, 12 Feb 2022 11:11:02 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s24so13304078oic.6;
        Sat, 12 Feb 2022 11:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+wyT1oWuhI65Zad/t8RG6/bImnXZf7s8T2d26vS6GI=;
        b=htWbLaH9jrdukXZQn3kET561OhRCR2atyzhsWS+EQz7DmIUXFR5c2TRWLs5kezww8O
         6suXc9uduEyHyu849z2fgsDEfv09QbbtHzJ9DP6Sadf+pIHfmy11Dfs20xL1MBeKK5S+
         okRPPWFwZC9oRAeTkh50w+MrYqSwd319c5yC9cbOmE5Ae/zqoP4DhyR7mgFVlIaBOPQL
         gylHLzWKsobfuOuN8kVQnx/eSu4eOnfooCbgNMFNB1UE63D8nDs4dObARr13T+W+ADUz
         +LU3CTW64BhXVlInM4OjMkHson8sw0ktyV2KxV7Sdg1Ui2/q143K5qeCKdl9d6Hvocyh
         CS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+wyT1oWuhI65Zad/t8RG6/bImnXZf7s8T2d26vS6GI=;
        b=kxEZFa4neAERHaBky20DACYAkacQDQUZ47I3AmicCDRGwV8umtPCtLUg3qU1IlxuFU
         YRfRZnFEoJ81+YLht3wZOLf/mvP735zAU1zvUrpx0dybJVL0PlwJpDXdNrycBVcvteNp
         LpJWC6vqU92U9sFFWRgFbW9bOPJ9wxVybMXWr0tZmqB3HNoooIHA7/veNvFII5Ir42AC
         AIQpOLQvRtNsLFfz4znhgL7VS8JAoFw7HSQHw9zNhX5RDF3szCGVAqCLO+jhebmaozEp
         aPstbXSGeiLdRnVt8IN7TpbcUbgNHVZoAkzTTZUwv2vmE1UGWhkYK6QpyAqIydzZq2Hd
         SF1g==
X-Gm-Message-State: AOAM532aiHLWEOc8gUCfIROYw6NpWCCw7c0KfpkCn9HZj6H/fbnDcYaf
        dJiElp4cbwIA9zHruZF8kBikH7x0YzQ=
X-Google-Smtp-Source: ABdhPJzYJeMksw8FP1YFbv2yDzvSULuewk2mdvSFccVFVVLkl2cIh/v4dySfbTv+5u5ASh/ejRb5qw==
X-Received: by 2002:a05:6808:1983:: with SMTP id bj3mr2618250oib.313.1644693061731;
        Sat, 12 Feb 2022 11:11:01 -0800 (PST)
Received: from localhost.localdomain ([2804:d51:4934:ba00:3201:7b94:7a78:8d5a])
        by smtp.gmail.com with ESMTPSA id e89sm442798ote.54.2022.02.12.11.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 11:11:01 -0800 (PST)
From:   Marcos Alano <marcoshalano@gmail.com>
To:     dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     Marcos Alano <marcoshalano@gmail.com>
Subject: [RESEND PATCH] Correct the name for Xbox Series S|X controller
Date:   Sat, 12 Feb 2022 16:10:15 -0300
Message-Id: <20220212191014.1754721-1-marcoshalano@gmail.com>
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

