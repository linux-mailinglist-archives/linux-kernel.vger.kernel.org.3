Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5B4816D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhL2UwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhL2Uvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4490C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:40 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so7415221wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RYLjV/KsTSydN7cpKQfVD7hNP0rRNeSCBgS7kcgCQmE=;
        b=DkUAFMhlYQXgbNx+AjtbaEhrxXPxTEAhzrIDs3KBbUzIGx9Qhj18rdUQ96yrJgpKYx
         Ezfywnsj6TyTfmj69qrd8A68maDw4Xe16ZmKMXSkBfVL4tjMUrdM6tsTFRU0nI+2BQEi
         SIGL9ZhBZnAKnllbvjsFpXvkXB0a8I1JFNdZWErRDw0ULTyok24snuGfJxQ61L6cryFx
         7aRYArkU8HVOrzXsemDabUhDTuj6cfEXqJh6fD/5f/EWw7koa549lb52IU6B9y4Aw4tW
         rwNqO8FrKUh3Lh7cULaxpZpejtDc5Q8h2PaHS4FOkHu9CkTtG9Bvft3wD0Hb4WlcEjjr
         blNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RYLjV/KsTSydN7cpKQfVD7hNP0rRNeSCBgS7kcgCQmE=;
        b=mKF1UC5m5CVBhveySd7VPZEDncPGVdyWh+vLDBZ3fL8Eko1eJVRF/1IMFOlq0CwRGo
         l22IDXrdfl+K8bfiZ9ykdqS3rrvo8sZ6tR958060FjlZoCW8u0gI2LHrRLKW8wiYgv48
         zrn7vhcHh+EW7cPIv1MAfdbW5fBRk6MKeoRJ4u/dH9gOYVxbzlNGSavQxxRoZINIo6I9
         ALDHC5WyBgbBVvANKBqvl3N3SevgxF0QAr8MR73jZPPWxb9CXvmyrIDBlWH+wpdSIjCO
         xZBrpATGxJXxaDHmJPDx9CQwe0RZFppRAE/WXRKDEj1EImt4NsN7nd/FUxtn/XDxLddh
         kqBg==
X-Gm-Message-State: AOAM533rF0ZngZmk6EMe8vVL/Gck0qZT9VFPiIAiBClzhlx8tqdlXKlI
        csM0r15jhIitpmF7b/6J0D8=
X-Google-Smtp-Source: ABdhPJyOdfC8KhiTiLj0hrDkzqCjnb/WGqoY9W6CPCX6638Hq5YePXVFIeoW40P/fqgsvFCu7KcjnQ==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr7138529wmh.118.1640811099477;
        Wed, 29 Dec 2021 12:51:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:39 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 18/32] staging: r8188eu: make odm_CommonInfoSelfUpdate() static
Date:   Wed, 29 Dec 2021 21:50:54 +0100
Message-Id: <20211229205108.26373-19-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_CommonInfoSelfUpdate() is only used in odm.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 52 +++++++++----------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index d62ae3e021be..94ad1e5b9804 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -311,6 +311,32 @@ static void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
 	pDM_Odm->RFPathRxEnable = (u8)rtl8188e_PHY_QueryBBReg(adapter, 0xc04, 0x0F);
 }
 
+static void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
+{
+	u8 EntryCnt = 0;
+	u8 i;
+	struct sta_info *pEntry;
+
+	if (*pDM_Odm->pBandWidth == ODM_BW40M) {
+		if (*pDM_Odm->pSecChOffset == 1)
+			pDM_Odm->ControlChannel = *pDM_Odm->pChannel - 2;
+		else if (*pDM_Odm->pSecChOffset == 2)
+			pDM_Odm->ControlChannel = *pDM_Odm->pChannel + 2;
+	} else {
+		pDM_Odm->ControlChannel = *pDM_Odm->pChannel;
+	}
+
+	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
+		pEntry = pDM_Odm->pODM_StaInfo[i];
+		if (IS_STA_VALID(pEntry))
+			EntryCnt++;
+	}
+	if (EntryCnt == 1)
+		pDM_Odm->bOneEntryOnly = true;
+	else
+		pDM_Odm->bOneEntryOnly = false;
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -434,32 +460,6 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 	}
 }
 
-void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
-{
-	u8 EntryCnt = 0;
-	u8 i;
-	struct sta_info *pEntry;
-
-	if (*pDM_Odm->pBandWidth == ODM_BW40M) {
-		if (*pDM_Odm->pSecChOffset == 1)
-			pDM_Odm->ControlChannel = *pDM_Odm->pChannel - 2;
-		else if (*pDM_Odm->pSecChOffset == 2)
-			pDM_Odm->ControlChannel = *pDM_Odm->pChannel + 2;
-	} else {
-		pDM_Odm->ControlChannel = *pDM_Odm->pChannel;
-	}
-
-	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
-		pEntry = pDM_Odm->pODM_StaInfo[i];
-		if (IS_STA_VALID(pEntry))
-			EntryCnt++;
-	}
-	if (EntryCnt == 1)
-		pDM_Odm->bOneEntryOnly = true;
-	else
-		pDM_Odm->bOneEntryOnly = false;
-}
-
 void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index b92e5b68161e..e6e6c7c49130 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -35,7 +35,6 @@ void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm);
 void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
-void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm);
 void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
 void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
-- 
2.34.1

