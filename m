Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869925998B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347906AbiHSJg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346923AbiHSJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:36:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5565FD2B04
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:36:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kb8so7779624ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jmGCfK1PpP8C14WpA4xMyU1skN/b8h3qkvgiLCfaJxg=;
        b=cEiRGJWsnku5iN/nHbhoTUSlVQwzkCJFNeFn0HB5XrD3FNtEAOLNXIA42CTyfnbRje
         qKHZTj+WLzt+og2RsFGCQz5lpRU57B/vSNPXdTKVKAkMdjQnuRizNv9lDkoE/guCIzZH
         SPT2LEvKcppSPLRqzJMZyDW6fJIF8FnLfAawccqq8Vlta9y9wdIeg/6ThuhvvqaxfM5N
         vQG6hFuhWOEc9QqABk6qKhWc98PnOLO90frRqOY6SyLu2AFiqZ1QACXTcpEIx8wW6czw
         Sha2Sve8DrT3td5RmTl1Y/OWSxG7jBDcsmT3ZKeUJsQ1pVrHOpSwU+gpo0W4Kf/GXxFj
         OEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jmGCfK1PpP8C14WpA4xMyU1skN/b8h3qkvgiLCfaJxg=;
        b=TaoqYX5yox6WInQiLmr6gEla/QzG2uFlBEbFSimj623IYgm60qiZCSDC/iWD5660Tq
         seYS2Sz7+nRmSrEPXbk2abBbR9sKm6HxOoy3oi8dnOUntD3BvrXNnRhgF2utuZ9dPyPL
         q+DzXExbDJabe/A+DPyfd77+YzYYTZA7jJGw+Ys7ztSxiXvCK2CmREbCthm/ZetzUCgX
         bM3/SO6RovOHF4EOjPoe8udiENeNamK7C9gzxNsgK/E3/emTPmgInlTqnmC6CydBb8TM
         KJi/LxUR4UNEM2Bl93fW45esQ6OHHOwDMi/737LY6WtjYVxydOol9m4DugGlGhyhEwaS
         ZXqQ==
X-Gm-Message-State: ACgBeo1xaHFsq8mUxywqtUTelj368Y0zXAD5sXgaEZGI3QIhvIbpAz6y
        w5JqwAb5n+d6DLMy9TDFUvk=
X-Google-Smtp-Source: AA6agR5e8xvAXGujp+HyemWbRMHXnPHcYTA6X+7G9mjDmsPBXtXahQ7VTNPjrwNMhjdmTAJvO4yQcg==
X-Received: by 2002:a17:907:2e01:b0:730:9ecc:cd28 with SMTP id ig1-20020a1709072e0100b007309ecccd28mr4309267ejc.360.1660901767889;
        Fri, 19 Aug 2022 02:36:07 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906941800b00734d4bd1792sm2055929ejx.162.2022.08.19.02.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 02:36:07 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH 1/3] staging: rtl8723bs: remove unused function ODM_InbandNoise_Monitor
Date:   Fri, 19 Aug 2022 11:35:35 +0200
Message-Id: <46d73e331bae2192a328f6691763f39ea6c18b08.1660901124.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660901124.git.namcaov@gmail.com>
References: <cover.1660901124.git.namcaov@gmail.com>
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

