Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A64B917C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiBPTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:41:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiBPTlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:41:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6703B2B0493
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:40:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so5832679edn.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJs3wZPlit28Aegqoi78pEIwXS8QXed5MWvYu0xvZbg=;
        b=Fp1uM02j+TYjGS31e1VCPfXg6fT0NKA1apVGS9w1+829yEnKXvnGdYVrOgUCp7p4Wp
         feXTS6zsV/kkzY2LjlioJrsUcSwjWH0A/0Vlp9ZKajBjaAIkp5BV20Z9tb51s8CLvzkg
         qjqNdE2d1yIH5HDSp/kYhZMDJ0+TYUvtWZKlO7U1ZAIJKvu/P6Rj63ljESDdZGNxS4EZ
         5gYNwoMVT9+gpUWsJi7mxb9rObUM1YQAoRfUkFjrcfXci8XBC7Nc6MFXlh9iWlkfqvY8
         bb/7UQcQVm1MyKF5rXQwEshuY2PJTFNCV2fmFuABlAhlfdtlDEQbOnObeNVsKTu/JtZ1
         4dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJs3wZPlit28Aegqoi78pEIwXS8QXed5MWvYu0xvZbg=;
        b=Td32OT8t8ItzgtXUACxFWbtcu/GfTag0PMZl5X5DSUqajDIBIyBkOHAZhbboWZY0qz
         ywRyX0oA6qwJ5CNv/eYoGvsPc/I3agAGL7iudJEQYuKPkPoRABhWeVCAXLs56EQ+l0+P
         Q7sRKPzKoaAwPeK+ZZQPgev4uzFPAQwsoqCH9+KHJz7YJIA9+5KqqZ5aE8E9arDEz9pJ
         q3j6xEsQQEt9cDiXJM9VLwPl9auxT8JUyik+5cXk6VqDKA/ubTELtzYhsQLz3gSEFKJf
         0/8RRgHvCQ0mtH2w8rq1+c8dLPTZTGuIFBZmgbCMCcAL/IXUnyDfcfNzjU3vPCyOHzwn
         4rZQ==
X-Gm-Message-State: AOAM532KBL3LULHBU7uyDhyTbONj3e2nH4vyVjjp1Yk+DBPMkUSDLgy9
        EnRBs4goXQQOIHd0j+HYV8E=
X-Google-Smtp-Source: ABdhPJxG87pANgnSnKv1kyrdeZ8E03fWeAZcr7r+P6afhuNU7TN961B0EbomRbxiDwEvbcplwEI9NQ==
X-Received: by 2002:a05:6402:5108:b0:410:d312:924 with SMTP id m8-20020a056402510800b00410d3120924mr4549999edd.430.1645040447067;
        Wed, 16 Feb 2022 11:40:47 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8c.dynamic.kabel-deutschland.de. [95.90.187.140])
        by smtp.gmail.com with ESMTPSA id z18sm276910ejl.78.2022.02.16.11.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:40:46 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: remove unused enum
Date:   Wed, 16 Feb 2022 20:40:36 +0100
Message-Id: <20220216194038.6762-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216194038.6762-1-straube.linux@gmail.com>
References: <20220216194038.6762-1-straube.linux@gmail.com>
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

Remove an unused enum from usb_halinit.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 3b8869455166..ca2833d3e7dc 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -484,11 +484,6 @@ static void _BBTurnOnBlock(struct adapter *Adapter)
 	rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bOFDMEn, 0x1);
 }
 
-enum {
-	Antenna_Lfet = 1,
-	Antenna_Right = 2,
-};
-
 static void _InitAntenna_Selection(struct adapter *Adapter)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
-- 
2.35.1

