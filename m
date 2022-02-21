Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1D74BD6E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiBUHeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:34:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346257AbiBUHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:33:54 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B1A659F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id bq11so6091898edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GygaqrnptWbGRKfUQnwAPPKWiQdpM61jTZJHob6nbtc=;
        b=a4vK4Slurn80v0GcEbZhj3E5dz1U+rEx6E9kOq1YgwC2RFddMjCemcnRU+xDhb68Z9
         2z1ryStDhoth611iAu2B39GjnRTdXwae2s/AXvy6aWgvUvHSOaHpKxSYimMroktBwQ7T
         BvJxv3acdVLg1R0ZkYyF8VEJX/wb8A/ToVef9m6dy3LYCr8/yeYljF4m7MdzRVYMJ2lK
         Vx6FcvL2t+LFMTaAWk2CznV4A5VbjxesXt7DH17snKETnmq0/Mcbwecm5tBhyHTeZx/m
         GneFqOkYDZ8/MNNVD1E6Fi1V8C6huExLTnymM+baErXjrPcbkSPnDW7EZ1vFZtLhOV06
         Zl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GygaqrnptWbGRKfUQnwAPPKWiQdpM61jTZJHob6nbtc=;
        b=JhOzlgxd9e5v3/p9CNpskDZOOSudc7W9hEEtcIgv5sqlP3RAiLrrW4G8BnicIIxBrn
         L6+5kWkkbGx/XWIuPe0hwulS5grM9NnM9M63YRJfOt9AJP1pMsu31TKXfvFXiSAJriZB
         33W3DoKHyCYUoN8jRB5hHYbgSmxBkC8vmOZKE6EP6RZqPk01ZVIqfL/3JUoF4Dlvx/4v
         wKlEl26fdv66jz1riU1B3eAXROqx92XB8J6a9iNj2eRMG4bVtyInVAKX+80RwGqIey+H
         9xsuTAtuqGgf1u3Tqea+aRH8uG/+BJDSiUeNLOJeNi93174MWM/LwlhsYHAlwroyqLMd
         abdg==
X-Gm-Message-State: AOAM531cDpmd8Ep/ix3Pqhu8FgbnNkXh+N6TzLVHTMWIOp4q62OzUS9R
        zNIOPNk7+Vds3gNJbvHbBfU=
X-Google-Smtp-Source: ABdhPJxjql3GmCyCpnZqwfYhPqgIJzQIhr6UBSwPupEjDAJc8LihhbWXT8uxgjsQbfeVRmKd2vkDYA==
X-Received: by 2002:a05:6402:168e:b0:410:d2a4:b0dd with SMTP id a14-20020a056402168e00b00410d2a4b0ddmr19744492edv.403.1645428796050;
        Sun, 20 Feb 2022 23:33:16 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id c11sm8673128edx.42.2022.02.20.23.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:33:15 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/5] staging: r8188eu: remove ODM_CmnInfoHook()
Date:   Mon, 21 Feb 2022 08:33:02 +0100
Message-Id: <20220221073306.16636-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221073306.16636-1-straube.linux@gmail.com>
References: <20220221073306.16636-1-straube.linux@gmail.com>
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

Each case in ODM_CmnInfoHook() just sets a single variable. Set the
variables directly and remove ODM_CmnInfoHook().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2:
no changes

 drivers/staging/r8188eu/hal/odm.c         | 31 -----------------------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 13 +++++-----
 drivers/staging/r8188eu/include/odm.h     | 14 ----------
 3 files changed, 7 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index e0824eefd83a..6f594ae33c6e 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -639,37 +639,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	pDM_Odm->BbSwingFlagOfdm		= false;
 }
 
-void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def CmnInfo, void *pValue)
-{
-	/*  */
-	/*  Hook call by reference pointer. */
-	/*  */
-	switch	(CmnInfo) {
-	/*  Dynamic call by reference pointer. */
-	case	ODM_CMNINFO_WM_MODE:
-		pDM_Odm->pWirelessMode = (u8 *)pValue;
-		break;
-	case	ODM_CMNINFO_SEC_CHNL_OFFSET:
-		pDM_Odm->pSecChOffset = (u8 *)pValue;
-		break;
-	case	ODM_CMNINFO_BW:
-		pDM_Odm->pBandWidth = (u8 *)pValue;
-		break;
-	case	ODM_CMNINFO_CHNL:
-		pDM_Odm->pChannel = (u8 *)pValue;
-		break;
-	case	ODM_CMNINFO_SCAN:
-		pDM_Odm->pbScanInProcess = (bool *)pValue;
-		break;
-	case	ODM_CMNINFO_POWER_SAVING:
-		pDM_Odm->pbPowerSaving = (bool *)pValue;
-		break;
-	default:
-		/* do nothing */
-		break;
-	}
-}
-
 /*  Update Band/CHannel/.. The values are dynamic but non-per-packet. */
 void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 {
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index a05d8687c18d..09e78c4855f9 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -38,12 +38,13 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
 
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_WM_MODE, &pmlmeext->cur_wireless_mode);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_CHNL_OFFSET, &hal_data->nCur40MhzPrimeSC);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_BW, &hal_data->CurrentChannelBW);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_CHNL, &hal_data->CurrentChannel);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SCAN, &pmlmepriv->bScanInProcess);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_POWER_SAVING, &pwrctrlpriv->bpower_saving);
+	dm_odm->pWirelessMode = &pmlmeext->cur_wireless_mode;
+	dm_odm->pSecChOffset = &hal_data->nCur40MhzPrimeSC;
+	dm_odm->pBandWidth = (u8 *)&hal_data->CurrentChannelBW;
+	dm_odm->pChannel = &hal_data->CurrentChannel;
+	dm_odm->pbScanInProcess = (bool *)&pmlmepriv->bScanInProcess;
+	dm_odm->pbPowerSaving = (bool *)&pwrctrlpriv->bpower_saving;
+
 	ODM_CmnInfoInit(dm_odm, ODM_CMNINFO_RF_ANTENNA_TYPE, hal_data->TRxAntDivType);
 
 	for (i = 0; i < NUM_STA; i++)
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 9fb09e0a0df9..0e85bd88ab8a 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -126,17 +126,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_MP_TEST_CHIP,
 	/* HOOK BEFORE REG INIT-----------  */
 
-	/*  Dynamic value: */
-/*  POINTER REFERENCE-----------  */
-	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
-	ODM_CMNINFO_SEC_CHNL_OFFSET,	/*  ODM_SEC_CHNL_OFFSET_E */
-	ODM_CMNINFO_BW,			/*  ODM_BW_E */
-	ODM_CMNINFO_CHNL,
-
-	ODM_CMNINFO_SCAN,
-	ODM_CMNINFO_POWER_SAVING,
-/*  POINTER REFERENCE----------- */
-
 /* CALL BY VALUE------------- */
 	ODM_CMNINFO_LINK,
 	ODM_CMNINFO_RSSI_MIN,
@@ -472,9 +461,6 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm);
 void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm,
 		     enum odm_common_info_def CmnInfo, u32 Value);
 
-void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm,
-		     enum odm_common_info_def CmnInfo, void *pValue);
-
 void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value);
 
 #endif
-- 
2.35.1

