Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D25468B51
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhLEODR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbhLEODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:03:02 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF7CC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 05:59:35 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so32047839edd.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 05:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gAS0cKvETcknOrMPrbKidw5V5Godx+Ja70TOG5Jm99M=;
        b=IOU2GQxttc8BZEb2fFAMSpC0UfeXbd3yLehHOu2YAeF3tZOWnJWZeD2GAS6K/Bg+u0
         zkjjGBaVy4xcQwG5kvxjAmbd2AVNSMTtIVQqH1afT+rF11bveOTe04MNAoFZLdcIxsW0
         5qGemqMFK2pLjjlO7vSgBxdQXjpnWxHS1K5yBYfdfDW1cH0PjbrYj22M9BAfHRAKl+Nt
         Ti5Mf0tQPDiY8qwmsTcbcKHZqIrQHhlGGTqydnz6ETJmooRcTvFChFww1RlKJP+WdTZq
         deOko0Mzb6+N6ioQljtvcs20msCitBNjWZ+SjImwJxqZypbWltW+mYFivJVaQKtnFNzB
         bGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gAS0cKvETcknOrMPrbKidw5V5Godx+Ja70TOG5Jm99M=;
        b=1vLWPFcV4uzOIv4yFQXDORzK6wX9pUBOVvD/U4ovSLKjDCwuXORWtlGvcIj5KIDe9a
         5txn9jhoUWTu1HxZfBQ4fCTPm3BVePUEFLzhF4i+KBXndgb4xUZXWIbblTrrIhzC2wxJ
         ZZiMFIW0ij6GO/EJ+wRgU0LcrLPC9CownlwemwqIH6qwq5ckagRcaFHx2mPh2LPO2fip
         7UI7WAydq5bZuXWY0vrdOQFmJTZdDd6HLLyKdzrv1EvapvgWWTN/NqxrpuiX3+klc8Cb
         458cFVYksaZH+FbyefTUzFuHkHc/ACyxlWTTu7T4mIbgxPz39wG7MZSNuJx66MKlWa2P
         96zQ==
X-Gm-Message-State: AOAM532fn5V0/lwUTQRhxP5iRKjPDlgGo27qtUKgTAb2DkOnWuY4gk5E
        S9tV1lGiqFt4XYYqJFNMSRg=
X-Google-Smtp-Source: ABdhPJxXWZADQzMH825f7+NuESbynuVU6C435b/5sjX+Qs/IKDK92PoxeRMNs1xsGuMl9b7DNtSaTw==
X-Received: by 2002:a17:906:3647:: with SMTP id r7mr39098147ejb.124.1638712773959;
        Sun, 05 Dec 2021 05:59:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id yd20sm5146451ejb.47.2021.12.05.05.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:59:33 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/12] staging: r8188eu: bWIFI_Display is set but never used
Date:   Sun,  5 Dec 2021 14:59:16 +0100
Message-Id: <20211205135919.30460-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205135919.30460-1-straube.linux@gmail.com>
References: <20211205135919.30460-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bWIFI_Display in odm_dm_struct is set but never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c               | 3 ---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h      | 1 -
 drivers/staging/r8188eu/include/odm.h           | 2 --
 4 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index b1cebdfb7d88..5629556cca8a 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -260,9 +260,6 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 	case	ODM_CMNINFO_ABILITY:
 		pDM_Odm->SupportAbility = (u32)Value;
 		break;
-	case	ODM_CMNINFO_WIFI_DISPLAY:
-		pDM_Odm->bWIFI_Display = (bool)Value;
-		break;
 	case	ODM_CMNINFO_LINK:
 		pDM_Odm->bLinked = (bool)Value;
 		break;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index ed54da84e40b..5791172fa5c4 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -874,9 +874,6 @@ void rtl8188e_SetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVaria
 		       }
 		}
 		break;
-	case HAL_ODM_WIFI_DISPLAY_STATE:
-			ODM_CmnInfoUpdate(podmpriv, ODM_CMNINFO_WIFI_DISPLAY, bSet);
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 3383570c2bf3..7de35fde15a9 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -96,7 +96,6 @@ enum hal_def_variable {
 
 enum hal_odm_variable {
 	HAL_ODM_STA_INFO,
-	HAL_ODM_WIFI_DISPLAY_STATE,
 };
 
 typedef s32 (*c2h_id_filter)(u8 id);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index d6c10ac2b8a8..69faf8b50996 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -230,7 +230,6 @@ enum odm_common_info_def {
 /*  POINTER REFERENCE----------- */
 
 /* CALL BY VALUE------------- */
-	ODM_CMNINFO_WIFI_DISPLAY,
 	ODM_CMNINFO_LINK,
 	ODM_CMNINFO_RSSI_MIN,
 	ODM_CMNINFO_RF_ANTENNA_TYPE,		/*  u8 */
@@ -479,7 +478,6 @@ struct odm_dm_struct {
 /*  POINTER REFERENCE----------- */
 	/*  */
 /* CALL BY VALUE------------- */
-	bool	bWIFI_Display;
 	bool	bLinked;
 	u8	RSSI_Min;
 	bool	bIsMPChip;
-- 
2.34.1

