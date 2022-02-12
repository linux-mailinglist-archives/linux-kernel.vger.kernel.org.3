Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042434B3787
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 20:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiBLTGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 14:06:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiBLTGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 14:06:45 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED0EC6E;
        Sat, 12 Feb 2022 11:06:41 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so8595163otr.11;
        Sat, 12 Feb 2022 11:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+wyT1oWuhI65Zad/t8RG6/bImnXZf7s8T2d26vS6GI=;
        b=YGhM6zTvQvEFbtNdKs7nvs5JGr1cpR1nG8q4CJbylSlOk6dEW9W8r1NrySWlv8MC96
         vt1xN3FnsjRgekTxNLufTWQ8I6TgnbKYdxgeJCOw8mHGh8PuXonS+Ficz3rE5lv95+gb
         bseS8R/m//phWlDNOpDADaTW8IMfbnQO0yYwasvCKl1xMIkbdCutTiKPbh+PMzPGx1ZW
         wEq607BT4LzTG4PaKAuATrxb9u/UGG/pZWRsTI1DfM0ilcEgjmgN5Niw94L87K2n+ZQO
         wwyippn+IzDoK9mJUqT0sgpWGZ20s+2t+Nnzfk3jkNc2ZPx2an4Eq/Kmv+fiiIR5E0Kl
         oZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+wyT1oWuhI65Zad/t8RG6/bImnXZf7s8T2d26vS6GI=;
        b=nj00SMKzvnlGmWbHMGO50MPG4YOuAbNR+aVhp5C0ojpAue+Ir7rGniguGzLShArnDe
         M2WQEDlVkQjvHS2VYvsEWL3BgCDnnPXatZuCMKrZ6VZDELAg5ac6bleE20ybGwjSJ/rF
         lNodp5WQMyRBpYcC4oyl/9/O7++4T5MDyfHomBpXcrQyzJkzBjCInS/DKnKe+tcipfCo
         vLQmY1ET1SQ6rgMKqPZYZfLq+OIBUus0u2QlpwD0H7KWb1v5ryxgJsJdHdLewIw+Mymi
         stskdpM5y5FdtiW62zQ+Hm8cK74C1Pes/PVeGEvMsrp2JwQwPAN14XzyMNvI7IsgYeaF
         pcWQ==
X-Gm-Message-State: AOAM530t2qZHtuhveq1F2FqwITwSq8ymjN2uJAcQ38UCUppMxwYt69/H
        MwM5mhzr+9d6WeIIL1tCxD2ix4Bo9BY=
X-Google-Smtp-Source: ABdhPJym+e3mOG9254+eY2pRWBxCgvdFZKVFYQEpNWTE9t9l4N7IPeG7BEedLpyUfVQXR8Gi2avw8g==
X-Received: by 2002:a9d:1b62:: with SMTP id l89mr2450448otl.368.1644692801119;
        Sat, 12 Feb 2022 11:06:41 -0800 (PST)
Received: from localhost.localdomain ([2804:d51:4934:ba00:3201:7b94:7a78:8d5a])
        by smtp.gmail.com with ESMTPSA id bh7sm7654217oib.6.2022.02.12.11.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 11:06:40 -0800 (PST)
From:   Marcos Alano <marcoshalano@gmail.com>
To:     dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Cc:     Marcos Alano <marcoshalano@gmail.com>
Subject: [RESEND PATCH] Correct the name for Xbox Series S|X controller
Date:   Sat, 12 Feb 2022 16:05:21 -0300
Message-Id: <20220212190520.1752354-1-marcoshalano@gmail.com>
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

