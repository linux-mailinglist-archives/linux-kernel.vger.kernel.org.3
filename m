Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA974468C5C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 18:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhLERSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 12:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbhLERSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 12:18:08 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DECC061359
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 09:14:40 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so32969386edb.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 09:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRkJ3vqagMiphf+5S4sQxNeN85AmGcBUzfK5lHDgLOE=;
        b=BqBGgDJ2+8QBb0T/X1Zyw5WpvAWQjgw8tNFRzl8ySid6bRJKFzX/cL9b31uhdeknK6
         bfIQc5pAWMeEt9v173xb3go3O7mFXOnDTdk/KSqMhG+fxxlVTB4F1AcyUTKY0UTtZ0bN
         kDa+szOXNKNeIO0bYsVAZsH/xQSqzyvP9swquqVuvrbbE/3+H7/YXhqPLsT8QqzJSYGn
         PJGh8k4V127Ptl6okpLN17Z/HcgYbxrLnR12HabLUrucaqHr39EDvzOU3gTa0imW+c6Q
         AQ5azRa5lewTTTsyDz9HnwE7JBar9YiCHkKw+i7PK8gxHt/Revj3p0QDkG4TqNRpIPxH
         Xw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRkJ3vqagMiphf+5S4sQxNeN85AmGcBUzfK5lHDgLOE=;
        b=uQf/lSjcosCNoF2MiueM/jweobKrhOoBjqlLghFEMcY3+9B3LYLq2LIlaOij1Y/RZp
         96ykGlLQwh39QM47zR091zvnos+8HG2UOKfTeIkcqHESo0P1pQnIMRLUBEM+XIcDww5+
         XFotQmsfOtOB1BV90ANgvRz8rcxgIYP4vqwZmTSUFiNwuGYxTc2hlECULIHBCVKuyhLw
         LV74ePj2UxWsIsVfscYCffDLA/r5a80jJTdyOxQOi1O7jCVEXLwFzEEfKwyZ6X0HPEtD
         IzRH52GwW1tVYdovoJUYboP0B5iTeKHDE5BhbBGXk4oT8UGpo6e5TgNagQNr24xoTWBJ
         M1GA==
X-Gm-Message-State: AOAM533yy/ilNOO5NQLxHwHBhV2hC26/871wD8Xgk15hUmfeMC8JnPxr
        PQ8d+ABASZhHvcl25MsumNk=
X-Google-Smtp-Source: ABdhPJwodYyDyOV53o/Rfjf8cAmLez9ZjfmgW4SHZSDDvuLZGdmu/gpfO2hMAWkoRwjZEOFkDkBmow==
X-Received: by 2002:a17:906:cb82:: with SMTP id mf2mr39627694ejb.266.1638724479060;
        Sun, 05 Dec 2021 09:14:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::b792])
        by smtp.gmail.com with ESMTPSA id ch28sm6071773edb.72.2021.12.05.09.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 09:14:38 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 08/10] staging: r8188eu: bWIFI_Direct is set but never used
Date:   Sun,  5 Dec 2021 18:13:40 +0100
Message-Id: <20211205171342.20551-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205171342.20551-1-straube.linux@gmail.com>
References: <20211205171342.20551-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bWIFI_Direct in odm_dm_struct is set but never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c          | 3 ---
 drivers/staging/r8188eu/hal/odm.c               | 3 ---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h      | 1 -
 drivers/staging/r8188eu/include/odm.h           | 2 --
 5 files changed, 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index b265b5e46851..9ea1d935724a 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1944,7 +1944,6 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 		/* Enable P2P function */
 		init_wifidirect_info(padapter, role);
 
-		rtl8188e_SetHalODMVar(padapter, HAL_ODM_P2P_STATE, NULL, true);
 	} else if (role == P2P_ROLE_DISABLE) {
 		if (_FAIL == rtw_pwr_wakeup(padapter)) {
 			ret = _FAIL;
@@ -1963,8 +1962,6 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 			memset(&pwdinfo->rx_prov_disc_info, 0x00, sizeof(struct rx_provdisc_req_info));
 		}
 
-		rtl8188e_SetHalODMVar(padapter, HAL_ODM_P2P_STATE, NULL, false);
-
 		/* Restore to initial setting. */
 		update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
 	}
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 8779d5accf52..b1cebdfb7d88 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -260,9 +260,6 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 	case	ODM_CMNINFO_ABILITY:
 		pDM_Odm->SupportAbility = (u32)Value;
 		break;
-	case	ODM_CMNINFO_WIFI_DIRECT:
-		pDM_Odm->bWIFI_Direct = (bool)Value;
-		break;
 	case	ODM_CMNINFO_WIFI_DISPLAY:
 		pDM_Odm->bWIFI_Display = (bool)Value;
 		break;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index acd343eec280..ed54da84e40b 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -874,9 +874,6 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVaria
 		       }
 		}
 		break;
-	case HAL_ODM_P2P_STATE:
-			ODM_CmnInfoUpdate(podmpriv, ODM_CMNINFO_WIFI_DIRECT, bSet);
-		break;
 	case HAL_ODM_WIFI_DISPLAY_STATE:
 			ODM_CmnInfoUpdate(podmpriv, ODM_CMNINFO_WIFI_DISPLAY, bSet);
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 7385ebaaba5c..3383570c2bf3 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -96,7 +96,6 @@ enum hal_def_variable {
 
 enum hal_odm_variable {
 	HAL_ODM_STA_INFO,
-	HAL_ODM_P2P_STATE,
 	HAL_ODM_WIFI_DISPLAY_STATE,
 };
 
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index f83b94a74b70..d6c10ac2b8a8 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -230,7 +230,6 @@ enum odm_common_info_def {
 /*  POINTER REFERENCE----------- */
 
 /* CALL BY VALUE------------- */
-	ODM_CMNINFO_WIFI_DIRECT,
 	ODM_CMNINFO_WIFI_DISPLAY,
 	ODM_CMNINFO_LINK,
 	ODM_CMNINFO_RSSI_MIN,
@@ -480,7 +479,6 @@ struct odm_dm_struct {
 /*  POINTER REFERENCE----------- */
 	/*  */
 /* CALL BY VALUE------------- */
-	bool	bWIFI_Direct;
 	bool	bWIFI_Display;
 	bool	bLinked;
 	u8	RSSI_Min;
-- 
2.34.1

