Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F3A58B404
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiHFGJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbiHFGJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:09:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C95120199
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 23:09:49 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r4so5654361edi.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 23:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5I+v5QzSk+bZ7pDEdk0V2aAobL+DUNvbn5oomeG6tvY=;
        b=HeQCo2ZfyOw4W49h46NkhEu6w+zLcUJVhq/30mHdViNiPMyxecNFQaRnNTeFn8H5zz
         ghd8/ZUrSpmwkW7DlPlRp6bXNrJFJNp0udcmU/MernpCLbyMUNCznjdME/WoGKW3lWLA
         9lrZJwnaGRnC420kqt9fyWMeRqBhIkgsF1fkoiNkh+7xJWXSWJv2pWAhnJcZ2255eUK0
         ra/c8jB0vht7yqYEubTjwyzQtMEQDI/GSfol8XKg/t4ka42dTAZVT2Uah8l0DD9J2g3a
         KleAZf5kZ1TYnPqjZ7g5lj7+eaRiIfUXa+nHqTh6l8ck4kdk2XQHPAC8HATAh7ZLNxvi
         Bncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5I+v5QzSk+bZ7pDEdk0V2aAobL+DUNvbn5oomeG6tvY=;
        b=MHag2Wy90kjGGXuKNwj3bYIKlzseu9nsA1i1uvjQOPXDCi4qv7Xqvdwl+MCqojbeQq
         BAn7UQxSQEeZEdLFa/0h+S/tPNtOvMPUKR/Xp5LkYYUsn7Be2HOkhZuYs4VLgYQxsofp
         HDE+Tb/2keOsDngbxrlCWKNyiVl2PGqkIyR54EuVDg93w1yHwIf7noehfFGNSo3T0fXr
         27VHdQXDSYX3r3WQu0zcWbsQlLAps/T/RW/DhAfjVOv76CcchScluBjGfu81iTylUyTo
         snck8MxJgaGAY/hRBCLQjakwFNfyayu2IgfOT4oDKpu9chDs2Kzw/JRCEVu+qmRxcihM
         5i4A==
X-Gm-Message-State: ACgBeo32PHWXPi4EsEwvx6+vCNfR//t4J6ZlYchLpLAutoZJMtESNEAV
        Sx6DGPs+HYj7ZJYFx9fJdt8=
X-Google-Smtp-Source: AA6agR4X086kYSluvhH2r9JDQeydIYZWbBtoDvzYITewnsvHTsK+lv4A0M56P6j4odwzeMx6og0f/Q==
X-Received: by 2002:aa7:d712:0:b0:43d:3651:7217 with SMTP id t18-20020aa7d712000000b0043d36517217mr9328225edq.79.1659766187590;
        Fri, 05 Aug 2022 23:09:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id p10-20020a05640243ca00b0043a7293a03dsm1002357edc.7.2022.08.05.23.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 23:09:47 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: clean up comment for phy_calculate_bit_shift()
Date:   Sat,  6 Aug 2022 08:09:29 +0200
Message-Id: <20220806060929.11022-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806060929.11022-1-straube.linux@gmail.com>
References: <20220806060929.11022-1-straube.linux@gmail.com>
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

Clean up the comment for function phy_calculate_bit_shift().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index e9e24efabd76..a435ec65d4b1 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -12,17 +12,7 @@
 /*  1. BB register R/W API */
 /*  */
 
-/**
-* Function:	phy_CalculateBitShift
-*
-* OverView:	Get shifted position of the BitMask
-*
-* Input:
-*			u32		BitMask,
-*
-* Output:	none
-* Return:		u32		Return the shift bit bit position of the mask
-*/
+/* Get shifted position of the bit mask */
 static u32 phy_calculate_bit_shift(u32 bitmask)
 {
 	u32 i = ffs(bitmask);
-- 
2.37.1

