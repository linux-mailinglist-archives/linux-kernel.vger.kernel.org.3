Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A00468B4F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhLEODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbhLEODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:03:01 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7B2C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 05:59:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w1so32026686edc.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 05:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Woq3HlHO11za/Z8dWOzGeHMcMYdN1R19HxtEMwFIAg=;
        b=N4oJAjk6+V+5Oh9/bZA4bR9NI8uGFmDf0Za46qdJUZs5Jsz2TPEalWRJh82s9lVPhd
         EbTLXPYZ71FyIiEP846aoB8VygKe8ffZWenStW4lKExavzZ6ZK68LyjQvkNmYny/AIZ6
         xwYRQM38A0IWxJbI0PZoJq7t20w0mX/TVZosGzkWR9D4RJSL5TRjxsmOX05nEkmhAyCC
         qWnEkiW1lfn0Zq+WwwiZ6YNd1wjSUQhN3/BxszuTYlOHrqGTTasw6uaLzaLT6IHGOneQ
         6499RZVEzG9GY5TdFqhlbDuzFGP7TbpuevIczwWOqLAoDman7xFumR7+YRu1Es7aR2Ck
         zJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Woq3HlHO11za/Z8dWOzGeHMcMYdN1R19HxtEMwFIAg=;
        b=AdbBic1L/5UndfJA82C8DJVQy6nkMz6YZDfLUYfA5UvkzRF8nlU/MlmyRZ0dMtMqmW
         li1sIaz0UYOiyiNoZ2xprFgKUGa3p3ZUqAusIECuwKGs7a21LdB+99z5MjbRRnSJhvlV
         iGtTi4JngrGmlQd0pXNvUz7JV6ICoF7Dpj44bw2IXGCyLZFo5wQhcbBFsGLZn7jrEtjZ
         GPZ99om/F8A0tIA2sdD01y8HNQIK2RUMsUMvpcTQ9O7ChMs++IpUX3DIEYMC0kkZ1W4Y
         bT8BYpYsID7DgmkeyZaL2oQDuuXd4SYXkwYhewGtU1QKDa+tHrMIv/2RYlSnTRzx9wPx
         5E0w==
X-Gm-Message-State: AOAM533mPuLWFRUDH/HqmbClDFksj5exJP5NJ9phbDtYVqpy1qhVsYoJ
        FSyBnYl7GQ5/Nti233DM9Vg=
X-Google-Smtp-Source: ABdhPJwVSqLsF7seQb3loYSztRDEescEwXD7kSzmUYOU3NW7DrwiLY6dMYrQRoGl/8dO29VctB+rjA==
X-Received: by 2002:a17:906:e28b:: with SMTP id gg11mr38796707ejb.23.1638712772569;
        Sun, 05 Dec 2021 05:59:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id yd20sm5146451ejb.47.2021.12.05.05.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:59:32 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/12] staging: r8188eu: remove duplicate defines
Date:   Sun,  5 Dec 2021 14:59:14 +0100
Message-Id: <20211205135919.30460-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205135919.30460-1-straube.linux@gmail.com>
References: <20211205135919.30460-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following constants are defined in three different header files.

IQK_MAC_REG_NUM
IQK_ADDA_REG_NUM
IQK_BB_REG_NUM
HP_THERMAL_NUM

Keep them in odm.h and remove them from Hal8188EPhyCfg.h and
rtl8188e_dm.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 5 -----
 drivers/staging/r8188eu/include/rtl8188e_dm.h    | 7 +------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index f4cfd11b36c1..addc6a5354a6 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -11,11 +11,6 @@
 #define MAX_TXPWR_IDX_NMODE_92S		63
 #define Reset_Cnt_Limit			3
 
-#define IQK_MAC_REG_NUM			4
-#define IQK_ADDA_REG_NUM		16
-#define IQK_BB_REG_NUM			9
-#define HP_THERMAL_NUM			8
-
 #define MAX_AGGR_NUM			0x07
 
 /*--------------------------Define Parameters-------------------------------*/
diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
index 208bea050f6f..0b3a9a1a4e5c 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_dm.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
@@ -8,12 +8,7 @@ enum{
 	UP_LINK,
 	DOWN_LINK,
 };
-/*  duplicate code,will move to ODM ######### */
-#define IQK_MAC_REG_NUM		4
-#define IQK_ADDA_REG_NUM		16
-#define IQK_BB_REG_NUM			9
-#define HP_THERMAL_NUM		8
-/*  duplicate code,will move to ODM ######### */
+
 struct	dm_priv {
 	u32	InitODMFlag;
 
-- 
2.34.1

