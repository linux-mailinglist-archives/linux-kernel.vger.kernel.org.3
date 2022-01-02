Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C45482B5D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiABNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:12:01 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08BCC061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 05:12:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id b73so20017170wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jan 2022 05:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EUDmwLB5yfmQWSSlq3AiM8nBbJjWg7Qwk3bKLu8jt3k=;
        b=Esxg6cQdaodcxTky+8Nh9rJjStVomTlq9ZvvbyQzEoKlYGot0j40UehhHkVOYopffJ
         cUKtZh9TAf4OfecffriQOLc5PksEU11oUBT1/MMAvfDEgmPmmGIw7ATuFV9gze5t1QS4
         N69lpf8H6+RieapuKogeZ29cMsk56jTPWO6b/nIqCzNq3gMBs6K2GxNvXVvNtL8OXUpU
         oluL2FQm5FKIAN8V/Ke7/8jK3IukFF1Nwj2FjHuwRTS2tV6tPJWva+0hIjGWDa7YZ2hr
         rUr2+QSgfp2NoWDF5IyDSUOtD5APCVHRkjyj6H3Vw63IolNcuxa5hb6dAmadNm3prbFn
         eLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EUDmwLB5yfmQWSSlq3AiM8nBbJjWg7Qwk3bKLu8jt3k=;
        b=zVOxgZoHprY9A8gOuabSZkb+0vFU4RZ2fZ1ELZkjFBt4g95phPLqMKNuxp8x1t3dYm
         k8ZXgevUevzl2ToPxXmjNwMe1lQ/Hd4b440CB/pIAgwsNPwtoMh/eIe/yK8YZqjVsQLr
         YPgVsZMsAvCQDVw6M0oL1FwEQEGM/g1H9xEOuG4lBBQ8cjAFZk/KpidywTHnDnIOUW2g
         sEDPIJxzAzJX6S2H50vzDUBHszl8PS3SN9wzAdNwFDisYrLq5FXeLXToS3MUE+8jiZjY
         ErrXNl/QGKzHh6Quh9eg+etVbCydIGvi6Llt8ncqkLEz1Z/2v4c5JTSulSUUsrEmxvXN
         exeQ==
X-Gm-Message-State: AOAM533kvBKTx6hBKdjmeMa0ZnfqHI6ygUcquZNJJOMJW+jpQYXNRpm1
        LByoZrWDNJZxi011cNhuZBc=
X-Google-Smtp-Source: ABdhPJy5JSVb+QPzwJ3GproL+IzsO2wngO2+0p6goHTf6j9NRgimdF9shxEZ53eZWCoq9J/LD0UNAg==
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr35936082wmq.152.1641129119455;
        Sun, 02 Jan 2022 05:11:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id m35sm65640044wms.1.2022.01.02.05.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 05:11:59 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/11] staging: r8188eu: enum hw90_block is not used
Date:   Sun,  2 Jan 2022 14:11:38 +0100
Message-Id: <20220102131141.12310-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102131141.12310-1-straube.linux@gmail.com>
References: <20220102131141.12310-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumeration hw90_block is not used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index addc6a5354a6..fe6111fe278e 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -17,14 +17,6 @@
 
 /*------------------------------Define structure----------------------------*/
 
-enum hw90_block {
-	HW90_BLOCK_MAC = 0,
-	HW90_BLOCK_PHY0 = 1,
-	HW90_BLOCK_PHY1 = 2,
-	HW90_BLOCK_RF = 3,
-	HW90_BLOCK_MAXIMUM = 4, /*  Never use this */
-};
-
 enum rf_radio_path {
 	RF_PATH_A = 0,			/* Radio Path A */
 	RF_PATH_B = 1,			/* Radio Path B */
-- 
2.34.1

