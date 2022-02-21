Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180D4BD75F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346234AbiBUHeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:34:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346328AbiBUHdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:33:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DC0140AD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:19 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qx21so30754912ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpPKMOOkrFJF8q2NbuFWkI8+0Qjpz9YTMzfUO37K1GE=;
        b=eVeSHrAldynujWT89vm1fFlDDPVKlpctWwU39dILonBi95xwqCqw6OKIjjukkEI/kL
         e1wA5Mq/vFT6w1LQ0H2D9Ng0+IPFc7Z09q/eSlD/g4GkkUvB3EkMjExQ8tHL1WaP804d
         Qjh0R3cHxj6Px9q+YpLm5Q/rVO9gPBFwOFWsT1XZGa18GHX8GBHFxIIv4dPx1xvd3F1q
         vKhwzN35gp3OvDiHjWRRSCRRYYXlA1Fw1hFUg1/DhT9er/+XELITrSU03rlgnBXMTrHc
         3nVQ3K1qJX6fQzlUgYHHoC51VsmXFihTqow/1Fkqlvo4uwrorTC4EgCrq3rtEWNWe5/O
         0D5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpPKMOOkrFJF8q2NbuFWkI8+0Qjpz9YTMzfUO37K1GE=;
        b=OVQW7GMikMKCPex/42IcJDUJkHoFCqX2gk9MwYo5eYkZ8cpy6mbLjhjzaP9u7Bf8SI
         ZSLJfts7srir7X2LHBM7C4ukv0mKLld4jteeibWGFFN171F8VEywphOiKIUt/N26yXlQ
         KGngtfkvVBp9340JVRtkYOJikxnCErlmxeFXaOiUmvmwwLrRqSdezA7OZS1mVtE4iRbz
         U5rOLODo8E0GIkg6hkc/0GOhpVsjhqJ+YayaVCQ+b4pAvW1MXZ6mBDBCJwhNFgt7VFP0
         ncA2W8bgTFJvnssaW8Kz9MiFcg5jRCQ1+m6WzjCtnjPflQEtUDOKb8aU+UX9H80JKxpg
         R5MQ==
X-Gm-Message-State: AOAM5329GlEUDxOCxNfxSoZwEVtQlqAEBPP/d33LSxITrfsmJqkU6heU
        lWDn9O9aPXJwvnRx27vd0yU=
X-Google-Smtp-Source: ABdhPJziO6jTr9J2uSUPk4q6xmDikxZKg+/yxSRzpUduiW5u07oqOlRVGvv0SL3D6Na77Ewv/4Z+VQ==
X-Received: by 2002:a17:907:30cc:b0:6ce:d97:cb0f with SMTP id vl12-20020a17090730cc00b006ce0d97cb0fmr15023881ejb.0.1645428798560;
        Sun, 20 Feb 2022 23:33:18 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id c11sm8673128edx.42.2022.02.20.23.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:33:18 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/5] staging: r8188eu: remove ODM_CmnInfoUpdate()
Date:   Mon, 21 Feb 2022 08:33:06 +0100
Message-Id: <20220221073306.16636-6-straube.linux@gmail.com>
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

Each case in ODM_CmnInfoUpdate() just sets a single variable. Set the
variables directly and remove ODM_CmnInfoUpdate().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2:
no changes

 drivers/staging/r8188eu/hal/odm.c         | 21 +--------------------
 drivers/staging/r8188eu/hal/rtl8188e_dm.c |  4 ++--
 drivers/staging/r8188eu/include/odm.h     |  7 -------
 3 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 5d2f934d78ae..94f9b125d860 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -464,7 +464,7 @@ static void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm)
 		pdmpriv->EntryMinUndecoratedSmoothedPWDB = 0;
 
 	FindMinimumRSSI(Adapter);
-	ODM_CmnInfoUpdate(&pHalData->odmpriv, ODM_CMNINFO_RSSI_MIN, pdmpriv->MinUndecoratedPWDBForDM);
+	pHalData->odmpriv.RSSI_Min = pdmpriv->MinUndecoratedPWDBForDM;
 }
 
 static void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm)
@@ -639,25 +639,6 @@ void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	pDM_Odm->BbSwingFlagOfdm		= false;
 }
 
-/*  Update Band/CHannel/.. The values are dynamic but non-per-packet. */
-void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
-{
-	/*  */
-	/*  This init variable may be changed in run time. */
-	/*  */
-	switch	(CmnInfo) {
-	case	ODM_CMNINFO_ABILITY:
-		pDM_Odm->SupportAbility = (u32)Value;
-		break;
-	case	ODM_CMNINFO_LINK:
-		pDM_Odm->bLinked = (bool)Value;
-		break;
-	case	ODM_CMNINFO_RSSI_MIN:
-		pDM_Odm->RSSI_Min = (u8)Value;
-		break;
-	}
-}
-
 void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI)
 {
 	struct rtw_dig *pDM_DigTable = &pDM_Odm->DM_DigTable;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index df0b412c52eb..6d28e3dc0d26 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -36,7 +36,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	if (hal_data->AntDivCfg)
 		pdmpriv->InitODMFlag |= ODM_BB_ANT_DIV;
 
-	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
+	dm_odm->SupportAbility = pdmpriv->InitODMFlag;
 
 	dm_odm->pWirelessMode = &pmlmeext->cur_wireless_mode;
 	dm_odm->pSecChOffset = &hal_data->nCur40MhzPrimeSC;
@@ -80,7 +80,7 @@ void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
 			bLinked = true;
 	}
 
-	ODM_CmnInfoUpdate(&hal_data->odmpriv, ODM_CMNINFO_LINK, bLinked);
+	hal_data->odmpriv.bLinked = bLinked;
 	ODM_DMWatchdog(&hal_data->odmpriv);
 }
 
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 7a10f57b9bd3..b88b3f3d08ee 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -122,19 +122,14 @@ enum odm_common_info_def {
 	/*  Fixed value: */
 
 	/* HOOK BEFORE REG INIT----------- */
-	ODM_CMNINFO_ABILITY,		/* ODM_ABILITY_E */
 	ODM_CMNINFO_MP_TEST_CHIP,
 	/* HOOK BEFORE REG INIT-----------  */
 
 /* CALL BY VALUE------------- */
-	ODM_CMNINFO_LINK,
-	ODM_CMNINFO_RSSI_MIN,
 	ODM_CMNINFO_RF_ANTENNA_TYPE,		/*  u8 */
 /* CALL BY VALUE-------------*/
 };
 
-/*  2011/10/20 MH Define ODM support ability.  ODM_CMNINFO_ABILITY */
-
 enum odm_ability_def {
 	/*  BB ODM section BIT 0-15 */
 	ODM_BB_RSSI_MONITOR		= BIT(4),
@@ -455,6 +450,4 @@ void ODM_DMWatchdog(struct odm_dm_struct *pDM_Odm);
 void ODM_CmnInfoInit(struct odm_dm_struct *pDM_Odm,
 		     enum odm_common_info_def CmnInfo, u32 Value);
 
-void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value);
-
 #endif
-- 
2.35.1

