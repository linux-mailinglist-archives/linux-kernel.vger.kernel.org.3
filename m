Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B666D468B50
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhLEODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbhLEODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:03:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9795AC061751
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 05:59:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o20so32034160eds.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRkJ3vqagMiphf+5S4sQxNeN85AmGcBUzfK5lHDgLOE=;
        b=LNsgQKdgplikNjQMv8qVNqmdsgEtADlv1oWuvUGoKprfu7zLqyXJCuyQrUItcH9Xeb
         z1dZa7YQs65Ub1GlF88xl9McNazyHEoi1NI8WlUDzr3mxVsVyc55BXPvJvKXuGqwluGS
         tLg/S6uQPhZbIs577XfYpXyqZWSjk6O5uhyyDoHcQkqgU6roOG3t6zBEHYztnu2pMGHd
         LRyvLXni0xnZAomxipG0N7a5fhnI3QQY5t8oZom8Kj4okk6kUO4fj878o3LVtzvYozcS
         JKslh6Y1+jjzcN5qAiT6Cm6OXwhQaKWw7O0KmEXHJeYzaHVIImGCCFeo2YpzeqWf4A/K
         Ag0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRkJ3vqagMiphf+5S4sQxNeN85AmGcBUzfK5lHDgLOE=;
        b=fLWRDDac3kxdDxcMmJQR6Ol5TyohKYiVBpDkIxg+pC7HKEfnw1qUzFdGVZCmdMIn6w
         7Q3w3gyFIjNf2kkYWaqeHVReD1JcniCZl0lBxwAdoIal7Ro/k2UQr3HpLTeGnPqKFCaA
         c48+rQSsWeeHY066VZmZPAm4RWBdvDsF3NOF7J1ttrcSC8gi2MYotJ2RsoZXbZNeY9M5
         Y2O5ZjdnOkJy8LZMDDHjNUKnOA3/hpEDFLx0nNsmey6TkfA8SMScxD0EbXfucdm//O2D
         i7zQwY9s2+OAY22cfl4y3nWGqIF7xamlKu/TAsdiOjg7W1/K1bvIayguQwBKdVb5jUHh
         V0NA==
X-Gm-Message-State: AOAM530ZsSMXqQ2adyTJv8ovSkdvVWa0IT35TDMrBb533glp8YYhlDMQ
        LhroPYSOf75GdBmxsXGUKIE=
X-Google-Smtp-Source: ABdhPJwIyAXt3zs+68XOj80CAvRF1x3vsdQRUfNdeussv8ZjlXX3tGZLPFK3DFy5BkV+lN3QphoUyg==
X-Received: by 2002:a17:906:640d:: with SMTP id d13mr38460797ejm.444.1638712773243;
        Sun, 05 Dec 2021 05:59:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id yd20sm5146451ejb.47.2021.12.05.05.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:59:32 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/12] staging: r8188eu: bWIFI_Direct is set but never used
Date:   Sun,  5 Dec 2021 14:59:15 +0100
Message-Id: <20211205135919.30460-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205135919.30460-1-straube.linux@gmail.com>
References: <20211205135919.30460-1-straube.linux@gmail.com>
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

