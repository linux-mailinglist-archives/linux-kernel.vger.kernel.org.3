Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F244816CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhL2UwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhL2Uvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E32AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v10-20020a05600c214a00b00345e59928eeso8484924wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eo0tfBwpFHKmaR9uiricUJYGewJt0PxAB46raXgX+vQ=;
        b=OCvcOZjiP3MfnVzjNKa/Pd4TQMzgNtpZeV5QTlf8gykItJ0aH7mviqOXdjnM8PUDAC
         kFSHImHNx360vVlosGk1Sp0s4myY2TUed0an0H5JVUvLKX7mECAP6vhguZtIeNAyo9FO
         jirb0R/oXEJjEGsUd0IpLs//qCFMveUGitwPp7uFJO8we8Y/u4fQdP1v2mmTlmhaP8aQ
         pJoe6qdnyfJTN6u9Xr2t5D5T3l8712rW3RWPd2mFx8nOR0iDe+Mu6QAYpTTdAiKq4DMT
         Rx/n0ozGMKp5VLXgh8aJQdv1WbV6ZAP3hynVdPzlaweWG1YkezKE0JBijpF0ydO+q5WP
         VRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eo0tfBwpFHKmaR9uiricUJYGewJt0PxAB46raXgX+vQ=;
        b=mCC4Ocy87VIoEonfUNV5XmZaxU7xsOoz0CgAgONd+YLDzTp8CNvDYTk+Mulz4atE48
         33h9rUYuq/SDa2AgsLDkSOLZ1jxj1K6EPPA0h8P/9aCQdpfp8yvtE21pwyUal7TjOUu0
         NtT/SLlaO4qXXqSiDO+0RXgYKcNPuycQhkKYopIDCOvTZj8Cwi4wKv4crNhEtu8JqpVw
         /LN0T/6e4aJH3JrOZPqfEVapYV1ZxzT/DR1RQNVpqzMOIOcY01BPbeYerLQ4dlvtxSye
         oejger/B3/iB9rfnkvS8sOBv+neP3ES47LTytntsPt2PNbQOqv4tqjsvWT25UvhtUV1b
         132A==
X-Gm-Message-State: AOAM5328Ykiwb8yafo1hkNb83b7JZThH/GKWYHYm7WgKYoS8CTqYGeTD
        ycLRi+UoV9ohemly2JvOxls=
X-Google-Smtp-Source: ABdhPJx1uxF1NI04/LcRERUu4LP2wJXu5LEcCa3YTkeGs3L3pYG9ffLBsfNkIaebsIqIixTWUozUrw==
X-Received: by 2002:a7b:c08c:: with SMTP id r12mr23494060wmh.161.1640811097140;
        Wed, 29 Dec 2021 12:51:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 15/32] staging: r8188eu: make odm_DIGInit() static
Date:   Wed, 29 Dec 2021 21:50:51 +0100
Message-Id: <20211229205108.26373-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_DIGInit() is used only in odm.c. Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 58 +++++++++----------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index c50f5219df36..cb1882f8a8bd 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -142,6 +142,35 @@ u8 CCKSwingTable_Ch14[CCK_TABLE_SIZE][8] = {
 #define		RxDefaultAnt1		0x65a9
 #define	RxDefaultAnt2		0x569a
 
+static void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
+{
+	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
+	struct adapter *adapter = pDM_Odm->Adapter;
+
+	pDM_DigTable->CurIGValue = (u8)rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N);
+	pDM_DigTable->RssiLowThresh	= DM_DIG_THRESH_LOW;
+	pDM_DigTable->RssiHighThresh	= DM_DIG_THRESH_HIGH;
+	pDM_DigTable->FALowThresh	= DM_false_ALARM_THRESH_LOW;
+	pDM_DigTable->FAHighThresh	= DM_false_ALARM_THRESH_HIGH;
+	pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
+	pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
+	pDM_DigTable->BackoffVal = DM_DIG_BACKOFF_DEFAULT;
+	pDM_DigTable->BackoffVal_range_max = DM_DIG_BACKOFF_MAX;
+	pDM_DigTable->BackoffVal_range_min = DM_DIG_BACKOFF_MIN;
+	pDM_DigTable->PreCCK_CCAThres = 0xFF;
+	pDM_DigTable->CurCCK_CCAThres = 0x83;
+	pDM_DigTable->ForbiddenIGI = DM_DIG_MIN_NIC;
+	pDM_DigTable->LargeFAHit = 0;
+	pDM_DigTable->Recover_cnt = 0;
+	pDM_DigTable->DIG_Dynamic_MIN_0 = DM_DIG_MIN_NIC;
+	pDM_DigTable->DIG_Dynamic_MIN_1 = DM_DIG_MIN_NIC;
+	pDM_DigTable->bMediaConnect_0 = false;
+	pDM_DigTable->bMediaConnect_1 = false;
+
+	/* To Initialize pDM_Odm->bDMInitialGainEnable == false to avoid DIG error */
+	pDM_Odm->bDMInitialGainEnable = true;
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -310,35 +339,6 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 	}
 }
 
-void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
-{
-	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
-	struct adapter *adapter = pDM_Odm->Adapter;
-
-	pDM_DigTable->CurIGValue = (u8)rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_IGI_A_11N, ODM_BIT_IGI_11N);
-	pDM_DigTable->RssiLowThresh	= DM_DIG_THRESH_LOW;
-	pDM_DigTable->RssiHighThresh	= DM_DIG_THRESH_HIGH;
-	pDM_DigTable->FALowThresh	= DM_false_ALARM_THRESH_LOW;
-	pDM_DigTable->FAHighThresh	= DM_false_ALARM_THRESH_HIGH;
-	pDM_DigTable->rx_gain_range_max = DM_DIG_MAX_NIC;
-	pDM_DigTable->rx_gain_range_min = DM_DIG_MIN_NIC;
-	pDM_DigTable->BackoffVal = DM_DIG_BACKOFF_DEFAULT;
-	pDM_DigTable->BackoffVal_range_max = DM_DIG_BACKOFF_MAX;
-	pDM_DigTable->BackoffVal_range_min = DM_DIG_BACKOFF_MIN;
-	pDM_DigTable->PreCCK_CCAThres = 0xFF;
-	pDM_DigTable->CurCCK_CCAThres = 0x83;
-	pDM_DigTable->ForbiddenIGI = DM_DIG_MIN_NIC;
-	pDM_DigTable->LargeFAHit = 0;
-	pDM_DigTable->Recover_cnt = 0;
-	pDM_DigTable->DIG_Dynamic_MIN_0 = DM_DIG_MIN_NIC;
-	pDM_DigTable->DIG_Dynamic_MIN_1 = DM_DIG_MIN_NIC;
-	pDM_DigTable->bMediaConnect_0 = false;
-	pDM_DigTable->bMediaConnect_1 = false;
-
-	/* To Initialize pDM_Odm->bDMInitialGainEnable == false to avoid DIG error */
-	pDM_Odm->bDMInitialGainEnable = true;
-}
-
 void odm_DIG(struct odm_dm_struct *pDM_Odm)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 7f08f2d0a671..258119e2c4b9 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -31,7 +31,6 @@
 #include "odm_RegConfig8188E.h"
 #include "odm_RTL8188E.h"
 
-void odm_DIGInit(struct odm_dm_struct *pDM_Odm);
 void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm);
 void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
-- 
2.34.1

