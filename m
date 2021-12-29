Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703954816CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhL2UwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbhL2Uvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52324C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:39 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso15027480wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Z2mH0hwfiXngpZkvcLg582ceC50cyN898oGM/f5+3E=;
        b=btxgsoj2qIKPoITgfyiOARptVqODP2hv6WBlB0FomW2g/7zLZGG75pixN7r9Jsp/4g
         GCNtSdp1+2koNDPKxzsrbL8DaHp39gAbI+IKWfWvYcTbkszjrMkCZdWK682EqngwNyPU
         816T46bfAH1nGfBg/Ve8XpFg8fbMJ3/98+/cWjGwvsJxKqplBh/uUctrCmbo0gic6UZF
         e0+EMG1FHKWp2PmWo6eI0PoUG30RgZ9bP8QEPp3u5pldQoXOpmSjCOoH9GcpEmGzkYZC
         CJiLa2fqpnF0soIAXvRg5s30QQ0lS/uiwEz/S+aZ8/68Apm6RkrlwTfWACCvKQFhxGDq
         COZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Z2mH0hwfiXngpZkvcLg582ceC50cyN898oGM/f5+3E=;
        b=nI+pKU06V920n/MbTt+N5mgdnlV0DsWiyfdHsJyznEVR8tR/3kFzz6lRhdX1EPUaIt
         Ai5CEcVZjfMV3khvxwBaJb23GozKl+pT8uJgvS08voBSMD3iyVSMixBWsymH/MUEwprj
         QIbzVky285GK2L+UEhxzVzDlvdgO+D5CMdBGAYF3TkZxmu0G1SWION74Kqk1Nd7A75XJ
         l5h8s/CbZFrVPZJ08yGwuibY87eHk9ntHbMJMK47mUmKFfZxKp7P1Q6z7oKPxnAuxGHB
         0eD8Tw9pYY4007Xq9Dug87H8F5t6x3D35aNWdk19I9KbcZi5aJLSp7ow5tUSry995fGr
         xCMw==
X-Gm-Message-State: AOAM531nsMdk04qR1K7y0ahMCX7zyybvVvX4qoKndUs0XSAcOUJPdWWu
        HhM+/+eB7CIdoebyNruFMkc=
X-Google-Smtp-Source: ABdhPJwqix7T6hZJvvS4wexiqRfVqacssJgpMeRDcg1mpk0TCGDUBHKY/DDGIOx21QXJA7bneq9YJg==
X-Received: by 2002:a7b:c042:: with SMTP id u2mr10725848wmc.18.1640811097883;
        Wed, 29 Dec 2021 12:51:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:37 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 16/32] staging: r8188eu: make odm_DIG() static
Date:   Wed, 29 Dec 2021 21:50:52 +0100
Message-Id: <20211229205108.26373-17-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_DIG() is used only in odm.c. Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 264 +++++++++---------
 drivers/staging/r8188eu/include/odm_precomp.h |   1 -
 2 files changed, 132 insertions(+), 133 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index cb1882f8a8bd..6f94954ba987 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -171,6 +171,138 @@ static void odm_DIGInit(struct odm_dm_struct *pDM_Odm)
 	pDM_Odm->bDMInitialGainEnable = true;
 }
 
+static void odm_DIG(struct odm_dm_struct *pDM_Odm)
+{
+	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
+	struct false_alarm_stats *pFalseAlmCnt = &pDM_Odm->FalseAlmCnt;
+	u8 DIG_Dynamic_MIN;
+	u8 DIG_MaxOfMin;
+	bool FirstConnect, FirstDisConnect;
+	u8 dm_dig_max, dm_dig_min;
+	u8 CurrentIGI = pDM_DigTable->CurIGValue;
+
+	if (!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT))
+		return;
+
+	if (*pDM_Odm->pbScanInProcess)
+		return;
+
+	/* add by Neil Chen to avoid PSD is processing */
+	if (!pDM_Odm->bDMInitialGainEnable)
+		return;
+
+	DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
+	FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
+	FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
+
+	/* 1 Boundary Decision */
+	dm_dig_max = DM_DIG_MAX_NIC;
+	dm_dig_min = DM_DIG_MIN_NIC;
+	DIG_MaxOfMin = DM_DIG_MAX_AP;
+
+	if (pDM_Odm->bLinked) {
+		/* 2 8723A Series, offset need to be 10 */
+		/* 2 Modify DIG upper bound */
+		if ((pDM_Odm->RSSI_Min + 20) > dm_dig_max)
+			pDM_DigTable->rx_gain_range_max = dm_dig_max;
+		else if ((pDM_Odm->RSSI_Min + 20) < dm_dig_min)
+			pDM_DigTable->rx_gain_range_max = dm_dig_min;
+		else
+			pDM_DigTable->rx_gain_range_max = pDM_Odm->RSSI_Min + 20;
+		/* 2 Modify DIG lower bound */
+		if (pDM_Odm->bOneEntryOnly) {
+			if (pDM_Odm->RSSI_Min < dm_dig_min)
+				DIG_Dynamic_MIN = dm_dig_min;
+			else if (pDM_Odm->RSSI_Min > DIG_MaxOfMin)
+				DIG_Dynamic_MIN = DIG_MaxOfMin;
+			else
+				DIG_Dynamic_MIN = pDM_Odm->RSSI_Min;
+		} else if (pDM_Odm->SupportAbility & ODM_BB_ANT_DIV) {
+			/* 1 Lower Bound for 88E AntDiv */
+			if (pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)
+				DIG_Dynamic_MIN = (u8)pDM_DigTable->AntDiv_RSSI_max;
+		} else {
+			DIG_Dynamic_MIN = dm_dig_min;
+		}
+	} else {
+		pDM_DigTable->rx_gain_range_max = dm_dig_max;
+		DIG_Dynamic_MIN = dm_dig_min;
+	}
+
+	/* 1 Modify DIG lower bound, deal with abnormally large false alarm */
+	if (pFalseAlmCnt->Cnt_all > 10000) {
+		if (pDM_DigTable->LargeFAHit != 3)
+			pDM_DigTable->LargeFAHit++;
+		if (pDM_DigTable->ForbiddenIGI < CurrentIGI) {
+			pDM_DigTable->ForbiddenIGI = CurrentIGI;
+			pDM_DigTable->LargeFAHit = 1;
+		}
+
+		if (pDM_DigTable->LargeFAHit >= 3) {
+			if ((pDM_DigTable->ForbiddenIGI + 1) > pDM_DigTable->rx_gain_range_max)
+				pDM_DigTable->rx_gain_range_min = pDM_DigTable->rx_gain_range_max;
+			else
+				pDM_DigTable->rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 1);
+			pDM_DigTable->Recover_cnt = 3600; /* 3600=2hr */
+		}
+
+	} else {
+		/* Recovery mechanism for IGI lower bound */
+		if (pDM_DigTable->Recover_cnt != 0) {
+			pDM_DigTable->Recover_cnt--;
+		} else {
+			if (pDM_DigTable->LargeFAHit < 3) {
+				if ((pDM_DigTable->ForbiddenIGI - 1) < DIG_Dynamic_MIN) { /* DM_DIG_MIN) */
+					pDM_DigTable->ForbiddenIGI = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
+					pDM_DigTable->rx_gain_range_min = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
+				} else {
+					pDM_DigTable->ForbiddenIGI--;
+					pDM_DigTable->rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 1);
+				}
+			} else {
+				pDM_DigTable->LargeFAHit = 0;
+			}
+		}
+	}
+
+	/* 1 Adjust initial gain by false alarm */
+	if (pDM_Odm->bLinked) {
+		if (FirstConnect) {
+			CurrentIGI = pDM_Odm->RSSI_Min;
+		} else {
+			if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2)
+				CurrentIGI = CurrentIGI + 4;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
+			else if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH1)
+				CurrentIGI = CurrentIGI + 2;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
+			else if (pFalseAlmCnt->Cnt_all < DM_DIG_FA_TH0)
+				CurrentIGI = CurrentIGI - 2;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
+		}
+	} else {
+		if (FirstDisConnect) {
+			CurrentIGI = pDM_DigTable->rx_gain_range_min;
+		} else {
+			/* 2012.03.30 LukeLee: enable DIG before link but with very high thresholds */
+			if (pFalseAlmCnt->Cnt_all > 10000)
+				CurrentIGI = CurrentIGI + 2;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
+			else if (pFalseAlmCnt->Cnt_all > 8000)
+				CurrentIGI = CurrentIGI + 1;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
+			else if (pFalseAlmCnt->Cnt_all < 500)
+				CurrentIGI = CurrentIGI - 1;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
+		}
+	}
+	/* 1 Check initial gain by upper/lower bound */
+	if (CurrentIGI > pDM_DigTable->rx_gain_range_max)
+		CurrentIGI = pDM_DigTable->rx_gain_range_max;
+	if (CurrentIGI < pDM_DigTable->rx_gain_range_min)
+		CurrentIGI = pDM_DigTable->rx_gain_range_min;
+
+	/* 2 High power RSSI threshold */
+
+	ODM_Write_DIG(pDM_Odm, CurrentIGI);/* ODM_Write_DIG(pDM_Odm, pDM_DigTable->CurIGValue); */
+	pDM_DigTable->bMediaConnect_0 = pDM_Odm->bLinked;
+	pDM_DigTable->DIG_Dynamic_MIN_0 = DIG_Dynamic_MIN;
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -339,138 +471,6 @@ void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 	}
 }
 
-void odm_DIG(struct odm_dm_struct *pDM_Odm)
-{
-	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
-	struct false_alarm_stats *pFalseAlmCnt = &pDM_Odm->FalseAlmCnt;
-	u8 DIG_Dynamic_MIN;
-	u8 DIG_MaxOfMin;
-	bool FirstConnect, FirstDisConnect;
-	u8 dm_dig_max, dm_dig_min;
-	u8 CurrentIGI = pDM_DigTable->CurIGValue;
-
-	if (!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT))
-		return;
-
-	if (*pDM_Odm->pbScanInProcess)
-		return;
-
-	/* add by Neil Chen to avoid PSD is processing */
-	if (!pDM_Odm->bDMInitialGainEnable)
-		return;
-
-	DIG_Dynamic_MIN = pDM_DigTable->DIG_Dynamic_MIN_0;
-	FirstConnect = (pDM_Odm->bLinked) && (!pDM_DigTable->bMediaConnect_0);
-	FirstDisConnect = (!pDM_Odm->bLinked) && (pDM_DigTable->bMediaConnect_0);
-
-	/* 1 Boundary Decision */
-	dm_dig_max = DM_DIG_MAX_NIC;
-	dm_dig_min = DM_DIG_MIN_NIC;
-	DIG_MaxOfMin = DM_DIG_MAX_AP;
-
-	if (pDM_Odm->bLinked) {
-		/* 2 8723A Series, offset need to be 10 */
-		/* 2 Modify DIG upper bound */
-		if ((pDM_Odm->RSSI_Min + 20) > dm_dig_max)
-			pDM_DigTable->rx_gain_range_max = dm_dig_max;
-		else if ((pDM_Odm->RSSI_Min + 20) < dm_dig_min)
-			pDM_DigTable->rx_gain_range_max = dm_dig_min;
-		else
-			pDM_DigTable->rx_gain_range_max = pDM_Odm->RSSI_Min + 20;
-		/* 2 Modify DIG lower bound */
-		if (pDM_Odm->bOneEntryOnly) {
-			if (pDM_Odm->RSSI_Min < dm_dig_min)
-				DIG_Dynamic_MIN = dm_dig_min;
-			else if (pDM_Odm->RSSI_Min > DIG_MaxOfMin)
-				DIG_Dynamic_MIN = DIG_MaxOfMin;
-			else
-				DIG_Dynamic_MIN = pDM_Odm->RSSI_Min;
-		} else if (pDM_Odm->SupportAbility & ODM_BB_ANT_DIV) {
-			/* 1 Lower Bound for 88E AntDiv */
-			if (pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)
-				DIG_Dynamic_MIN = (u8)pDM_DigTable->AntDiv_RSSI_max;
-		} else {
-			DIG_Dynamic_MIN = dm_dig_min;
-		}
-	} else {
-		pDM_DigTable->rx_gain_range_max = dm_dig_max;
-		DIG_Dynamic_MIN = dm_dig_min;
-	}
-
-	/* 1 Modify DIG lower bound, deal with abnormally large false alarm */
-	if (pFalseAlmCnt->Cnt_all > 10000) {
-		if (pDM_DigTable->LargeFAHit != 3)
-			pDM_DigTable->LargeFAHit++;
-		if (pDM_DigTable->ForbiddenIGI < CurrentIGI) {
-			pDM_DigTable->ForbiddenIGI = CurrentIGI;
-			pDM_DigTable->LargeFAHit = 1;
-		}
-
-		if (pDM_DigTable->LargeFAHit >= 3) {
-			if ((pDM_DigTable->ForbiddenIGI + 1) > pDM_DigTable->rx_gain_range_max)
-				pDM_DigTable->rx_gain_range_min = pDM_DigTable->rx_gain_range_max;
-			else
-				pDM_DigTable->rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 1);
-			pDM_DigTable->Recover_cnt = 3600; /* 3600=2hr */
-		}
-
-	} else {
-		/* Recovery mechanism for IGI lower bound */
-		if (pDM_DigTable->Recover_cnt != 0) {
-			pDM_DigTable->Recover_cnt--;
-		} else {
-			if (pDM_DigTable->LargeFAHit < 3) {
-				if ((pDM_DigTable->ForbiddenIGI - 1) < DIG_Dynamic_MIN) { /* DM_DIG_MIN) */
-					pDM_DigTable->ForbiddenIGI = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
-					pDM_DigTable->rx_gain_range_min = DIG_Dynamic_MIN; /* DM_DIG_MIN; */
-				} else {
-					pDM_DigTable->ForbiddenIGI--;
-					pDM_DigTable->rx_gain_range_min = (pDM_DigTable->ForbiddenIGI + 1);
-				}
-			} else {
-				pDM_DigTable->LargeFAHit = 0;
-			}
-		}
-	}
-
-	/* 1 Adjust initial gain by false alarm */
-	if (pDM_Odm->bLinked) {
-		if (FirstConnect) {
-			CurrentIGI = pDM_Odm->RSSI_Min;
-		} else {
-			if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH2)
-					CurrentIGI = CurrentIGI + 4;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
-			else if (pFalseAlmCnt->Cnt_all > DM_DIG_FA_TH1)
-					CurrentIGI = CurrentIGI + 2;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
-			else if (pFalseAlmCnt->Cnt_all < DM_DIG_FA_TH0)
-					CurrentIGI = CurrentIGI - 2;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
-		}
-	} else {
-		if (FirstDisConnect) {
-			CurrentIGI = pDM_DigTable->rx_gain_range_min;
-		} else {
-			/* 2012.03.30 LukeLee: enable DIG before link but with very high thresholds */
-			if (pFalseAlmCnt->Cnt_all > 10000)
-				CurrentIGI = CurrentIGI + 2;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+2; */
-			else if (pFalseAlmCnt->Cnt_all > 8000)
-				CurrentIGI = CurrentIGI + 1;/* pDM_DigTable->CurIGValue = pDM_DigTable->PreIGValue+1; */
-			else if (pFalseAlmCnt->Cnt_all < 500)
-				CurrentIGI = CurrentIGI - 1;/* pDM_DigTable->CurIGValue =pDM_DigTable->PreIGValue-1; */
-		}
-	}
-	/* 1 Check initial gain by upper/lower bound */
-	if (CurrentIGI > pDM_DigTable->rx_gain_range_max)
-		CurrentIGI = pDM_DigTable->rx_gain_range_max;
-	if (CurrentIGI < pDM_DigTable->rx_gain_range_min)
-		CurrentIGI = pDM_DigTable->rx_gain_range_min;
-
-	/* 2 High power RSSI threshold */
-
-	ODM_Write_DIG(pDM_Odm, CurrentIGI);/* ODM_Write_DIG(pDM_Odm, pDM_DigTable->CurIGValue); */
-	pDM_DigTable->bMediaConnect_0 = pDM_Odm->bLinked;
-	pDM_DigTable->DIG_Dynamic_MIN_0 = DIG_Dynamic_MIN;
-}
-
 /* 3============================================================ */
 /* 3 FASLE ALARM CHECK */
 /* 3============================================================ */
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 258119e2c4b9..ea9fe7044314 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -37,7 +37,6 @@ void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm);
 void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
-void odm_DIG(struct odm_dm_struct *pDM_Odm);
 void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
 void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm);
-- 
2.34.1

