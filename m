Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE3599D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349469AbiHSNuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349442AbiHSNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:50:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF9CFBA7D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y13so8876435ejp.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=meuYSHAo/A5Ok1qkNjeYNT8E0hFFDPVG1zV7y+jAVHY=;
        b=Z4XSZdUv/W82vjjUKWk23bwYPDMs2hA9znu0oVMhJxFkrcG6OacVqQGvEhj4USVcUn
         ZongS/OaLR1dkS17omnxqK0iUh6mT9SCkWnrjC8ug9p7Cu3gb2d2HutVcseqa5zsol5G
         XroXWis1BsCNrLATfB7k2h5uhhffRd/mfER2E/W2YG4yoUEWAyM3ifyHpTtRWuSfC5Rq
         MFmF2qdG3hY3kku0mdTBtptd+dkB0paBmrqlZO0IfhtGSIVX8LC3ztfi7VIHK0OqWd8d
         cRM/szOyAN70EkOynNPhRKF+8SVFUEi7x/eUb4M2whmN9QD8ud73Rf0gGnl9AjVl1jZc
         6wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=meuYSHAo/A5Ok1qkNjeYNT8E0hFFDPVG1zV7y+jAVHY=;
        b=Zz5Xy3fvmwXxmkuVda0E7QpOoHRfhY244RLhfiOQu1lN8bzsyG6AMVH7rFOOk+82nj
         xIt4H9VZZ73BDIgoBkysRK/1YGmUC5AbRrQxssvXFvqIzY4KnyDkZlNebD/D9RTypneS
         6bYC/8WlH7+elVnqjRqVj527AV03wcvE5PCDOV06GXtKj9/B5nyjbsw4FIDwhiqihYh1
         f+pp2hshX8m8fPJ5HyOaCjtSNxrggWBfxXQq4a9GgifCpIVYErcKAohylTzHXJx4fDzY
         nMjtHHqmz7wjCS7jNHIbSeX05QI31cENKGn6aiieOG24JkV+NDSqQKpyeFd/p+o1t41O
         Ivog==
X-Gm-Message-State: ACgBeo3RrCLecLJbSItgrCGRRoBP5oBYCEyFp5IXikUb+zxo2X7VuODX
        v60SDKDCzQWZ2vWt43sNBcw=
X-Google-Smtp-Source: AA6agR7oqC9dIg09hMfcQf7XSrdrIl5Yr/TGCrz96da051ZK0Vyt6/1Bogz7/eL6O+By3Rkc9eeIAg==
X-Received: by 2002:a17:907:6d06:b0:731:5809:ec67 with SMTP id sa6-20020a1709076d0600b007315809ec67mr4962544ejc.195.1660917033170;
        Fri, 19 Aug 2022 06:50:33 -0700 (PDT)
Received: from nam-dell.ucebne.fiit.stuba.sk ([147.175.148.17])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b0073087140945sm2313821ejk.123.2022.08.19.06.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:50:32 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     lkp@intel.com
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: [PATCH v2 6/8] staging: rtl8723bs: remove function rtw_odm_adaptivity_parm_msg
Date:   Fri, 19 Aug 2022 15:49:40 +0200
Message-Id: <24c3baa696adb7633d643258b60bba9bcd18b953.1660916523.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660916523.git.namcaov@gmail.com>
References: <cover.1660916523.git.namcaov@gmail.com>
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

because this function is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_odm.c    | 18 ------------------
 drivers/staging/rtl8723bs/include/rtw_odm.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_odm.c b/drivers/staging/rtl8723bs/core/rtw_odm.c
index ec8406c18b03..2cba7825c9b3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_odm.c
+++ b/drivers/staging/rtl8723bs/core/rtw_odm.c
@@ -129,24 +129,6 @@ void rtw_odm_ability_msg(void *sel, struct adapter *adapter)
 	}
 }
 
-void rtw_odm_adaptivity_parm_msg(void *sel, struct adapter *adapter)
-{
-	struct hal_com_data *pHalData = GET_HAL_DATA(adapter);
-	struct dm_odm_t *odm = &pHalData->odmpriv;
-
-	netdev_dbg(adapter->pnetdev, "%10s %16s %8s %10s %11s %14s\n",
-		   "TH_L2H_ini", "TH_EDCCA_HL_diff", "IGI_Base", "ForceEDCCA",
-		   "AdapEn_RSSI", "IGI_LowerBound");
-	netdev_dbg(adapter->pnetdev,
-		   "0x%-8x %-16d 0x%-6x %-10d %-11u %-14u\n",
-		   (u8)odm->TH_L2H_ini,
-		   odm->TH_EDCCA_HL_diff,
-		   odm->IGI_Base,
-		   odm->ForceEDCCA,
-		   odm->AdapEn_RSSI,
-		   odm->IGI_LowerBound);
-}
-
 void rtw_odm_adaptivity_parm_set(struct adapter *adapter, s8 TH_L2H_ini,
 				 s8 TH_EDCCA_HL_diff, s8 IGI_Base,
 				 bool ForceEDCCA, u8 AdapEn_RSSI,
diff --git a/drivers/staging/rtl8723bs/include/rtw_odm.h b/drivers/staging/rtl8723bs/include/rtw_odm.h
index ea9c4de0f284..be0d47413fd2 100644
--- a/drivers/staging/rtl8723bs/include/rtw_odm.h
+++ b/drivers/staging/rtl8723bs/include/rtw_odm.h
@@ -19,7 +19,6 @@ void rtw_odm_dbg_level_set(struct adapter *adapter, u32 level);
 
 void rtw_odm_ability_msg(void *sel, struct adapter *adapter);
 
-void rtw_odm_adaptivity_parm_msg(void *sel, struct adapter *adapter);
 void rtw_odm_adaptivity_parm_set(struct adapter *adapter, s8 TH_L2H_ini, s8 TH_EDCCA_HL_diff,
 	s8 IGI_Base, bool ForceEDCCA, u8 AdapEn_RSSI, u8 IGI_LowerBound);
 void rtw_odm_get_perpkt_rssi(void *sel, struct adapter *adapter);
-- 
2.25.1

