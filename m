Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABAB4816CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhL2UwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbhL2Uvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:45 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D588C061748
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b73so14380519wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sYWhROV3J/dITq6IQ2WM54SGEN8Pa5CA7vyqizdoDJo=;
        b=g3j8V9HI+zmxeGUf0AmdTSwkd5A3NIpf90l7o1y9tBfmeLDVAnfoZHsX72qg+RgwCg
         WWu+ASx/OIozQf/ZbXFPmQ3/UHbhGt4DPq8JCzgDOWX6pobXWyUpqHjD4cJkh9ANw9Rr
         mkLpBgXd1J0yYkZ2EVx6Zpiqu7bAy6BO/A6S6Y69vNDDFn29c9HyZAQ9BG2jhUKinzWm
         NXH8HIQys31HFQv1aXIQK9GKSGMM5AFlQTYH63q+6T5Q56wT8gV3AhyrrEknEg+W71L0
         Ocwl24yoGg1Vw1Tpy3t7DlixMxBK5nChnGJqg1iG1eFTi5pSirFfCOuAR1aXpcSYY3Hk
         Sqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sYWhROV3J/dITq6IQ2WM54SGEN8Pa5CA7vyqizdoDJo=;
        b=fnkPl2xcJDnlJ81p0kGCubns4LxqAeiZvO92/iQxV5DTs4//UY1HEGt5/YGf0T9gvl
         3CPJucEStvI8ZRCTXSZDMcKIUdWA7xRgAbUo5g12NAx3/uuoyrq6hCZfO+gpiGJbcUlf
         s4E0SOQgLcsZ23BlbJ64vjvXj8DWyQCvMtX8nW4dJkc5z6atZF5bzcKlTe1rZCh+JCiF
         rcQjtXiug20xPJp28JDxLUUIBZe5D+0HAaMCYpoukDkYP+NEiJPWlP3aacC1qec+Zl+F
         usa3jIo/YdXo/0y+r4mMob2c7G+UMpxbCw6TwESk0EqM+k/K+G1MYd6RB49FOQvxM6/A
         BDuw==
X-Gm-Message-State: AOAM533oHX5toaLggK2sufwMjHAtoknCV/lT9T5Udao2IjJo/G747+/n
        gvCBS3WU5+gfgt1Jp24jeBI=
X-Google-Smtp-Source: ABdhPJxbdgpyhowcJ/hjAWz2gc6wA8vccXbzKoFri2DjmTESmIi0I9HB8wXTbgPS3wy55/04PNi9Wg==
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr23097400wmj.156.1640811100863;
        Wed, 29 Dec 2021 12:51:40 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:40 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 20/32] staging: r8188eu: make odm_RefreshRateAdaptiveMask() static
Date:   Wed, 29 Dec 2021 21:50:56 +0100
Message-Id: <20211229205108.26373-21-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_RefreshRateAdaptiveMask() is only used in odm.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 51 +++++++------------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 7394dff4f7ff..41e954ec4e86 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -346,6 +346,24 @@ static void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm)
 	pOdmRA->LowRSSIThresh = 20;
 }
 
+static void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
+{
+	u8 i;
+	struct adapter *pAdapter = pDM_Odm->Adapter;
+
+	if (pAdapter->bDriverStopped)
+		return;
+
+	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
+		struct sta_info *pstat = pDM_Odm->pODM_StaInfo[i];
+
+		if (IS_STA_VALID(pstat)) {
+			if (ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false, &pstat->rssi_level))
+				rtw_hal_update_ra_mask(pAdapter, i, pstat->rssi_level);
+		}
+	}
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -703,39 +721,6 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 	return rate_bitmap;
 }
 
-/*-----------------------------------------------------------------------------
- * Function:	odm_RefreshRateAdaptiveMask()
- *
- * Overview:	Update rate table mask according to rssi
- *
- * Input:		NONE
- *
- * Output:		NONE
- *
- * Return:		NONE
- *
- * Revised History:
- *	When		Who		Remark
- *	05/27/2009	hpfan	Create Version 0.
- *
- *---------------------------------------------------------------------------*/
-void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm)
-{
-	u8 i;
-	struct adapter *pAdapter = pDM_Odm->Adapter;
-
-	if (pAdapter->bDriverStopped)
-		return;
-
-	for (i = 0; i < ODM_ASSOCIATE_ENTRY_NUM; i++) {
-		struct sta_info *pstat = pDM_Odm->pODM_StaInfo[i];
-		if (IS_STA_VALID(pstat)) {
-			if (ODM_RAStateCheck(pDM_Odm, pstat->rssi_stat.UndecoratedSmoothedPWDB, false, &pstat->rssi_level))
-				rtw_hal_update_ra_mask(pAdapter, i, pstat->rssi_level);
-		}
-	}
-}
-
 /*  Return Value: bool */
 /*  - true: RATRState is changed. */
 bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate, u8 *pRATRState)
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index bb4ea0b57f08..c2287d00aa60 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -38,7 +38,6 @@ void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
 void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
 void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm);
-void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm);
 void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm);
 void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm);
-- 
2.34.1

