Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3359ABCC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245145AbiHTGnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244833AbiHTGnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:43:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4771181E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:43:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gk3so12392017ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jmGCfK1PpP8C14WpA4xMyU1skN/b8h3qkvgiLCfaJxg=;
        b=TnBejUt3mv99xj9NCm/2aMZ61TZLahK62aKH9XgCIt8STTI6imfqFkf5QR+DeLs7Nz
         CUhQySJTa396di1l425A7SEpn+fENqCXYXSt3LEbN9PAIin7ZFk9cMyXp2f2cxkT4PyD
         pBDaUhrBznjESOiF4reqUM5zmh5gf+POI+MzEHXr+Nzr7xt2ptWaCG7LUYABjBroyvpg
         kGsVvtVbtEzKkfIdWZifAU0kWC0OmnaKlZZyjmDyFLNhjkvCr76rvy9ER+QzQIrjekKV
         /7Fr3cH3IGxUWzpM3Hf/MkELPSv2GOjh4hpT+t62VhjXo4duLGC0whiDh3Amp0BIVcx2
         Vp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jmGCfK1PpP8C14WpA4xMyU1skN/b8h3qkvgiLCfaJxg=;
        b=q4kmwLtNbnwQ0K6QEtaSW+FDICpEogWfJULEN5pjjeHHYCoVD8bIoUnQ8roMTUFmZQ
         Grmp3H+nr2zP2J1Md9U7dTnPVvSsBThIQ5WDR1iMaXqHf1Fu8NZWR/hM44r7DIZK+uPM
         Bv3LZA7G/r0S56x6+N36T4NwFXH9rdV8HmKYI2GDKKkw7FGRfmncQBkTxyNEfZ8pmZtC
         wM1DGJs8nWDU844k+p9tq9gAbPQ8pCKCTDbBaoXAv+ZbHSpR1x7VDsPS9lIkaBeIZB+8
         +9Kvrk1kBo+pYwBIAbCxdzI7IsSevJhHnf033TsvqzOC5bKlafJN3CM/KktdC47U2TB3
         x45A==
X-Gm-Message-State: ACgBeo1PsGR+Otf7SN62LhwrVieaJrgzuZfJuOp06dFabSGJ/XAaYXwM
        mLZPcILiwRtB1D6c1Q9DcM4=
X-Google-Smtp-Source: AA6agR5AYoSyQYhdFmno3awwnL/KqdiAY/EWoPslkD1DD0cXO1/u4VDORiF4nCEDyYzYCSFhq6fkfw==
X-Received: by 2002:a17:907:6091:b0:731:37fb:bd9 with SMTP id ht17-20020a170907609100b0073137fb0bd9mr6966716ejc.219.1660977806197;
        Fri, 19 Aug 2022 23:43:26 -0700 (PDT)
Received: from nam-dell.vm.stuba.sk ([147.175.88.220])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906329b00b0073c0b87ba34sm2935816ejw.198.2022.08.19.23.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 23:43:25 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 1/4] staging: rtl8723bs: remove unused function ODM_InbandNoise_Monitor
Date:   Sat, 20 Aug 2022 08:42:43 +0200
Message-Id: <46d73e331bae2192a328f6691763f39ea6c18b08.1660977536.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660977535.git.namcaov@gmail.com>
References: <cover.1660977535.git.namcaov@gmail.com>
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

because this function is not used. Also remove function
odm_InbandNoise_Monitor_NSeries because it is a static function
which is only called from ODM_InbandNoise_Monitor.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  | 111 ------------------
 .../staging/rtl8723bs/hal/odm_NoiseMonitor.h  |   7 --
 2 files changed, 118 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
index 392cc8a398f5..b85b323cf5bd 100644
--- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
+++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
@@ -17,114 +17,3 @@
 #define Valid_Min				-35
 #define Valid_Max			10
 #define ValidCnt				5
-
-static s16 odm_InbandNoise_Monitor_NSeries(
-	struct dm_odm_t *pDM_Odm,
-	u8 bPauseDIG,
-	u8 IGIValue,
-	u32 max_time
-)
-{
-	u32 tmp4b;
-	u8 max_rf_path = 0, rf_path;
-	u8 reg_c50, reg_c58, valid_done = 0;
-	struct noise_level noise_data;
-	u32 start  = 0;
-
-	pDM_Odm->noise_level.noise_all = 0;
-
-	max_rf_path = 1;
-
-	memset(&noise_data, 0, sizeof(struct noise_level));
-
-	/*  */
-	/*  Step 1. Disable DIG && Set initial gain. */
-	/*  */
-
-	if (bPauseDIG)
-		odm_PauseDIG(pDM_Odm, ODM_PAUSE_DIG, IGIValue);
-	/*  */
-	/*  Step 2. Disable all power save for read registers */
-	/*  */
-	/* dcmd_DebugControlPowerSave(padapter, PSDisable); */
-
-	/*  */
-	/*  Step 3. Get noise power level */
-	/*  */
-	start = jiffies;
-	while (1) {
-
-		/* Stop updating idle time pwer report (for driver read) */
-		PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_TxGainStage, BIT25, 1);
-
-		/* Read Noise Floor Report */
-		tmp4b = PHY_QueryBBReg(pDM_Odm->Adapter, 0x8f8, bMaskDWord);
-
-		/* PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XAAGCCore1, bMaskByte0, TestInitialGain); */
-		/* if (max_rf_path == 2) */
-		/* PHY_SetBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0, TestInitialGain); */
-
-		/* update idle time pwer report per 5us */
-		PHY_SetBBReg(pDM_Odm->Adapter, rFPGA0_TxGainStage, BIT25, 0);
-
-		noise_data.value[RF_PATH_A] = (u8)(tmp4b&0xff);
-		noise_data.value[RF_PATH_B]  = (u8)((tmp4b&0xff00)>>8);
-
-		for (rf_path = RF_PATH_A; rf_path < max_rf_path; rf_path++) {
-			noise_data.sval[rf_path] = (s8)noise_data.value[rf_path];
-			noise_data.sval[rf_path] /= 2;
-		}
-		/* mdelay(10); */
-		/* msleep(10); */
-
-		for (rf_path = RF_PATH_A; rf_path < max_rf_path; rf_path++) {
-			if ((noise_data.valid_cnt[rf_path] < ValidCnt) && (noise_data.sval[rf_path] < Valid_Max && noise_data.sval[rf_path] >= Valid_Min)) {
-				noise_data.valid_cnt[rf_path]++;
-				noise_data.sum[rf_path] += noise_data.sval[rf_path];
-				if (noise_data.valid_cnt[rf_path] == ValidCnt) {
-					valid_done++;
-				}
-
-			}
-
-		}
-
-		/* printk("####### valid_done:%d #############\n", valid_done); */
-		if ((valid_done == max_rf_path) || (jiffies_to_msecs(jiffies - start) > max_time)) {
-			for (rf_path = RF_PATH_A; rf_path < max_rf_path; rf_path++) {
-				/* printk("%s PATH_%d - sum = %d, valid_cnt = %d\n", __func__, rf_path, noise_data.sum[rf_path], noise_data.valid_cnt[rf_path]); */
-				if (noise_data.valid_cnt[rf_path])
-					noise_data.sum[rf_path] /= noise_data.valid_cnt[rf_path];
-				else
-					noise_data.sum[rf_path]  = 0;
-			}
-			break;
-		}
-	}
-	reg_c50 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XAAGCCore1, bMaskByte0);
-	reg_c50 &= ~BIT7;
-	pDM_Odm->noise_level.noise[RF_PATH_A] = -110 + reg_c50 + noise_data.sum[RF_PATH_A];
-	pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_A];
-
-	if (max_rf_path == 2) {
-		reg_c58 = (s32)PHY_QueryBBReg(pDM_Odm->Adapter, rOFDM0_XBAGCCore1, bMaskByte0);
-		reg_c58 &= ~BIT7;
-		pDM_Odm->noise_level.noise[RF_PATH_B] = -110 + reg_c58 + noise_data.sum[RF_PATH_B];
-		pDM_Odm->noise_level.noise_all += pDM_Odm->noise_level.noise[RF_PATH_B];
-	}
-	pDM_Odm->noise_level.noise_all /= max_rf_path;
-
-	/*  */
-	/*  Step 4. Recover the Dig */
-	/*  */
-	if (bPauseDIG)
-		odm_PauseDIG(pDM_Odm, ODM_RESUME_DIG, IGIValue);
-
-	return pDM_Odm->noise_level.noise_all;
-
-}
-
-s16 ODM_InbandNoise_Monitor(void *pDM_VOID, u8 bPauseDIG, u8 IGIValue, u32 max_time)
-{
-	return odm_InbandNoise_Monitor_NSeries(pDM_VOID, bPauseDIG, IGIValue, max_time);
-}
diff --git a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h
index ab114543f39c..01c5c524d4e0 100644
--- a/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h
+++ b/drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h
@@ -29,11 +29,4 @@ struct odm_noise_monitor {
 	s16 noise_all;
 };
 
-s16 ODM_InbandNoise_Monitor(
-	void *pDM_VOID,
-	u8 bPauseDIG,
-	u8 IGIValue,
-	u32 max_time
-);
-
 #endif
-- 
2.25.1

