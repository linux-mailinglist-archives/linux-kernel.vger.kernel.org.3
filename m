Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32D4816CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhL2UwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhL2Uvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3D0C061746
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:41 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso12313496wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVYrlpfJgC3IdZnqoKx33nCnJZO80bvNlUR0uFaOeys=;
        b=DduON4OO/1m2/LbPxu2Rkvdhjvx+xRhFiAAsKedQpumsC5G/Aq5AS0ap/Vh/tP1vmI
         AQYUiMwXb+ooz6EWE0BWtEkHJ1qYfu5jx3RTLhSb0WQfi2EG2MDFfJfR9b2GYJvNbCcW
         fdtg5FtfWF+qxBBh6TcPEi1P4Kl3RnIgTwRkOsdZhLrGvcYiWv/nzRl8aXfm+Unu/kZt
         Y1KFv2JG0QtshIwSKA3YZ0NMNKjhf4rIvD7K50Qh0kJCKh+I9mCYIlgMy04OuUqExH8X
         dSHLHCs9ts3ujLMML85738wka2b90g4soeu1PLHG6PtOC+h3/bH2hhvgiKg53d+jWUNy
         PAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVYrlpfJgC3IdZnqoKx33nCnJZO80bvNlUR0uFaOeys=;
        b=oJS2jNPWmvNDkwYBg5rdug9S0l/3zxWoghtLqkQB4S8pa5UemrQyIRmDMiT5vGxntx
         fGedoxuK0Bi+wDxc/Yp2P16e9MME+8LiwZ8rJT6cwIIrkwlbTtgXWLgOsXwMPtWoH4gB
         i1cdMW2ZmwdgxOwSGgUIr+wf4tJ/T2VTdzKYW/XmEgpfmf/+TJwFwWbdjDhvGSMVDF6+
         7vmf/YlNRAzfSkb2/dk75OJv1GMGBPfPfp2qjcQuJ82EeQB2jPkL1251RsXE9Vzspp1e
         HKjHSsn58j/b+2uK3mVexjstSp+AffAJ5DyLgK4LxcdgIfHE152YX3JhY2TEkNBFpNKX
         muaA==
X-Gm-Message-State: AOAM533mx8R7I74tQYKUdLw7oKKvE+02aBu/caOpMTLZy6aX7WDtk6/n
        OX5jB4WusC8hcVPY1NGgeX0=
X-Google-Smtp-Source: ABdhPJzkqiqxSo2V0MykxnlQ4tjs4fbP8X7+/jUlcz6FV1RfWEW0EZ4GV7iyHPEclBBuTd+utOYcpg==
X-Received: by 2002:a05:600c:2150:: with SMTP id v16mr22854750wml.10.1640811100180;
        Wed, 29 Dec 2021 12:51:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:39 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 19/32] staging: r8188eu: make odm_RateAdaptiveMaskInit() static
Date:   Wed, 29 Dec 2021 21:50:55 +0100
Message-Id: <20211229205108.26373-20-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_RateAdaptiveMaskInit() is only used in odm.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 18 +++++++++---------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 94ad1e5b9804..7394dff4f7ff 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -337,6 +337,15 @@ static void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
 		pDM_Odm->bOneEntryOnly = false;
 }
 
+static void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm)
+{
+	struct odm_rate_adapt *pOdmRA = &pDM_Odm->RateAdaptive;
+
+	pOdmRA->RATRState = DM_RATR_STA_INIT;
+	pOdmRA->HighRSSIThresh = 50;
+	pOdmRA->LowRSSIThresh = 20;
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -646,15 +655,6 @@ void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal)
 /* 3 Rate Adaptive */
 /* 3============================================================ */
 
-void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm)
-{
-	struct odm_rate_adapt *pOdmRA = &pDM_Odm->RateAdaptive;
-
-	pOdmRA->RATRState = DM_RATR_STA_INIT;
-	pOdmRA->HighRSSIThresh = 50;
-	pOdmRA->LowRSSIThresh = 20;
-}
-
 u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u8 rssi_level)
 {
 	struct sta_info *pEntry;
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index e6e6c7c49130..bb4ea0b57f08 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -31,7 +31,6 @@
 #include "odm_RegConfig8188E.h"
 #include "odm_RTL8188E.h"
 
-void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm);
 void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
-- 
2.34.1

