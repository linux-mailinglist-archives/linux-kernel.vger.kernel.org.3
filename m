Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E9F5AABDF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiIBJxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiIBJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7A6C6FC8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c59so1934119edf.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6Aqp2CnBk1QACLxggfiOgjUbjEfen+S7yS/YB9rrdMM=;
        b=bt439Yd79hZlUveKtb7EfEGN54BN2p9KzmbAr83gDhkEHXHidd+tMd2dUK0XyylgDc
         b+jbQv8c/JmCYdQp1riLZykWpOjJXIUl02RdM+zyVwaIwXst7BoPKVTPAcmpGQE5ZC1s
         wRWptBOL69ItcMY4XChm0ej03A7uU6t7pY3k9j/HLSwJ8H+9XrQnArkTepMH3XKFGIsW
         YxSsXmsrL+LUrUeDsIY1XniFuovduJX5su8XeTA7igmyZsgOhNYpyUqiabhk8UeTacNN
         AQDQFqXLOyV9rmTYZmgA9khqH5LcUbDYxsiz43fgyaIGaiZhkhZv/qbZLsGu9Qh/bIq4
         jL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6Aqp2CnBk1QACLxggfiOgjUbjEfen+S7yS/YB9rrdMM=;
        b=kxQe+IPcOfBadL6Zskkjna8bW3Sh6OJxQ+nU7WZi01zPN/q1sYeO3zehZttiwNfjxI
         Qc9UOE+T1iO32qSESe51UeXkXUu25dIhwuISuZldSUXbnJbdy4SSgjktsWrrp437YGpL
         Xouyh8graCgAD3xPnpBdv7AncHEYUuDX7/7Qfl0LBu2Shp/ZmMjXHgNFa+7Ay74DfcaR
         P99G01JWBWXRCOPZcqQvug9S16GuM9KNrpFrpTwAisgVZaG7t9qTmVdpD9I+ps5ek1Cp
         z7PNaXtHNKexcbj17bHFyHwc89ebndaDWdbxtzFNoKxWEb/P56n0zidy/qhKPDicEbqz
         eIGQ==
X-Gm-Message-State: ACgBeo12SgWOzSIlIkoR2+TYiyui778CQhmpNyk/PL2BWM8F3aCe4jWW
        2bOEOYhPloeT9+0x+X5Dl3R1ioYagJJL8A==
X-Google-Smtp-Source: AA6agR5eIcQO/SIZCdZKTaAjLVkFC4wgK+jKQhq0Ks6CTQSo4vsoFPVqbSuPlQ1a4Efc0ET4FKSHYQ==
X-Received: by 2002:a05:6402:26c6:b0:448:6812:7355 with SMTP id x6-20020a05640226c600b0044868127355mr20746614edd.385.1662112356946;
        Fri, 02 Sep 2022 02:52:36 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:36 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 04/10] staging: rtl8723bs: delete rtw_odm.c and rtw_odm.h
Date:   Fri,  2 Sep 2022 11:51:54 +0200
Message-Id: <6870109ce0c51b4ab91ec370d8b2285dc635e5fe.1662111798.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662111798.git.namcaov@gmail.com>
References: <cover.1662111798.git.namcaov@gmail.com>
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

Remove rtw_odm.c and rtw_odm.h because the content of these files
is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/Makefile            |   1 -
 drivers/staging/rtl8723bs/core/rtw_odm.c      | 116 ------------------
 drivers/staging/rtl8723bs/include/drv_types.h |   1 -
 drivers/staging/rtl8723bs/include/rtw_odm.h   |  24 ----
 4 files changed, 142 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_odm.c
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_odm.h

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index bc7ff1dd14f9..590bde02058c 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -10,7 +10,6 @@ r8723bs-y = \
 		core/rtw_ieee80211.o \
 		core/rtw_mlme.o \
 		core/rtw_mlme_ext.o \
-		core/rtw_odm.o \
 		core/rtw_pwrctrl.o \
 		core/rtw_recv.o \
 		core/rtw_rf.o \
diff --git a/drivers/staging/rtl8723bs/core/rtw_odm.c b/drivers/staging/rtl8723bs/core/rtw_odm.c
deleted file mode 100644
index 47fd2ee9bb9f..000000000000
--- a/drivers/staging/rtl8723bs/core/rtw_odm.c
+++ /dev/null
@@ -1,116 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2013 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#include <drv_types.h>
-#include <rtw_debug.h>
-#include <rtw_odm.h>
-#include <hal_data.h>
-
-#define RTW_ODM_COMP_MAX 32
-
-static const char * const odm_ability_str[] = {
-	/* BIT0 */"ODM_BB_DIG",
-	/* BIT1 */"ODM_BB_RA_MASK",
-	/* BIT2 */"ODM_BB_DYNAMIC_TXPWR",
-	/* BIT3 */"ODM_BB_FA_CNT",
-	/* BIT4 */"ODM_BB_RSSI_MONITOR",
-	/* BIT5 */"ODM_BB_CCK_PD",
-	/* BIT6 */"ODM_BB_ANT_DIV",
-	/* BIT7 */"ODM_BB_PWR_SAVE",
-	/* BIT8 */"ODM_BB_PWR_TRAIN",
-	/* BIT9 */"ODM_BB_RATE_ADAPTIVE",
-	/* BIT10 */"ODM_BB_PATH_DIV",
-	/* BIT11 */"ODM_BB_PSD",
-	/* BIT12 */"ODM_BB_RXHP",
-	/* BIT13 */"ODM_BB_ADAPTIVITY",
-	/* BIT14 */"ODM_BB_DYNAMIC_ATC",
-	/* BIT15 */NULL,
-	/* BIT16 */"ODM_MAC_EDCA_TURBO",
-	/* BIT17 */"ODM_MAC_EARLY_MODE",
-	/* BIT18 */NULL,
-	/* BIT19 */NULL,
-	/* BIT20 */NULL,
-	/* BIT21 */NULL,
-	/* BIT22 */NULL,
-	/* BIT23 */NULL,
-	/* BIT24 */"ODM_RF_TX_PWR_TRACK",
-	/* BIT25 */"ODM_RF_RX_GAIN_TRACK",
-	/* BIT26 */"ODM_RF_CALIBRATION",
-};
-
-#define RTW_ODM_ABILITY_MAX 27
-
-static const char * const odm_dbg_level_str[] = {
-	NULL,
-	"ODM_DBG_OFF",
-	"ODM_DBG_SERIOUS",
-	"ODM_DBG_WARNING",
-	"ODM_DBG_LOUD",
-	"ODM_DBG_TRACE",
-};
-
-#define RTW_ODM_DBG_LEVEL_NUM 6
-
-void rtw_odm_dbg_level_msg(void *sel, struct adapter *adapter)
-{
-	u32 dbg_level;
-	int i;
-
-	rtw_hal_get_def_var(adapter, HW_DEF_ODM_DBG_LEVEL, &dbg_level);
-	netdev_dbg(adapter->pnetdev, "odm.DebugLevel = %u\n", dbg_level);
-	for (i = 0; i < RTW_ODM_DBG_LEVEL_NUM; i++) {
-		if (odm_dbg_level_str[i])
-			netdev_dbg(adapter->pnetdev, "%u %s\n", i,
-				   odm_dbg_level_str[i]);
-	}
-}
-
-inline void rtw_odm_dbg_level_set(struct adapter *adapter, u32 level)
-{
-	rtw_hal_set_def_var(adapter, HW_DEF_ODM_DBG_LEVEL, &level);
-}
-
-void rtw_odm_ability_msg(void *sel, struct adapter *adapter)
-{
-	u32 ability = 0;
-	int i;
-
-	rtw_hal_get_hwreg(adapter, HW_VAR_DM_FLAG, (u8 *)&ability);
-	netdev_dbg(adapter->pnetdev, "odm.SupportAbility = 0x%08x\n", ability);
-	for (i = 0; i < RTW_ODM_ABILITY_MAX; i++) {
-		if (odm_ability_str[i])
-			netdev_dbg(adapter->pnetdev, "%cBIT%-2d %s\n",
-				   (BIT0 << i) & ability ? '+' : ' ', i,
-				   odm_ability_str[i]);
-	}
-}
-
-void rtw_odm_adaptivity_parm_set(struct adapter *adapter, s8 TH_L2H_ini,
-				 s8 TH_EDCCA_HL_diff, s8 IGI_Base,
-				 bool ForceEDCCA, u8 AdapEn_RSSI,
-				 u8 IGI_LowerBound)
-{
-	struct hal_com_data *pHalData = GET_HAL_DATA(adapter);
-	struct dm_odm_t *odm = &pHalData->odmpriv;
-
-	odm->TH_L2H_ini = TH_L2H_ini;
-	odm->TH_EDCCA_HL_diff = TH_EDCCA_HL_diff;
-	odm->IGI_Base = IGI_Base;
-	odm->ForceEDCCA = ForceEDCCA;
-	odm->AdapEn_RSSI = AdapEn_RSSI;
-	odm->IGI_LowerBound = IGI_LowerBound;
-}
-
-void rtw_odm_get_perpkt_rssi(void *sel, struct adapter *adapter)
-{
-	struct hal_com_data *hal_data = GET_HAL_DATA(adapter);
-	struct dm_odm_t *odm = &hal_data->odmpriv;
-
-	netdev_dbg(adapter->pnetdev,
-		   "RxRate = %s, RSSI_A = %d(%%), RSSI_B = %d(%%)\n",
-		   HDATA_RATE(odm->RxRate), odm->RSSI_A, odm->RSSI_B);
-}
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index bb4650f0b297..82159e1c7f9b 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -50,7 +50,6 @@
 #include <rtw_mlme_ext.h>
 #include <rtw_ap.h>
 #include <rtw_version.h>
-#include <rtw_odm.h>
 
 #include "ioctl_cfg80211.h"
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_odm.h b/drivers/staging/rtl8723bs/include/rtw_odm.h
deleted file mode 100644
index 6a431c121285..000000000000
--- a/drivers/staging/rtl8723bs/include/rtw_odm.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2013 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef __RTW_ODM_H__
-#define __RTW_ODM_H__
-
-#include <drv_types.h>
-
-/*
-* This file provides utilities/wrappers for rtw driver to use ODM
-*/
-
-void rtw_odm_dbg_level_msg(void *sel, struct adapter *adapter);
-void rtw_odm_dbg_level_set(struct adapter *adapter, u32 level);
-
-void rtw_odm_ability_msg(void *sel, struct adapter *adapter);
-
-void rtw_odm_adaptivity_parm_set(struct adapter *adapter, s8 TH_L2H_ini, s8 TH_EDCCA_HL_diff,
-	s8 IGI_Base, bool ForceEDCCA, u8 AdapEn_RSSI, u8 IGI_LowerBound);
-void rtw_odm_get_perpkt_rssi(void *sel, struct adapter *adapter);
-#endif /*  __RTW_ODM_H__ */
-- 
2.25.1

