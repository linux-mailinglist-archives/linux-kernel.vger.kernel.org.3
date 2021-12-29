Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9594816D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhL2Uwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhL2Uvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:49 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD94C061401
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:46 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso12268140wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qL5JcVFZ/8xE2kVZ4Z0vaz4/wps1vEerBBiGAuD/u18=;
        b=Nj6zx0EG+j9B6J72poTAUa4Wi1QDx0Kv0LATza2/OvbOdBsiPl7H/i83yojb+dEO4s
         LcmAFhmp99QpgxEhnvHHZqyrEWSfL+1UcZExXv8SPEirMWkyWx/Xjy1R3aXX6cR1WU/P
         /L5zJPsu5rYWnd0HNm9c0fuAVQFIlFAIHSQtq6572f5e+qOc7QU0Fk4u6DAli7K8qUz6
         Q3E/YBpIs39HXiKK7hkPVfBfcp5NhuCUvJlq+uV5TVMGhokAz3Mzi0zZ9oITMGkXTJ6l
         XjE0jgzlJ2vCbVTkGJkCYBDJhYrTsyNICxX89nRmeHDzcOCWJNhPiu1cFewUfimmehFk
         Mzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qL5JcVFZ/8xE2kVZ4Z0vaz4/wps1vEerBBiGAuD/u18=;
        b=tZXryMq5t8DARs+Xe80M+vmtw5uC94MmFvsnB0fhHkwxlZBgYBOja9cvXbf42Waa0Y
         H2UkZuxymulyzuNsBOfvxxQsqOckO4YBmzG9IDDTBhy65EUKLhQOFpW3DcYP5/5KBfUM
         BWefASkwZo+/iWSTWa3c1mZji0cEQ+aIYaMpzxEiShtuISL5Dmy3yzmmgI5o1qc7LO5W
         HynoiQRE1cvBCFJ9IJIv7gYi1hnr8f8a0vUVY2T2P5EyHXpSm0QJgQQ8S28VPtrZokMC
         lSH9Ln60KBjvUJxqO2PXk070ZQiJM+oAUmNF1+Ou9uO/SN5gytlw1N1bNR+9KLwpxQvj
         TZ/w==
X-Gm-Message-State: AOAM532zFhOFtGSrcYRzk7hEpCDbR56+9Exmztnd+wDMWy2QUsL8D1UH
        dgnPQ7Cat1Eb0lKTH1uJ2/k=
X-Google-Smtp-Source: ABdhPJzjYWh93s2TXHpzHZ7R+sBG5Hrit9ke3BvXmXDXbY2EGTFJzxFKWW0S5pu8mr6hA9eyJy0Pmw==
X-Received: by 2002:a05:600c:9:: with SMTP id g9mr23092576wmc.127.1640811105007;
        Wed, 29 Dec 2021 12:51:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:44 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 26/32] staging: r8188eu: make odm_TXPowerTrackingThermalMeterInit() static
Date:   Wed, 29 Dec 2021 21:51:02 +0100
Message-Id: <20211229205108.26373-27-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_TXPowerTrackingThermalMeterInit() is only used in odm.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 20 ++++++++-----------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index f2318ec812be..fc402824bed0 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -528,6 +528,14 @@ static void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
 	ODM_CmnInfoUpdate(&pHalData->odmpriv, ODM_CMNINFO_RSSI_MIN, pdmpriv->MinUndecoratedPWDBForDM);
 }
 
+static void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm)
+{
+	pDM_Odm->RFCalibrateInfo.bTXPowerTracking = true;
+	pDM_Odm->RFCalibrateInfo.TXPowercount = 0;
+	pDM_Odm->RFCalibrateInfo.bTXPowerTrackingInit = false;
+	pDM_Odm->RFCalibrateInfo.TxPowerTrackControl = true;
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -825,18 +833,6 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 	return false;
 }
 
-/* 3============================================================ */
-/* 3 Tx Power Tracking */
-/* 3============================================================ */
-
-void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm)
-{
-	pDM_Odm->RFCalibrateInfo.bTXPowerTracking = true;
-	pDM_Odm->RFCalibrateInfo.TXPowercount = 0;
-	pDM_Odm->RFCalibrateInfo.bTXPowerTrackingInit = false;
-	pDM_Odm->RFCalibrateInfo.TxPowerTrackControl = true;
-}
-
 void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 92465e71b814..7150228dc8d7 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -33,7 +33,6 @@
 
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
-void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm);
 void odm_InitHybridAntDiv(struct odm_dm_struct *pDM_Odm);
 void odm_HwAntDiv(struct odm_dm_struct *pDM_Odm);
 
-- 
2.34.1

